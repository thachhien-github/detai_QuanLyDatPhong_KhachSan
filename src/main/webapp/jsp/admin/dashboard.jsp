<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Trang Quản Trị Khách Sạn</title>   
        <%@ include file="layout/header.jsp" %>
        <link rel="stylesheet" href="../../css/sidebar.css">
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
