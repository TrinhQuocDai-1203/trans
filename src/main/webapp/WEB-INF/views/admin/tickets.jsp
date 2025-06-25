<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FUTA Bus Lines - Quản lý vé</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
    <style>
        .table th {
            background-color: #f8f9fa;
            font-weight: 600;
            vertical-align: middle;
        }
        
        .table td {
            vertical-align: middle;
        }
        
        .route-info {
            display: flex;
            flex-direction: column;
        }
        
        .route-arrow {
            color: #6c757d;
            font-size: 14px;
            margin: 0 5px;
        }
        
        .ticket-id {
            font-weight: 600;
            color: #ff6600;
        }
        
        .action-buttons {
            display: flex;
            gap: 5px;
        }
        
        .empty-state {
            text-align: center;
            padding: 40px 20px;
        }
        
        .empty-icon {
            font-size: 48px;
            color: #d1d5db;
            margin-bottom: 15px;
        }
        
        .empty-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 10px;
            color: #4b5563;
        }
        
        .empty-subtitle {
            color: #6b7280;
            margin-bottom: 20px;
        }

        /* Thêm CSS mới để phù hợp với thiết kế trong ảnh */
        .page-header {
            background-color: #ff6600;
            color: white;
            padding: 15px 20px;
            margin-bottom: 20px;
        }
        
        .page-title {
            font-size: 24px;
            font-weight: 600;
            margin: 0;
            display: flex;
            align-items: center;
        }
        
        .page-title i {
            margin-right: 10px;
        }
        
        .filter-tabs {
            display: flex;
            gap: 5px;
            margin-top: 10px;
        }
        
        .filter-tab {
            color: white;
            text-decoration: none;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
        }
        
        .filter-tab i {
            margin-right: 5px;
        }
        
        .filter-tab.active {
            background-color: rgba(255, 255, 255, 0.2);
            font-weight: 600;
        }
        
        .filter-tab:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }
        
        .table-container {
            background-color: white;
            border-radius: 0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-top: 0;
            padding: 0;
        }
        
        .table {
            margin-bottom: 0;
        }
        
        .table th {
            border-top: none;
            border-bottom: 1px solid #dee2e6;
            background-color: #f8f9fa;
            color: #495057;
            font-weight: 600;
            padding: 12px 15px;
        }
        
        .table td {
            padding: 12px 15px;
            border-bottom: 1px solid #dee2e6;
        }
        
        .btn-confirm {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            text-decoration: none;
        }
        
        .btn-confirm:hover {
            background-color: #218838;
            color: white;
        }
        
        .btn-cancel {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            text-decoration: none;
            margin-left: 5px;
        }
        
        .btn-cancel:hover {
            background-color: #c82333;
            color: white;
        }
        
        /* Search form styles */
        .search-section {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 15px 20px;
            margin-bottom: 20px;
        }
        
        .search-title {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        
        .search-title i {
            margin-right: 8px;
            color: #ff6600;
        }
        
        .search-form {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        
        .search-input {
            flex: 1;
            min-width: 200px;
        }
        
        .search-btn {
            background-color: #ff6600;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
        }
        
        .search-btn i {
            margin-right: 5px;
        }
        
        .search-btn:hover {
            background-color: #e55c00;
        }
        
        .clear-btn {
            background-color: #f8f9fa;
            color: #6c757d;
            border: 1px solid #dee2e6;
            padding: 8px 15px;
            border-radius: 4px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
        }
        
        .clear-btn i {
            margin-right: 5px;
        }
        
        .clear-btn:hover {
            background-color: #e9ecef;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <jsp:include page="/WEB-INF/components/nav-admin.jsp" />

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10" style="padding-left: 0px !important; padding-right: 0px !important;">
                <div class="page-header">
                    <h1 class="page-title"></i> Quản lý vé</h1>
                    <div class="filter-tabs">
                        <a href="${pageContext.request.contextPath}/admin/tickets" class="filter-tab ${empty selectedStatus ? 'active' : ''}">
                            <i class="bi bi-funnel"></i> Tất cả
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/tickets?status=PENDING" class="filter-tab ${selectedStatus == 'PENDING' ? 'active' : ''}">
                            <i class="bi bi-clock"></i> Chờ xác nhận
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/tickets?status=PAID" class="filter-tab ${selectedStatus == 'PAID' ? 'active' : ''}">
                            <i class="bi bi-credit-card"></i> Đã thanh toán
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/tickets?status=CONFIRMED" class="filter-tab ${selectedStatus == 'CONFIRMED' ? 'active' : ''}">
                            <i class="bi bi-check-circle"></i> Đã xác nhận
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/tickets?status=CANCELLED" class="filter-tab ${selectedStatus == 'CANCELLED' ? 'active' : ''}">
                            <i class="bi bi-x-circle"></i> Đã hủy
                        </a>
                    </div>
                </div>
                
                <div style="padding: 0px 20px;">
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success" role="alert">
                            <i class="bi bi-check-circle-fill me-2"></i> ${successMessage}
                        </div>
                    </c:if>
                    
                    <!-- Thêm phần tìm kiếm -->
                    <div class="search-section">
                        <h5 class="search-title"><i class="bi bi-search"></i> Tìm kiếm vé</h5>
                        <form action="${pageContext.request.contextPath}/admin/tickets/search" method="get" class="search-form">
                            <div class="search-input">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                                    <input type="text" name="customerName" class="form-control" placeholder="Tên khách hàng" value="${param.customerName}">
                                </div>
                            </div>
                            <div class="search-input">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                                    <input type="text" name="phoneNumber" class="form-control" placeholder="Số điện thoại" value="${param.phoneNumber}">
                                </div>
                            </div>
                            <div class="search-input">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-calendar"></i></span>
                                    <input type="date" name="bookingDate" class="form-control" 
                                           value="<fmt:formatDate value="${selectedDate}" pattern="yyyy-MM-dd" />" 
                                           placeholder="Ngày đặt vé">
                                </div>
                            </div>
                            <button type="submit" class="search-btn">
                                <i class="bi bi-search"></i> Tìm kiếm
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/tickets" style="text-decoration: none;" class="clear-btn">
                                <i class="bi bi-x-circle"></i> Xóa bộ lọc
                            </a>
                        </form>
                    </div>
                    
                    <!-- Hiển thị thông tin về ngày đang xem -->
                    <c:if test="${selectedDate != null}">
                        <div class="alert alert-info mb-3" role="alert">
                            <i class="bi bi-calendar-check me-2"></i> 
                            Đang xem vé ngày: <strong><fmt:formatDate value="${selectedDate}" pattern="dd/MM/yyyy" /></strong>
                            <c:if test="${selectedStatus != null}">
                                - Trạng thái: <strong>${selectedStatus}</strong>
                            </c:if>
                        </div>
                    </c:if>
                    
                    <!-- Bảng dữ liệu mới theo thiết kế trong ảnh -->
                    <div class="table-container">
                        <c:choose>
                            <c:when test="${not empty tickets}">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Mã vé</th>
                                                <th>Khách hàng</th>
                                                <th>Chuyến đi</th>
                                                <th>Số ghế</th>
                                                <th>Ngày đặt</th>
                                                <th>Giá vé</th>
                                                <th>Trạng thái</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${tickets}" var="ticket">
                                                <tr>
                                                    <td><span class="ticket-id">#${ticket.id}</span></td>
                                                    <td>
                                                        <div>${ticket.user.fullName}</div>
                                                        <small class="text-muted"><i class="bi bi-telephone me-1"></i>${ticket.user.numberPhone}</small>
                                                    </td>
                                                    <td>
                                                        <div class="route-info">
                                                            <div>${ticket.trip.departureLocation}</div>
                                                            <div class="route-arrow"><i class="bi bi-arrow-down"></i></div>
                                                            <div>${ticket.trip.destinationLocation}</div>
                                                            <small class="text-muted">
                                                                <i class="bi bi-calendar-event me-1"></i>
                                                                <fmt:formatDate value="${ticket.trip.departureTime}" pattern="dd/MM/yyyy HH:mm" />
                                                            </small>
                                                        </div>
                                                    </td>
                                                    <td><span class="badge bg-light text-dark">${ticket.seat.seatNumber}</span></td>
                                                    <td>
                                                        <i class="bi bi-clock-history me-1"></i>
                                                        <fmt:formatDate value="${ticket.bookingDate}" pattern="dd/MM/yyyy HH:mm" />
                                                    </td>
                                                    <td>
                                                        <span class="fw-bold text-primary">
                                                            <fmt:formatNumber value="${ticket.price}" type="currency" currencySymbol="" maxFractionDigits="0" /> VND
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span class="status-badge status-${ticket.status.toLowerCase()}">
                                                            <c:choose>
                                                                <c:when test="${ticket.status == 'PENDING'}">
                                                                    <i class="bi bi-clock me-1"></i> Chờ xác nhận
                                                                </c:when>
                                                                <c:when test="${ticket.status == 'PAID'}">
                                                                    <i class="bi bi-credit-card me-1"></i> Đã thanh toán
                                                                </c:when>
                                                                <c:when test="${ticket.status == 'CONFIRMED'}">
                                                                    <i class="bi bi-check-circle me-1"></i> Đã xác nhận
                                                                </c:when>
                                                                <c:when test="${ticket.status == 'CANCELLED'}">
                                                                    <i class="bi bi-x-circle me-1"></i> Đã hủy
                                                                </c:when>
                                                                <c:otherwise>${ticket.status}</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div class="action-buttons">
                                                            <c:if test="${ticket.status == 'PAID' || ticket.status == 'PENDING'}">
                                                                <a href="${pageContext.request.contextPath}/admin/tickets/confirm/${ticket.id}" 
                                                                class="btn-confirm" 
                                                                onclick="return confirm('Xác nhận vé này?')">
                                                                    <i class="bi bi-check-lg me-1"></i> Xác nhận
                                                                </a>
                                                                
                                                                <a href="${pageContext.request.contextPath}/admin/tickets/cancel/${ticket.id}" 
                                                                class="btn-cancel" 
                                                                onclick="return confirm('Bạn có chắc chắn muốn hủy vé này?')">
                                                                    <i class="bi bi-x-lg me-1"></i> Hủy vé
                                                                </a>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <div class="empty-icon">
                                        <i class="bi bi-ticket-perforated"></i>
                                    </div>
                                    <h3 class="empty-title">Không tìm thấy vé nào</h3>
                                    <p class="empty-subtitle">Không có vé nào phù hợp với điều kiện tìm kiếm của bạn.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
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
                if (currentPath.includes('/admin/tickets') && href.includes('/admin/tickets')) {
                    link.classList.add('active');
                }
            });
        });
    </script>
    <script src="${pageContext.request.contextPath}/resources/js/admin.js"></script>
</body>
</html> 