<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đăng nhập | HCMCT Hotel</title>
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-login.css"/>
    </head>
    <body>

        <div class="login-container d-flex justify-content-center align-items-center">
            <div class="login-box p-4 rounded shadow-lg">
                <div class="text-center mb-4">
                    <i class="bi bi-building fs-1 text-warning"></i>
                    <h3 class="mt-2 text-light">HCMCT Hotel</h3>
                    <p class="text-secondary">Đăng nhập hệ thống</p>
                </div>

                <form action="${pageContext.request.contextPath}/auth" method="post">
                    <div class="mb-3">
                        <label class="form-label text-light">Tên đăng nhập</label>
                        <input type="text" name="username" class="form-control" placeholder="Nhập tên đăng nhập" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label text-light">Mật khẩu</label>
                        <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-login">
                            <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                        </button>
                    </div>
                </form>

                <div class="mt-3 text-center">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="text-warning text-decoration-none">
                        <i class="bi bi-arrow-left me-1"></i> Quay lại trang chủ
                    </a>
                </div>
            </div>
        </div>

    </body>
</html>
