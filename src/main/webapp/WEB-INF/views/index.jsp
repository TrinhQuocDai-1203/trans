<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>FUTA Bus Lines - Trang chủ</title>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/search-results.css">
    <style>
      /* Reset CSS */
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
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

      /* Header Styles */
      header {
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      }

      .top-header {
        background-color: #ff6600;
        padding: 10px 0;
        color: white;
      }

      .logo {
        height: 50px;
        margin-right: 10px;
      }

      .logo-text {
        display: flex;
        flex-direction: column;
      }

      .top-header .container {
        display: flex;
        justify-content: space-between;
        align-items: center;
      }

      .auth-button {
        background-color: white;
        color: #ff6600;
        padding: 8px 15px;
        border-radius: 20px;
        text-decoration: none;
        font-weight: 500;
        display: inline-flex;
        align-items: center;
      }

      .auth-button i {
        margin-right: 5px;
      }

      /* Navigation Styles */
      .main-nav {
        background-color: white;
      }

      .nav-links {
        display: flex;
        list-style: none;
        margin: 0;
        padding: 0;
      }

      .nav-item {
        position: relative;
      }

      .nav-item a {
        display: block;
        padding: 15px 20px;
        color: #333;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.3s;
      }

      .nav-item.active a {
        color: #ff6600;
        font-weight: bold;
      }

      .nav-item.active::after {
        content: "";
        position: absolute;
        bottom: 0;
        left: 20px;
        right: 20px;
        height: 3px;
        background-color: #ff6600;
      }

      .nav-item a:hover {
        color: #ff6600;
      }

      /* Banner Styles */
      .banner {
        margin-bottom: 20px;
      }

      .banner-image {
        width: 100%;
        border-radius: 8px;
        overflow: hidden;
      }

      /* Booking Form Styles */
      .booking-form {
        margin-bottom: 40px;
      }

      .form-container {
        background-color: white;
        border-radius: 10px;
        padding: 30px;
        box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
      }

      .trip-type {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
        justify-content: space-between;
      }

      .radio-container {
        display: flex;
        align-items: center;
        margin-right: 20px;
        cursor: pointer;
      }

      .radio-container input {
        margin-right: 8px;
      }

      .booking-guide {
        color: #ff6600;
        text-decoration: none;
        margin-left: auto;
        font-weight: 600;
      }

      .booking-guide:hover {
        text-decoration: underline;
      }

      .form-row {
        display: grid;
        grid-template-columns: 1fr 1fr 1fr 0.5fr;
        gap: 15px;
        align-items: end;
      }

      .form-group {
        margin-bottom: 15px;
      }

      .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #4b5563;
      }

      .form-control {
        width: 100%;
        padding: 12px 15px;
        border: 2px solid #d1d5db;
        border-radius: 8px;
        font-size: 16px;
        transition: all 0.3s ease;
      }

      .form-control:focus {
        border-color: #ff6600;
        box-shadow: 0 0 0 0.25rem rgba(255, 102, 0, 0.25);
        outline: none;
      }

      select.form-control {
        appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%23333333' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 15px center;
        padding-right: 40px;
      }

      .recent-searches {
        margin-top: 20px;
        padding-top: 20px;
        border-top: 1px solid #eee;
      }

      .recent-searches h4 {
        font-size: 16px;
        margin-bottom: 15px;
        color: #4b5563;
        font-weight: 600;
      }

      .search-item {
        width: fit-content;
        background-color: #f8f9fa;
        padding: 12px 18px;
        border-radius: 8px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        margin-bottom: 10px;
        cursor: pointer;
        transition: all 0.3s ease;
        border: 1px solid #e5e7eb;
      }

      .search-item:hover {
        background-color: #fff3e6;
        border-color: #ffcca5;
      }

      .form-actions {
        margin-top: 25px;
        text-align: center;
      }

      .btn-search {
        background-color: #ff6600;
        color: white;
        border: none;
        padding: 14px 35px;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
      }

      .btn-search:hover {
        background-color: #e55c00;
        transform: translateY(-2px);
      }

      .btn-search i {
        margin-right: 8px;
      }

      input[type="date"].form-control {
        padding: 11px 15px;
      }

      /* Popular Routes Styles */
      .popular-routes {
        margin-bottom: 40px;
      }

      .section-title {
        text-align: center;
        margin-bottom: 30px;
        position: relative;
        font-size: 28px;
        color: #333;
      }

      .section-title::after {
        content: "";
        display: block;
        width: 60px;
        height: 3px;
        background-color: #ff6600;
        margin: 15px auto 0;
      }

      .routes-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 20px;
      }

      .route-card {
        background-color: white;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s;
      }

      .route-card:hover {
        transform: translateY(-5px);
      }

      .route-card img {
        width: 100%;
        height: 150px;
        object-fit: cover;
      }

      .route-info {
        padding: 15px;
      }

      .route-info h3 {
        margin-bottom: 10px;
        font-size: 18px;
      }

      .route-price {
        color: #666;
        margin-bottom: 15px;
      }

      .route-price span {
        color: #ff6600;
        font-weight: bold;
      }

      .btn-book {
        display: block;
        text-align: center;
        background-color: #ff6600;
        color: white;
        padding: 8px 0;
        border-radius: 4px;
        text-decoration: none;
        font-weight: 500;
        transition: background-color 0.3s;
      }

      .btn-book:hover {
        background-color: #e55c00;
      }

      /* Services Styles */
      .services {
        padding: 40px 0;
        background-color: #f8f9fa;
      }

      .services-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 20px;
      }

      .service-card {
        background-color: white;
        border-radius: 8px;
        padding: 30px 20px;
        text-align: center;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      }

      .service-icon {
        width: 70px;
        height: 70px;
        background-color: #fff3e6;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 20px;
      }

      .service-icon i {
        font-size: 30px;
        color: #ff6600;
      }

      .service-card h3 {
        margin-bottom: 15px;
        font-size: 18px;
      }

      .service-card p {
        color: #666;
        font-size: 14px;
      }

      /* Responsive Styles */
      @media (max-width: 992px) {
        .routes-grid,
        .services-grid {
          grid-template-columns: repeat(2, 1fr);
        }

        .form-row {
          grid-template-columns: 1fr 1fr;
        }

        .footer-content {
          grid-template-columns: repeat(2, 1fr);
        }
      }

      @media (max-width: 768px) {
        .nav-links {
          flex-wrap: wrap;
        }

        .nav-item {
          flex: 0 0 33.333%;
          text-align: center;
        }

        .routes-grid,
        .services-grid {
          grid-template-columns: 1fr;
        }

        .footer-content {
          grid-template-columns: 1fr;
        }
      }
    </style>
  </head>
  <body>
    <jsp:include page="/WEB-INF/components/header.jsp" />

    <main class="container">
      <!-- Banner Section -->
      <section class="banner" style="margin-top: 10px">
        <div class="container">
          <div class="banner-content" style="text-align: center; width: 100%">
            <img
              src="https://cdn.futabus.vn/futa-busline-web-cms-prod/2257_x_501_px_2ecaaa00d0/2257_x_501_px_2ecaaa00d0.png"
              alt="FUTA Bus Lines"
              style="width: 100%"
            />
          </div>
        </div>
      </section>

      <!-- Booking Form Section -->
      <section class="results-section">
        <form action="${pageContext.request.contextPath}" method="post">
          <div class="form-container">
            <div class="trip-type">
              <div></div>
              <a href="#" class="booking-guide">Hướng dẫn mua vé</a>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label>Điểm đi</label>
                <div class="select-wrapper" for="departureLocation">
                  <select
                    name="departureLocation"
                    class="form-control"
                    id="departureLocation"
                    required
                  >
                    <option value="">-- Chọn điểm khởi hành --</option>
                    <c:forEach items="${locations}" var="location">
                      <option value="${location}" ${param.departureLocation == location ? 'selected' : ''}>
                        ${location}
                      </option>
                    </c:forEach>
                  </select>
                </div>
              </div>

              <div class="form-group">
                <label>Điểm đến</label>
                <div class="select-wrapper" for="destinationLocation">
                  <select
                    name="destinationLocation"
                    class="form-control"
                    id="destinationLocation"
                    required
                  >
                    <option value="">-- Chọn điểm đến --</option>
                    <c:forEach items="${locations}" var="location">
                      <option value="${location}" ${param.destinationLocation == location ? 'selected' : ''}>
                        ${location}
                      </option>
                    </c:forEach>
                  </select>
                </div>
              </div>

              <div class="form-group">
                <label>Ngày đi</label>
                <input
                  type="date"
                  class="form-control"
                  value="${not empty departureDate ? departureDate : now}"
                  min="${now}"
                  name="departureDate"
                  id="departureDate"
                  required
                />
              </div>

              <div class="form-group">
                <label>Số vé</label>
                <div class="select-wrapper">
                  <select
                    name="passengerCount"
                    class="form-control"
                    id="passengerCount"
                    required
                  >
                    <option value="">-- Chọn số vé --</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                  </select>
                </div>
              </div>
            </div>


            <div class="form-actions">
              <button type="submit" class="btn-search">
                <i class="fas fa-search"></i> Tìm chuyến xe
              </button>
            </div>
          </div>
        </form>
      </section>
      <script>
        document.addEventListener("DOMContentLoaded", function () {
          const departureLocationValue = "${trip.departureLocation}";
          const destinationLocationValue = "${trip.destinationLocation}";
          const departureDropdown =
            document.getElementById("departureLocation");
          const destinationDropdown = document.getElementById(
            "destinationLocation"
          );
          const departureHidden = document.getElementById(
            "departureLocationHidden"
          );
          const destinationHidden = document.getElementById(
            "destinationLocationHidden"
          );

          // Load the province data from JSON file
          fetch("${pageContext.request.contextPath}/resources/js/province.json")
            .then((response) => response.json())
            .then((data) => {
              // Parse the provinces from the JSON data
              for (const code in data) {
                const province = data[code];
                const optionText = province.name_with_type;

                // Add to departure dropdown
                const departureOption = document.createElement("option");
                departureOption.value = optionText;
                departureOption.textContent = optionText;
                departureDropdown.appendChild(departureOption);

                // Add to destination dropdown
                const destinationOption = document.createElement("option");
                destinationOption.value = optionText;
                destinationOption.textContent = optionText;
                destinationDropdown.appendChild(destinationOption);
              }

              // Nếu có giá trị từ model, thì set selected cho dropdown và hidden field
              if (departureLocationValue) {
                departureDropdown.value = departureLocationValue;
                departureHidden.value = departureLocationValue;
              }

              if (destinationLocationValue) {
                destinationDropdown.value = destinationLocationValue;
                destinationHidden.value = destinationLocationValue;
              }

              // Update hidden fields when dropdowns change
              departureDropdown.addEventListener("change", function () {
                departureHidden.value = this.value;
              });

              destinationDropdown.addEventListener("change", function () {
                destinationHidden.value = this.value;
              });
            })
            .catch((error) =>
              console.error("Error loading province data:", error)
            );
        });
      </script>

      <c:choose>
        <c:when test="${showResults == true}">
          <section class="results-section">
            <div class="">
              <h1 class="section-title">Kết Quả Tìm Kiếm</h1>
              
              <div class="search-summary">
                <div class="route">
                  <i class="fas fa-map-marker-alt departure"></i>
                  <span class="location">${departureLocation}</span>
                  <i class="fas fa-long-arrow-alt-right"></i>
                  <i class="fas fa-map-marker-alt destination"></i>
                  <span class="location">${destinationLocation}</span>
                </div>
                <div class="date">
                  <i class="far fa-calendar-alt"></i>
                  <span>${departureDate}</span>
                </div>
              </div>
              
              <div class="results-container">
                <div class="search-filter">
                  <a href="#" class="filter-btn active">Tất cả</a>
                  <a href="#" class="filter-btn">Sáng (00:00 - 12:00)</a>
                  <a href="#" class="filter-btn">Chiều (12:00 - 18:00)</a>
                  <a href="#" class="filter-btn">Tối (18:00 - 24:00)</a>
                </div>
                
                <c:choose>
                  <c:when test="${empty trips}">
                    <div class="no-results">
                      <i class="fas fa-exclamation-circle"></i>
                      <p>Không tìm thấy chuyến xe phù hợp. Vui lòng thử lại với các tiêu chí khác.</p>
                    </div>
                  </c:when>
                  <c:otherwise>
                    <div class="trip-list">
                      <p>Đã tìm thấy ${trips.size()} chuyến xe phù hợp.</p>
                      
                      <c:forEach items="${trips}" var="trip">
                        <div class="trip-card" style="border: 1px solid #eee; border-radius: 8px; padding: 20px; margin-bottom: 15px; display: flex; flex-wrap: wrap; justify-content: space-between; align-items: center;">
                          <div style="flex: 1; min-width: 300px;">
                            <div style="display: flex; align-items: center; margin-bottom: 15px;">
                              <div style="text-align: center; min-width: 120px;">
                                <div style="font-size: 20px; font-weight: 600; color: #333;">
                                  <fmt:formatDate value="${trip.departureTime}" pattern="HH:mm dd/MM" />
                                </div>
                                <div style="font-size: 14px; color: #6c757d;">${trip.departureLocation}</div>
                              </div>
                              <div style="flex: 1; display: flex; flex-direction: column; align-items: center; padding: 0 15px;">
                                <div style="height: 2px; background-color: #ddd; width: 100%; position: relative;"></div>
                                <c:set var="diffInMillies" value="${trip.arrivalTime.time - trip.departureTime.time}" />
                                <c:set var="hours" value="${diffInMillies / (60 * 60 * 1000)}" />
                                <div style="font-size: 12px; color: #6c757d; margin-top: 5px;">${Math.round(hours)}h</div>
                              </div>
                              <div style="text-align: center; min-width: 120px;">
                                <div style="font-size: 20px; font-weight: 600; color: #333;">
                                  <fmt:formatDate value="${trip.arrivalTime}" pattern="HH:mm dd/MM" />
                                </div>
                                <div style="font-size: 14px; color: #6c757d;">${trip.destinationLocation}</div>
                              </div>
                            </div>
                            
                            <div style="display: flex; flex-wrap: wrap; gap: 15px;">
                              <div style="margin-right: 20px; font-size: 14px; display: flex; align-items: center;">
                                <i class="fas fa-bus" style="margin-right: 8px; color: #6c757d;"></i>
                                <span>${trip.bus.busType}</span>
                              </div>
                              <div style="margin-right: 20px; font-size: 14px; display: flex; align-items: center;">
                                <i class="fas fa-chair" style="margin-right: 8px; color: #6c757d;"></i>
                                <span>${trip.availableSeats} chỗ trống</span>
                              </div>
                            </div>
                          </div>
                          
                          <div style="text-align: center; min-width: 150px; margin-left: 20px;">
                            <div style="margin-bottom: 15px;">
                              <div style="font-size: 22px; font-weight: 600; color: #ff6600;">
                                <fmt:formatNumber value="${trip.price}" pattern="#,###" /> đ
                              </div>
                              <div style="font-size: 12px; color: #6c757d;">Giá/Người</div>
                            </div>
                            <a href="${pageContext.request.contextPath}/user/book-trip/${trip.id}" 
                               style="display: inline-block; background-color: #ff6600; color: white; padding: 10px 25px; border-radius: 4px; text-decoration: none; font-weight: 500;">
                              Chọn Chuyến
                            </a>
                          </div>
                        </div>
                      </c:forEach>
                    </div>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </section>
        </c:when>
      </c:choose>

      <!-- Services Section -->
      <section class="services">
        <div class="container">
          <h2 class="section-title">Dịch Vụ Của Chúng Tôi</h2>
          <div class="services-grid">
            <div class="service-card">
              <div class="service-icon">
                <i class="fas fa-bus"></i>
              </div>
              <h3>Xe Giường Nằm</h3>
              <p>
                Trải nghiệm thoải mái với ghế giường nằm cao cấp, tiện nghi hiện
                đại.
              </p>
            </div>

            <div class="service-card">
              <div class="service-icon">
                <i class="fas fa-wifi"></i>
              </div>
              <h3>WiFi Miễn Phí</h3>
              <p>Kết nối internet tốc độ cao suốt hành trình di chuyển.</p>
            </div>

            <div class="service-card">
              <div class="service-icon">
                <i class="fas fa-utensils"></i>
              </div>
              <h3>Đồ Ăn & Nước Uống</h3>
              <p>Thưởng thức đồ ăn nhẹ và nước uống miễn phí trên xe.</p>
            </div>

            <div class="service-card">
              <div class="service-icon">
                <i class="fas fa-headphones"></i>
              </div>
              <h3>Hỗ Trợ 24/7</h3>
              <p>Đội ngũ nhân viên luôn sẵn sàng hỗ trợ mọi lúc mọi nơi.</p>
            </div>
          </div>
        </div>
      </section>
    </main>

    <jsp:include page="/WEB-INF/components/footer.jsp" />

    <!-- CSS cho trang chủ -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      // Format date input to display properly
      document.addEventListener('DOMContentLoaded', function() {
        const dateInput = document.getElementById('departureDate');
        if (!dateInput.value) {
          const today = new Date();
          const formattedDate = today.toISOString().split('T')[0];
          dateInput.value = formattedDate;
        }
      });
    </script>

  </body>
</html>
