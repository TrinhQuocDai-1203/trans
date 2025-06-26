<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Vé - Kim Quy Bus</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/book-trip.css">
    <style>
        /* Cải thiện UI hiển thị ghế */
        .seat-container {
            width: 100%;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        
        .level-indicator {
            width: 100%;
            text-align: center;
            background-color: #f8f9fa;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 6px;
            font-weight: bold;
            color: #333;
            margin-top: 20px;
        }
        
        .seat-group {
            display: flex;
            flex-wrap: wrap;
            width: 100%;
            justify-content: center;
            gap: 15px;
        }
        
        /* Ghế giường nằm */
        .sleeper-seat {
            width: 80px;
            height: 45px;
        }
        
        .level-divider {
            width: 100%;
            height: 2px;
            background-color: #e9ecef;
            margin: 25px 0;
        }
        
        /* Debug - cho thấy số ghế rõ hơn */
        .seat span {
            font-size: 14px;
            font-weight: bold;
        }
        
        /* Thêm style cho ghế đã đặt */
        .seat.booked {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
            cursor: not-allowed;
            opacity: 0.8;
        }
        
        .seat.booked i {
            color: #dc3545;
        }
        
        /* Thêm style cho ghế đang chọn */
        .seat.selected {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }
        
        .seat.selected i {
            color: #28a745;
        }
        
        /* Style cơ bản cho ghế */
        .seat {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 60px;
            height: 60px;
            border: 2px solid #ddd;
            border-radius: 8px;
            background-color: #f8f9fa;
            cursor: pointer;
            transition: all 0.2s ease;
            position: relative;
            padding: 5px;
        }
        
        .seat:hover:not(.booked) {
            background-color: #e2e6ea;
            border-color: #dae0e5;
        }
        
        /* Cấu trúc hai tầng trong một hàng */
        .floor-container {
            display: flex;
            width: 100%;
            gap: 30px;
            margin-top: 20px;
        }
        
        .floor {
            flex: 1;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 15px;
            background-color: #f8f9fa;
        }
        
        .floor-title {
            text-align: center;
            font-weight: bold;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #dee2e6;
        }
        
        /* Thêm style cho các ghế đã chọn */
        .selected-seats-list {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 10px;
            min-height: 40px;
        }
        
        .selected-seat-tag {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .selected-seat-tag .remove-seat {
            cursor: pointer;
            color: #721c24;
            font-weight: bold;
        }
        
        .seat-selection-info {
            margin: 15px 0;
            padding: 12px;
            background-color: #e9ecef;
            border-radius: 5px;
            font-size: 14px;
            color: #495057;
            border-left: 4px solid #007bff;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/components/header.jsp" />
    
    <main>
        <section class="booking-section">
            <div class="container">
                <h1 class="section-title">Đặt Vé Xe</h1>
                
                <div class="booking-container">
                    <!-- Thông tin chuyến đi -->
                    <div class="trip-summary">
                        <h2 class="trip-title">
                            <i class="fas fa-bus"></i> ${trip.departureLocation} - ${trip.destinationLocation}
                        </h2>
                        
                        <div class="trip-details">
                            <div class="detail-item">
                                <i class="far fa-calendar-alt"></i>
                                <div class="detail-content">
                                    <div class="detail-label">Ngày khởi hành</div>
                                    <div class="detail-value"><fmt:formatDate value="${trip.departureTime}" pattern="dd/MM/yyyy" /></div>
                                </div>
                            </div>
                            
                            <div class="detail-item">
                                <i class="far fa-clock"></i>
                                <div class="detail-content">
                                    <div class="detail-label">Giờ khởi hành</div>
                                    <div class="detail-value"><fmt:formatDate value="${trip.departureTime}" pattern="HH:mm" /></div>
                                </div>
                            </div>
                            
                            <div class="detail-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <div class="detail-content">
                                    <div class="detail-label">Điểm đón</div>
                                    <div class="detail-value">${trip.departurePoint.name}</div>
                                </div>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <div class="detail-content">
                                    <div class="detail-label">Điểm đến</div>
                                    <div class="detail-value">${trip.destinationPoint.name}</div>
                                </div>
                            </div>
                            
                            <div class="detail-item">
                                <i class="fas fa-money-bill-wave"></i>
                                <div class="detail-content">
                                    <div class="detail-label">Giá vé</div>
                                    <div class="detail-value"><fmt:formatNumber value="${trip.price}" pattern="#,###" /> đ</div>
                                </div>
                            </div>
                            
                            <div class="detail-item">
                                <i class="fas fa-bus"></i>
                                <div class="detail-content">
                                    <div class="detail-label">Loại xe</div>
                                    <div class="detail-value">${trip.bus.busType} - ${trip.bus.capacity} chỗ</div>
                                </div>
                            </div>

                            <div class="detail-item">
                                <i class="fas fa-bus"></i>
                                <div class="detail-content">
                                    <div class="detail-label">Biển kiểm soát</div>
                                    <div class="detail-value">${trip.bus.licensePlate}</div>
                                </div>
                            </div>

                            <div class="detail-item">
                                <i class="fas fa-bus"></i>
                                <div class="detail-content">
                                    <div class="detail-label">Tài xế chính</div>
                                    <div class="detail-value">${trip.primaryDriver.fullName}</div>
                                </div>
                            </div>

                            <div class="detail-item">
                                <i class="fas fa-bus"></i>
                                <div class="detail-content">
                                    <div class="detail-label">Tài xế phụ</div>
                                    <div class="detail-value">${trip.secondaryDriver.fullName}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Phần chọn ghế -->
                    <div class="seat-selection">
                        <h3 class="section-header"><i class="fas fa-couch"></i> Chọn Ghế</h3>
                        
                        <div class="seat-selection-info">
                            <i class="fas fa-info-circle"></i> Bạn có thể chọn tối đa ${maxSeats} ghế. Mỗi ghế sẽ tạo một vé riêng.
                        </div>
                        
                        <div class="bus-layout">
                            <div class="bus-front">
                                <span>Phía trước xe</span>
                                <div class="steering-wheel"><i class="fas fa-dharmachakra"></i></div>
                            </div>
                            
                            <!-- Lấy dữ liệu ghế đã đặt từ server -->
                            <input type="hidden" id="busCapacity" value="${trip.bus.capacity}">
                            <input type="hidden" id="busType" value="${trip.bus.busType}">
                            <input type="hidden" id="tripId" value="${trip.id}">
                            <input type="hidden" id="bookedSeatsData" value='${bookedSeatsJson}'>
                            <input type="hidden" id="maxSeats" value='${maxSeats}'>
                            
                            <!-- Container chứa ghế sẽ được tạo bằng JavaScript -->
                            <div id="seatLayoutContainer" class="seat-container"></div>
                            
                            <div class="seat-legend">
                                <div class="legend-item">
                                    <div class="seat-sample available"></div>
                                    <span>Còn trống</span>
                                </div>
                                <div class="legend-item">
                                    <div class="seat-sample selected"></div>
                                    <span>Đang chọn</span>
                                </div>
                                <div class="legend-item">
                                    <div class="seat-sample booked"></div>
                                    <span>Đã đặt</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Phần thông tin đặt vé -->
                    <div class="booking-details">
                        <h3 class="section-header"><i class="fas fa-ticket-alt"></i> Thông Tin Đặt Vé</h3>
                        
                        <form id="bookingForm" action="${pageContext.request.contextPath}/user/book-seat" method="post">
                            <input type="hidden" name="tripId" value="${trip.id}">
                            <!-- Container cho các input ghế đã chọn -->
                            <div id="seatNumbersContainer"></div>
                            <input type="hidden" name="pickupLocation" value="${trip.departurePoint.name}">
                            
                            <div class="form-group">
                                <label for="selectedSeats" class="form-label">Ghế đã chọn:</label>
                                <div id="selectedSeats" class="selected-seats-list"></div>
                            </div>
                            
                            <div class="price-summary">
                                <div class="price-row">
                                    <span class="price-label">Giá vé:</span>
                                    <span class="price-value"><fmt:formatNumber value="${trip.price}" pattern="#,###" /> đ</span>
                                </div>
                                <div class="price-row">
                                    <span class="price-label">Số lượng ghế:</span>
                                    <span id="seatCount" class="price-value">0</span>
                                </div>
                                <div class="price-row total-row">
                                    <span class="price-label">Tổng tiền:</span>
                                    <span id="totalPrice" class="price-value total-price"><fmt:formatNumber value="0" pattern="#,###" /> đ</span>
                                </div>
                            </div>
                            
                            <button type="submit" id="btnBookNow" class="btn-book" disabled>
                                <i class="fas fa-ticket-alt"></i> Đặt Vé Ngay
                            </button>
                        </form>
                    </div>

                    <div class="booking-notice">
                        <div class="alert alert-warning">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <strong>Lưu ý:</strong> 
                        </div>
                    </div>
                    
                    <div class="seat-map">
                        <!-- ... existing code ... -->
                    </div>
                </div>
            </div>
        </section>
    </main>
    
    <jsp:include page="/WEB-INF/components/footer.jsp" />
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Lấy các phần tử DOM
            const busCapacity = parseInt(document.getElementById('busCapacity').value);
            const busType = document.getElementById('busType').value;
            const tripId = document.getElementById('tripId').value;
            const seatLayoutContainer = document.getElementById('seatLayoutContainer');
            const selectedSeatsContainer = document.getElementById('selectedSeats');
            const seatNumbersContainer = document.getElementById('seatNumbersContainer');
            const bookButton = document.getElementById('btnBookNow');
            const maxSeats = parseInt(document.getElementById('maxSeats').value) || 3;
            const seatCountElement = document.getElementById('seatCount');
            const totalPriceElement = document.getElementById('totalPrice');
            const tripPrice = ${trip.price};

            // Mảng lưu trữ các ghế đã chọn
            let selectedSeats = [];

            // Lấy thông tin ghế đã đặt
            let bookedSeats = [];
            try {
                const bookedSeatsJson = document.getElementById('bookedSeatsData').value;
                if (bookedSeatsJson) {
                    bookedSeats = JSON.parse(bookedSeatsJson);
                    console.log("Booked seats:", bookedSeats);
                }
            } catch (e) {
                console.error("Error parsing booked seats data", e);
            }
            
            // Tạo layout ghế dựa vào loại xe
            if (busType === 'Xe giường nằm') {
                createSleeperBusLayout(busCapacity, bookedSeats);
            } else {
                createRegularBusLayout(busCapacity, bookedSeats);
            }
            
            // Hàm xử lý việc chọn ghế
            function handleSeatSelection(seat) {
                // Kiểm tra xem ghế đã đặt chưa
                if (seat.classList.contains('booked')) {
                    return; // Không cho phép chọn ghế đã đặt
                }
                
                const seatNum = seat.dataset.seatNumber;
                
                // Kiểm tra xem ghế đã được chọn chưa
                if (seat.classList.contains('selected')) {
                    // Nếu đã chọn, bỏ chọn
                    seat.classList.remove('selected');
                    
                    // Xóa khỏi mảng ghế đã chọn
                    const index = selectedSeats.indexOf(seatNum);
                    if (index > -1) {
                        selectedSeats.splice(index, 1);
                    }
                } else {
                    // Nếu chưa chọn và chưa đạt giới hạn, thêm vào
                    if (selectedSeats.length < maxSeats) {
                        seat.classList.add('selected');
                        selectedSeats.push(seatNum);
                    } else {
                        alert(`Bạn chỉ có thể chọn tối đa ${maxSeats} ghế.`);
                        return;
                    }
                }
                
                // Cập nhật hiển thị ghế đã chọn
                updateSelectedSeatsDisplay();
                
                // Cập nhật giá tiền
                updatePriceSummary();
                
                // Kích hoạt/vô hiệu hóa nút đặt vé
                bookButton.disabled = selectedSeats.length === 0;
            }
            
            // Hàm cập nhật hiển thị ghế đã chọn
            function updateSelectedSeatsDisplay() {
                // Xóa tất cả các hidden input cũ
                seatNumbersContainer.innerHTML = '';
                
                // Xóa tất cả các tag ghế cũ
                selectedSeatsContainer.innerHTML = '';
                
                // Thêm các hidden input mới cho mỗi ghế đã chọn
                selectedSeats.forEach(seatNum => {
                    // Tạo hidden input cho form submission
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'seatNumbers';
                    input.value = seatNum;
                    seatNumbersContainer.appendChild(input);
                    
                    // Tạo tag hiển thị ghế đã chọn
                    const seatTag = document.createElement('div');
                    seatTag.className = 'selected-seat-tag';
                    
                    const seatText = document.createElement('span');
                    seatText.textContent = seatNum;
                    seatTag.appendChild(seatText);
                    
                    const removeBtn = document.createElement('span');
                    removeBtn.className = 'remove-seat';
                    removeBtn.innerHTML = '&times;';
                    removeBtn.addEventListener('click', function() {
                        // Tìm và bỏ chọn ghế tương ứng
                        const seatElement = document.querySelector(`.seat[data-seat-number="${seatNum}"]`);
                        if (seatElement) {
                            seatElement.classList.remove('selected');
                        }
                        
                        // Xóa khỏi mảng ghế đã chọn
                        const index = selectedSeats.indexOf(seatNum);
                        if (index > -1) {
                            selectedSeats.splice(index, 1);
                        }
                        
                        // Cập nhật lại hiển thị
                        updateSelectedSeatsDisplay();
                        updatePriceSummary();
                        
                        // Kích hoạt/vô hiệu hóa nút đặt vé
                        bookButton.disabled = selectedSeats.length === 0;
                    });
                    seatTag.appendChild(removeBtn);
                    
                    selectedSeatsContainer.appendChild(seatTag);
                });
            }
            
            // Hàm cập nhật tổng giá tiền
            function updatePriceSummary() {
                const seatCount = selectedSeats.length;
                const totalPrice = seatCount * tripPrice;
                
                seatCountElement.textContent = seatCount;
                totalPriceElement.textContent = new Intl.NumberFormat('vi-VN').format(totalPrice) + ' đ';
            }
            
            // Hàm tạo layout cho xe giường nằm
            function createSleeperBusLayout(capacity, bookedSeats) {
                const halfCapacity = Math.ceil(capacity / 2);
                
                // Tạo container cho 2 tầng
                const floorsContainer = document.createElement('div');
                floorsContainer.className = 'floor-container';
                
                // Tạo container tầng 1
                const floor1 = document.createElement('div');
                floor1.className = 'floor';
                
                // Tiêu đề tầng 1
                const floor1Title = document.createElement('div');
                floor1Title.className = 'floor-title';
                floor1Title.innerHTML = '<i class="fas fa-bed"></i> Tầng 1';
                floor1.appendChild(floor1Title);
                
                // Tạo nhóm ghế tầng 1
                const level1Group = document.createElement('div');
                level1Group.className = 'seat-group';
                console.log(bookedSeats);
                
                // Tạo ghế cho tầng 1
                for (let i = 1; i <= halfCapacity; i++) {
                    const seatNumber = "T1-S" + i;
                    const isBooked = bookedSeats.includes(seatNumber);
                    
                    const seat = createSeatElement(seatNumber, isBooked, 'bed', true);
                    level1Group.appendChild(seat);
                    
                    // Tạo ngắt hàng sau mỗi 2 ghế
                    if (i % 2 === 0) {
                        const rowBreak = document.createElement('div');
                        rowBreak.className = 'seat-row-break';
                        level1Group.appendChild(rowBreak);
                    }
                }
                
                floor1.appendChild(level1Group);
                floorsContainer.appendChild(floor1);
                
                // Tạo container tầng 2
                const floor2 = document.createElement('div');
                floor2.className = 'floor';
                
                // Tiêu đề tầng 2
                const floor2Title = document.createElement('div');
                floor2Title.className = 'floor-title';
                floor2Title.innerHTML = '<i class="fas fa-bed"></i> Tầng 2';
                floor2.appendChild(floor2Title);
                
                // Tạo nhóm ghế tầng 2
                const level2Group = document.createElement('div');
                level2Group.className = 'seat-group';
                
                // Tạo ghế cho tầng 2
                for (let i = halfCapacity + 1; i <= capacity; i++) {
                    const seatNumber = "T2-S" + i;
                    const isBooked = bookedSeats.includes(seatNumber);
                    
                    const seat = createSeatElement(seatNumber, isBooked, 'bed', true);
                    level2Group.appendChild(seat);
                    
                    // Tạo ngắt hàng sau mỗi 2 ghế
                    if ((i - halfCapacity) % 2 === 0) {
                        const rowBreak = document.createElement('div');
                        rowBreak.className = 'seat-row-break';
                        level2Group.appendChild(rowBreak);
                    }
                }
                
                floor2.appendChild(level2Group);
                floorsContainer.appendChild(floor2);
                
                // Thêm container vào layout chính
                seatLayoutContainer.appendChild(floorsContainer);
            }
            
            // Hàm tạo layout cho xe thường
            function createRegularBusLayout(capacity, bookedSeats) {
                // Tạo ghế
                for (let i = 1; i <= capacity; i++) {
                    const seatNumber = "T1-S" + i;
                    const isBooked = bookedSeats.includes(seatNumber);
                    
                    const seat = createSeatElement(seatNumber, isBooked, 'couch', false);
                    seatLayoutContainer.appendChild(seat);
                    
                    // Tạo ngắt hàng sau mỗi 4 ghế
                    if (i % 2 === 0) {
                        const rowBreak = document.createElement('div');
                        rowBreak.className = 'seat-row-break';
                        seatLayoutContainer.appendChild(rowBreak);
                    }
                }
            }
            
            // Hàm tạo element ghế
            function createSeatElement(seatNumber, isBooked, seatType, isSleeper) {
                const seat = document.createElement('div');
                seat.className = 'seat' + (isBooked ? ' booked' : '') + (isSleeper ? ' sleeper-seat' : '');
                seat.dataset.seatNumber = seatNumber;
                
                const icon = document.createElement('i');
                icon.className = `fas fa-${seatType}`;
                seat.appendChild(icon);
                
                const span = document.createElement('span');
                span.textContent = seatNumber;
                seat.appendChild(span);
                
                // Chỉ thêm event listener nếu ghế chưa được đặt
                if (!isBooked) {
                    seat.addEventListener('click', function() {
                        handleSeatSelection(this);
                    });
                }
                
                return seat;
            }
        });
    </script>
</body>
</html> 