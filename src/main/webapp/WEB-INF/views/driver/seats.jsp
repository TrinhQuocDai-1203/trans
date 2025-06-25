<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sơ đồ ghế - Xe Di Dau Nhe</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/seats.css">
</head>
<body>
    <jsp:include page="/WEB-INF/components/header.jsp" />
    
    <div class="container">
        <h1 class="page-title">Sơ đồ ghế</h1>
        
        <jsp:include page="/WEB-INF/views/driver/driver-nav.jsp" />
        
        <div class="trip-details">
            <div class="trip-detail">
                <span class="detail-label">Tuyến đường</span>
                <span class="detail-value">${trip.departureLocation} - ${trip.destinationLocation}</span>
            </div>
            <div class="trip-detail">
                <span class="detail-label">Ngày khởi hành</span>
                <span class="detail-value"><fmt:formatDate value="${trip.departureTime}" pattern="dd/MM/yyyy" /></span>
            </div>
            <div class="trip-detail">
                <span class="detail-label">Giờ khởi hành</span>
                <span class="detail-value"><fmt:formatDate value="${trip.departureTime}" pattern="HH:mm" /></span>
            </div>
            <div class="trip-detail">
                <span class="detail-label">Số ghế đã đặt</span>
                <span class="detail-value">${trip.bus.capacity - trip.availableSeats}/${trip.bus.capacity}</span>
            </div>
            <div class="trip-detail">
                <span class="detail-label">Xe</span>
                <span class="detail-value">${trip.bus.licensePlate} (${trip.bus.busType})</span>
            </div>
        </div>
        
        <div class="bus-layout">
            <div class="front-label">Phía trước xe</div>
            
            <c:choose>
                <c:when test="${trip.bus.busType eq 'Xe giường nằm' || trip.bus.capacity > 30}">
                    <!-- Layout for sleeper bus -->
                    <div class="floor-container">
                        <!-- First floor -->
                        <div class="floor">
                            <div class="floor-title">
                                <i class="fas fa-bed"></i> Tầng 1
                            </div>
                            <div class="seat-container">
                                <c:set var="halfCapacity" value="${trip.bus.capacity / 2}" />
                                <c:forEach begin="1" end="${halfCapacity}" var="i">
                                    <c:set var="seatNumber" value="T1-S${i}" />
                                    <c:set var="seatFound" value="false" />
                                    <c:set var="currentSeat" value="${null}" />
                                    
                                    <c:forEach items="${seats}" var="seat">
                                        <c:if test="${seat.seatNumber eq seatNumber}">
                                            <c:set var="seatFound" value="true" />
                                            <c:set var="currentSeat" value="${seat}" />
                                        </c:if>
                                    </c:forEach>
                                    
                                    <c:choose>
                                        <c:when test="${seatFound}">
                                            <div class="seat ${currentSeat.booked ? 'booked' : 'available'}" 
                                                 data-seat-id="${currentSeat.id}" 
                                                 data-seat-number="${currentSeat.seatNumber}"
                                                 data-is-booked="${currentSeat.booked}"
                                                 onclick="showPassengerInfo(this)">
                                                <i class="fas fa-bed"></i>
                                                <span>${currentSeat.seatNumber}</span>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="seat available" 
                                                 data-seat-number="${seatNumber}"
                                                 data-is-booked="false"
                                                 onclick="showPassengerInfo(this)">
                                                <i class="fas fa-bed"></i>
                                                <span>${seatNumber}</span>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <c:if test="${i % 2 == 0}">
                                        <div class="seat-row-break"></div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <!-- Second floor -->
                        <div class="floor">
                            <div class="floor-title">
                                <i class="fas fa-bed"></i> Tầng 2
                            </div>
                            <div class="seat-container">
                                <c:forEach begin="${halfCapacity + 1}" end="${trip.bus.capacity}" var="i">
                                    <c:set var="seatNumber" value="T2-S${i}" />
                                    <c:set var="seatFound" value="false" />
                                    <c:set var="currentSeat" value="${null}" />
                                    
                                    <c:forEach items="${seats}" var="seat">
                                        <c:if test="${seat.seatNumber eq seatNumber}">
                                            <c:set var="seatFound" value="true" />
                                            <c:set var="currentSeat" value="${seat}" />
                                        </c:if>
                                    </c:forEach>
                                    
                                    <c:choose>
                                        <c:when test="${seatFound}">
                                            <div class="seat ${currentSeat.booked ? 'booked' : 'available'}" 
                                                 data-seat-id="${currentSeat.id}" 
                                                 data-seat-number="${currentSeat.seatNumber}"
                                                 data-is-booked="${currentSeat.booked}"
                                                 onclick="showPassengerInfo(this)">
                                                <i class="fas fa-bed"></i>
                                                <span>${currentSeat.seatNumber}</span>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="seat available" 
                                                 data-seat-number="${seatNumber}"
                                                 data-is-booked="false"
                                                 onclick="showPassengerInfo(this)">
                                                <i class="fas fa-bed"></i>
                                                <span>${seatNumber}</span>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <c:if test="${(i - halfCapacity) % 2 == 0}">
                                        <div class="seat-row-break"></div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Layout for regular bus -->
                    <div class="seat-container">
                        <c:forEach begin="1" end="${trip.bus.capacity}" var="i">
                            <c:set var="seatNumber" value="S${i}" />
                            <c:set var="seatFound" value="false" />
                            <c:set var="currentSeat" value="${null}" />
                            
                            <c:forEach items="${seats}" var="seat">
                                <c:if test="${seat.seatNumber eq seatNumber}">
                                    <c:set var="seatFound" value="true" />
                                    <c:set var="currentSeat" value="${seat}" />
                                </c:if>
                            </c:forEach>
                            
                            <c:choose>
                                <c:when test="${seatFound}">
                                    <div class="seat ${currentSeat.booked ? 'booked' : 'available'}" 
                                         data-seat-id="${currentSeat.id}" 
                                         data-seat-number="${currentSeat.seatNumber}"
                                         data-is-booked="${currentSeat.booked}"
                                         onclick="showPassengerInfo(this)">
                                        <i class="fas fa-couch"></i>
                                        <span>${currentSeat.seatNumber}</span>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="seat available" 
                                         data-seat-number="${seatNumber}"
                                         data-is-booked="false"
                                         onclick="showPassengerInfo(this)">
                                        <i class="fas fa-couch"></i>
                                        <span>${seatNumber}</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            
                            <c:if test="${i % 4 == 0}">
                                <div class="seat-row-break"></div>
                            </c:if>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
            
            <div class="legend">
                <div class="legend-item">
                    <div class="legend-color available-legend"></div>
                    <span>Còn trống</span>
                </div>
                <div class="legend-item">
                    <div class="legend-color booked-legend"></div>
                    <span>Đã đặt</span>
                </div>
            </div>
        </div>
        
        <div class="passenger-info">
            <h2 class="passenger-info-title">Thông tin hành khách</h2>
            
            <div id="passengerDetails">
                <div class="no-passenger-selected">
                    Chọn một ghế để xem thông tin hành khách
                </div>
            </div>
        </div>
        
        <div class="passenger-list">
            <h2 class="passenger-list-title">Danh sách hành khách</h2>
            
            <table class="passenger-list-table">
                <thead>
                    <tr>
                        <th>Ghế</th>
                        <th>Họ tên</th>
                        <th>Số điện thoại</th>
                        <th>Điểm đón</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="hasPassengers" value="false" />
                    <c:forEach items="${seats}" var="seat">
                        <c:if test="${seat.booked and seatTicketMap[seat.id] ne null}">
                            <c:set var="hasPassengers" value="true" />
                            <tr onclick="highlightSeat('${seat.id}')">
                                <td><span class="passenger-seat">${seat.seatNumber}</span></td>
                                <td>${seatTicketMap[seat.id].user.fullName}</td>
                                <td>${seatTicketMap[seat.id].user.numberPhone}</td>
                                <td>${seatTicketMap[seat.id].pickupLocation}</td>
                                <td>${seatTicketMap[seat.id].status}</td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    <c:if test="${not hasPassengers}">
                        <tr>
                            <td colspan="5" style="text-align: center;">Chưa có hành khách nào đặt ghế</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    
    <script>
        // Lưu trữ dữ liệu hành khách trong JavaScript để truy cập nhanh
        const passengerData = {
            <c:forEach items="${seats}" var="seat">
                <c:if test="${seat.booked and seatTicketMap[seat.id] ne null}">
                    "${seat.id}": {
                        seatNumber: "${seat.seatNumber}",
                        fullName: "${seatTicketMap[seat.id].user.fullName}",
                        phone: "${seatTicketMap[seat.id].user.numberPhone}",
                        pickupLocation: "${seatTicketMap[seat.id].pickupLocation}",
                        bookingDate: "<fmt:formatDate value='${seatTicketMap[seat.id].bookingDate}' pattern='dd/MM/yyyy HH:mm' />",
                        status: "${seatTicketMap[seat.id].status}"
                    },
                </c:if>
            </c:forEach>
        };
        
        // Hàm hiển thị thông tin hành khách khi click vào ghế
        function showPassengerInfo(seatElement) {
            const seatId = seatElement.getAttribute('data-seat-id');
            const seatNumber = seatElement.getAttribute('data-seat-number');
            const isBooked = seatElement.getAttribute('data-is-booked') === 'true';
            
            const passengerDetailsDiv = document.getElementById('passengerDetails');
            
            if (isBooked && seatId && passengerData[seatId]) {
                // Show thông tin hành khách đã đặt ghế
                const passenger = passengerData[seatId];
                
                passengerDetailsDiv.innerHTML = 
                    '<div class="passenger-info-row">' +
                        '<div class="passenger-info-label">Ghế:</div>' +
                        '<div class="passenger-info-value">' + passenger.seatNumber + '</div>' +
                    '</div>' +
                    '<div class="passenger-info-row">' +
                        '<div class="passenger-info-label">Họ tên:</div>' +
                        '<div class="passenger-info-value">' + passenger.fullName + '</div>' +
                    '</div>' +
                    '<div class="passenger-info-row">' +
                        '<div class="passenger-info-label">Số điện thoại:</div>' +
                        '<div class="passenger-info-value">' + passenger.phone + '</div>' +
                    '</div>' +
                    '<div class="passenger-info-row">' +
                        '<div class="passenger-info-label">Điểm đón:</div>' +
                        '<div class="passenger-info-value">' + passenger.pickupLocation + '</div>' +
                    '</div>' +
                    '<div class="passenger-info-row">' +
                        '<div class="passenger-info-label">Ngày đặt:</div>' +
                        '<div class="passenger-info-value">' + passenger.bookingDate + '</div>' +
                    '</div>' +
                    '<div class="passenger-info-row">' +
                        '<div class="passenger-info-label">Trạng thái:</div>' +
                        '<div class="passenger-info-value">' + getStatusVietnamese(passenger.status) + '</div>' +
                    '</div>';

            } else {
                // Show thông tin ghế trống
                passengerDetailsDiv.innerHTML = 
                    '<div class="passenger-info-row">' +
                        '<div class="passenger-info-label">Ghế:</div>' +
                        '<div class="passenger-info-value">' + seatNumber + '</div>' +
                    '</div>' +
                    '<div class="passenger-info-row">' +
                        '<div class="passenger-info-label">Trạng thái:</div>' +
                        '<div class="passenger-info-value">Vị trí trống</div>' +
                    '</div>';
            }
        }
        
        // Hàm tô màu ghế khi click vào hành khách trong danh sách
        function highlightSeat(seatId) {
            const seatElement = document.querySelector(`.seat[data-seat-id="${seatId}"]`);
            if (seatElement) {
                seatElement.scrollIntoView({behavior: 'smooth', block: 'center'});
                showPassengerInfo(seatElement);
            }
        }

        //Hàm chuyển trạng thái thành tiếng việt
        function getStatusVietnamese(status) {
            switch (status) {
                case 'RESERVED':
                    return 'Chờ thanh toán';
                case 'PAID':
                    return 'Đã thanh toán';
                case 'CANCELLED':
                    return 'Đã hủy';
                default:
                    return status;
            }
        }
    </script>
</body>
</html>