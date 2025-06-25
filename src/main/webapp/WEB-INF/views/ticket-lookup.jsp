<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tra cứu vé - FUTA Bus Lines</title>
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
            background-color: var(--primary-color);
            color: white;
            padding: 40px 0;
            margin-bottom: 40px;
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
        
        .lookup-form {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        
        .lookup-title {
            color: var(--primary-color);
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .lookup-btn {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-weight: 600;
            width: 100%;
            margin-top: 15px;
        }
        
        .lookup-btn:hover {
            background-color: #e55c00;
            color: white;
        }
        
        .ticket-result {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        
        .ticket-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .ticket-id {
            font-size: 18px;
            font-weight: 600;
        }
        
        .ticket-status {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 30px;
            font-size: 14px;
            font-weight: 600;
        }
        
        .status-reserved {
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
        
        .ticket-info {
            margin-bottom: 25px;
        }
        
        .info-label {
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 5px;
            display: block;
        }
        
        .info-value {
            font-weight: 600;
            font-size: 16px;
        }
        
        .trip-details {
            background-color: #f9fafb;
            padding: 15px;
            border-radius: 8px;
            margin-top: 15px;
        }
        
        .qr-code {
            text-align: center;
            margin-top: 20px;
            padding: 15px;
            background-color: #f9fafb;
            border-radius: 8px;
        }
        
        .qr-code img {
            max-width: 150px;
            margin-bottom: 10px;
        }
        
        .trip-route {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
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
        
        .alert-error {
            background-color: #fee2e2;
            color: #dc2626;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .ticket-actions {
            margin-top: 25px;
            display: flex;
            gap: 15px;
        }
        
        .btn-secondary {
            background-color: #6b7280;
            color: white;
            border: none;
        }
        
        .btn-secondary:hover {
            background-color: #4b5563;
            color: white;
        }
    </style>
</head>
<body>
    <!-- Header Component -->
    <jsp:include page="/WEB-INF/components/header.jsp" />
    
    <div class="section-header">
        <div class="container">
            <h1 class="section-title">Tra cứu vé</h1>
            <p class="section-subtitle">Kiểm tra thông tin vé của bạn một cách dễ dàng</p>
        </div>
    </div>
    
    <div class="container">
        <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="lookup-form">
                    <h2 class="lookup-title">Nhập thông tin vé</h2>
                    
                    <c:if test="${not empty error}">
                        <div class="alert-error mb-4">
                            <i class="fa-solid fa-circle-exclamation me-2"></i> ${error}
                        </div>
                    </c:if>
                    
                    <form action="${pageContext.request.contextPath}/tra-cuu-ve" method="post">
                        <div class="mb-3">
                            <label for="ticketId" class="form-label">Mã vé</label>
                            <input type="text" class="form-control" id="ticketId" name="ticketId" placeholder="Nhập mã vé của bạn" required>
                        </div>
                        
                        <div class="mb-3">
                            <label for="phone" class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại đặt vé" required>
                        </div>
                        
                        <button type="submit" class="btn lookup-btn">
                            <i class="fa-solid fa-magnifying-glass me-2"></i> Tra cứu vé
                        </button>
                    </form>
                </div>
                
                <c:if test="${found}">
                    <div class="ticket-result">
                        <div class="ticket-header">
                            <div class="ticket-id">
                                <i class="fa-solid fa-ticket me-2"></i> Vé #${ticket.id}
                            </div>
                            <div class="ticket-status ${ticket.status == 'PAID' ? 'status-paid' : ticket.status == 'CANCELLED' ? 'status-cancelled' : 'status-reserved'}">
                                <c:choose>
                                    <c:when test="${ticket.status == 'PAID'}">
                                        <i class="fa-solid fa-check-circle me-1"></i> Đã thanh toán
                                    </c:when>
                                    <c:when test="${ticket.status == 'CANCELLED'}">
                                        <i class="fa-solid fa-times-circle me-1"></i> Đã hủy
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa-solid fa-clock me-1"></i> Chờ thanh toán
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="ticket-info">
                                    <span class="info-label">Người đặt vé</span>
                                    <div class="info-value">${ticket.user.fullName}</div>
                                </div>
                                
                                <div class="ticket-info">
                                    <span class="info-label">Số điện thoại</span>
                                    <div class="info-value">${ticket.user.numberPhone}</div>
                                </div>
                                
                                <div class="ticket-info">
                                    <span class="info-label">Thời gian đặt vé</span>
                                    <div class="info-value">
                                        <fmt:formatDate value="${ticket.bookingDate}" pattern="dd/MM/yyyy HH:mm" />
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="ticket-info">
                                    <span class="info-label">Số ghế</span>
                                    <div class="info-value">${ticket.seat.seatNumber}</div>
                                </div>
                                
                                <div class="ticket-info">
                                    <span class="info-label">Giá vé</span>
                                    <div class="info-value">
                                        <fmt:formatNumber value="${ticket.price}" type="currency" currencySymbol="VND" maxFractionDigits="0" />
                                    </div>
                                </div>
                                
                                <div class="ticket-info">
                                    <span class="info-label">Điểm đón</span>
                                    <div class="info-value">${ticket.pickupLocation}</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="trip-details">
                            <h5 class="mb-3">Chi tiết chuyến đi</h5>
                            
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
                            
                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <span class="info-label">Tài xế</span>
                                        <div class="info-value">${ticket.trip.primaryDriver.fullName}</div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <span class="info-label">Xe</span>
                                        <div class="info-value">${ticket.trip.bus.licensePlate} (${ticket.trip.bus.busType})</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <%-- <c:if test="${ticket.status == 'PAID'}">
                            <div class="qr-code">
                                <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=FUTA-TICKET-${ticket.id}" alt="QR Code">
                                <div>Quét mã QR để xác nhận lên xe</div>
                            </div>
                        </c:if> --%>
                        
                        <c:if test="${ticket.status == 'RESERVED'}">
                            <div class="ticket-actions">
                                <a href="${pageContext.request.contextPath}/user/payment/${ticket.id}" class="btn lookup-btn">
                                    <i class="fa-solid fa-credit-card me-2"></i> Thanh toán ngay
                                </a>
                                
                                <a href="${pageContext.request.contextPath}/user/cancel-ticket/${ticket.id}" 
                                   class="btn btn-secondary" 
                                   onclick="return confirm('Bạn có chắc chắn muốn hủy vé này?')">
                                    <i class="fa-solid fa-times me-2"></i> Hủy vé
                                </a>
                            </div>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <!-- Footer Component -->
    <jsp:include page="/WEB-INF/components/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 