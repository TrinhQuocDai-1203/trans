<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Kim Quy Bus - Trang Quản Trị</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css"
    />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
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
      
      #sidebar {
        background-color: #343a40;
        min-height: 100vh;
        color: white;
        transition: all 0.3s;
      }
      
      #sidebar .nav-link {
        color: rgba(255, 255, 255, 0.8);
        padding: 12px 20px;
        border-left: 3px solid transparent;
        transition: all 0.2s;
      }
      
      #sidebar .nav-link:hover {
        color: white;
        background-color: rgba(255, 255, 255, 0.1);
        border-left: 3px solid #ff6600;
      }
      
      #sidebar .nav-link.active {
        color: white;
        background-color: rgba(255, 255, 255, 0.1);
        border-left: 3px solid #ff6600;
      }
      
      #sidebar .nav-link i {
        margin-right: 10px;
        width: 20px;
        text-align: center;
      }
      
      .admin-header {
        background-color: #ff6600;
        color: white;
        padding: 15px 0;
        margin-bottom: 20px;
      }
      
      .admin-title {
        font-weight: bold;
        font-size: 24px;
        margin: 0;
      }
      
      .stat-card {
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        transition: transform 0.3s;
        border-left: 4px solid #ff6600;
      }
      
      .stat-card:hover {
        transform: translateY(-5px);
      }
      
      .card-icon {
        font-size: 2rem;
        color: #ff6600;
      }
      
      .action-btn {
        background-color: #ff6600;
        color: white;
        border: none;
        border-radius: 4px;
        padding: 10px 20px;
        font-weight: 500;
        transition: all 0.2s;
      }
      
      .action-btn:hover {
        background-color: #e55c00;
        color: white;
      }
      
      .action-btn i {
        margin-right: 8px;
      }
      
      .table-container {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        padding: 20px;
        margin-bottom: 30px;
      }
      
      .section-title {
        font-size: 18px;
        font-weight: bold;
        color: #333;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
      }
      
      .section-title i {
        margin-right: 10px;
        color: #ff6600;
      }
      
      .badge.status-badge {
        padding: 6px 10px;
        font-weight: 500;
      }
      
      .welcome-message {
        font-size: 1.5rem;
        font-weight: 600;
        margin-bottom: 20px;
        color: #343a40;
      }
      
      .welcome-message span {
        color: #ff6600;
      }
      
      .action-links {
        margin-bottom: 30px;
      }
      
      @media (max-width: 768px) {
        #sidebar {
          min-height: auto;
        }
      }
    </style>
  </head>
  <body>
    <div class="container-fluid">
      <div class="row" >
        <!-- Sidebar -->
        <jsp:include page="/WEB-INF/components/nav-admin.jsp" />

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10" style="padding-left: 0px !important; padding-right: 0px !important;">
          <div class="admin-header py-3" >
            <div class="container-fluid">
              <div class="d-flex justify-content-between align-items-center">
                <h1 class="admin-title">Bảng Điều Khiển</h1>
                <div class="user-info d-flex align-items-center">
                  <span class="me-2"><i class="bi bi-person-circle"></i> ${sessionScope.user.fullName}</span>
                  <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-light">
                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                  </a>
                </div>
              </div>
            </div>
          </div>

          <div style="padding: 0px 20px;">
            <div class="welcome-message">
            Xin chào, <span>${sessionScope.user.fullName}</span>!
          </div>

          <!-- Stats cards -->
          <div class="row mb-4">
            <div class="col-md-4 mb-3">
              <div class="card stat-card h-100">
                <div class="card-body d-flex align-items-center">
                  <div class="card-icon me-3">
                    <i class="bi bi-calendar-check"></i>
                  </div>
                  <div>
                    <h6 class="card-subtitle mb-2 text-muted">Chuyến đi hôm nay</h6>
                    <h2 class="card-title mb-0">${tripsToday}</h2>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-4 mb-3">
              <div class="card stat-card h-100">
                <div class="card-body d-flex align-items-center">
                  <div class="card-icon me-3">
                    <i class="bi bi-people"></i>
                  </div>
                  <div>
                    <h6 class="card-subtitle mb-2 text-muted">Tổng số tài xế</h6>
                    <h2 class="card-title mb-0">${driversCount}</h2>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-4 mb-3">
              <div class="card stat-card h-100">
                <div class="card-body d-flex align-items-center">
                  <div class="card-icon me-3">
                    <i class="bi bi-truck"></i>
                  </div>
                  <div>
                    <h6 class="card-subtitle mb-2 text-muted">Tổng số xe</h6>
                    <h2 class="card-title mb-0">${busesCount}</h2>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="table-container">
            <h2 class="section-title">
              <i class="bi bi-calendar-event"></i> Chuyến xe hôm nay
            </h2>

            <c:if test="${empty todayTrips}">
              <div class="alert alert-info">
                <i class="bi bi-info-circle me-2"></i> Không có chuyến xe nào được lên lịch hôm nay.
              </div>
            </c:if>

            <c:if test="${not empty todayTrips}">
              <div class="table-responsive">
                <table class="table table-hover">
                  <thead class="table-light">
                    <tr>
                      <th>ID</th>
                      <th>Điểm đi</th>
                      <th>Điểm đến</th>
                      <th>Thời gian</th>
                      <th>Tài xế chính</th>
                      <th>Tài xế phụ</th>
                      <th>Trạng thái</th>
                      <th>Thao tác</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="trip" items="${todayTrips}">
                      <tr>
                        <td>${trip.id}</td>
                        <td>${trip.departureLocation}</td>
                        <td>${trip.destinationLocation}</td>
                        <td>
                          <fmt:formatDate
                            value="${trip.departureTime}"
                            pattern="HH:mm"
                          />
                        </td>
                        <td>${trip.primaryDriver.fullName}</td>
                        <td>${trip.secondaryDriver.fullName}</td>
                        <td>
                          <c:choose>
                            <c:when test="${trip.status eq 'SCHEDULED'}">
                              <span class="badge bg-info status-badge">Đã lên lịch</span>
                            </c:when>
                            <c:when test="${trip.status eq 'IN_PROGRESS'}">
                              <span class="badge bg-warning status-badge">Đang chạy</span>
                            </c:when>
                            <c:when test="${trip.status eq 'COMPLETED'}">
                              <span class="badge bg-success status-badge">Hoàn thành</span>
                            </c:when>
                            <c:when test="${trip.status eq 'CANCELLED'}">
                              <span class="badge bg-danger status-badge">Đã hủy</span>
                            </c:when>
                          </c:choose>
                        </td>
                        <td>
                          <div class="btn-group">
                            <a href="${pageContext.request.contextPath}/admin/trips/edit/${trip.id}" 
                               class="btn btn-sm btn-outline-primary">
                              <i class="bi bi-pencil"></i>
                            </a>
                          </div>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </c:if>
          </div>
          </div>
        </main>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      // Highlight active navigation item
      document.addEventListener('DOMContentLoaded', function() {
        const currentPath = window.location.pathname;
        const navLinks = document.querySelectorAll('#sidebar .nav-link');
        
        navLinks.forEach(link => {
          if (currentPath === link.getAttribute('href')) {
            link.classList.add('active');
          } else {
            link.classList.remove('active');
          }
        });
        
        // Default to home if no match
        if (currentPath.endsWith('/admin/')) {
          document.querySelector('#sidebar .nav-link[href*="/admin/"]').classList.add('active');
        }
      });
    </script>
  </body>
</html>
