<%@page import="java.util.List"%>
<%@page import="model.Room"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>HCMCT Hotel - Danh sách phòng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/room-list.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top px-4">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold d-flex align-items-center" href="${pageContext.request.contextPath}/../../index.jsp">
                    <i class="bi bi-building me-2 text-warning"></i> HCMCT Hotel
                </a>
                <!-- ... -->
            </div>
        </nav>

        <div class="container mt-5 pt-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="m-0 flex-grow-1 text-center">Danh sách phòng khách sạn</h2>
            </div>

            <!-- debug -->
            <div class="mb-3">
                <strong>Rooms size: </strong><c:out value="${fn:length(listRooms)}" />
                <c:if test="${not empty error}">
                    <div class="alert alert-danger mt-2">${error}</div>
                </c:if>
            </div>

            <div class="row">
                <c:choose>
                    <c:when test="${not empty listRooms}">
                        <c:forEach var="r" items="${listRooms}">
                            <div class="col-md-3 mb-4">
                                <div class="card shadow-sm h-100">
                                    <img src="${pageContext.request.contextPath}/img/${r.soPhong}.jpg"
                                         class="card-img-top room-img" alt="Room Image"/>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title mb-3 text-primary">${r.soPhong}</h5>
                                        <p class="card-text mb-2"><strong>Loại:</strong> ${r.tenLoaiPhong}</p>
                                        <p class="card-text mb-2">
                                            <strong>Giá:</strong>
                                            <fmt:formatNumber value="${r.donGia}" type="currency" currencySymbol="VNĐ"/>
                                        </p>
                                        <p class="card-text mb-3"><strong>Tình trạng:</strong> ${r.trangThai}</p>

                                        <form action="${pageContext.request.contextPath}/jsp/booking/bookingForm.jsp" method="get" class="mt-auto">
                                            <input type="hidden" name="maPhong" value="${r.maPhong}"/>
                                            <button class="btn btn-primary w-100">Đặt phòng ngay</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12 text-center">
                            <div class="alert alert-warning">
                                Hiện chưa có phòng nào được thêm vào hệ thống.
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-secondary">← Quay về trang chủ</a>
            </div>
        </div>

        <footer id="contact" class="text-center py-4 bg-dark text-light">
            <p class="mb-0">© 2025 HCMCT Hotel. All rights reserved.</p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
