<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Liên hệ | HCMCT Hotel</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contact.css">
    </head>
    <body>
        <!-- ======= Navbar ======= -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top px-4">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold d-flex align-items-center" href="${pageContext.request.contextPath}/jsp/index.jsp">
                    <i class="bi bi-building me-2 text-warning"></i> HCMCT Hotel
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <ul class="navbar-nav align-items-center gap-3">
                        <li class="nav-item"><a class="nav-link active" href="#">Trang chủ</a></li>
                        <li class="nav-item"><a class="nav-link" href="#rooms">Phòng</a></li>
                        <li class="nav-item"><a class="nav-link" href="#services">Dịch vụ</a></li>
                        <li class="nav-item"><a class="nav-link" href="jsp/contact.jsp">Liên hệ</a></li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/login.jsp"
                               class="btn btn-outline-warning px-3 py-1 d-flex align-items-center">
                                <i class="bi bi-box-arrow-in-right me-2"></i> Đăng nhập
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Google Map -->
        <iframe src="https://www.google.com/maps?q=252+L%C3%BD+Ch%C3%ADnh+Th%E1%BA%AFng,+Ph%C6%B0%E1%BB%9Dng+Nhi%C3%AAu+L%E1%BB%99c,+Tp.+HCM&output=embed"></iframe>

        <div class="container contact-section">
            <h3 class="contact-header">Liên hệ với HCMCT Hotel</h3>
            <div class="row mt-4">
                <div class="col-md-6 contact-info">
                    <p><i class="bi bi-geo-alt-fill"></i> 252 Lý Chính Thắng, P. Nhiêu Lộc, TP. HCM</p>
                    <p><i class="bi bi-telephone-fill"></i> 0906 891 704</p>
                    <p><i class="bi bi-envelope-fill"></i> contact@hcmcthotel.com</p>
                    <p>Khách sạn HCMCT mang đến không gian nghỉ dưỡng hiện đại, tiện nghi và dịch vụ tận tâm hàng đầu tại trung tâm thành phố.</p>
                </div>
                <div class="col-md-6">
                    <form>
                        <div class="mb-3">
                            <label for="name" class="form-label">Họ và tên</label>
                            <input type="text" id="name" class="form-control" placeholder="Nhập họ tên của bạn">
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" id="email" class="form-control" placeholder="Nhập email của bạn">
                        </div>
                        <div class="mb-3">
                            <label for="message" class="form-label">Nội dung</label>
                            <textarea id="message" class="form-control" rows="4" placeholder="Nhập nội dung liên hệ..."></textarea>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn-submit">Gửi liên hệ</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- ======= Footer ======= -->
        <footer id="contact" class="text-center py-4 bg-dark text-light mt-5">
            <p class="mb-0">
                © 2025 HCMCT Hotel. All rights reserved. | Designed by 
                <span class="text-warning">Team NHPK</span>
            </p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
