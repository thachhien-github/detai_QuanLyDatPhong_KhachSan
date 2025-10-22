<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đặt phòng</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/booking-form.css"/>
    </head>
    <body>

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
            <a class="navbar-brand fw-bold fs-4" href="${pageContext.request.contextPath}/index.jsp">
                HCMCT Hotel
            </a>
            <div class="ms-auto d-flex gap-3">
                <a href="${pageContext.request.contextPath}/jsp/login.jsp" class="btn btn-warning">
                    Đăng nhập
                </a>
            </div>
        </nav>

        <!-- Form -->
        <div class="container mt-5">
            <div class="card p-4 shadow form-container mx-auto">
                <h3 class="text-center mb-4">Đặt phòng</h3>

                <form action="${pageContext.request.contextPath}/booking" method="post">
                    <input type="hidden" name="maPhong" value="${param.maPhong}"/>

                    <div class="input-row">
                        <label>Họ tên</label>
                        <input type="text" name="hoTen" required>
                    </div>

                    <div class="input-row">
                        <label>Số điện thoại</label>
                        <input type="text" name="sdt" required>
                    </div>

                    <div class="input-row">
                        <label>Email</label>
                        <input type="email" name="email">
                    </div>

                    <div class="input-row">
                        <label>Địa chỉ</label>
                        <input type="text" name="diaChi">
                    </div>

                    <div class="input-row">
                        <label>Ngày nhận</label>
                        <input type="date" name="ngayNhan" required>
                    </div>

                    <div class="input-row">
                        <label>Ngày trả</label>
                        <input type="date" name="ngayTra" required>
                    </div>

                    <div class="d-flex justify-content-center gap-3 mt-4">
                        <a href="${pageContext.request.contextPath}/rooms" class="btn btn-secondary">
                            ← Quay lại
                        </a>
                        <button type="submit" class="btn btn-success">
                            Đặt phòng
                        </button>
                    </div>
                </form>
            </div>
        </div>

    </body>
</html>
