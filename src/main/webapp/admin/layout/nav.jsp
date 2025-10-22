<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../css/style-dashboard.css">

<nav class="navbar navbar-expand-lg navbar-dark custom-navbar px-4">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold d-flex align-items-center" href="#">
            <i class="bi bi-building me-2"></i> Hệ thống Quản lý Khách Sạn
        </a>

        <div class="d-flex align-items-center">
            <span class="navbar-text me-3">
                <i class="bi bi-person-circle me-1"></i> Quản trị viên
            </span>

            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-custom btn-sm">
                <i class="bi bi-box-arrow-right me-1"></i> Đăng xuất
            </a>

        </div>
    </div>
</nav>
