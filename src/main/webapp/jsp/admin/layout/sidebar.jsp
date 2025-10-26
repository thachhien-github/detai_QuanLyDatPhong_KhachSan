<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!-- sidebar.jsp -->
<link rel="stylesheet" href="../../css/sidebar.css">

<div class="sidebar p-3">
    <h6 class="text-center mb-4">
        <i class="bi bi-journal-text me-2"></i>Menu Quản lý
    </h6>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link d-flex align-items-center active" href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                <i class="bi bi-house-door-fill me-2"></i> Trang chủ
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/jsp/booking/bookingList.jsp" class="nav-link d-flex align-items-center" href="yeu-cau">
                <i class="bi bi-envelope-paper me-2"></i> Yêu cầu đặt phòng
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link d-flex align-items-center" href="#">
                <i class="bi bi-person-lines-fill me-2"></i> Khách hàng
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link d-flex align-items-center" href="${pageContext.request.contextPath}/rooms">
                <i class="bi bi-building-check me-2"></i> Quản lý phòng
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link d-flex align-items-center" href="#">
                <i class="bi bi-gear-fill me-2"></i> Quản trị hệ thống
            </a>
        </li>
    </ul>
</div>
