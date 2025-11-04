<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.LuuTru" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8"/>
        <title>Quản lý Lưu Trú - HCMCT Hotel</title>
        <jsp:include page="../admin/layout/header.jsp" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/roomtype-list.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-dashboard.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css"/>
    </head>
    <body>
        <jsp:include page="../admin/layout/nav.jsp" />

        <div class="container-fluid mt-3">
            <div class="row">
                <div class="col-md-2 p-0">
                    <jsp:include page="../admin/layout/sidebar.jsp" />
                </div>

                <div class="col-md-10">
                    <h2 class="text-dark mb-3">
                        <i class="bi bi-person-badge me-2 text-warning"></i> Quản lý Lưu Trú
                    </h2>
                    <hr/>

                    <div class="card-surface p-3">
                        <!-- Toolbar -->
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="d-flex align-items-center gap-2">
                                <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#modalCheckIn">
                                    <i class="bi bi-plus-lg me-1"></i> Check-in
                                </button>
                                <div class="ms-2 text-muted small">
                                    Tổng: <strong id="itemsCountSmall">${empty luutruList ? 0 : fn:length(luutruList)}</strong>
                                </div>
                            </div>
                            <form id="searchForm" class="d-flex" method="get" action="${pageContext.request.contextPath}/luutru">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-search"></i></span>
                                    <input type="text" id="searchInput" name="q" class="form-control"
                                           placeholder="Tìm theo phòng, khách, CCCD..." value="${fn:escapeXml(param.q)}"/>
                                </div>
                            </form>
                        </div>

                        <!-- Alert success/error -->
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

                        <!-- Table Lưu Trú -->
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>#</th>
                                        <th>Mã Lưu Trú</th>
                                        <th>Mã Đặt</th>
                                        <th>Khách</th>
                                        <th>CCCD</th>
                                        <th>Phòng</th>
                                        <th>Check-in</th>
                                        <th>Check-out</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody id="tbodyLuuTru">
                                    <c:forEach var="l" items="${luutruList}" varStatus="s">
                                        <tr class="l-row"
                                            data-search="${l.hoTen} ${l.cccd} ${l.maPhong} ${l.maDatPhong}"
                                            data-trangthai="${empty l.gioCheckOut ? 'Đang lưu trú' : 'Đã trả phòng'}">
                                            <td>${s.index + 1}</td>
                                            <td>${l.maLuuTru}</td>
                                            <td>${l.maDatPhong}</td>
                                            <td>${l.hoTen}</td>
                                            <td>${l.cccd}</td>
                                            <td>${l.maPhong}</td>
                                            <td>${l.gioCheckIn}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty l.gioCheckOut}">
                                                        ${l.gioCheckOut}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-warning">Đang lưu trú</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${empty l.gioCheckOut}">
                                                        <span class="badge bg-success">Đang lưu trú</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Đã trả phòng</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:if test="${empty l.gioCheckOut}">
                                                    <button class="btn btn-sm btn-danger btn-checkout"
                                                            data-maluutru="${l.maLuuTru}"
                                                            data-map="${l.maPhong}"
                                                            data-madat="${l.maDatPhong}">
                                                        Check-out
                                                    </button>
                                                </c:if>
                                                <c:if test="${not empty l.gioCheckOut}">
                                                    <span class="text-muted">—</span>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="../admin/layout/footer.jsp" />

        <!-- Modal CHECK-IN -->
        <div class="modal fade" id="modalCheckIn" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/luutru" method="post">
                        <div class="modal-header bg-success text-white">
                            <h5 class="modal-title">Check-in khách</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="action" value="checkin"/>
                            <div class="mb-3">
                                <label class="form-label">Chọn Đặt phòng (đã xác nhận)</label>
                                <select name="maDatPhong" id="selDatPhong" class="form-select" required>
                                    <option value="">-- Chọn Đặt phòng --</option>
                                    <c:forEach var="dp" items="${confirmedBookings}">
                                        <option value="${dp.maDatPhong}" data-map="${dp.maPhong}" data-hoten="${dp.tenKhach}">
                                            ${dp.maDatPhong} — ${dp.maPhong} — ${dp.tenKhach} — ${dp.ngayNhanDuKien} → ${dp.ngayTraDuKien}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-2">
                                <label class="form-label">Mã phòng</label>
                                <input id="ciMaPhong" class="form-control" readonly/>
                            </div>
                            <div class="mb-2">
                                <label class="form-label">Tên khách</label>
                                <input id="ciHoTen" name="hoTen" class="form-control" readonly/>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">CCCD</label>
                                <input id="ciCCCD" name="cccd" class="form-control"/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-success">Xác nhận Check-in</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal CHECK-OUT confirm -->
        <div class="modal fade" id="modalCheckoutConfirm" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/luutru" method="post" id="formCheckout">
                        <div class="modal-header bg-danger text-white">
                            <h5 class="modal-title">Xác nhận Check-out</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="action" value="checkout"/>
                            <input type="hidden" name="maLuuTru" id="coMaLuuTru"/>
                            <input type="hidden" name="maDatPhong" id="coMaDatPhong"/>
                            <input type="hidden" name="maPhong" id="coMaPhong"/>
                            <p>Bạn có chắc muốn check-out cho <strong id="coInfo"></strong> ?</p>
                            <p class="text-muted">Hệ thống sẽ cập nhật giờ check-out hiện tại và trả phòng.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-danger">Xác nhận Check-out</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const sel = document.getElementById('selDatPhong');
                const ciMaPhong = document.getElementById('ciMaPhong');
                const ciHoTen = document.getElementById('ciHoTen');
                if (sel) {
                    sel.addEventListener('change', function () {
                        const opt = this.options[this.selectedIndex];
                        ciMaPhong.value = opt.dataset.map || '';
                        ciHoTen.value = opt.dataset.hoten || '';
                    });
                }

                const input = document.getElementById('searchInput');
                const rows = document.querySelectorAll('#tbodyLuuTru .l-row');
                const itemsCount = document.getElementById('itemsCountSmall');
                function applyFiler(q) {
                    const query = (q || '').trim().toLowerCase();
                    let visible = 0;
                    rows.forEach(r => {
                        const txt = r.dataset.search.toLowerCase();
                        if (!query || txt.includes(query)) {
                            r.style.display = '';
                            visible++;
                        } else {
                            r.style.display = 'none';
                        }
                    });
                    if (itemsCount)
                        itemsCount.textContent = visible;
                }
                input && input.addEventListener('input', e => applyFiler(e.target.value));
                applyFiler(input ? input.value : '');

                document.querySelectorAll('.btn-checkout').forEach(btn => {
                    btn.addEventListener('click', function () {
                        const maLuuTru = this.dataset.maluutru;
                        const maPhong = this.dataset.map;
                        const maDat = this.dataset.madat;
                        document.getElementById('coMaLuuTru').value = maLuuTru;
                        document.getElementById('coMaPhong').value = maPhong;
                        document.getElementById('coMaDatPhong').value = maDat;
                        document.getElementById('coInfo').textContent = 'Mã Lưu Trú: ' + maLuuTru + ' — Phòng: ' + maPhong;
                        new bootstrap.Modal(document.getElementById('modalCheckoutConfirm')).show();
                    });
                });

                document.querySelectorAll('.alert-dismissible').forEach(a => {
                    setTimeout(() => bootstrap.Alert.getOrCreateInstance(a).close(), 4000);
                });
            });
        </script>
    </body>
</html>
