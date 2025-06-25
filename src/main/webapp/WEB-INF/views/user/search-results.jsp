<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="results-section">
    <div class="">
        <h1 class="section-title">Kết Quả Tìm Kiếm</h1>
        
        <div class="search-summary">
            <div class="route">
                <i class="fas fa-map-marker-alt departure"></i>
                <span class="location">${departureLocation}</span>
                <i class="fas fa-long-arrow-alt-right"></i>
                <i class="fas fa-map-marker-alt destination"></i>
                <span class="location">${destinationLocation}</span>
            </div>
            <div class="date">
                <i class="far fa-calendar-alt"></i>
                <span>${departureDate}</span>
            </div>
        </div>
        
        <div class="results-container">
            <div class="search-filter">
                <a href="#" class="filter-btn active">Tất cả</a>
                <a href="#" class="filter-btn">Sáng (00:00 - 12:00)</a>
                <a href="#" class="filter-btn">Chiều (12:00 - 18:00)</a>
                <a href="#" class="filter-btn">Tối (18:00 - 24:00)</a>
            </div>
            
            <c:choose>
                <c:when test="${empty trips}">
                    <div class="no-results">
                        <i class="fas fa-exclamation-circle"></i>
                        <p>Không tìm thấy chuyến xe phù hợp. Vui lòng thử lại với các tiêu chí khác.</p>
                        <!-- <a href="${pageContext.request.contextPath}/user/search-trips" class="btn-search-again">Tìm Kiếm Lại</a> -->
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="trip-list">
                        <c:forEach items="${trips}" var="trip">
                            <div class="trip-card">
                                <div class="trip-details">
                                    <div class="trip-route">
                                        <div class="time-location">
                                            <div class="time"><fmt:formatDate value="${trip.departureTime}" pattern="HH:mm dd/MM" /></div>
                                            <div class="location">${trip.departureLocation}</div>
                                        </div>
                                        <div class="trip-duration">
                                            <div class="duration-line"></div>
                                            <c:set var="diffInMillies" value="${trip.arrivalTime.time - trip.departureTime.time}" />
                                            <c:set var="hours" value="${diffInMillies / (60 * 60 * 1000)}" />
                                            <div class="duration-time">${Math.round(hours)}h</div>
                                        </div>
                                        <div class="time-location">
                                            <div class="time"><fmt:formatDate value="${trip.arrivalTime}" pattern="HH:mm dd/MM" /></div>
                                            <div class="location">${trip.destinationLocation}</div>
                                        </div>
                                    </div>
                                    
                                    <c:if test="${trip.departureLocation ne param.departureLocation || trip.destinationLocation ne param.destinationLocation}">
                                        <div class="intermediate-stop-notice">
                                            <i class="fa fa-info-circle"></i>
                                            <span>Chuyến này đi từ ${trip.departureLocation} đến ${trip.destinationLocation} và đi qua ${param.destinationLocation}.</span>
                                        </div>
                                    </c:if>
                                    
                                    <div class="trip-info">
                                        <div class="bus-type">
                                            <i class="fas fa-bus"></i>
                                            <span>${trip.bus.busType}</span>
                                        </div>
                                        <div class="pickup-point">
                                            <i class="fas fa-map-marker-alt"></i>
                                            <span>Điểm đón: ${trip.departurePoint.address}</span>
                                        </div>
                                        <div class="seats-available">
                                            <i class="fas fa-chair"></i>
                                            <span>${trip.availableSeats} chỗ trống</span>
                                        </div>
                                    </div>
                                    
                                    <c:if test="${trip.destinationLocation != param.destinationLocation}">
                                        <div class="intermediate-stop-info alert alert-info mb-2">
                                            <i class="bi bi-info-circle"></i>
                                            Chuyến xe đi từ <strong>${trip.departureLocation}</strong> đến <strong>${trip.destinationLocation}</strong> 
                                            <a href="#" class="show-stops-btn" data-trip-id="${trip.id}">Xem chi tiết lộ trình</a>
                                        </div>
                                    </c:if>
                                </div>
                                
                                <div class="trip-action">
                                    <div class="price">
                                        <div class="amount"><fmt:formatNumber value="${trip.price}" pattern="#,###" /> đ</div>
                                        <div class="price-type">Giá/Người</div>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/user/book-trip/${trip.id}" class="btn-book">Chọn Chuyến</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>

