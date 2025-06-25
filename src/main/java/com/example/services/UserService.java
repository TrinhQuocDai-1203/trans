// src/main/java/com/example/service/UserService.java
package com.example.services;

import com.example.dao.UserDAO;
import com.example.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserService {
    
    private final UserDAO userDAO;
    
    @Autowired
    public UserService(UserDAO userDAO) {
        this.userDAO = userDAO;
    }
    
    // Kiểm tra đăng nhập
    public User authenticate(String numberPhone, String password) {
        User user = userDAO.findByNumberPhone(numberPhone);
        if (user != null && verifyPassword(password, user.getPassword())) {
            return user;
        }
        return null;
    }
    
    // Đăng ký tài khoản
    public boolean registerUser(User user) {
        // Kiểm tra username và email đã tồn tại chưa
        if (userDAO.findByNumberPhone(user.getNumberPhone()) != null) {
            return false;
        }
        // Mã hóa mật khẩu
        user.setPassword(hashPassword(user.getPassword()));
        
        // Mặc định role là USER nếu không được chỉ định
        if (user.getRole() == null) {
            user.setRole(User.Role.USER);
        }
        
        return userDAO.save(user);
    }
    
    // Mã hóa mật khẩu
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    // Kiểm tra mật khẩu
    private boolean verifyPassword(String inputPassword, String storedPassword) {
        return hashPassword(inputPassword).equals(storedPassword);
    }
    
    // Lấy người dùng theo ID
    public User getUserById(Long id) {
        return userDAO.findById(id);
    }
    
    // Lấy tất cả người dùng
    public List<User> getAllUsers() {
        return userDAO.findAll();
    }
    
    // Lấy người dùng theo vai trò
    public List<User> getUsersByRole(User.Role role) {
        return userDAO.findByRole(role);
    }
    
    public List<User> searchDriversByName(String name) {
        List<User> drivers = userDAO.findByRole(User.Role.DRIVER);
        if (name == null || name.trim().isEmpty()) {
            return drivers;
        }
        
        String nameLower = name.toLowerCase();
        return drivers.stream()
                .filter(driver -> driver.getFullName().toLowerCase().contains(nameLower))
                .collect(Collectors.toList());
    }
    
    // Lưu hoặc cập nhật người dùng
    public boolean saveUser(User user) {
        if (user.getId() == null) {
            // Nếu người dùng mới, mã hóa mật khẩu
            user.setPassword(hashPassword(user.getPassword()));
            return userDAO.save(user);
        } else {
            // Nếu người dùng tồn tại, kiểm tra xem có cần cập nhật mật khẩu không
            User existingUser = userDAO.findById(user.getId());
            
            // Nếu mật khẩu để trống, giữ nguyên mật khẩu cũ
            if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
                user.setPassword(existingUser.getPassword());
            } else if (!user.getPassword().equals(existingUser.getPassword())) {
                // Nếu mật khẩu đã thay đổi, mã hóa mật khẩu mới
                user.setPassword(hashPassword(user.getPassword()));
            }
            
            return userDAO.update(user);
        }
    }
}