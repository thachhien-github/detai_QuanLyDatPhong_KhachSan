<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Room"%>
<%@page import="model.RoomType"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách phòng</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/room-list.css"/>
    </head>
    <body>

        <!-- Navbar đồng bộ -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
            <a class="navbar-brand fw-bold fs-4" href="${pageContext.request.contextPath}/index.jsp">
                HCMCT Hotel
            </a>
            <div class="ms-auto d-flex gap-3">
                <a href="${pageContext.request.contextPath}/rooms" class="btn btn-outline-light">
                    Phòng
                </a>
                <a href="${pageContext.request.contextPath}/booking/list" class="btn btn-outline-light">
                    Yêu cầu đặt phòng
                </a>
                <a href="${pageContext.request.contextPath}/jsp/login.jsp" class="btn btn-warning">
                    Đăng nhập
                </a>
            </div>
        </nav>

        <div class="container mt-4">
            <h2 class="mb-4 text-center">Danh sách phòng khách sạn</h2>

            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Mã phòng</th>
                        <th>Tên phòng</th>
                        <th>Loại phòng</th>
                        <th>Giá</th>
                        <th>Tình trạng</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Room> list = (List<Room>) request.getAttribute("listRooms");
                        if (list != null) {
                            for (Room r : list) {
                                RoomType lt = r.getLoaiPhong();
                    %>
                    <tr>
                        <td><%= r.getMaPhong()%></td>
                        <td><%= r.getTenPhong()%></td>
                        <td><%= (lt != null ? lt.getTenLoai() : "")%></td>
                        <td><%= r.getGia()%></td>
                        <td><%= r.getTinhTrang()%></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/jsp/booking/bookingForm.jsp" method="get">
                                <input type="hidden" name="maPhong" value="<%= r.getMaPhong()%>"/>
                                <button class="btn btn-primary btn-sm">Đặt phòng</button>
                            </form>
                        </td>
                    </tr>
                    <%      }
                        }
                    %>
                </tbody>
            </table>

            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-secondary">
                    ← Quay về trang chủ
                </a>
            </div>
        </div>

    </body>
</html>
