<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Booking"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý đặt phòng</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/booking-list.css"/>
    </head>
    <body>

        <!-- Navbar giống index -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
            <a class="navbar-brand fw-bold fs-4" href="${pageContext.request.contextPath}/index.jsp">
                HCMCT Hotel
            </a>
            <div class="ms-auto d-flex gap-3">
                <a href="${pageContext.request.contextPath}/rooms" class="btn btn-outline-light">
                    Phòng
                </a>
                <a href="${pageContext.request.contextPath}/jsp/login.jsp" class="btn btn-warning">
                    Đăng nhập
                </a>
            </div>
        </nav>

        <!-- Nội dung chính -->
        <div class="container mt-4">
            <h2 class="mb-4 text-center">Danh sách yêu cầu đặt phòng</h2>

            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Mã đặt phòng</th>
                        <th>Khách hàng</th>
                        <th>Phòng</th>
                        <th>Ngày đặt</th>
                        <th>Nhận phòng</th>
                        <th>Trả phòng</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Booking> list = (List<Booking>) request.getAttribute("listBookings");
                        if (list != null) {
                            for (Booking b : list) {
                    %>
                    <tr>
                        <td><%= b.getMaDP()%></td>
                        <td><%= b.getCustomer().getHoTen()%></td>
                        <td><%= b.getRoom().getMaPhong()%></td>
                        <td><%= b.getNgayDat()%></td>
                        <td><%= b.getNgayNhan()%></td>
                        <td><%= b.getNgayTra()%></td>
                        <td><%= b.getTrangThai()%></td>
                        <td>
                            <a class="btn btn-success btn-sm"
                               href="${pageContext.request.contextPath}/booking/approve?id=<%= b.getMaDP()%>&action=approve">
                                Xác nhận
                            </a>
                            <a class="btn btn-danger btn-sm"
                               href="${pageContext.request.contextPath}/booking/approve?id=<%= b.getMaDP()%>&action=reject">
                                Từ chối
                            </a>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>

            <!-- Nút quay về index -->
            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-secondary">
                    ← Quay về trang chủ
                </a>
            </div>

        </div>

    </body>
</html>
