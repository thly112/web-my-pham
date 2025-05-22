package orishop.util;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*")  // Áp dụng cho mọi request
public class SecurityHeaderFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletResponse httpResp = (HttpServletResponse) response;

        // Chống clickjacking
        httpResp.setHeader("X-Frame-Options", "DENY");

        // Có thể dùng thêm Content-Security-Policy nếu cần:
        // httpResp.setHeader("Content-Security-Policy", "frame-ancestors 'none'");

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) {}
    @Override
    public void destroy() {}
}
