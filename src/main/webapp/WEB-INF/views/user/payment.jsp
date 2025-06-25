<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán - FUTA Bus Lines</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
        
        .payment-section {
            padding: 40px 0;
        }
        
        .section-title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .payment-container {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-bottom: 40px;
        }
        
        .ticket-summary {
            flex: 1;
            min-width: 300px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 25px;
        }
        
        .payment-methods {
            flex: 2;
            min-width: 400px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 25px;
        }
        
        .summary-title, .payment-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--primary-color);
        }
        
        .route-info {
            margin-bottom: 25px;
        }
        
        .route {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        
        .location {
            text-align: center;
        }
        
        .time {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .place {
            font-size: 14px;
            color: #6b7280;
        }
        
        .route-arrow {
            color: var(--primary-color);
            font-size: 24px;
        }
        
        .date {
            text-align: center;
            font-size: 14px;
            color: #6b7280;
            margin-top: 10px;
        }
        
        .date i {
            margin-right: 5px;
            color: var(--primary-color);
        }
        
        .detail-list {
            border-top: 1px solid #f3f4f6;
            border-bottom: 1px solid #f3f4f6;
            padding: 15px 0;
            margin-bottom: 20px;
        }
        
        .detail-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        
        .detail-item:last-child {
            margin-bottom: 0;
        }
        
        .label {
            font-size: 14px;
            color: #6b7280;
        }
        
        .value {
            font-weight: 600;
        }
        
        .value.seat {
            color: var(--primary-color);
        }
        
        .price-summary {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .price-summary .label {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-color);
        }
        
        .price-summary .value.price {
            font-size: 20px;
            font-weight: 700;
            color: var(--primary-color);
        }
        
        /* Payment Tabs */
        .payment-tabs {
            margin-bottom: 30px;
        }
        
        .tab-headers {
            display: flex;
            border-bottom: 1px solid #e5e7eb;
            margin-bottom: 20px;
        }
        
        .tab-header {
            padding: 12px 20px;
            cursor: pointer;
            border-bottom: 2px solid transparent;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            color: #6b7280;
        }
        
        .tab-header:hover {
            color: var(--primary-color);
        }
        
        .tab-header.active {
            color: var(--primary-color);
            border-bottom-color: var(--primary-color);
            font-weight: 600;
        }
        
        .tab-header i {
            margin-right: 10px;
            font-size: 18px;
        }
        
        .tab-content {
            display: none;
            padding: 10px 0;
        }
        
        .tab-content.active {
            display: block;
        }
        
        /* QR Code */
        .qr-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }
        
        .qr-code {
            margin-bottom: 20px;
        }
        
        .qr-info {
            color: #6b7280;
        }
        
        .qr-info .note {
            font-size: 13px;
            margin-top: 10px;
            color: #9ca3af;
        }
        
        /* Bank Transfer */
        .bank-info {
            padding: 20px;
            border-radius: 8px;
            background-color: #f9fafb;
        }
        
        .bank-account {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .bank-logo {
            width: 80px;
            margin-right: 20px;
        }
        
        .bank-logo img {
            width: 100%;
            height: auto;
        }
        
        .account-details {
            flex: 1;
        }
        
        .account-name {
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .account-number {
            font-size: 18px;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 5px;
        }
        
        .transfer-note {
            background-color: white;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            padding: 15px;
            position: relative;
        }
        
        .note-title {
            font-size: 14px;
            color: #6b7280;
            margin-bottom: 5px;
        }
        
        .note-content {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .btn-copy {
            position: absolute;
            top: 15px;
            right: 15px;
            background-color: #f3f4f6;
            border: none;
            border-radius: 4px;
            padding: 5px 10px;
            font-size: 14px;
            color: #6b7280;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .btn-copy:hover {
            background-color: #e5e7eb;
            color: var(--text-color);
        }
        
        /* Card Form */
        .card-form {
            padding: 10px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            color: #6b7280;
        }
        
        .form-control {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #e5e7eb;
            border-radius: 6px;
            font-size: 16px;
            transition: all 0.2s;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 2px rgba(255, 102, 0, 0.1);
        }
        
        .form-row {
            display: flex;
            gap: 15px;
        }
        
        .form-row .form-group {
            flex: 1;
        }
        
        /* Payment Actions */
        .payment-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn-confirm, .btn-cancel {
            padding: 12px 25px;
            border-radius: 6px;
            font-weight: 600;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-confirm {
            background-color: var(--primary-color);
            color: white;
            border: none;
            flex: 2;
        }
        
        .btn-confirm:hover {
            background-color: #e55c00;
        }
        
        .btn-cancel {
            background-color: #f3f4f6;
            color: #dc2626;
            border: 1px solid #e5e7eb;
            flex: 1;
        }
        
        .btn-cancel:hover {
            background-color: #fee2e2;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .payment-container {
                flex-direction: column;
            }
            
            .form-row {
                flex-direction: column;
                gap: 0;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/components/header.jsp" />
    
    <main>
        <section class="payment-section">
            <div class="container">
                <h1 class="section-title">Thanh Toán Vé</h1>
                
                <div class="payment-container">
                    <div class="ticket-summary">
                        <h2 class="summary-title"><i class="fas fa-ticket-alt me-2"></i>Thông Tin Vé</h2>
                        
                        <div class="summary-content">
                            <div class="route-info">
                                <div class="route">
                                    <div class="location departure">
                                        <div class="time"><fmt:formatDate value="${ticket.trip.departureTime}" pattern="HH:mm" /></div>
                                        <div class="place">${ticket.trip.departureLocation}</div>
                                    </div>
                                    
                                    <div class="route-arrow">
                                        <i class="fas fa-long-arrow-alt-right"></i>
                                    </div>
                                    
                                    <div class="location arrival">
                                        <div class="time"><fmt:formatDate value="${ticket.trip.arrivalTime}" pattern="HH:mm" /></div>
                                        <div class="place">${ticket.trip.destinationLocation}</div>
                                    </div>
                                </div>
                                
                                <div class="date">
                                    <i class="far fa-calendar-alt"></i>
                                    <span><fmt:formatDate value="${ticket.trip.departureTime}" pattern="dd/MM/yyyy" /></span>
                                </div>
                            </div>
                            
                            <div class="alert alert-danger mb-3">
                                <i class="fas fa-clock me-2"></i>
                                <strong>Thời hạn thanh toán:</strong> 
                                <span id="countdown">Đang tính...</span>
                                <div class="mt-2">Vé sẽ tự động bị hủy sau khi hết thời hạn thanh toán!</div>
                            </div>
                            
                            <div class="detail-list">
                                <div class="detail-item">
                                    <div class="label">Số ghế:</div>
                                    <div class="value seat">${ticket.seat.seatNumber}</div>
                                </div>
                                
                                <div class="detail-item">
                                    <div class="label">Loại xe:</div>
                                    <div class="value">${ticket.trip.bus.busType} - ${ticket.trip.bus.capacity} chỗ</div>
                                </div>
                                
                                <div class="detail-item">
                                    <div class="label">Điểm đón:</div>
                                    <div class="value">${ticket.pickupLocation}</div>
                                </div>
                                
                                <div class="detail-item">
                                    <div class="label">Tài xế:</div>
                                    <div class="value">${ticket.trip.primaryDriver.fullName}</div>
                                </div>
                                
                                <div class="detail-item">
                                    <div class="label">Liên hệ tài xế:</div>
                                    <div class="value">${ticket.trip.primaryDriver.numberPhone}</div>
                                </div>
                                
                                <div class="detail-item">
                                    <div class="label">Ngày đặt vé:</div>
                                    <div class="value"><fmt:formatDate value="${ticket.bookingDate}" pattern="dd/MM/yyyy HH:mm" /></div>
                                </div>
                                
                                <div class="detail-item">
                                    <div class="label">Trạng thái:</div>
                                    <div class="value">
                                        <span class="badge bg-warning text-dark">
                                            <i class="fas fa-clock me-1"></i> Chờ thanh toán
                                        </span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="price-summary">
                                <div class="label">Tổng tiền:</div>
                                <div class="value price"><fmt:formatNumber value="${ticket.price}" pattern="#,###" /> đ</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="payment-methods">
                        <h2 class="payment-title"><i class="fas fa-credit-card me-2"></i>Phương Thức Thanh Toán</h2>
                        
                        <div class="payment-tabs">
                            <div class="tab-headers">
                                <div class="tab-header active" data-tab="qr-payment">
                                    <i class="fas fa-qrcode"></i>
                                    <span>QR Code</span>
                                </div>
                                <div class="tab-header" data-tab="bank-transfer">
                                    <i class="fas fa-university"></i>
                                    <span>Chuyển khoản</span>
                                </div>
                            </div>
                            
                            <div class="tab-contents">
                                <div class="tab-content active" id="qr-payment">
                                    <div class="qr-container">
                                        <div class="qr-code">
                                            <img src="https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=FUTA_BUS_LINES_PAYMENT_ID_${ticket.id}_AMOUNT_${ticket.price}" alt="QR Code">
                                        </div>
                                        <div class="transfer-note">
                                            <div class="note-title">Nội dung chuyển khoản:</div>
                                            <div class="note-content">FUTA-${ticket.id}-${ticket.seat.seatNumber}</div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="tab-content" id="bank-transfer">
                                    <div class="bank-info">
                                        <div class="bank-account">
                                            <div class="bank-logo">
                                                <img src="https://pluspng.com/img-png/vietcombank-logo-png-vietcombank-com-vn-android-app-300.png" alt="Vietcombank">
                                            </div>
                                            <div class="account-details">
                                                <div class="account-name">FUTA Bus Lines</div>
                                                <div class="account-number">1019940324</div>
                                                <div class="bank-name">Vietcombank</div>
                                            </div>
                                        </div>
                                        
                                        <div class="transfer-note">
                                            <div class="note-title">Nội dung chuyển khoản:</div>
                                            <div class="note-content">FUTA-${ticket.id}-${ticket.seat.seatNumber}</div>
                                            <button class="btn-copy" onclick="copyToClipboard('FUTA-${ticket.id}-${ticket.seat.seatNumber}')">
                                                <i class="far fa-copy"></i> Sao chép
                                            </button>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/user/confirm-payment" method="post">
                            <input type="hidden" name="ticketId" value="${ticket.id}">
                            <div class="payment-actions">
                                <button type="submit" class="btn-confirm">
                                    <i class="fas fa-check-circle me-2"></i> Xác Nhận Thanh Toán
                                </button>
                                <a href="${pageContext.request.contextPath}/user/cancel-ticket/${ticket.id}" class="btn-cancel" onclick="return confirm('Bạn có chắc chắn muốn hủy giao dịch này?')">
                                    <i class="fas fa-times-circle me-2"></i> Hủy
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </main>
    
    <jsp:include page="/WEB-INF/components/footer.jsp" />
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const tabHeaders = document.querySelectorAll('.tab-header');
            
            tabHeaders.forEach(header => {
                header.addEventListener('click', function() {
                    // Remove active class from all headers
                    document.querySelectorAll('.tab-header').forEach(h => {
                        h.classList.remove('active');
                    });
                    
                    // Add active class to clicked header
                    this.classList.add('active');
                    
                    // Hide all tab contents
                    document.querySelectorAll('.tab-content').forEach(content => {
                        content.classList.remove('active');
                    });
                    
                    // Show the corresponding tab content
                    const tabId = this.getAttribute('data-tab');
                    document.getElementById(tabId).classList.add('active');
                });
            });
        });
        
        function copyToClipboard(text) {
            const tempInput = document.createElement('input');
            tempInput.value = text;
            document.body.appendChild(tempInput);
            tempInput.select();
            document.execCommand('copy');
            document.body.removeChild(tempInput);
            
            alert('Đã sao chép nội dung chuyển khoản!');
        }
        
        // Countdown timer for payment deadline
        document.addEventListener('DOMContentLoaded', function() {
            // Get payment deadline from the server
            var deadlineStr = "${ticket.paymentDeadline}"; // Format: yyyy-MM-dd HH:mm:ss
            var deadline = new Date(deadlineStr.replace(/-/g, '/'));
            
            // Update the countdown every second
            var countdownElement = document.getElementById('countdown');
            
            function updateCountdown() {
                var now = new Date();
                var timeLeft = deadline - now;
                
                if (timeLeft <= 0) {
                    countdownElement.innerHTML = "Đã hết thời gian thanh toán!";
                    countdownElement.style.color = "red";
                    countdownElement.style.fontWeight = "bold";
                    
                    // Redirect to booking page after 3 seconds
                    setTimeout(function() {
                        window.location.href = "${pageContext.request.contextPath}/user/bookings";
                    }, 3000);
                    
                    return;
                }
                
                var minutes = Math.floor((timeLeft % (1000 * 60 * 60)) / (1000 * 60));
                var seconds = Math.floor((timeLeft % (1000 * 60)) / 1000);
                
                countdownElement.innerHTML = minutes + " phút " + seconds + " giây";
                
                // Change color when less than 2 minutes left
                if (timeLeft < 2 * 60 * 1000) {
                    countdownElement.style.color = "red";
                    countdownElement.style.fontWeight = "bold";
                }
            }
            
            // Update immediately and then every second
            updateCountdown();
            setInterval(updateCountdown, 1000);
        });
    </script>
</body>
</html> 