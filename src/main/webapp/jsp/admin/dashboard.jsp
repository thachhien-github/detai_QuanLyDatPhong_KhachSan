<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Trang Quản Trị Khách Sạn</title>   
        <%@ include file="layout/header.jsp" %>
        <link rel="stylesheet" href="../../css/sidebar.css">
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
                <!-- Sidebar -->
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
                    <p>Chào mừng bạn đến với hệ thống quản lý khách sạn!</p>

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
                            <div class="card border-success shadow-sm">
                                <div class="card-body">
                                    <i class="bi bi-person-check-fill fs-2 text-success"></i>
                                    <h5 class="mt-2">Khách đang ở</h5>
                                    <p class="fs-4 fw-bold text-success">${khachDangO}</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="card border-info shadow-sm">
                                <div class="card-body">
                                    <i class="bi bi-calendar-check fs-2 text-info"></i>
                                    <h5 class="mt-2">Đặt phòng hôm nay</h5>
                                    <p class="fs-4 fw-bold text-info">${datPhongHomNay}</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="card border-danger shadow-sm">
                                <div class="card-body">
                                    <i class="bi bi-door-closed-fill fs-2 text-danger"></i>
                                    <h5 class="mt-2">Phòng trống</h5>
                                    <p class="fs-4 fw-bold text-danger">${phongTrong}</p>
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

    <!-- Optional JS Chart -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Biểu đồ doanh thu mẫu
        const ctx = document.getElementById('chartDoanhThu');
        if (ctx) {
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6'],
                    datasets: [{
                            label: 'Doanh thu (VNĐ)',
                            data: [120, 180, 150, 220, 190, 260],
                            backgroundColor: 'rgba(255, 193, 7, 0.8)',
                            borderColor: 'rgb(255, 193, 7)',
                            borderWidth: 1
                        }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {color: '#555'}
                        },
                        x: {
                            ticks: {color: '#555'}
                        }
                    },
                    plugins: {
                        legend: {
                            labels: {color: '#333'}
                        }
                    }
                }
            });
        }
    </script>

</body>
</html>
