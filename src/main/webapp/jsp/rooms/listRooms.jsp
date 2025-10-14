<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Room"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách phòng</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/room-list.css"/>
    </head>
    <body>

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
            <a class="navbar-brand fw-bold fs-4" href="${pageContext.request.contextPath}/index.jsp">HCMCT Hotel</a>
            <div class="ms-auto d-flex gap-3">
                <a href="${pageContext.request.contextPath}/rooms" class="btn btn-outline-light">Phòng</a>
                <a href="${pageContext.request.contextPath}/booking/list" class="btn btn-outline-light">Yêu cầu đặt phòng</a>
                <a href="${pageContext.request.contextPath}/jsp/login.jsp" class="btn btn-warning">Đăng nhập</a>
            </div>
        </nav>

        <div class="container mt-4">
            <h2 class="mb-4 text-center">Danh sách phòng khách sạn</h2>

            <div class="row">
                <%
                    List<Room> list = (List<Room>) request.getAttribute("listRooms");
                    if (list != null) {
                        for (Room r : list) {
                            int lt = r.getMaLoai();
                %>
                <div class="col-md-3 mb-4">
                    <div class="card shadow-sm h-100">
                        <img src="${pageContext.request.contextPath}/img/<%= r.getHinhAnh()%>"
                             class="card-img-top room-img" alt="Room Image"/>

                        <div class="card-body">
                            <h5 class="card-title mb-3"><%= r.getTenPhong()%></h5>

                            <p class="card-text mb-2">
                                <strong>Loại:</strong> <%= lt%>
                            </p>
                            <p class="card-text mb-2">
                                <strong>Giá:</strong> <%= r.getGia()%> VNĐ
                            </p>
                            <p class="card-text mb-3">
                                <strong>Tình trạng:</strong> <%= r.getTinhTrang()%>
                            </p>

                            <form action="${pageContext.request.contextPath}/jsp/booking/bookingForm.jsp" method="get">
                                <input type="hidden" name="maPhong" value="<%= r.getMaPhong()%>"/>
                                <button class="btn btn-primary w-100">Đặt phòng ngay</button>
                            </form>
                        </div>
                    </div>
                </div>
                <%
                        }
                    }
                %>
            </div>

            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-secondary">
                    ← Quay về trang chủ
                </a>
            </div>
        </div>

    </body>
</html>
