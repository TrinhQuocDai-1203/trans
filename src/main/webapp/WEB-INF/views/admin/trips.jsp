<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FUTA Bus Lines - Quản lý chuyến đi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
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
                            <h1 class="admin-title">Quản lý chuyến đi</h1>
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
                    <c:if test="${not empty message}">
                    <div class="alert alert-success" role="alert">
                        <i class="bi bi-check-circle me-2"></i>${message}
                    </div>
                </c:if>

                <!-- Date filter -->
                <div class="filter-section">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h5 class="section-title"><i class="bi bi-funnel"></i> Lọc chuyến đi theo ngày</h5>
                            <form action="${pageContext.request.contextPath}/admin/trips/search" method="get" class="d-flex">
                                <div class="input-group me-2">
                                    <span class="input-group-text">Từ ngày</span>
                                    <input type="date" name="startDate" class="form-control auto-submit" 
                                           value="<fmt:formatDate value='${startDate}' pattern='yyyy-MM-dd' />">
                                </div>
                                <div class="input-group me-2">
                                    <span class="input-group-text">Đến ngày</span>
                                    <input type="date" name="endDate" class="form-control auto-submit" 
                                           value="<fmt:formatDate value='${endDate}' pattern='yyyy-MM-dd' />">
                                </div>
                                <button type="submit" class="btn action-btn me-1">Lọc</button>
                                <button type="button" class="btn btn-outline-secondary clear-search">
                                    <i class="bi bi-x-circle"></i>
                                </button>
                            </form>
                        </div>
                        <div class="col-md-4 text-end">
                            <a href="${pageContext.request.contextPath}/admin/trips/add" class="btn action-btn">
                                <i class="bi bi-plus-circle"></i> Thêm chuyến đi mới
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Trips table -->
                <div class="table-container">
                    <h2 class="section-title"><i class="bi bi-calendar-check"></i> Danh sách chuyến đi</h2>
                    
                    <!-- Thông báo về các chuyến đi trong ngày -->
                    <div class="alert alert-info mb-3" role="alert">
                        <i class="bi bi-calendar-event me-2"></i> 
                        Các chuyến đi khởi hành ngày hôm nay (<strong><fmt:formatDate value="${currentDate}" pattern="dd/MM/yyyy" /></strong>) được hiển thị lên đầu tiên
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Điểm đi</th>
                                    <th>Điểm đến</th>
                                    <th>Thời gian khởi hành</th>
                                    <th>Tài xế chính</th>
                                    <th>Tài xế phụ</th>
                                    <th>Xe</th>
                                    <th>Số ghế</th>
                                    <th>Giá vé</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="trip" items="${trips}">
                                    <c:set var="isTodayTrip" value="${trip.departureTime != null && fn:substring(trip.departureTime.toString(), 0, 10) == fn:substring(currentDate.toString(), 0, 10)}" />
                                    <tr class="${isTodayTrip ? 'table-warning' : ''}">
                                        <td>
                                            ${trip.id}
                                            <c:if test="${isTodayTrip}">
                                                <span class="badge bg-danger">Hôm nay</span>
                                            </c:if>
                                        </td>
                                        <td>${trip.departureLocation}</td>
                                        <td>${trip.destinationLocation}</td>
                                        <td><fmt:formatDate value="${trip.departureTime}" pattern="dd/MM/yyyy HH:mm" /></td>
                                        <td>${trip.primaryDriver.fullName}</td>
                                        <td>${trip.secondaryDriver != null ? trip.secondaryDriver.fullName : '-'}</td>
                                        <td>${trip.bus.licensePlate} (${trip.bus.busType})</td>
                                        <td>${trip.availableSeats}</td>
                                        <td><fmt:formatNumber value="${trip.price}" type="currency" currencySymbol="VND" /></td>
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
                                        <td class="action-column">
                                            <a href="${pageContext.request.contextPath}/admin/trips/edit/${trip.id}" 
                                               class="btn btn-sm btn-outline-primary">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/trips/delete/${trip.id}" 
                                               class="btn btn-sm btn-outline-danger"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa chuyến đi này?')">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty trips}">
                                    <tr>
                                        <td colspan="11" class="text-center">Không có chuyến đi nào</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
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
    <script src="${pageContext.request.contextPath}/resources/js/admin-search.js"></script>
</body>
</html> 