<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Khách sạn HCMCT Hotel</title>
        <link rel="stylesheet" 
              href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
            <a class="navbar-brand fw-bold d-flex align-items-center" href="#">
                <i class="bi bi-building me-2"></i> HCMCT Hotel
            </a>
            <div class="ms-auto d-flex gap-3">
                <a href="${pageContext.request.contextPath}/jsp/login.jsp" class="btn btn-outline-custom btn-sm">
                    <i class="bi bi-box-arrow-right me-1"></i> Đăng nhập
                </a>
            </div>
        </nav>

        <div class="hero">
            <div class="overlay"></div>

            <div class="hero-content">
                <h1>Chào mừng đến HCMCT Hotel</h1>
                <p>Trải nghiệm nghỉ dưỡng sang trọng, tiện nghi và đẳng cấp</p>

                <a href="${pageContext.request.contextPath}/rooms" 
                   class="btn btn-custom btn-book">
                    Đặt phòng ngay
                </a>

            </div>
        </div>

        <footer>
            © 2025 HCMCT Hotel. All rights reserved.
        </footer>

    </body>
</html>
