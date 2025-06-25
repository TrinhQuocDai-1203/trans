// src/main/java/com/example/controller/AuthController.java
package com.example.controllers;

import com.example.model.User;
import com.example.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {
    
    private final UserService userService;
    
    @Autowired
    public AuthController(UserService userService) {
        this.userService = userService;
    }
    
    @GetMapping("/login")
    public String loginPage(@RequestParam(required = false) String redirectUrl, Model model, HttpSession session) {
        // Kiểm tra xem có session không, nếu có thì không hiển thị trang login
        if (session.getAttribute("user") != null) {
            return "redirect:/";
        }
        model.addAttribute("redirectUrl", redirectUrl);
        return "auth/login";
    }
    
    @PostMapping("/login")
    public String login(
            @RequestParam String numberPhone,
            @RequestParam String password,
            @RequestParam(required = false) String redirectUrl,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        User user = userService.authenticate(numberPhone, password);
        
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Số điện thoại hoặc mật khẩu không đúng");
            return "redirect:/login";
        }
        
        session.setAttribute("user", user);
        
        // Chuyển hướng dựa vào role
        if (redirectUrl != null && !redirectUrl.isEmpty()) {
            return "redirect:" + redirectUrl;
        } else {
            switch (user.getRole()) {
                case ADMIN:
                    return "redirect:/admin/";
                case DRIVER:
                    return "redirect:/driver/";
                default:
                    return "redirect:/";
            }
        }
    }
    
    @GetMapping("/register")
    public String registerPage(Model model, HttpSession session) {
        // Kiểm tra xem có session không, nếu có thì không hiển thị trang register
        if (session.getAttribute("user") != null) {
            return "redirect:/";
        }
        model.addAttribute("user", new User());
        return "auth/register";
    }
    
    @PostMapping("/register")
    public String register(
            @RequestParam String numberPhone,
            @RequestParam String password,
            @RequestParam String confirmPassword,
            @RequestParam String fullName,
            RedirectAttributes redirectAttributes) {
        
        if (!password.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Mật khẩu xác nhận không khớp");
            return "redirect:/register";
        }
        
        User user = new User();
        user.setNumberPhone(numberPhone);
        user.setPassword(password);
        user.setFullName(fullName);
        user.setRole(User.Role.USER); // Mặc định là USER
        
        boolean success = userService.registerUser(user);
        
        if (!success) {
            redirectAttributes.addFlashAttribute("error", "Tên đăng nhập hoặc email đã tồn tại");
            return "redirect:/register";
        }
        
        redirectAttributes.addFlashAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập");
        return "redirect:/login";
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
    
    @GetMapping("/access-denied")
    public String accessDenied() {
        return "access-denied";
    }
}