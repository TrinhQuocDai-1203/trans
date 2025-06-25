package com.example.config;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

//Bộ lọc mã hóa ký tự cho tiếng Việt
public class CharacterEncodingFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");
        
        chain.doFilter(req, res);
    }
    
    @Override
    public void destroy() {
    }
}