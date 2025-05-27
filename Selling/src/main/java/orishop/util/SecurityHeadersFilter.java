package orishop.util;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;

public class SecurityHeadersFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Chống sniffing nội dung
        httpResponse.setHeader("X-Content-Type-Options", "nosniff");
        
        // Chống clickjacking (chèn trang qua iframe)
        httpResponse.setHeader("X-Frame-Options", "DENY");
        
        // Tăng cường bảo vệ XSS trong một số trình duyệt cũ
        httpResponse.setHeader("X-XSS-Protection", "1; mode=block");
        
        // Kiểm soát chia sẻ thông tin referrer
        httpResponse.setHeader("Referrer-Policy", "no-referrer");
        
//        Content Security Policy (CSP) — giới hạn tài nguyên có thể tải
//        Tùy chỉnh theo nhu cầu nếu bạn dùng CDN, JS, ảnh bên ngoài
//        httpResponse.setHeader("Content-Security-Policy",
//        	    "default-src 'self'; " +
//        	    "script-src 'self'; " +
//        	    "style-src 'self' 'unsafe-inline'; " + // Cho phép style nội tuyến
//        	    "img-src * data:;");

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
