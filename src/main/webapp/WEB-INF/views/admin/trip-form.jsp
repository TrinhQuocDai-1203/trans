<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>
      FUTA Bus Lines - ${trip.id == null ? 'Thêm chuyến đi mới' : 'Chỉnh sửa chuyến đi'}
    </title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css"
    />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
  </head>
  <body>
    <div class="container-fluid">
      <div class="row">
        <!-- Sidebar -->
        <jsp:include page="/WEB-INF/components/nav-admin.jsp" />

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10" style="padding-left: 0px !important; padding-right: 0px !important;">
          <div class="admin-header py-3">
            <div class="container-fluid">
              <div class="d-flex justify-content-between align-items-center">
                <h1 class="admin-title">
                  ${trip.id == null ? 'Thêm chuyến đi mới' : 'Chỉnh sửa chuyến đi'}
                </h1>
                <div class="user-info d-flex align-items-center">
                  <span class="me-2"><i class="bi bi-person-circle"></i> ${sessionScope.user.fullName}</span>
                  <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-light">
                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                  </a>
                </div>
              </div>
            </div>
          </div>

          <div style="padding-left: 20px; padding-right: 20px;">
            <div class="row">
            <div class="col-md-8">
              <div class="form-container">
                <h2 class="section-title">
                  <i class="bi bi-${trip.id == null ? 'plus-circle' : 'pencil-square'}"></i>
                  ${trip.id == null ? 'Nhập thông tin chuyến đi' : 'Cập nhật thông tin chuyến đi'}
                </h2>
                
                <form:form
                  action="${pageContext.request.contextPath}/admin/trips/save"
                  method="post"
                  modelAttribute="trip"
                  cssClass="mt-4"
                >
                  <form:hidden path="id" />

                  <div class="row mb-3">
                    <div class="col-md-6">
                      <label for="departureLocation" class="form-label"
                        >Điểm khởi hành</label
                      >
                      <select
                        id="departureLocation"
                        name="departureLocation"
                        class="form-select"
                        required
                      >
                        <option value="">-- Chọn điểm khởi hành --</option>
                        <c:forEach var="pickupPoint" items="${pickupPoints}">
                          <option value="${pickupPoint.id}">
                            ${pickupPoint.name} (${pickupPoint.city})
                          </option>
                        </c:forEach>
                      </select>
                    </div>
                    <div class="col-md-6">
                      <label for="destinationLocation" class="form-label"
                        >Điểm đến</label
                      >
                      <select name="destinationLocation" id="destinationLocation" class="form-select" required>
                        <option value="">-- Chọn điểm đến --</option>
                        <c:forEach var="pickupPoint" items="${pickupPoints}">
                          <option value="${pickupPoint.id}">
                            ${pickupPoint.name} (${pickupPoint.city})
                          </option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>

                  <div class="row mb-3">
                    <div class="col-md-6">
                      <label for="departureTime" class="form-label"
                        >Thời gian khởi hành</label
                      >
                      <form:input
                        path="departureTime"
                        type="datetime-local"
                        class="form-control"
                        required="true"
                      />
                    </div>
                    <div class="col-md-6">
                      <label for="arrivalTime" class="form-label"
                        >Thời gian đến (dự kiến)</label
                      >
                      <form:input
                        path="arrivalTime"
                        type="datetime-local"
                        class="form-control"
                      />
                    </div>
                  </div>

                  <div class="row mb-3">
                    <div class="col-md-6">
                      <label for="primaryDriverId" class="form-label"
                        >Tài xế chính</label
                      >
                      <select
                        name="primaryDriverId"
                        id="primaryDriverId"
                        class="form-select"
                      >
                        <option value="">
                          -- Chọn tài xế chính --
                        </option>
                        <c:forEach var="driver" items="${drivers}">
                          <option value="${driver.id}">
                            ${driver.fullName} (${driver.numberPhone})
                          </option>
                        </c:forEach>
                      </select>
                    </div>
                    <div class="col-md-6">
                      <label for="secondaryDriverId" class="form-label"
                        >Tài xế phụ</label
                      >
                      <select
                        name="secondaryDriverId"
                        id="secondaryDriverId"
                        class="form-select"
                      >
                        <option value="">
                          -- Chọn tài xế phụ (không bắt buộc) --
                        </option>
                        <c:forEach var="driver" items="${drivers}">
                          <option value="${driver.id}">
                            ${driver.fullName} (${driver.numberPhone})
                          </option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>

                  <div class="row mb-3">
                    <div class="col-md-6">
                      <label for="busId" class="form-label">Xe</label>
                      <select
                        name="busId"
                        id="busId"
                        class="form-select"
                        required
                      >
                        <option value="">-- Chọn xe --</option>
                        <c:forEach var="bus" items="${buses}">
                          <option value="${bus.id}">
                            ${bus.licensePlate} - ${bus.busType} (${bus.capacity}
                            chỗ)
                          </option>
                        </c:forEach>
                      </select>
                    </div>
                    <div class="col-md-6">
                      <label for="status" class="form-label">Trạng thái</label>
                      <form:select path="status" class="form-select">
                        <form:option value="SCHEDULED">Đã lên lịch</form:option>
                        <form:option value="IN_PROGRESS">Đang chạy</form:option>
                        <form:option value="COMPLETED">Hoàn thành</form:option>
                        <form:option value="CANCELLED">Đã hủy</form:option>
                      </form:select>
                    </div>
                  </div>
                  <div class="row mb-3">
                    <div class="col-md-6">
                      <label for="price" class="form-label">Giá vé (VND)</label>
                      <form:input
                        path="price"
                        type="number"
                        step="1000"
                        class="form-control"
                        required="true"
                      />
                    </div>
                    
                  </div>

                  <div class="mb-3 mt-4">
                    <button type="submit" class="btn btn-primary">
                      <i class="bi bi-save me-2"></i>Lưu
                    </button>
                    <a
                      href="${pageContext.request.contextPath}/admin/trips"
                      class="btn btn-secondary ms-2"
                      >
                      <i class="bi bi-x-circle me-2"></i>Hủy
                    </a>
                  </div>
                </form:form>
              </div>
            </div>
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
              const href = link.getAttribute('href');
              if (currentPath.includes('/admin/trips') && href.includes('/admin/trips')) {
                  link.classList.add('active');
              }
          });
      });
    </script>
  </body>
</html>
