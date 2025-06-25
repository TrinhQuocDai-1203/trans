<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Lịch trình tài xế - Xe Di Dau Nhe</title>
    <style>
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
        
        .schedule-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
            overflow: hidden;
        }
        
        .schedule-header {
            background-color: #f8f9fa;
            padding: 15px 20px;
            border-bottom: 1px solid #e9ecef;
        }
        
        .schedule-date {
            font-size: 18px;
            font-weight: 500;
            color: #343a40;
        }
        
        .schedule-item {
            padding: 20px;
            border-bottom: 1px solid #e9ecef;
            display: grid;
            grid-template-columns: 120px 1fr auto;
            gap: 20px;
            align-items: center;
        }
        
        .schedule-item:last-child {
            border-bottom: none;
        }
        
        .trip-time {
            font-weight: 500;
            color: #343a40;
            font-size: 16px;
        }
        
        .trip-details {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        
        .trip-route {
            font-weight: 500;
            color: #343a40;
            font-size: 16px;
        }
        
        .trip-info {
            color: #6c757d;
            font-size: 14px;
        }
        
        .trip-actions {
            display: flex;
            gap: 10px;
        }
        
        .action-link {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 14px;
            text-decoration: none;
            background-color: #e0f2fe;
            color: #0284c7;
            font-weight: 500;
            transition: all 0.2s;
        }
        
        .action-link:hover {
            background-color: #bae6fd;
        }
        
        .status-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 500;
            margin-left: 10px;
        }
        
        .status-badge.scheduled {
            background-color: #fff7ed;
            color: #c2410c;
        }
        
        .status-badge.in-progress {
            background-color: #ecfdf5;
            color: #047857;
        }
        
        .status-badge.completed {
            background-color: #f0f9ff;
            color: #0369a1;
        }
        
        .empty-schedule {
            padding: 40px;
            text-align: center;
            color: #6c757d;
        }
        
        @media (max-width: 768px) {
            .schedule-item {
                grid-template-columns: 1fr;
                gap: 10px;
            }
            
            .trip-actions {
                justify-content: flex-start;
            }
        }
    </style>
</head>
<body>
    
    <div class="container">
        <h1 class="page-title">Lịch trình tài xế</h1>
        
        <c:choose>
            <c:when test="${not empty scheduledTrips}">
                <!-- Group trips by date for better organization -->
                <c:set var="currentDate" value="" />
                
                <c:forEach items="${scheduledTrips}" var="trip" varStatus="status">
                    <fmt:formatDate value="${trip.departureTime}" pattern="yyyy-MM-dd" var="tripDate" />
                    
                    <c:if test="${currentDate != tripDate}">
                        <c:if test="${!status.first}">
                            </div> <!-- Close previous schedule-card -->
                        </c:if>
                        
                        <div class="schedule-card">
                            <div class="schedule-header">
                                <div class="schedule-date">
                                    <fmt:formatDate value="${trip.departureTime}" pattern="EEEE, dd/MM/yyyy" />
                                </div>
                            </div>
                        
                        <c:set var="currentDate" value="${tripDate}" />
                    </c:if>
                    
                    <div class="schedule-item">
                        <div class="trip-time">
                            <fmt:formatDate value="${trip.departureTime}" pattern="HH:mm" />
                        </div>
                        
                        <div class="trip-details">
                            <div class="trip-route">
                                ${trip.departureLocation} → ${trip.destinationLocation}
                                <span class="status-badge ${trip.status == 'SCHEDULED' ? 'scheduled' : trip.status == 'IN_PROGRESS' ? 'in-progress' : 'completed'}">
                                    ${trip.status}
                                </span>
                            </div>
                            <div class="trip-info">
                                Xe: ${trip.bus.licensePlate} | Số ghế: ${trip.bus.capacity - trip.availableSeats}/${trip.bus.capacity}
                            </div>
                        </div>
                        
                        <div class="trip-actions">
                            <a href="/driver/seats/${trip.id}" class="action-link">Xem ghế</a>
                        </div>
                    </div>
                    
                    <c:if test="${status.last}">
                        </div> <!-- Close last schedule-card -->
                    </c:if>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="schedule-card">
                    <div class="empty-schedule">
                        Không có lịch trình nào sắp tới
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>