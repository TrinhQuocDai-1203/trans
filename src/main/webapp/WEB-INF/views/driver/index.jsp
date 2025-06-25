<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Driver Dashboard - Xe Di Dau Nhe</title>
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
        
        .driver-content {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .dashboard-header {
            margin-bottom: 30px;
        }
        
        .dashboard-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }
        
        .dashboard-subtitle {
            color: #666;
            font-size: 16px;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 20px;
        }
        
        .stat-title {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }
        
        .stat-value {
            font-size: 28px;
            font-weight: bold;
            color: #333;
        }
        
        .upcoming-trips {
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
        }
        
        .trip-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .trip-table th, .trip-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .trip-table th {
            font-weight: 500;
            color: #666;
            background-color: #f9f9f9;
        }
        
        .status-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .status-badge.pending, .status-badge.SCHEDULED {
            background-color: #fff7ed;
            color: #c2410c;
        }
        
        .status-badge.ongoing, .status-badge.IN_PROGRESS {
            background-color: #ecfdf5;
            color: #047857;
        }
        
        .status-badge.completed, .status-badge.COMPLETED {
            background-color: #f0f9ff;
            color: #0369a1;
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
        
        @media (max-width: 768px) {
            .stats-grid {
                grid-template-columns: 1fr;
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
    
    <div class="driver-content">
        <div class="dashboard-header">
            <h1 class="dashboard-title">Xin chào, ${sessionScope.user.fullName}</h1>
            <p class="dashboard-subtitle">Quản lý chuyến xe của bạn</p>
        </div>
        
        <jsp:include page="/WEB-INF/views/driver/driver-nav.jsp" />
        
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-title">Tổng số chuyến</div>
                <div class="stat-value">${totalTrips}</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-title">Chuyến sắp tới</div>
                <div class="stat-value">${upcomingTripsCount}</div>
            </div>

        </div>
        
        <div class="upcoming-trips">
            <h2 class="section-title">Chuyến sắp tới</h2>
            
            <table class="trip-table">
                <thead>
                    <tr>
                        <th>Mã chuyến</th>
                        <th>Điểm đi</th>
                        <th>Điểm đến</th>
                        <th>Ngày</th>
                        <th>Giờ</th>
                        <th>Số khách</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty upcomingTrips}">
                            <c:forEach items="${upcomingTrips}" var="trip">
                                <tr>
                                    <td>#${trip.id}</td>
                                    <td>${trip.departureLocation}</td>
                                    <td>${trip.destinationLocation}</td>
                                    <td><fmt:formatDate value="${trip.departureTime}" pattern="dd/MM/yyyy" /></td>
                                    <td><fmt:formatDate value="${trip.departureTime}" pattern="HH:mm" /></td>
                                    <td>${trip.bus.capacity - trip.availableSeats}/${trip.bus.capacity}</td>
                                    <td><span class="status-badge ${trip.status}">${trip.status}</span></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/driver/seats/${trip.id}" class="action-link">Xem ghế</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="8" style="text-align: center; padding: 20px;">Không có chuyến nào sắp tới</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>