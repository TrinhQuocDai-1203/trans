<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - FUTA Bus Lines</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        :root {
            --primary-color: #ff6600;
            --secondary-color: #f8f9fa;
            --text-color: #333;
            --light-color: #ffffff;
            --border-color: #d1d5db;
        }
        
        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--secondary-color);
            line-height: 1.6;
            color: var(--text-color);
        }
        
        .auth-container {
            max-width: 500px;
            margin: 50px auto;
            background-color: var(--light-color);
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        
        .auth-logo {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .auth-logo img {
            height: 60px;
        }
        
        .auth-title {
            text-align: center;
            color: var(--primary-color);
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 25px;
        }
        
        .auth-subtitle {
            text-align: center;
            color: #666;
            font-size: 16px;
            margin-bottom: 25px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-color);
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            font-size: 15px;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(255, 102, 0, 0.15);
            outline: none;
        }
        
        .auth-btn {
            display: block;
            width: 100%;
            padding: 12px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-align: center;
            transition: background-color 0.3s;
        }
        
        .auth-btn:hover {
            background-color: #e55c00;
        }
        
        .error-message {
            color: #e11d48;
            margin-bottom: 15px;
            font-size: 14px;
            text-align: center;
            padding: 10px;
            background-color: #fef2f2;
            border-radius: 6px;
            border: 1px solid #fee2e2;
        }
        
        .auth-links {
            text-align: center;
            margin-top: 25px;
            font-size: 15px;
            color: #666;
        }
        
        .auth-links a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }
        
        .auth-links a:hover {
            text-decoration: underline;
        }
        
        .auth-separator {
            display: flex;
            align-items: center;
            margin: 25px 0;
        }
        
        .auth-separator::before,
        .auth-separator::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .auth-separator span {
            padding: 0 10px;
            color: #6b7280;
            font-size: 14px;
        }
        
        .social-login {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .social-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: #f3f4f6;
            color: #333;
            border: 1px solid #e5e7eb;
            transition: all 0.3s;
        }
        
        .social-btn:hover {
            background-color: #e5e7eb;
        }
        
        .terms-text {
            text-align: center;
            margin-top: 20px;
            font-size: 13px;
            color: #6b7280;
        }
        
        .terms-text a {
            color: var(--primary-color);
            text-decoration: none;
        }
        
        .terms-text a:hover {
            text-decoration: underline;
        }
        
        .password-requirements {
            font-size: 13px;
            color: #6b7280;
            margin-top: 5px;
        }
        
        .password-requirements ul {
            margin-top: 5px;
            padding-left: 20px;
        }
        
        .password-requirements li {
            margin-bottom: 3px;
        }
    </style>
</head>
<body>
    <!-- Header Component -->
    <jsp:include page="/WEB-INF/components/header.jsp" />
    
    <div class="container">
        <div class="auth-container">
            <div class="auth-logo">
                <div style="display: flex; flex-direction: column; align-items: center;">
                    <span style="font-size: 28px; font-weight: bold; color: #ff6600;">FUTA Bus Lines</span>
                    <span style="font-size: 14px; color: #666;">CHẤT LƯỢNG LÀ DANH DỰ</span>
                </div>
            </div>
            
            <h1 class="auth-title">Tạo tài khoản mới</h1>
            <p class="auth-subtitle">Đăng ký để trải nghiệm dịch vụ đặt vé xe tốt nhất</p>
            
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
                <div class="form-group">
                    <label for="numberPhone" class="form-label">Số điện thoại</label>
                    <input type="text" id="numberPhone" name="numberPhone" class="form-control" placeholder="Nhập số điện thoại của bạn" required />
                    <div id="phoneError" class="password-requirements" style="color: #e11d48; display: none;">Số điện thoại không hợp lệ. Vui lòng nhập số.</div>
                </div>
                
                <div class="form-group">
                    <label for="fullName" class="form-label">Họ tên</label>
                    <input type="text" id="fullName" name="fullName" class="form-control" placeholder="Nhập họ tên đầy đủ của bạn" required />
                </div>
                
                <div class="form-group">
                    <label for="password" class="form-label">Mật khẩu</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Tạo mật khẩu mới" required />
                    <div class="password-requirements">
                        Mật khẩu phải có:
                        <ul>
                            <li>Ít nhất 8 ký tự</li>
                            <li>Ít nhất 1 chữ cái viết hoa</li>
                            <li>Ít nhất 1 ký tự đặc biệt hoặc số</li>
                        </ul>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu" required />
                    <div id="passwordError" class="password-requirements" style="color: #e11d48; display: none;">Mật khẩu xác nhận không khớp.</div>
                </div>
                
                <button type="submit" class="auth-btn" id="registerBtn">Đăng ký</button>
                
                <div class="terms-text">
                    Bằng việc đăng ký, bạn đồng ý với <a href="#">Điều khoản dịch vụ</a> và <a href="#">Chính sách bảo mật</a> của chúng tôi.
                </div>
            </form>
            
            <div class="auth-separator">
                <span>Hoặc đăng ký với</span>
            </div>
            
            <div class="social-login">
                <a href="#" class="social-btn">
                    <i class="fab fa-facebook-f"></i>
                </a>
                <a href="#" class="social-btn">
                    <i class="fab fa-google"></i>
                </a>
                <a href="#" class="social-btn">
                    <i class="fab fa-apple"></i>
                </a>
            </div>
            
            <div class="auth-links">
                Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
            </div>
        </div>
    </div>
    
    <!-- Footer Component -->
    <jsp:include page="/WEB-INF/components/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('registerForm');
            const phoneInput = document.getElementById('numberPhone');
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            const phoneError = document.getElementById('phoneError');
            const passwordError = document.getElementById('passwordError');
            
            // Validate phone number on input
            phoneInput.addEventListener('input', function() {
                const regex = /^[0-9]+$/;
                if (!regex.test(this.value)) {
                    phoneError.style.display = 'block';
                } else {
                    phoneError.style.display = 'none';
                }
            });
            
            // Validate password match on input
            confirmPassword.addEventListener('input', function() {
                if (this.value !== password.value) {
                    passwordError.style.display = 'block';
                } else {
                    passwordError.style.display = 'none';
                }
            });
            
            // Form submission validation
            form.addEventListener('submit', function(e) {
                // Check phone number
                const regex = /^[0-9]+$/;
                if (!regex.test(phoneInput.value)) {
                    phoneError.style.display = 'block';
                    e.preventDefault();
                    phoneInput.focus();
                    return false;
                }
                
                // Check password match
                if (password.value !== confirmPassword.value) {
                    passwordError.style.display = 'block';
                    e.preventDefault();
                    confirmPassword.focus();
                    return false;
                }
                
                return true;
            });
        });
    </script>
</body>
</html>