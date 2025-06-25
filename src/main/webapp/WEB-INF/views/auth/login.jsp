<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - FUTA Bus Lines</title>
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
            max-width: 450px;
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
        
        .success-message {
            color: #16a34a;
            margin-bottom: 15px;
            font-size: 14px;
            text-align: center;
            padding: 10px;
            background-color: #f0fdf4;
            border-radius: 6px;
            border: 1px solid #dcfce7;
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
        
        .forgot-password {
            text-align: right;
            margin-bottom: 20px;
        }
        
        .forgot-password a {
            color: #6b7280;
            font-size: 14px;
            text-decoration: none;
        }
        
        .forgot-password a:hover {
            color: var(--primary-color);
            text-decoration: underline;
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
            
            <h1 class="auth-title">Đăng nhập</h1>
            <p class="auth-subtitle">Đăng nhập để đặt vé xe và quản lý tài khoản của bạn</p>
            
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="success-message">${success}</div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/login" method="post">
                <input type="hidden" name="redirectUrl" value="${redirectUrl}" />
                
                <div class="form-group">
                    <label for="numberPhone" class="form-label">Số điện thoại</label>
                    <input type="text" id="numberPhone" name="numberPhone" class="form-control" placeholder="Nhập số điện thoại của bạn" required />
                </div>
                
                <div class="form-group">
                    <label for="password" class="form-label">Mật khẩu</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu của bạn" required />
                </div>
                
                <div class="forgot-password">
                    <a href="#">Quên mật khẩu?</a>
                </div>
                
                <button type="submit" class="auth-btn">Đăng nhập</button>
            </form>
            
            <div class="auth-separator">
                <span>Hoặc đăng nhập với</span>
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
                Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
            </div>
        </div>
    </div>
    
    <!-- Footer Component -->
    <jsp:include page="/WEB-INF/components/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>