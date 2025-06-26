<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav
          id="sidebar"
          class="col-md-3 col-lg-2 d-md-block sidebar collapse"
        >
          <div class="position-sticky pt-3">
            <div class="text-center mb-4">
              <h5 class="text-white">Kim Quy  Bus Lines</h5>
              <p class="text-white-50">Hệ thống </p>
            </div>
            <hr class="text-white-50">
            <ul class="nav flex-column">
              <li class="nav-item">
                <a
                  class="nav-link"
                  href="${pageContext.request.contextPath}/admin/"
                >
                  <i class=""></i> Bảng điều khiển
                </a>
              </li>
              <li class="nav-item">
                <a
                  class="nav-link"
                  href="${pageContext.request.contextPath}/admin/trips"
                >
                  <i class=""></i> Quản lý chuyến đi
                </a>
              </li>
              <li class="nav-item">
                <a
                  class="nav-link"
                  href="${pageContext.request.contextPath}/admin/tickets"
                >
                  <i class=""></i> Quản lý vé
                </a>
              </li>
              <li class="nav-item">
                <a
                  class="nav-link"
                  href="${pageContext.request.contextPath}/admin/drivers"
                >
                  <i class=""></i> Quản lý tài xế
                </a>
              </li>
              <li class="nav-item">
                <a
                  class="nav-link"
                  href="${pageContext.request.contextPath}/admin/buses"
                >
                  <i class=""></i> Quản lý xe
                </a>
              </li>
              <li class="nav-item">
                <a
                  class="nav-link"
                  href="${pageContext.request.contextPath}/admin/pickup-points"
                >
                  <i class=""></i> Quản lý điểm dừng
                </a>
              </li>
              <li class="nav-item">
                <a
                  class="nav-link"
                  href="${pageContext.request.contextPath}/admin/reports"
                >
                  <i class=""></i> Báo cáo thống kê
                </a>
              </li>
              
            </ul>
          </div>
        </nav>