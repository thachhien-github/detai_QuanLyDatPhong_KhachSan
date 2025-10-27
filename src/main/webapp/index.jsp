<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>HCMCT Hotel - Trải nghiệm nghỉ dưỡng đẳng cấp</title>

        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>

        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>

        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    </head>
    <body>

        <!-- ======= Navbar ======= -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top px-4">
            <div class="container-fluid">
                <!-- Logo -->
                <a class="navbar-brand fw-bold d-flex align-items-center" href="${pageContext.request.contextPath}/index.jsp">
                    <i class="bi bi-building me-2 text-warning"></i> HCMCT Hotel
                </a>

                <!-- Toggle button -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- Nav items -->
                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <ul class="navbar-nav align-items-center gap-3"> <!-- thêm gap đều -->
                        <li class="nav-item">
                            <a class="nav-link active" href="index.jsp">Trang chủ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#rooms">Phòng</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#services">Dịch vụ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="jsp/contact.jsp">Liên hệ</a>
                        </li>
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


        <!-- ======= Hero Section ======= -->
        <div class="hero">
            <div class="overlay"></div>
            <div class="hero-content text-center text-light">
                <h1>Chào mừng đến HCMCT Hotel</h1>
                <p>Trải nghiệm nghỉ dưỡng sang trọng, tiện nghi và đẳng cấp</p>
                <a href="${pageContext.request.contextPath}/rooms" 
                   class="btn btn-custom btn-book">Đặt phòng ngay</a>
            </div>
        </div>

        <!-- ======= About Section ======= -->
        <section id="about" class="container py-5 text-center">
            <h2 class="fw-bold mb-3 text-warning">Về chúng tôi</h2>
            <p class="text-muted mb-4">
                HCMCT Hotel mang đến cho bạn không gian nghỉ dưỡng hiện đại, sang trọng, cùng với dịch vụ chuyên nghiệp và tận tâm.
                Dù là chuyến công tác hay kỳ nghỉ cùng gia đình, chúng tôi luôn sẵn sàng phục vụ bạn một cách tốt nhất.
            </p>

            <div class="row justify-content-center">
                <div class="col-md-4 mb-3">
                    <div class="card border-0 shadow-sm p-4 h-100">
                        <i class="bi bi-wifi fs-1 text-warning"></i>
                        <h5 class="mt-3">Wi-Fi miễn phí</h5>
                        <p class="text-muted">Kết nối nhanh chóng, ổn định trong toàn bộ khuôn viên khách sạn.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="card border-0 shadow-sm p-4 h-100">
                        <i class="bi bi-cup-hot fs-1 text-warning"></i>
                        <h5 class="mt-3">Nhà hàng sang trọng</h5>
                        <p class="text-muted">Thưởng thức ẩm thực đa dạng trong không gian ấm cúng và tinh tế.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="card border-0 shadow-sm p-4 h-100">
                        <i class="bi bi-person-hearts fs-1 text-warning"></i>
                        <h5 class="mt-3">Phục vụ tận tâm</h5>
                        <p class="text-muted">Đội ngũ nhân viên chuyên nghiệp, thân thiện luôn sẵn sàng hỗ trợ bạn.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ======= Room Preview ======= -->
        <section id="rooms" class="py-5 bg-light text-center">
            <div class="container">
                <h2 class="fw-bold mb-4 text-warning">Loại phòng nổi bật</h2>
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="card shadow-sm border-0 h-100">
                            <img src="https://images.pexels.com/photos/261187/pexels-photo-261187.jpeg" class="card-img-top" alt="Phòng đơn">
                            <div class="card-body">
                                <h5 class="card-title">Phòng đơn</h5>
                                <p class="card-text text-muted">Phù hợp cho khách đi công tác ngắn ngày, đầy đủ tiện nghi.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card shadow-sm border-0 h-100">
                            <img src="https://images.pexels.com/photos/271624/pexels-photo-271624.jpeg" class="card-img-top" alt="Phòng đôi">
                            <div class="card-body">
                                <h5 class="card-title">Phòng đôi</h5>
                                <p class="card-text text-muted">Không gian thoải mái, tiện nghi hiện đại cho 2 người.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card shadow-sm border-0 h-100">
                            <img src="https://images.pexels.com/photos/1457842/pexels-photo-1457842.jpeg" class="card-img-top" alt="Phòng VIP">
                            <div class="card-body">
                                <h5 class="card-title">Phòng VIP</h5>
                                <p class="card-text text-muted">Trải nghiệm đẳng cấp với ban công view biển và dịch vụ cao cấp.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ======= Footer ======= -->
        <footer id="contact" class="text-center py-4 bg-dark text-light">
            <p class="mb-0">
                © 2025 HCMCT Hotel. All rights reserved. | Designed by <span class="text-warning">Team NHPK </span>
            </p>
        </footer>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
