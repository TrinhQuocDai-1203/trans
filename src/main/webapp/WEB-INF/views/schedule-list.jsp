<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch trình chuyến xe - FUTA Bus Lines</title>
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
        
        .hero-section {
            background-color: var(--primary-color);
            color: white;
            padding: 40px 0;
            margin-bottom: 40px;
            text-align: center;
        }
        
        .hero-title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .hero-subtitle {
            font-size: 18px;
            opacity: 0.9;
            margin-bottom: 15px;
        }
        
        .trip-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 25px;
            overflow: hidden;
            transition: transform 0.3s ease;
        }
        
        .trip-card:hover {
            transform: translateY(-5px);
        }
        
        .trip-header {
            background-color: #f9fafb;
            padding: 15px 20px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .trip-date {
            font-weight: 600;
            color: #4b5563;
        }
        
        .trip-status {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 30px;
            font-size: 14px;
            font-weight: 600;
        }
        
        .status-available {
            background-color: #d1fae5;
            color: #059669;
        }
        
        .status-limited {
            background-color: #fef3c7;
            color: #d97706;
        }
        
        .status-full {
            background-color: #fee2e2;
            color: #dc2626;
        }
        
        .trip-body {
            padding: 20px;
        }
        
        .trip-route {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .route-point {
            flex: 1;
        }
        
        .route-line {
            flex: 2;
            height: 2px;
            background-color: #e5e7eb;
            position: relative;
            margin: 0 15px;
        }
        
        .route-line::before, 
        .route-line::after {
            content: '';
            position: absolute;
            top: -4px;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background-color: var(--primary-color);
        }
        
        .route-line::before {
            left: 0;
        }
        
        .route-line::after {
            right: 0;
        }
        
        .route-point-title {
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .route-point-subtitle {
            font-size: 14px;
            color: #6b7280;
        }
        
        .trip-details {
            display: flex;
            flex-wrap: wrap;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #f3f4f6;
        }
        
        .detail-item {
            flex: 1;
            min-width: 120px;
            margin-bottom: 15px;
        }
        
        .detail-label {
            font-size: 14px;
            color: #6b7280;
            margin-bottom: 5px;
        }
        
        .detail-value {
            font-weight: 600;
        }
        
        .trip-actions {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #f3f4f6;
        }
        
        .book-btn {
            display: block;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 5px;
            padding: 12px 20px;
            font-weight: 600;
            text-align: center;
            width: 100%;
        }
        
        .book-btn:hover {
            background-color: #e55c00;
            color: white;
        }
        
        .book-btn.disabled {
            background-color: #d1d5db;
            color: #6b7280;
            cursor: not-allowed;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .empty-icon {
            font-size: 60px;
            color: #d1d5db;
            margin-bottom: 20px;
        }
        
        .empty-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #4b5563;
        }
        
        .empty-subtitle {
            color: #6b7280;
            margin-bottom: 30px;
        }
        
        .remaining-seats {
            font-weight: 600;
            color: #059669;
        }
        
        .limited-seats {
            color: #d97706;
        }
        
        .no-seats {
            color: #dc2626;
        }
        
        .search-box {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        
        .search-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--primary-color);
        }
        
        .search-link {
            display: inline-block;
            color: var(--primary-color);
            font-weight: 600;
            text-decoration: none;
            padding: 8px 15px;
            border: 2px solid var(--primary-color);
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        
        .search-link:hover {
            background-color: var(--primary-color);
            color: white;
        }
    </style>
</head>
<body>
    <!-- Header Component -->
    <jsp:include page="/WEB-INF/components/header.jsp" />
    
    <div class="hero-section">
        <div class="container">
            <h1 class="hero-title">Lịch trình chuyến xe</h1>
            <p class="hero-subtitle">Tất cả các chuyến xe sắp khởi hành của FUTA Bus Lines</p>
        </div>
    </div>
    
    <div class="container">
        <div class="search-box">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h3 class="search-title mb-md-0">Tìm kiếm chuyến xe phù hợp với lịch trình của bạn?</h3>
                </div>
                <div class="col-md-4 text-md-end">
                    <a href="${pageContext.request.contextPath}/" class="search-link">
                        <i class="fa-solid fa-search me-2"></i> Tìm kiếm chuyến xe
                    </a>
                </div>
            </div>
        </div>
        
        <c:choose>
            <c:when test="${not empty trips}">
                <div class="row">
                    <c:forEach items="${trips}" var="trip">
                        <div class="col-md-6 col-lg-4">
                            <div class="trip-card">
                                <div class="trip-header">
                                    <div class="trip-date">
                                        <fmt:formatDate value="${trip.departureTime}" pattern="dd/MM/yyyy" />
                                    </div>
                                    <c:set var="availableSeats" value="${trip.availableSeats}" />
                                    <div class="trip-status ${availableSeats > 10 ? 'status-available' : availableSeats > 0 ? 'status-limited' : 'status-full'}">
                                        <c:choose>
                                            <c:when test="${availableSeats > 10}">
                                                <i class="fa-solid fa-check-circle me-1"></i> Còn nhiều chỗ
                                            </c:when>
                                            <c:when test="${availableSeats > 0}">
                                                <i class="fa-solid fa-exclamation-circle me-1"></i> Sắp hết chỗ
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fa-solid fa-times-circle me-1"></i> Hết chỗ
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                
                                <div class="trip-body">
                                    <div class="trip-route">
                                        <div class="route-point text-start">
                                            <div class="route-point-title">${trip.departureLocation}</div>
                                            <div class="route-point-subtitle">
                                                <fmt:formatDate value="${trip.departureTime}" pattern="HH:mm" />
                                            </div>
                                        </div>
                                        
                                        <div class="route-line"></div>
                                        
                                        <div class="route-point text-end">
                                            <div class="route-point-title">${trip.destinationLocation}</div>
                                            <div class="route-point-subtitle">
                                                <fmt:formatDate value="${trip.arrivalTime}" pattern="HH:mm" />
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="trip-details">
                                        <div class="detail-item">
                                            <div class="detail-label">Loại xe</div>
                                            <div class="detail-value">${trip.bus.busType}</div>
                                        </div>
                                        
                                        <div class="detail-item">
                                            <div class="detail-label">Biển số</div>
                                            <div class="detail-value">${trip.bus.licensePlate}</div>
                                        </div>
                                        
                                        <div class="detail-item">
                                            <div class="detail-label">Giá vé</div>
                                            <div class="detail-value">
                                                <fmt:formatNumber value="${trip.price}" type="currency" currencySymbol="VND" maxFractionDigits="0" />
                                            </div>
                                        </div>
                                        
                                        <div class="detail-item">
                                            <div class="detail-label">Số ghế trống</div>
                                            <div class="detail-value ${availableSeats > 10 ? 'remaining-seats' : availableSeats > 0 ? 'limited-seats' : 'no-seats'}">
                                                ${availableSeats} / ${trip.bus.capacity}
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="trip-actions">
                                        <c:choose>
                                            <c:when test="${availableSeats > 0}">
                                                <a href="${pageContext.request.contextPath}/user/book-trip/${trip.id}" class="book-btn">
                                                    <i class="fa-solid fa-ticket me-2"></i> Đặt vé ngay
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="#" class="book-btn disabled">
                                                    <i class="fa-solid fa-ban me-2"></i> Hết vé
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">
                        <i class="fa-solid fa-bus"></i>
                    </div>
                    <h3 class="empty-title">Không tìm thấy chuyến xe nào</h3>
                    <p class="empty-subtitle">Hiện tại chưa có chuyến xe nào trong lịch trình.</p>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                        <i class="fa-solid fa-home me-2"></i> Quay lại trang chủ
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- Footer Component -->
    <jsp:include page="/WEB-INF/components/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>