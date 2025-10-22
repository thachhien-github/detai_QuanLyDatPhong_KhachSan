<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%
    // Xử lý đăng nhập
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String message = "";

    if (username != null && password != null) {
        if (username.equals("admin") && password.equals("admin")) {
            session.setAttribute("user", "admin");
            response.sendRedirect("../admin/dashboard.jsp");
            return;
        } else {
            message = "Tên đăng nhập hoặc mật khẩu không đúng!";
        }
    }
%>
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

        <div class="login-container">
            <div class="login-box shadow-lg">
                <div class="text-center mb-4">
                    <i class="bi bi-building fs-1 text-warning"></i>
                    <h3 class="mt-2 text-light">HCMCT Hotel</h3>
                    <p class="text-secondary">Đăng nhập hệ thống</p>
                </div>

                <form action="../admin/dashboard.jsp" method="post">
                    <div class="mb-3">
                        <label class="form-label text-light">Tên đăng nhập</label>
                        <input type="text" name="username" class="form-control" placeholder="Nhập tên đăng nhập" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label text-light">Mật khẩu</label>
                        <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
                    </div>

                    <button type="submit" class="btn btn-login w-100">
                        <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                    </button>
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
