<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Truy cập bị từ chối - Xe Di Dau Nhe</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        
        .container {
            max-width: 600px;
            margin: 100px auto;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 40px;
        }
        
        h1 {
            color: #e11d48;
            margin-bottom: 20px;
        }
        
        p {
            color: #4b5563;
            margin-bottom: 30px;
            font-size: 18px;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 24px;
            background-color: #4f46e5;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 16px;
        }
        
        .btn:hover {
            background-color: #4338ca;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Truy cập bị từ chối</h1>
        <p>Bạn không có quyền truy cập vào trang này. Vui lòng liên hệ quản trị viên nếu đây là sự cố.</p>
        <a href="${pageContext.request.contextPath}/" class="btn">Quay lại trang chủ</a>
    </div>
</body>
</html>