<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Booking"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8"/>
        <title>Trang Quản Trị Khách Sạn</title>
        <%@ include file="../admin/layout/header.jsp" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/booking-list.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-dashboard.css">


    </head>
    <body>
        <%@ include file="../admin/layout/nav.jsp" %>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-2 p-0">
                    <%@ include file="../admin/layout/sidebar.jsp" %>
                </div>

                <!-- Main Content -->
                <div class="col-md-10 mt-3">
                    <h2 class="text-dark">
                        <i class="bi bi-speedometer2 me-2 text-warning"></i>
                        Bảng điều khiển khách sạn - yêu cầu đặt phòng
                    </h2>
                    <hr/>

                    <div class="container mt-4">

                        <table class="table table-bordered table-hover align-middle text-center">
                            <thead class="table-light">
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
                            <c:choose>
                                <c:when test="${not empty listBookings}">
                                    <c:forEach var="b" items="${listBookings}">
                                        <tr>
                                            <td><c:out value="${b.maDP}"/></td>
                                        <td>
                                        <c:choose>
                                            <c:when test="${not empty b.customer}"><c:out value="${b.customer.hoTen}"/></c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                        </td>
                                        <td>
                                        <c:choose>
                                            <c:when test="${not empty b.room}"><c:out value="${b.room.maPhong}"/></c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                        </td>
                                        <td><fmt:formatDate value="${b.ngayDat}" pattern="yyyy-MM-dd"/></td>
                                        <td><fmt:formatDate value="${b.ngayNhan}" pattern="yyyy-MM-dd"/></td>
                                        <td><fmt:formatDate value="${b.ngayTra}" pattern="yyyy-MM-dd"/></td>
                                        <td><c:out value="${b.trangThai}"/></td>
                                        <td>
                                            <a class="btn btn-success btn-sm"
                                               href="${pageContext.request.contextPath}/booking/approve?id=${b.maDP}&action=approve">
                                                <i class="bi bi-check2-circle"></i> Xác nhận
                                            </a>
                                            <a class="btn btn-danger btn-sm"
                                               href="${pageContext.request.contextPath}/booking/approve?id=${b.maDP}&action=reject"
                                               onclick="return confirm('Bạn có muốn từ chối yêu cầu này?');">
                                                <i class="bi bi-x-circle"></i> Từ chối
                                            </a>
                                        </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8" class="text-center text-muted py-3">Không có yêu cầu đặt phòng nào.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>

                        <!-- Nút quay về dashboard -->
                        <div class="text-center mt-4">
                            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-secondary">
                                ← Quay về trang chủ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="../admin/layout/footer.jsp" %>

        <%-- nếu cần JS bootstrap --%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>