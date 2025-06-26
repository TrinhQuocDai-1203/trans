<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kim Quy Bus - ${bus.id == null ? 'Thêm xe mới' : 'Chỉnh sửa xe'}</title>
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
                            <h1 class="admin-title">${bus.id == null ? 'Thêm xe mới' : 'Chỉnh sửa xe'}</h1>
                            <div class="user-info d-flex align-items-center">
                                <span class="me-2"><i class="bi bi-person-circle"></i> ${sessionScope.user.fullName}</span>
                                <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-light">
                                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div style="padding: 0 20px;">
                    <div class="row">
                    <div class="col-md-6">
                        <div class="form-container">
                            <h2 class="section-title">
                                <i class="bi bi-${bus.id == null ? 'plus-circle' : 'pencil-square'}"></i>
                                ${bus.id == null ? 'Nhập thông tin xe' : 'Cập nhật thông tin xe'}
                            </h2>
                            
                            <form:form action="${pageContext.request.contextPath}/admin/buses/save" method="post" modelAttribute="bus" cssClass="mt-4">
                                <form:hidden path="id" />
                                
                                <div class="mb-3">
                                    <label for="licensePlate" class="form-label">Biển kiểm soát</label>
                                    <form:input path="licensePlate" class="form-control" required="true" />
                                </div>
                                
                                <div class="mb-3">
                                    <label for="busType" class="form-label">Loại xe</label>
                                    <select name="busType" id="busType" class="form-select">
                                        <option value="Xe ngồi">Xe ngồi</option>
                                        <option value="Xe giường nằm">Xe giường nằm</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="capacity" class="form-label">Số chỗ ngồi</label>
                                    <select name="capacity" id="capacity" class="form-select">
                                        <option value="8">8</option>
                                        <option value="12">12</option>
                                        <option value="16">16</option>
                                        <option value="24">24</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3 mt-4">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-save me-2"></i>Lưu
                                    </button>
                                    <a href="${pageContext.request.contextPath}/admin/buses" class="btn btn-secondary ms-2">
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
                if (currentPath.includes('/admin/buses') && href.includes('/admin/buses')) {
                    link.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>