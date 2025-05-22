package orishop.controllers.web;

import java.io.IOException;
import java.io.PrintWriter;


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

@WebServlet(urlPatterns = { "/web/login", "/web/register", "/web/forgotpass", "/web/waiting", "/web/VerifyCode",
		"/web/logout" })

public class WebHomeControllers extends HttpServlet {
	private static final long serialVersionUID = 1L;

	IAccountService accountService = new AccountServiceImpl();

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

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

			// truy cập session
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

	private void postForgotPassword(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException {
	    resp.setContentType("text/html; charset=UTF-8");
	    req.setCharacterEncoding("UTF-8");

	    try {
	        String username = req.getParameter("username");
	        String email = req.getParameter("email");

	        AccountModels user = accountService.findOne(username);

	        // Kiểm tra null trước khi truy cập thuộc tính
	        if (user == null || user.getMail() == null || user.getUsername() == null) {
	            req.setAttribute("error", "Tên đăng nhập hoặc email không đúng");
	            req.getRequestDispatcher("/views/web/forgotpassword.jsp").forward(req, resp);
	            return;
	        }

	        // So sánh thông tin người dùng
	        if (!user.getUsername().equals(username) || !user.getMail().equals(email)) {
	            req.setAttribute("error", "Tên đăng nhập hoặc email không đúng");
	            req.getRequestDispatcher("/views/web/forgotpassword.jsp").forward(req, resp);
	            return;
	        }

	        // Gửi email
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
	        // Ghi log nội bộ, tránh hiển thị chi tiết lỗi cho người dùng
	        e.printStackTrace(); // Có thể thay bằng logger.error("Lỗi gửi email khôi phục mật khẩu", e);

	        req.setAttribute("error", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.");
	        req.getRequestDispatcher("/views/web/forgotpassword.jsp").forward(req, resp);
	    }
	}


	private void getLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// check session
		HttpSession session = req.getSession(false);
		if (session != null && session.getAttribute("account") != null) {
			resp.sendRedirect(req.getContextPath() + "/web/waiting");
			return;
		}
		// check cookie
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

	        // Kiểm tra đầu vào rỗng/null
	        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
	            req.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng");
	            req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
	            return;
	        }

	        AccountModels user = accountService.login(username, password);

	        // Kiểm tra thông tin đăng nhập
	        if (user == null || user.getStatus() != 1) {
	            req.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng");
	            req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
	            return;
	        }

	        // Đăng nhập thành công
	        HttpSession session = req.getSession(true);
	        session.setAttribute("account", user);

	        if (isRememberMe) {
	            saveRememberMe(resp, username);
	        }

	        resp.sendRedirect(req.getContextPath() + "/web/waiting");

	    } catch (Exception e) {
	        // Ghi log nội bộ nếu cần
	        e.printStackTrace(); // Có thể dùng logger.error("Lỗi đăng nhập", e);

	        req.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại sau.");
	        req.getRequestDispatcher("/views/web/login.jsp").forward(req, resp);
	    }
	}


	private void getWaiting(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// kiem tra session
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
		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		req.setCharacterEncoding("UTF-8");
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String passwordConfirm = req.getParameter("passwordConfirm");
		String email = req.getParameter("email");

		if (password.equals(passwordConfirm)) {
			String alertMsg = "";
			if (accountService.checkExistEmail(email)) {
				alertMsg = "Email đã tồn tại";
				req.setAttribute("error", alertMsg);
				req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
			} else if (accountService.checkExistUsername(username)) {
				alertMsg = "Tài khoản đã tồn tại";
				req.setAttribute("error", alertMsg);
				req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
			} else {
				Email sm = new Email();
				// get the 6-digit code
				String code = sm.getRandom();
				AccountModels user = new AccountModels(username, email, code);
				boolean test = sm.sendEmail(user);

				if (test) {
					HttpSession session = req.getSession();
					session.setAttribute("account", user);

					boolean isSuccess = accountService.register(username, password, email, code);

					if (isSuccess) {
						resp.sendRedirect(req.getContextPath() + "/web/VerifyCode");

					} else {
						alertMsg = "Lỗi hệ thống!";
						req.setAttribute("error", alertMsg);
						req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
					}
				} else {
					alertMsg = "Lỗi khi gửi mail!!!!!!!!!!!!!!";
					req.setAttribute("error", alertMsg);
					req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);

				}
			}
		} else {
			String alertMsg = "PasswordConfirm khác password";
			req.setAttribute("error", alertMsg);
			req.getRequestDispatcher("/views/web/register.jsp").forward(req, resp);
		}
	}

}
