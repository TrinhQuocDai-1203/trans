<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý chuyến đi - Xe Di Dau Nhe</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
        }
        
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .page-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #333;
        }
        
        .filter-bar {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 8px;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .filter-label {
            font-weight: 500;
            color: #6c757d;
        }
        
        .filter-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .filter-select {
            padding: 8px 12px;
            border-radius: 4px;
            border: 1px solid #ced4da;
            background-color: white;
        }
        
        .trips-list {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }
        
        .trip-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .trip-table th, .trip-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .trip-table th {
            font-weight: 500;
            color: #6c757d;
            background-color: #f8f9fa;
        }
        
        .trip-table tr:last-child td {
            border-bottom: none;
        }
        
        .status-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .status-badge.SCHEDULED {
            background-color: #fff7ed;
            color: #c2410c;
        }
        
        .status-badge.IN_PROGRESS {
            background-color: #ecfdf5;
            color: #047857;
        }
        
        .status-badge.COMPLETED {
            background-color: #f0f9ff;
            color: #0369a1;
        }
        
        .status-badge.CANCELLED {
            background-color: #f3f4f6;
            color: #6b7280;
        }
        
        .action-link {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            text-decoration: none;
            background-color: #e0f2fe;
            color: #0284c7;
            font-weight: 500;
            transition: all 0.2s;
        }
        
        .action-link:hover {
            background-color: #bae6fd;
        }
        
        .empty-message {
            padding: 40px;
            text-align: center;
            color: #6c757d;
        }
        
        @media (max-width: 768px) {
            .filter-bar {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .trip-table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/components/header.jsp" />
    
    <div class="container">
        <div class="dashboard-header">
            <h1 class="page-title">Quản lý chuyến đi</h1>
        </div>
        
        <jsp:include page="/WEB-INF/views/driver/driver-nav.jsp" />
        
        <div class="filter-bar">
            <div class="filter-group">
                <span class="filter-label">Trạng thái:</span>
                <select class="filter-select" id="status-filter">
                    <option value="all">Tất cả</option>
                    <option value="SCHEDULED">Sắp tới</option>
                    <option value="IN_PROGRESS">Đang chạy</option>
                    <option value="COMPLETED">Đã hoàn thành</option>
                    <option value="CANCELLED">Đã hủy</option>
                </select>
            </div>
        </div>
        
        <div class="trips-list">
            <table class="trip-table">
                <thead>
                    <tr>
                        <th>Mã chuyến</th>
                        <th>Tuyến đường</th>
                        <th>Thời gian</th>
                        <th>Xe</th>
                        <th>Số khách</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty trips}">
                            <c:forEach items="${trips}" var="trip">
                                <tr data-status="${trip.status}">
                                    <td>#${trip.id}</td>
                                    <td>${trip.departureLocation} → ${trip.destinationLocation}</td>
                                    <td>
                                        <div><fmt:formatDate value="${trip.departureTime}" pattern="dd/MM/yyyy" /></div>
                                        <div><fmt:formatDate value="${trip.departureTime}" pattern="HH:mm" /></div>
                                    </td>
                                    <td>${trip.bus.licensePlate}</td>
                                    <td>${trip.bus.capacity - trip.availableSeats}/${trip.bus.capacity}</td>
                                    <td>
                                        <span class="status-badge ${trip.status}">
                                            ${trip.status}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/driver/seats/${trip.id}" class="action-link">Xem ghế</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" class="empty-message">Không có chuyến đi nào</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    
    <script>
        // Simple filter functionality
        document.getElementById('status-filter').addEventListener('change', function() {
            const status = this.value;
            const rows = document.querySelectorAll('.trip-table tbody tr[data-status]');
            
            if (status === 'all') {
                rows.forEach(row => row.style.display = '');
            } else {
                rows.forEach(row => {
                    if (row.getAttribute('data-status') === status) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            }
        });
    </script>
</body>
</html>
