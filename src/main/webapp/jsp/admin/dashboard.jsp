<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Trang Quản Trị Khách Sạn</title>   
        <%@ include file="layout/header.jsp" %>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/roomtype-list.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-dashboard.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css"/>
        <style>
            .alert-fixed {
                position: fixed;
                top: 20px;
                right: 20px;
                min-width: 250px;
                z-index: 1050;
                opacity: 0.95;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            }
        </style>
    </head>
    <body>
        <%@ include file="layout/nav.jsp" %>

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2 p-0">
                    <%@ include file="layout/sidebar.jsp" %>
                </div>

                <!-- Main Content -->
                <div class="col-md-10 mt-3">
                    <h2 class="text-dark">
                        <i class="bi bi-speedometer2 me-2 text-warning"></i>
                        Bảng điều khiển khách sạn
                    </h2>
                    <hr>

                    <!-- Dashboard Cards -->
                    <div class="row text-center g-3">
                        <div class="col-md-3">
                            <div class="card border-warning shadow-sm">
                                <div class="card-body">
                                    <i class="bi bi-building fs-2 text-warning"></i>
                                    <h5 class="mt-2">Tổng số phòng</h5>
                                    <p class="fs-4 fw-bold text-warning">${tongPhong}</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="card border-warning shadow-sm">
                                <div class="card-body">
                                    <i class="bi bi-person-check-fill fs-2 text-warning"></i>
                                    <h5 class="mt-2">Khách đang ở</h5>
                                    <p class="fs-4 fw-bold text-warning">${khachDangO}</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="card border-warning shadow-sm">
                                <div class="card-body">
                                    <i class="bi bi-calendar-check fs-2 text-warning"></i>
                                    <h5 class="mt-2">Đặt phòng hôm nay</h5>
                                    <p class="fs-4 fw-bold text-warning">${datPhongHomNay}</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="card border-warning shadow-sm">
                                <div class="card-body">
                                    <i class="bi bi-door-closed-fill fs-2 text-warning"></i>
                                    <h5 class="mt-2">Phòng trống</h5>
                                    <p class="fs-4 fw-bold text-warning">${phongTrong}</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Optional Chart Section -->
                    <div class="mt-4">
                        <h5 class="text-secondary">
                            <i class="bi bi-graph-up-arrow me-2 text-warning"></i>Thống kê doanh thu tháng
                        </h5>
                        <canvas id="chartDoanhThu" height="100"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="layout/footer.jsp" %>

        <!-- Thông báo tự ẩn -->
        <c:choose>
            <c:when test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-fixed" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i>${sessionScope.error}
                </div>
                <c:remove var="error" scope="session"/>
                <c:remove var="success" scope="session"/>
            </c:when>

            <c:when test="${not empty sessionScope.success}">
                <div class="alert alert-success alert-fixed" role="alert">
                    <i class="bi bi-check-circle me-2"></i>${sessionScope.success}
                </div>
                <c:remove var="success" scope="session"/>
                <c:remove var="error" scope="session"/>
            </c:when>
        </c:choose>

        <script>
            // Tự ẩn thông báo sau 3 giây
            setTimeout(() => {
                document.querySelectorAll('.alert-fixed').forEach(el => {
                    el.classList.add('fade');
                    setTimeout(() => el.remove(), 500);
                });
            }, 3000);
        </script>

        <!-- Chart JS -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            const doanhThuThang = [
            <c:forEach var="dt" items="${doanhThuThang}" varStatus="loop">
                ${dt}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
            ];

            const ctx = document.getElementById('chartDoanhThu').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
                    datasets: [{
                            label: 'Doanh thu (VNĐ)',
                            data: doanhThuThang,
                            backgroundColor: 'rgba(255, 193, 7, 0.8)',
                            borderColor: 'rgb(255, 193, 7)',
                            borderWidth: 1
                        }]
                },
                options: {
                    scales: {
                        y: {beginAtZero: true, ticks: {color: '#555'}},
                        x: {ticks: {color: '#555'}}
                    },
                    plugins: {legend: {labels: {color: '#333'}}}
                }
            });
        </script>


    </body>
</html>
