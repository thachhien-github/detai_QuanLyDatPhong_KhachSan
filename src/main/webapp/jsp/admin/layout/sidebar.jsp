<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="<c:url value='/css/sidebar.css'/>">

<div class="sidebar p-3">
    <h6 class="text-center mb-4">
        <i class="bi bi-journal-text me-2"></i> Menu Quản lý
    </h6>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link d-flex align-items-center active" href="<c:url value='/jsp/admin/dashboard.jsp'/>">
                <i class="bi bi-house-door-fill me-2"></i> Trang chủ
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link d-flex align-items-center" href="<c:url value='/booking/bookings'/>">
                <i class="bi bi-envelope-paper me-2"></i> Yêu cầu đặt phòng
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link d-flex align-items-center" href="<c:url value='/customers'/>">
                <i class="bi bi-person-lines-fill me-2"></i> Khách hàng
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link d-flex align-items-center" href="<c:url value='/loai-phong'/>">
                <i class="bi bi-tags me-2"></i> Quản lý loại phòng
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link d-flex align-items-center" href="<c:url value='/rooms-list'/>">
                <i class="bi bi-building-check me-2"></i> Quản lý phòng
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link d-flex align-items-center" href="<c:url value='/luutru'/>">
                <i class="bi bi-house-door-fill me-2"></i> Lưu trú
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link d-flex align-items-center" href="<c:url value='/HoaDon'/>">
                <i class="bi bi-house-door-fill me-2"></i> Quản lý hóa đơn
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link d-flex align-items-center" href="<c:url value='/jsp/admin/settings.jsp'/>">
                <i class="bi bi-gear-fill me-2"></i> Quản trị hệ thống
            </a>
        </li>
    </ul>
</div>
