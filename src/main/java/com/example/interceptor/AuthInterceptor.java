package com.example.interceptor;

import com.example.model.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AuthInterceptor implements HandlerInterceptor {
    
    // Định nghĩa mapping giữa URL pattern và role được phép truy cập
    private static final Map<String, List<User.Role>> ROLE_MAPPINGS = new HashMap<>();
    
    static {
        // URLs chỉ dành cho ADMIN
        ROLE_MAPPINGS.put("/admin/", Arrays.asList(User.Role.ADMIN));
        ROLE_MAPPINGS.put("/admin/users", Arrays.asList(User.Role.ADMIN));
        ROLE_MAPPINGS.put("/admin/reports", Arrays.asList(User.Role.ADMIN));
        
        // URLs dành cho DRIVER
        ROLE_MAPPINGS.put("/driver/", Arrays.asList(User.Role.DRIVER));
        ROLE_MAPPINGS.put("/driver/trips", Arrays.asList(User.Role.DRIVER));
        ROLE_MAPPINGS.put("/driver/schedule", Arrays.asList(User.Role.DRIVER));
        ROLE_MAPPINGS.put("/driver/seats", Arrays.asList(User.Role.DRIVER));

        // URLs dành cho USER
        ROLE_MAPPINGS.put("/user/bookings", Arrays.asList(User.Role.USER));
        ROLE_MAPPINGS.put("/user/book-trip", Arrays.asList(User.Role.USER));
        ROLE_MAPPINGS.put("/user/book-seat", Arrays.asList(User.Role.USER));
        ROLE_MAPPINGS.put("/user/history", Arrays.asList(User.Role.USER));
        
        // URLs cho cả ba role
        ROLE_MAPPINGS.put("/search", Arrays.asList(User.Role.USER, User.Role.DRIVER, User.Role.ADMIN));
    }
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Cho phép truy cập trang đăng nhập, đăng ký, trang chủ, lịch trình và tra cứu vé
        String uri = request.getRequestURI();
        if (uri.equals("/") || uri.equals("/login") || uri.equals("/register") || 
            uri.equals("/lich-trinh") || uri.equals("/tra-cuu-ve") || 
            uri.contains("/resources/")) {
            return true;
        }
        
        // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
        if (user == null) {
            response.sendRedirect("/login?redirectUrl=" + uri);
            return false;
        }
        
        // Kiểm tra quyền truy cập
        for (Map.Entry<String, List<User.Role>> entry : ROLE_MAPPINGS.entrySet()) {
            if (uri.startsWith(entry.getKey()) && !entry.getValue().contains(user.getRole())) {
                response.sendRedirect("/access-denied");
                return false;
            }
        }
        
        return true;
    }
}