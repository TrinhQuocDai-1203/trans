<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Đặt Vé - FUTA Bus Lines</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="/WEB-INF/components/header.jsp" />
    
    <main>
        <section class="bookings-section">
            <div class="container">
                <h1 class="section-title">Lịch Sử Đặt Vé</h1>
                
                <div class="bookings-container">
                    <div class="booking-filters">
                        <div class="search-box">
                            <input type="text" id="searchInput" placeholder="Tìm kiếm theo điểm đi, điểm đến..." class="search-input">
                            <button class="search-btn"><i class="fas fa-search"></i></button>
                        </div>
                        
                        <div class="filter-buttons">
                            <button class="filter-btn active" data-filter="all">Tất cả</button>
                            <button class="filter-btn" data-filter="RESERVED">Chờ thanh toán</button>
                            <button class="filter-btn" data-filter="PAID">Đã thanh toán</button>
                            <button class="filter-btn" data-filter="CANCELLED">Đã hủy</button>
                        </div>
                    </div>
                    
                    <div class="bookings-list">
                        <c:choose>
                            <c:when test="${empty tickets}">
                                <div class="no-bookings">
                                    <i class="fas fa-ticket-alt"></i>
                                    <p>Bạn chưa có vé nào. Hãy đặt vé để bắt đầu hành trình!</p>
                                    <a href="${pageContext.request.contextPath}/user/search-trips" class="btn-book-now">Đặt Vé Ngay</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${tickets}" var="ticket">
                                    <div class="booking-card" data-status="${ticket.status}">
                                        <div class="booking-header">
                                            <div class="booking-id">
                                                <span class="label">Mã vé:</span>
                                                <span class="value">#${ticket.id}</span>
                                            </div>
                                            <div class="booking-status ${ticket.status}">
                                                <c:choose>
                                                    <c:when test="${ticket.status eq 'RESERVED'}">
                                                        <i class="far fa-clock"></i> Chờ thanh toán
                                                    </c:when>
                                                    <c:when test="${ticket.status eq 'PAID'}">
                                                        <i class="fas fa-check-circle"></i> Đã thanh toán
                                                    </c:when>
                                                    <c:when test="${ticket.status eq 'CANCELLED'}">
                                                        <i class="fas fa-times-circle"></i> Đã hủy
                                                    </c:when>
                                                </c:choose>
                                            </div>
                                        </div>
                                        
                                        <div class="booking-body">
                                            <div class="trip-details">
                                                <div class="route">
                                                    <div class="location">
                                                        <div class="time"><fmt:formatDate value="${ticket.trip.departureTime}" pattern="HH:mm" /></div>
                                                        <div class="place">${ticket.trip.departureLocation}</div>
                                                    </div>
                                                    
                                                    <div class="arrow">
                                                        <i class="fas fa-arrow-right"></i>
                                                    </div>
                                                    
                                                    <div class="location">
                                                        <div class="time"><fmt:formatDate value="${ticket.trip.arrivalTime}" pattern="HH:mm" /></div>
                                                        <div class="place">${ticket.trip.destinationLocation}</div>
                                                    </div>
                                                </div>
                                                
                                                <div class="trip-info">
                                                    <div class="info-item">
                                                        <i class="far fa-calendar-alt"></i>
                                                        <span><fmt:formatDate value="${ticket.trip.departureTime}" pattern="dd/MM/yyyy" /></span>
                                                    </div>
                                                    
                                                    <div class="info-item">
                                                        <i class="fas fa-chair"></i>
                                                        <span>Ghế ${ticket.seat.seatNumber}</span>
                                                    </div>
                                                    
                                                    <div class="info-item">
                                                        <i class="fas fa-map-marker-alt"></i>
                                                        <span>Điểm đón: ${ticket.pickupLocation}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="booking-info">
                                                <div class="price">
                                                    <div class="amount"><fmt:formatNumber value="${ticket.price}" pattern="#,###" /> đ</div>
                                                    <div class="date">Đặt ngày: <fmt:formatDate value="${ticket.bookingDate}" pattern="dd/MM/yyyy" /></div>
                                                </div>
                                                
                                                <div class="booking-actions">
                                                    <c:choose>
                                                        <c:when test="${ticket.status eq 'RESERVED'}">
                                                            <a href="${pageContext.request.contextPath}/user/payment/${ticket.id}" class="btn-pay">
                                                                <i class="fas fa-money-bill-wave"></i> Thanh toán
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/user/cancel-ticket/${ticket.id}" class="btn-cancel">
                                                                <i class="fas fa-ban"></i> Hủy vé
                                                            </a>
                                                        </c:when>
                                                        <%-- <c:when test="${ticket.status eq 'PAID'}">
                                                            <button class="btn-view-details" onclick="showTicketDetails(${ticket.id})">
                                                                <i class="fas fa-info-circle"></i> Chi tiết
                                                            </button>
                                                            <button class="btn-download">
                                                                <i class="fas fa-download"></i> Tải vé
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="${pageContext.request.contextPath}/user/search-trips" class="btn-book-again">
                                                                <i class="fas fa-ticket-alt"></i> Đặt vé mới
                                                            </a>
                                                        </c:otherwise> --%>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Ticket Details Modal -->
        <div id="ticketModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <h2>Chi Tiết Vé</h2>
                
                <div class="ticket-details">
                    <div class="ticket-qr">
                        <img id="ticketQR" src="" alt="QR Code">
                    </div>
                    
                    <div class="ticket-info" id="ticketInfo">
                        <!-- Thông tin vé sẽ được cập nhật bằng JavaScript -->
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <jsp:include page="/WEB-INF/components/footer.jsp" />
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Filtering bookings
            const filterButtons = document.querySelectorAll('.filter-btn');
            const bookingCards = document.querySelectorAll('.booking-card');
            
            filterButtons.forEach(button => {
                button.addEventListener('click', () => {
                    // Remove active class from all buttons
                    filterButtons.forEach(btn => btn.classList.remove('active'));
                    
                    // Add active class to clicked button
                    button.classList.add('active');
                    
                    const filter = button.getAttribute('data-filter');
                    
                    bookingCards.forEach(card => {
                        if (filter === 'all' || card.getAttribute('data-status') === filter) {
                            card.style.display = 'block';
                        } else {
                            card.style.display = 'none';
                        }
                    });
                });
            });
            
            // Search functionality
            const searchInput = document.getElementById('searchInput');
            
            searchInput.addEventListener('keyup', () => {
                const searchTerm = searchInput.value.toLowerCase();
                
                bookingCards.forEach(card => {
                    const route = card.querySelector('.route').textContent.toLowerCase();
                    
                    if (route.includes(searchTerm)) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                });
            });
        });
        
        // Modal functionality
        const modal = document.getElementById('ticketModal');
        const closeBtn = document.querySelector('.close');
        
        closeBtn.onclick = function() {
            modal.style.display = 'none';
        }
        
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }
        
        function showTicketDetails(ticketId) {
            // In a real app, you would fetch ticket details from the server
            // For now, we'll just show a QR code with the ticket ID
            
            document.getElementById('ticketQR').src = 'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=FUTA_TICKET_' + ticketId;
            
            // Find ticket information from the page
            const card = document.querySelector(`.booking-card[data-id="${ticketId}"]`);
            const ticketInfoHtml = `
                <div class="detail-row">
                    <span class="label">Mã vé:</span>
                    <span class="value">#${ticketId}</span>
                </div>
                <!-- More details would be added here in a real app -->
            `;
            
            document.getElementById('ticketInfo').innerHTML = ticketInfoHtml;
            
            modal.style.display = 'block';
        }
    </script>
    
    <style>
        /* Reset CSS */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f8f9fa;
        }
        
        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
        }
        
        /* Bookings Section Styles */
        .bookings-section {
            padding: 40px 0;
        }
        
        .section-title {
            text-align: center;
            margin-bottom: 30px;
            color: #ff6600;
            font-size: 28px;
        }
        
        .bookings-container {
            background-color: white;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
        }
        
        /* Booking Filters Styles */
        .booking-filters {
            margin-bottom: 30px;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
        }
        
        .search-box {
            position: relative;
            flex: 1;
            min-width: 250px;
        }
        
        .search-input {
            width: 100%;
            padding: 12px 15px;
            padding-right: 40px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        .search-input:focus {
            border-color: #ff6600;
            outline: none;
        }
        
        .search-btn {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #6c757d;
            cursor: pointer;
        }
        
        .filter-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .filter-btn {
            padding: 8px 16px;
            border: 1px solid #ddd;
            border-radius: 20px;
            background-color: white;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 14px;
        }
        
        .filter-btn.active {
            background-color: #ff6600;
            color: white;
            border-color: #ff6600;
        }
        
        /* No Bookings Styles */
        .no-bookings {
            text-align: center;
            padding: 50px 20px;
            color: #6c757d;
        }
        
        .no-bookings i {
            font-size: 48px;
            margin-bottom: 20px;
            color: #ff6600;
        }
        
        .no-bookings p {
            margin-bottom: 20px;
            font-size: 18px;
        }
        
        .btn-book-now {
            display: inline-block;
            background-color: #ff6600;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s;
        }
        
        .btn-book-now:hover {
            background-color: #e55c00;
        }
        
        /* Booking Card Styles */
        .booking-card {
            border: 1px solid #eee;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 20px;
            transition: box-shadow 0.3s;
        }
        
        .booking-card:hover {
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .booking-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            background-color: #f8f9fa;
            border-bottom: 1px solid #eee;
        }
        
        .booking-id .label {
            color: #6c757d;
            margin-right: 5px;
        }
        
        .booking-id .value {
            font-weight: 600;
        }
        
        .booking-status {
            display: flex;
            align-items: center;
            font-size: 14px;
            font-weight: 500;
        }
        
        .booking-status i {
            margin-right: 5px;
        }
        
        .booking-status.RESERVED {
            color: #ffc107;
        }
        
        .booking-status.PAID {
            color: #28a745;
        }
        
        .booking-status.CANCELLED {
            color: #dc3545;
        }
        
        .booking-body {
            padding: 20px;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        
        .trip-details {
            flex: 1;
            min-width: 300px;
        }
        
        .route {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .location {
            text-align: center;
        }
        
        .time {
            font-size: 18px;
            font-weight: 600;
            color: #333;
        }
        
        .place {
            font-size: 14px;
            color: #6c757d;
        }
        
        .arrow {
            margin: 0 15px;
            color: #6c757d;
        }
        
        .trip-info {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .info-item {
            display: flex;
            align-items: center;
            font-size: 14px;
            color: #6c757d;
        }
        
        .info-item i {
            margin-right: 5px;
        }
        
        .booking-info {
            text-align: right;
            min-width: 200px;
            margin-left: 20px;
        }
        
        .price {
            margin-bottom: 15px;
        }
        
        .amount {
            font-size: 20px;
            font-weight: 600;
            color: #ff6600;
        }
        
        .date {
            font-size: 12px;
            color: #6c757d;
        }
        
        .booking-actions {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        
        .btn-pay, .btn-cancel, .btn-view-details, .btn-download, .btn-book-again {
            padding: 8px 15px;
            border-radius: 4px;
            text-align: center;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
        }
        
        .btn-pay, .btn-view-details, .btn-book-again {
            background-color: #ff6600;
            color: white;
            border: none;
        }
        
        .btn-pay:hover, .btn-view-details:hover, .btn-book-again:hover {
            background-color: #e55c00;
        }
        
        .btn-cancel {
            background-color: white;
            color: #6c757d;
            border: 1px solid #ddd;
        }
        
        .btn-cancel:hover {
            background-color: #f8f9fa;
        }
        
        .btn-download {
            background-color: #28a745;
            color: white;
            border: none;
        }
        
        .btn-download:hover {
            background-color: #218838;
        }
        
        .btn-pay i, .btn-cancel i, .btn-view-details i, .btn-download i, .btn-book-again i {
            margin-right: 5px;
        }
        
        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
        }
        
        .modal-content {
            background-color: white;
            margin: 10% auto;
            padding: 30px;
            border-radius: 8px;
            width: 80%;
            max-width: 600px;
            position: relative;
        }
        
        .close {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 28px;
            font-weight: bold;
            color: #6c757d;
            cursor: pointer;
        }
        
        .close:hover {
            color: #333;
        }
        
        .ticket-details {
            display: flex;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        
        .ticket-qr {
            flex: 1;
            min-width: 200px;
            display: flex;
            justify-content: center;
            padding: 20px;
        }
        
        .ticket-info {
            flex: 2;
            min-width: 300px;
            padding: 20px;
        }
        
        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        
        @media (max-width: 768px) {
            .booking-body {
                flex-direction: column;
            }
            
            .booking-info {
                margin-left: 0;
                margin-top: 20px;
                text-align: left;
            }
            
            .booking-actions {
                flex-direction: row;
                margin-top: 15px;
            }
            
            .btn-pay, .btn-cancel, .btn-view-details, .btn-download, .btn-book-again {
                flex: 1;
            }
        }
    </style>
</body>
</html> 