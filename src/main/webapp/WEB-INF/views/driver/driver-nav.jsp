<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .driver-nav {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        margin-bottom: 20px;
    }
    
    .driver-nav ul {
        display: flex;
        list-style: none;
        margin: 0;
        padding: 0;
    }
    
    .driver-nav li {
        position: relative;
    }
    
    .driver-nav a {
        display: block;
        padding: 15px 20px;
        text-decoration: none;
        color: #333;
        font-weight: 500;
        transition: all 0.3s;
    }
    
    .driver-nav a:hover {
        color: #ff6600;
    }
    
    .driver-nav a.active {
        color: #ff6600;
        font-weight: bold;
    }
    
    .driver-nav a.active::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 20px;
        right: 20px;
        height: 3px;
        background-color: #ff6600;
    }
    
    @media (max-width: 768px) {
        .driver-nav ul {
            flex-direction: column;
        }
        
        .driver-nav a.active::after {
            left: 0;
            right: 0;
            height: 2px;
        }
    }
</style>

<div class="driver-nav">
    <ul>
        <li>
            <a href="${pageContext.request.contextPath}/driver/" class="${pageContext.request.servletPath == '/WEB-INF/views/driver/index.jsp' ? 'active' : ''}">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/driver/trips" class="${pageContext.request.servletPath == '/WEB-INF/views/driver/trips.jsp' ? 'active' : ''}">
                <i class="fas fa-bus"></i> Chuyến đi
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/driver/schedule" class="${pageContext.request.servletPath == '/WEB-INF/views/driver/schedule.jsp' ? 'active' : ''}">
                <i class="fas fa-calendar-alt"></i> Lịch trình
            </a>
        </li>
    </ul>
</div>