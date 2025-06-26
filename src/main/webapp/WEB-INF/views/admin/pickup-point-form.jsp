<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kim Quy Bus - ${pickupPoint.id == null ? 'Thêm điểm dừng mới' : 'Chỉnh sửa điểm dừng'}</title>
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
                            <h1 class="admin-title">${pickupPoint.id == null ? 'Thêm điểm dừng mới' : 'Chỉnh sửa điểm dừng'}</h1>
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
                    <div class="col-md-6">
                        <div class="form-container">
                            <h2 class="section-title">
                                <i class="bi bi-${pickupPoint.id == null ? 'plus-circle' : 'pencil-square'}"></i>
                                ${pickupPoint.id == null ? 'Nhập thông tin điểm dừng' : 'Cập nhật thông tin điểm dừng'}
                            </h2>
                            
                            <form:form action="${pageContext.request.contextPath}/admin/pickup-points/save" method="post" modelAttribute="pickupPoint" cssClass="mt-4">
                                <form:hidden path="id" />
                                
                                <div class="mb-3">
                                    <label for="name" class="form-label">Tên điểm dừng</label>
                                    <form:input path="name" class="form-control" required="true" />
                                </div>
                                
                                <div class="mb-3">
                                    <label for="address" class="form-label">Địa chỉ</label>
                                    <form:input path="address" class="form-control" required="true" />
                                </div>
                                
                                <div class="mb-3">
                                    <label for="description" class="form-label">Mô tả</label>
                                    <form:textarea path="description" class="form-control" rows="3" />
                                </div>
                                
                                <div class="mb-3">
                                    <label for="city" class="form-label">Thành phố</label>
                                    <select id="departureLocation" name="city" class="form-select" required>
                                        <option value="">-- Chọn thành phố --</option>
                                    </select>
                                </div>
                                
                                <div class="mb-3 mt-4">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-save me-2"></i>Lưu
                                    </button>
                                    <a href="${pageContext.request.contextPath}/admin/pickup-points" class="btn btn-secondary ms-2">
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
    <script src="${pageContext.request.contextPath}/resources/js/admin.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const cityValue = "${pickupPoint.city}";
            const cityDropdown = document.getElementById('departureLocation');
            
            // Load the province data from JSON file
            fetch('${pageContext.request.contextPath}/resources/js/province.json')
                .then(response => response.json())
                .then(data => {
                    // Parse the provinces from the JSON data
                    for (const code in data) {
                        const province = data[code];
                        const optionText = province.name_with_type;
                        
                        // Add to city dropdown
                        const cityOption = document.createElement('option');
                        cityOption.value = optionText;
                        cityOption.textContent = optionText;
                        cityDropdown.appendChild(cityOption);
                    }
                    
                    // If we have a value from the model, set it as selected
                    if (cityValue) {
                        cityDropdown.value = cityValue;
                    }
                })
                .catch(error => console.error('Error loading province data:', error));
        });
    </script>
</body>
</html>
