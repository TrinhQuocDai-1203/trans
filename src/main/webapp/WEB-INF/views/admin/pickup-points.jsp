<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FUTA Bus Lines - Quản lý điểm dừng</title>
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
                            <h1 class="admin-title">Quản lý điểm dừng</h1>
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

                <div class="d-flex justify-content-between mb-3">
                    <div class="col-md-8">
                        <form action="${pageContext.request.contextPath}/admin/pickup-points/search" method="get" class="d-flex">
                            <input type="text" name="keyword" class="form-control me-2 search-input" style="width: 50%;" placeholder="Tìm kiếm theo tên hoặc thành phố" 
                                   value="${searchKeyword}">
                            <button type="submit" class="btn action-btn me-1">Tìm kiếm</button>
                            <button type="button" class="btn btn-outline-secondary clear-search">
                                <i class="bi bi-x-circle"></i>
                            </button>
                        </form>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/pickup-points/add" class="btn action-btn">
                        <i class="bi bi-plus-circle"></i> Thêm điểm dừng mới
                    </a>
                </div>

                <!-- Pickup Points table -->
                <div class="table-container">
                    <h2 class="section-title"><i class="bi bi-geo-alt"></i> Danh sách điểm dừng</h2>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Tên điểm dừng</th>
                                    <th>Địa chỉ</th>
                                    <th>Mô tả</th>
                                    <th>Thành phố</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="pickupPoint" items="${pickupPoints}">
                                    <tr>
                                        <td>${pickupPoint.id}</td>
                                        <td>${pickupPoint.name}</td>
                                        <td>${pickupPoint.address}</td>
                                        <td>${pickupPoint.description}</td>
                                        <td>${pickupPoint.city}</td>
                                        <td class="action-column">
                                            <a href="${pageContext.request.contextPath}/admin/pickup-points/edit/${pickupPoint.id}" 
                                               class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="Chỉnh sửa">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/pickup-points/delete/${pickupPoint.id}" 
                                               class="btn btn-sm btn-outline-danger" data-bs-toggle="tooltip" title="Xóa"
                                               onclick="return confirmDelete('Bạn có chắc chắn muốn xóa điểm dừng này?')">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty pickupPoints}">
                                    <tr>
                                        <td colspan="6" class="text-center">Không có điểm dừng nào</td>
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
    <script src="${pageContext.request.contextPath}/resources/js/admin.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/admin-search.js"></script>
</body>
</html>
