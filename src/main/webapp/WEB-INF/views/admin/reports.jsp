<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kim Quy Bus- Báo cáo thống kê</title>
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
                            <h1 class="admin-title">Báo cáo thống kê</h1>
                            <div class="user-info d-flex align-items-center">
                                <span class="me-2"><i class="bi bi-person-circle"></i> ${sessionScope.user.fullName}</span>
                                <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-light">
                                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Date range filter -->
                <div style="padding: 0px 20px;">
                <div class="filter-section">
                    <h2 class="section-title"><i class="bi bi-calendar-range"></i> Lọc theo thời gian</h2>
                    <form action="${pageContext.request.contextPath}/admin/reports" method="get" class="row g-3">
                        <div class="col-md-4">
                            <label for="startDate" class="form-label">Từ ngày</label>
                            <input type="date" name="startDate" id="startDate" class="form-control" 
                                   value="<fmt:formatDate value='${startDate}' pattern='yyyy-MM-dd' />">
                        </div>
                        <div class="col-md-4">
                            <label for="endDate" class="form-label">Đến ngày</label>
                            <input type="date" name="endDate" id="endDate" class="form-control" 
                                   value="<fmt:formatDate value='${endDate}' pattern='yyyy-MM-dd' />">
                        </div>
                        <div class="col-md-4 d-flex align-items-end">
                            <button type="submit" class="btn action-btn">
                                <i class="bi bi-search me-2"></i>Lọc kết quả
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Statistics cards -->
                <div class="row mb-4">
                    <div class="col-md-4 mb-3">
                        <div class="card stat-card h-100">
                            <div class="card-body d-flex align-items-center">
                                <div class="card-icon me-3">
                                    <i class="bi bi-calendar-check"></i>
                                </div>
                                <div>
                                    <h6 class="card-subtitle mb-2 text-muted">Tổng số chuyến đi</h6>
                                    <h2 class="card-title mb-0">${totalTrips}</h2>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card stat-card h-100">
                            <div class="card-body d-flex align-items-center">
                                <div class="card-icon me-3">
                                    <i class="bi bi-check-circle"></i>
                                </div>
                                <div>
                                    <h6 class="card-subtitle mb-2 text-muted">Chuyến đã hoàn thành</h6>
                                    <h2 class="card-title mb-0">${completedTrips}</h2>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card stat-card h-100">
                            <div class="card-body d-flex align-items-center">
                                <div class="card-icon me-3">
                                    <i class="bi bi-x-circle"></i>
                                </div>
                                <div>
                                    <h6 class="card-subtitle mb-2 text-muted">Chuyến đã hủy</h6>
                                    <h2 class="card-title mb-0">${cancelledTrips}</h2>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Trip statistics by driver -->
                <div class="table-container">
                    <h2 class="section-title"><i class="bi bi-person-badge"></i> Thống kê theo tài xế</h2>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Tài xế</th>
                                    <th>Số điện thoại</th>
                                    <th>Số chuyến đi</th>
                                    <th>Tỷ lệ hoàn thành</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="stat" items="${driverStats}">
                                    <tr>
                                        <td>${stat.driverName}</td>
                                        <td>${stat.phoneNumber}</td>
                                        <td>${stat.totalTrips}</td>
                                        <td style="width: 30%">
                                            <div class="progress">
                                                <div class="progress-bar bg-success" role="progressbar" 
                                                     style="width: ${stat.completionRate}%"
                                                     aria-valuenow="${stat.completionRate}" 
                                                     aria-valuemin="0" aria-valuemax="100">
                                                    ${stat.completionRate}%
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Popular routes -->
                <div class="table-container">
                    <h2 class="section-title"><i class="bi bi-map"></i> Tuyến đường phổ biến</h2>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Điểm đi</th>
                                    <th>Điểm đến</th>
                                    <th>Số chuyến</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="route" items="${popularRoutes}">
                                    <tr>
                                        <td>${route.departureLocation}</td>
                                        <td>${route.destinationLocation}</td>
                                        <td>${route.tripCount}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                </div>
                
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/admin.js"></script>
</body>
</html> 