<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử mua vé - Kim Quy Bus</title>
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
        
        .section-header {
            /* background-color: var(--primary-color); */
            /* color: white; */
            padding: 40px 0;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .section-title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .section-subtitle {
            font-size: 18px;
            opacity: 0.9;
        }
        
        .filter-bar {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        
        .filter-label {
            font-weight: 600;
            margin-right: 15px;
            color: #4b5563;
        }
        
        .filter-btn {
            border: 2px solid var(--border-color);
            background-color: white;
            color: #4b5563;
            border-radius: 30px;
            padding: 8px 20px;
            margin-right: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .filter-btn:hover {
            background-color: #f3f4f6;
        }
        
        .filter-btn.active {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }
        
        .ticket-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 25px;
            overflow: hidden;
            transition: transform 0.3s ease;
        }
        
        .ticket-card:hover {
            transform: translateY(-5px);
        }
        
        .ticket-header {
            background-color: #f9fafb;
            padding: 15px 20px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .ticket-id {
            font-weight: 600;
            color: #4b5563;
        }
        
        .ticket-date {
            font-size: 14px;
            color: #6b7280;
        }
        
        .ticket-status {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 30px;
            font-size: 14px;
            font-weight: 600;
        }
        
        .status-reserved, .status-pending {
            background-color: #fef3c7;
            color: #d97706;
        }
        
        .status-paid {
            background-color: #d1fae5;
            color: #059669;
        }
        
        .status-cancelled {
            background-color: #fee2e2;
            color: #dc2626;
        }
        
        .status-confirmed {
            background-color: #c6f6d5;
            color: #047857;
        }
        
        .ticket-body {
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
        
        .ticket-details {
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
        
        .ticket-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #f3f4f6;
        }
        
        .action-btn {
            flex: 1;
            text-align: center;
            padding: 10px;
            border-radius: 5px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        
        .btn-pay {
            background-color: var(--primary-color);
            color: white;
        }
        
        .btn-pay:hover {
            background-color: #e55c00;
            color: white;
        }
        
        .btn-view {
            background-color: #f3f4f6;
            color: #4b5563;
        }
        
        .btn-view:hover {
            background-color: #e5e7eb;
            color: #1f2937;
        }
        
        .btn-cancel {
            background-color: #f3f4f6;
            color: #dc2626;
        }
        
        .btn-cancel:hover {
            background-color: #fee2e2;
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
        
        .alert-success {
            background-color: #d1fae5;
            color: #059669;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .alert-success i {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <!-- Header Component -->
    <jsp:include page="/WEB-INF/components/header.jsp" />
    
    <div class="section-header">
        <div class="container">
            <h1 class="section-title">Lịch sử mua vé</h1>
            <p class="section-subtitle">Quản lý các vé bạn đã đặt một cách dễ dàng</p>
        </div>
    </div>
    
    <div class="container">
        <c:if test="${not empty successMessage}">
            <div class="alert-success mb-4">
                <i class="fa-solid fa-check-circle"></i> ${successMessage}
            </div>
        </c:if>
        
        <div class="filter-bar" >
            <span class="filter-label">Lọc theo trạng thái:</span>
            <a href="${pageContext.request.contextPath}/user/history" style="text-decoration: none;" class="filter-btn ${empty param.status ? 'active' : ''}">
                <i class="fa-solid fa-filter me-1"></i> Tất cả
            </a>
            <a href="${pageContext.request.contextPath}/user/history?status=PENDING" style="text-decoration: none;" class="filter-btn ${param.status == 'PENDING' ? 'active' : ''}">
                <i class="fa-solid fa-clock me-1"></i> Chờ xác nhận
            </a>
            <a href="${pageContext.request.contextPath}/user/history?status=PAID" style="text-decoration: none;" class="filter-btn ${param.status == 'PAID' ? 'active' : ''}">
                <i class="fa-solid fa-credit-card me-1"></i> Đã thanh toán
            </a>
            <a href="${pageContext.request.contextPath}/user/history?status=CONFIRMED" style="text-decoration: none;" class="filter-btn ${param.status == 'CONFIRMED' ? 'active' : ''}">
                <i class="fa-solid fa-check-circle me-1"></i> Đã xác nhận
            </a>
            <a href="${pageContext.request.contextPath}/user/history?status=CANCELLED" style="text-decoration: none;" class="filter-btn ${param.status == 'CANCELLED' ? 'active' : ''}">
                <i class="fa-solid fa-times-circle me-1"></i> Đã hủy
            </a>
        </div>
        
        <c:choose>
            <c:when test="${not empty tickets}">
                <div class="row">
                    <c:forEach items="${tickets}" var="ticket">
                        <div class="col-md-6 col-lg-4">
                            <div class="ticket-card">
                                <div class="ticket-header">
                                    <div>
                                        <div class="ticket-id">Vé #${ticket.id}</div>
                                        <div class="ticket-date">
                                            <i class="fa-regular fa-calendar me-1"></i>
                                            <fmt:formatDate value="${ticket.bookingDate}" pattern="dd/MM/yyyy HH:mm" />
                                        </div>
                                    </div>
                                    <div class="ticket-status ${ticket.status == 'PAID' ? 'status-paid' : ticket.status == 'CANCELLED' ? 'status-cancelled' : ticket.status == 'CONFIRMED' ? 'status-confirmed' : 'status-pending'}">
                                        <c:choose>
                                            <c:when test="${ticket.status == 'PAID'}">
                                                <i class="fa-solid fa-credit-card me-1"></i> Đã thanh toán
                                            </c:when>
                                            <c:when test="${ticket.status == 'CANCELLED'}">
                                                <i class="fa-solid fa-times-circle me-1"></i> Đã hủy
                                            </c:when>
                                            <c:when test="${ticket.status == 'CONFIRMED'}">
                                                <i class="fa-solid fa-check-circle me-1"></i> Đã xác nhận
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fa-solid fa-clock me-1"></i> Chờ xác nhận
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                
                                <div class="ticket-body">
                                    <div class="trip-route">
                                        <div class="route-point text-start">
                                            <div class="route-point-title">${ticket.trip.departureLocation}</div>
                                            <div class="route-point-subtitle">
                                                <fmt:formatDate value="${ticket.trip.departureTime}" pattern="HH:mm, dd/MM/yyyy" />
                                            </div>
                                        </div>
                                        
                                        <div class="route-line"></div>
                                        
                                        <div class="route-point text-end">
                                            <div class="route-point-title">${ticket.trip.destinationLocation}</div>
                                            <div class="route-point-subtitle">
                                                <fmt:formatDate value="${ticket.trip.arrivalTime}" pattern="HH:mm, dd/MM/yyyy" />
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="ticket-details">
                                        <div class="detail-item">
                                            <div class="detail-label">Số ghế</div>
                                            <div class="detail-value">${ticket.seat.seatNumber}</div>
                                        </div>
                                        
                                        <div class="detail-item">
                                            <div class="detail-label">Điểm đón</div>
                                            <div class="detail-value">${ticket.pickupLocation}</div>
                                        </div>
                                        
                                        <div class="detail-item">
                                            <div class="detail-label">Giá vé</div>
                                            <div class="detail-value">
                                                <fmt:formatNumber value="${ticket.price}" type="currency" currencySymbol="" maxFractionDigits="0" /> VND
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="ticket-actions">
                                        <c:choose>
                                            <c:when test="${ticket.status == 'PENDING'}">
                                                <a href="${pageContext.request.contextPath}/user/payment/${ticket.id}" class="action-btn btn-pay" style="text-decoration: none;">
                                                    <i class="fa-solid fa-credit-card me-2"></i> Thanh toán
                                                </a>
                                                <a href="${pageContext.request.contextPath}/tra-cuu-ve?ticketId=${ticket.id}&phone=${ticket.user.numberPhone}" class="action-btn btn-view" style="text-decoration: none;">
                                                    <i class="fa-solid fa-eye me-2"></i> Chi tiết
                                                </a>
                                                <a href="${pageContext.request.contextPath}/user/cancel-ticket/${ticket.id}" 
                                                   style="text-decoration: none;"
                                                   class="action-btn btn-cancel"
                                                   onclick="return confirm('Bạn có chắc chắn muốn hủy vé này?')">
                                                    <i class="fa-solid fa-times me-2"></i> Hủy vé
                                                </a>
                                            </c:when>
                                            <c:when test="${ticket.status == 'PAID'}">
                                                <a href="${pageContext.request.contextPath}/tra-cuu-ve?ticketId=${ticket.id}&phone=${ticket.user.numberPhone}" style="text-decoration: none;" class="action-btn btn-view">
                                                    <i class="fa-solid fa-eye me-2"></i> Xem chi tiết
                                                </a>
                                                <a href="${pageContext.request.contextPath}/user/cancel-ticket/${ticket.id}" 
                                                   style="text-decoration: none;"
                                                   class="action-btn btn-cancel"
                                                   onclick="return confirm('Bạn có chắc chắn muốn hủy vé này?')">
                                                    <i class="fa-solid fa-times me-2"></i> Hủy vé
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/tra-cuu-ve?ticketId=${ticket.id}&phone=${ticket.user.numberPhone}" style="text-decoration: none;" class="action-btn btn-view" style="flex: 2;">
                                                    <i class="fa-solid fa-eye me-2"></i> Xem chi tiết
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
                        <i class="fa-solid fa-ticket"></i>
                    </div>
                    <h3 class="empty-title">Không tìm thấy vé nào</h3>
                    <p class="empty-subtitle">Bạn chưa có vé xe nào trong hệ thống của chúng tôi.</p>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                        <i class="fa-solid fa-search me-2"></i> Tìm chuyến xe ngay
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