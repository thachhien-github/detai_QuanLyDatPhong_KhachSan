<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8"/>
        <title>Quản lý Đặt phòng - HCMCT Hotel</title>

        <jsp:include page="../admin/layout/header.jsp" />

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-dashboard.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/roomtype-list.css"/>
    </head>

    <body>
        <jsp:include page="../admin/layout/nav.jsp" />

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2 p-0">
                    <jsp:include page="../admin/layout/sidebar.jsp" />
                </div>

                <div class="col-md-10 mt-3">
                    <h2 class="text-dark">
                        <i class="bi bi-calendar-check me-2 text-warning"></i> Quản lý Đặt phòng
                    </h2>
                    <hr/>

                    <div class="container mt-3 inner-container">
                        <div class="card-surface">
                            <!-- Toolbar -->
                            <div class="toolbar">
                                <div class="toolbar-left">
                                    <button class="btn btn-success btn-sm" disabled>
                                        <i class="bi bi-list-ul me-1"></i> Danh sách Đặt phòng
                                    </button>
                                    <div class="ms-2 text-muted small">
                                        Tổng: <strong id="itemsCountSmall">${empty listBookings ? 0 : fn:length(listBookings)}</strong>
                                    </div>
                                </div>

                                <div class="toolbar-right">
                                    <form id="searchForm" class="d-flex" method="get"
                                          action="${pageContext.request.contextPath}/booking/bookings">
                                        <div class="toolbar search">
                                            <i class="bi bi-search"></i>
                                            <input type="text" id="searchInput" name="q"
                                                   placeholder="Tìm theo phòng, khách, trạng thái..."
                                                   value="${fn:escapeXml(param.q)}"/>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Thông báo -->
                            <c:if test="${not empty sessionScope.success}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    ${sessionScope.success}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                                <c:remove var="success" scope="session"/>
                            </c:if>
                            <c:if test="${not empty sessionScope.error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${sessionScope.error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                                <c:remove var="error" scope="session"/>
                            </c:if>

                            <!-- Bảng danh sách -->
                            <div class="table-wrap">
                                <table class="table table-hover align-middle">
                                    <thead>
                                        <tr>
                                            <th style="width:90px">Mã</th>
                                            <th>Phòng</th>
                                            <th>Khách</th>
                                            <th>Ngày đặt</th>
                                            <th>Nhận - Trả</th>
                                            <th style="width:130px">Trạng thái</th>
                                            <th style="width:180px">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tblBody">
                                        <c:forEach var="b" items="${listBookings}">
                                            <tr class="booking-row"
                                                data-madat="${b.maDatPhong}"
                                                data-maphong="${fn:escapeXml(b.maPhong)}"
                                                data-makhach="${fn:escapeXml(b.tenKhach)}"
                                                data-trangthai="${fn:escapeXml(b.trangThai)}">

                                                <td><c:out value="${b.maDatPhong}"/></td>
                                                <td><c:out value="${b.maPhong}"/></td>
                                                <td><c:out value="${b.tenKhach}"/></td>
                                                <td><c:out value="${fn:substring(b.ngayDat, 0, 16)}"/></td>
                                                <td>
                                                    <div><c:out value="${fn:substring(b.ngayNhanDuKien, 0, 10)}"/></div>
                                                    <div class="text-muted small">
                                                        <c:out value="${fn:substring(b.ngayTraDuKien, 0, 10)}"/>
                                                    </div>
                                                </td>

                                                <!-- Trạng thái -->
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${b.trangThai == 'Chờ xác nhận'}">
                                                            <span class="badge bg-warning text-dark">${b.trangThai}</span>
                                                        </c:when>
                                                        <c:when test="${b.trangThai == 'Đã xác nhận'}">
                                                            <span class="badge bg-success">${b.trangThai}</span>
                                                        </c:when>
                                                        <c:when test="${b.trangThai == 'Đã hủy'}">
                                                            <span class="badge bg-danger">${b.trangThai}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">${b.trangThai}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>

                                                <!-- Hành động -->
                                                <td>
                                                    <div class="actions">
                                                        <form action="${pageContext.request.contextPath}/booking/bookings" method="post">
                                                            <input type="hidden" name="maDatPhong" value="${b.maDatPhong}"/>
                                                            <button class="btn btn-icon btn-edit"
                                                                    name="action" value="confirm"
                                                                    title="Xác nhận"
                                                                    ${b.trangThai != 'Chờ xác nhận' ? 'disabled' : ''}>
                                                                <i class="bi bi-check-lg"></i>
                                                            </button>
                                                        </form>
                                                        <form action="${pageContext.request.contextPath}/booking/bookings" method="post">
                                                            <input type="hidden" name="maDatPhong" value="${b.maDatPhong}"/>
                                                            <button class="btn btn-icon btn-delete"
                                                                    name="action" value="cancel"
                                                                    title="Hủy"
                                                                    ${b.trangThai == 'Đã hủy' ? 'disabled' : ''}>
                                                                <i class="bi bi-x-lg"></i>
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="text-center mt-4">
                                <a href="${pageContext.request.contextPath}/jsp/admin/dashboard.jsp" class="btn btn-secondary">
                                    ← Quay về trang chủ
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="../admin/layout/footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const input = document.getElementById('searchInput');
                const rows = document.querySelectorAll('tr.booking-row');
                const itemsCount = document.getElementById('itemsCountSmall');

                function applyFilter(q) {
                    const query = (q || '').trim().toLowerCase();
                    let visible = 0;
                    rows.forEach(r => {
                        const combined = (r.dataset.maphong + ' ' + r.dataset.makhach + ' ' + r.dataset.trangthai).toLowerCase();
                        if (!query || combined.includes(query)) {
                            r.style.display = '';
                            visible++;
                        } else {
                            r.style.display = 'none';
                        }
                    });
                    if (itemsCount)
                        itemsCount.textContent = visible;
                }

                input && input.addEventListener('input', e => applyFilter(e.target.value));
                applyFilter(input ? input.value : '');

                // Tự động đóng alert
                document.querySelectorAll('.alert-dismissible').forEach(a => {
                    setTimeout(() => bootstrap.Alert.getOrCreateInstance(a).close(), 4000);
                });
            });
        </script>
    </body>
</html>
