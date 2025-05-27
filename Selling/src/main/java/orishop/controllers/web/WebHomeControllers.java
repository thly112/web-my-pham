package orishop.controllers.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import orishop.models.AccountModels;
import orishop.services.AccountServiceImpl;
import orishop.services.IAccountService;
import orishop.util.Constant;
import orishop.util.Email;

@WebServlet(urlPatterns = { "/web/login", "/web/register", "/web/forgotpass", "/web/waiting", "/web/VerifyCode", "/web/logout" })
public class WebHomeControllers extends HttpServlet {
    private static final long serialVersionUID = 1L;

    IAccountService accountService = new AccountServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Tạo token CSRF và lưu vào session
        HttpSession session = req.getSession();
        String csrfToken = UUID.randomUUID().toString();
        session.setAttribute("csrfToken", csrfToken);

        String url = req.getRequestURI().toString();

        if (url.contains("web/register")) {
            req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
        } else if (url.contains("web/VerifyCode")) {
            req.getRequestDispatcher("/views/web/verify.jsp").forward(req, resp);
        } else if (url.contains("web/login")) {
            getLogin(req, resp);
        } else if (url.contains("web/forgotpass")) {
            req.getRequestDispatcher("/views/web/forgotpassword.jsp").forward(req, resp);
        } else if (url.contains("web/waiting")) {
            getWaiting(req, resp);
        } else if (url.contains("web/logout")) {
            getLogout(req, resp);
        }
    }

    private void getLogout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        session.removeAttribute("account");

        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (Constant.COOKIE_REMEBER.equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                    resp.addCookie(cookie);
                }
            }
        }

        resp.sendRedirect(req.getContextPath() + "/user/home");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra token CSRF
        HttpSession session = req.getSession();
        String csrfToken = (String) session.getAttribute("csrfToken");
        String requestToken = req.getParameter("csrfToken");

        if (csrfToken == null || !csrfToken.equals(requestToken)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "CSRF token validation failed");
            return;
        }

        String url = req.getRequestURI().toString();
        if (url.contains("web/register")) {
            postRegister(req, resp);
        } else if (url.contains("web/login")) {
            postLogin(req, resp);
        } else if (url.contains("web/forgotpass")) {
            postForgotPassword(req, resp);
        } else if (url.contains("web/VerifyCode")) {
            postVerifyCode(req, resp);
        }
    }

    private void postVerifyCode(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        try (PrintWriter out = resp.getWriter()) {
            HttpSession session = req.getSession();
            AccountModels user = (AccountModels) session.getAttribute("account");
            String code = req.getParameter("authcode");

            if (code.equals(user.getCode())) {
                user.setMail(user.getMail());
                user.setStatus(1);

                accountService.updatestatus(user);
                req.setAttribute("message", "Kích hoạt tài khoản thành công!");
                req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Sai mã kích hoạt, vui lòng kiểm tra lại!!!");
                req.getRequestDispatcher("/views/web/verify.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.getStackTrace();
        }
    }

    private void saveRememberMe(HttpServletResponse resp, String username) {
        Cookie cookie = new Cookie(Constant.COOKIE_REMEBER, username);
        cookie.setMaxAge(30 * 60);
        resp.addCookie(cookie);
    }

    private void postForgotPassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        try {
            String username = req.getParameter("username");
            String email = req.getParameter("email");

            AccountModels user = accountService.findOne(username);

            if (user == null || user.getMail() == null || user.getUsername() == null) {
                req.setAttribute("error", "Tên đăng nhập hoặc email không đúng");
                req.getRequestDispatcher("/views/web/forgotpassword.jsp").forward(req, resp);
                return;
            }

            if (!user.getUsername().equals(username) || !user.getMail().equals(email)) {
                req.setAttribute("error", "Tên đăng nhập hoặc email không đúng");
                req.getRequestDispatcher("/views/web/forgotpassword.jsp").forward(req, resp);
                return;
            }

            Email sm = new Email();
            boolean sent = sm.EmailSend(user);

            if (sent) {
                req.setAttribute("message", "Vui lòng kiểm tra email để nhận mật khẩu");
                req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Không thể gửi email lúc này. Vui lòng thử lại sau.");
                req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.");
            req.getRequestDispatcher("/views/web/forgotpassword.jsp").forward(req, resp);
        }
    }

    private void getLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("account") != null) {
            resp.sendRedirect(req.getContextPath() + "/web/waiting");
            return;
        }

        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("username")) {
                    session = req.getSession(true);
                    session.setAttribute("username", cookie.getValue());
                    resp.sendRedirect(req.getContextPath() + "/waiting");
                    return;
                }
            }
        }

        req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
    }

    private void postLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        try {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String remember = req.getParameter("remember");

            boolean isRememberMe = "on".equals(remember);

            if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
                req.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng");
                req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
                return;
            }

            AccountModels user = accountService.login(username, password);

            if (user == null || user.getStatus() != 1) {
                req.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng");
                req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession(true);
            session.setAttribute("account", user);

            if (isRememberMe) {
                saveRememberMe(resp, username);
            }

            resp.sendRedirect(req.getContextPath() + "/web/waiting");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại sau.");
            req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
        }
    }

    private void getWaiting(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session != null && session.getAttribute("account") != null) {
            AccountModels u = (AccountModels) session.getAttribute("account");
            req.setAttribute("username", u.getUsername());
            if (u.getRoleID() == 1) {
                resp.sendRedirect(req.getContextPath() + "/user/home");
            } else if (u.getRoleID() == 2) {
                resp.sendRedirect(req.getContextPath() + "/admin/home");
            } else if (u.getRoleID() == 3) {
                resp.sendRedirect(req.getContextPath() + "/seller/home");
            } else if (u.getRoleID() == 4) {
                resp.sendRedirect(req.getContextPath() + "/shipper/home");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/web/login");
        }
    }

    private void postRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        try {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String passwordConfirm = req.getParameter("passwordConfirm");
            String email = req.getParameter("email");

            if (username == null || password == null || passwordConfirm == null || email == null ||
                username.isEmpty() || password.isEmpty() || passwordConfirm.isEmpty() || email.isEmpty()) {
                req.setAttribute("error", "Vui lòng điền đầy đủ thông tin.");
                req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
                return;
            }

            if (!password.equals(passwordConfirm)) {
                req.setAttribute("error", "Mật khẩu xác nhận không khớp.");
                req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
                return;
            }

            if (accountService.checkExistEmail(email)) {
                req.setAttribute("error", "Email đã được sử dụng.");
                req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
                return;
            }

            if (accountService.checkExistUsername(username)) {
                req.setAttribute("error", "Tên đăng nhập đã tồn tại.");
                req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
                return;
            }

            Email sm = new Email();
            String code = sm.getRandom();
            AccountModels user = new AccountModels(username, email, code);

            boolean emailSent = sm.sendEmail(user);
            if (!emailSent) {
                req.setAttribute("error", "Không thể gửi email xác minh. Vui lòng thử lại.");
                req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession();
            session.setAttribute("account", user);

            boolean isSuccess = accountService.register(username, password, email, code);
            if (isSuccess) {
                resp.sendRedirect(req.getContextPath() + "/web/VerifyCode");
            } else {
                req.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại sau.");
                req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.");
            req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
        }
    }
}