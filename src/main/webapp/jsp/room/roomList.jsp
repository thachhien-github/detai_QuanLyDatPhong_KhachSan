<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Room" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8"/>
        <title>Quản lý Phòng - HCMCT Hotel</title>
        <%@ include file="../admin/layout/header.jsp" %>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-dashboard.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/room-list.css"/>

        <style>
            .room-card-hide {
                display: none !important;
            }
        </style>
    </head>

    <body>
        <%@ include file="../admin/layout/nav.jsp" %>

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2 p-0">
                    <%@ include file="../admin/layout/sidebar.jsp" %>
                </div>

                <div class="col-md-10 mt-3">
                    <h2 class="text-dark">
                        <i class="bi bi-building-check me-2 text-warning"></i> Danh sách phòng
                    </h2>
                    <hr/>

                    <div class="container mt-3">

                        <!-- Toolbar -->
                        <div class="d-flex align-items-center justify-content-between mb-3 gap-2 flex-wrap">
                            <div class="d-flex gap-2">
                                <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#modalAddRoom">
                                    <i class="bi bi-plus-circle"></i> Thêm phòng
                                </button>
                            </div>

                            <form id="searchForm" class="d-flex ms-auto" method="get" action="rooms">
                                <input type="hidden" name="action" value="list"/>
                                <input type="text" name="q" id="searchInput" class="form-control me-2"
                                       placeholder="Tìm theo mã phòng, mô tả, trạng thái..."
                                       value="${fn:escapeXml(param.q)}" autocomplete="off"/>
                            </form>
                        </div>

                        <!-- Messages -->
                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                ${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <!-- Summary -->
                        <div class="mb-3">
                            <strong>Tổng số phòng: </strong>
                            <span id="roomsCount"><c:out value="${fn:length(rooms)}"/></span>
                        </div>

                        <!-- Cards -->
                        <div class="row" id="roomsContainer">
                            <c:choose>
                                <c:when test="${not empty rooms}">
                                    <c:forEach var="r" items="${rooms}">
                                        <div class="col-md-3 mb-4 room-card"
                                             data-ma="${r.maPhong}"
                                             data-maloai="${r.maLoaiPhong}"
                                             data-ten="${r.tenLoaiPhong}"
                                             data-trangthai="${r.trangThai}"
                                             data-mota="${r.moTa}"
                                             data-hinh="${r.hinhAnh}">
                                            <div class="card shadow-sm h-100">
                                                <img src="${pageContext.request.contextPath}/uploads/${r.hinhAnh}"
                                                     class="card-img-top room-img"
                                                     alt="Room ${r.maPhong}"
                                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/default-room.jpg';"/>

                                                <div class="card-body d-flex flex-column">
                                                    <h5 class="card-title mb-2 text-primary">
                                                        <c:out value="${r.maPhong}"/>
                                                    </h5>
                                                    <p class="card-text mb-1">
                                                        <strong>Loại phòng:</strong>
                                                        <c:out value="${r.tenLoaiPhong}"/>
                                                    </p>
                                                    <p class="card-text mb-1">
                                                        <strong>Trạng thái:</strong>
                                                        <c:choose>
                                                            <c:when test="${r.trangThai == 'Trống' || r.trangThai == 'Available'}">
                                                                <span class="text-success"><c:out value="${r.trangThai}"/></span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-danger"><c:out value="${r.trangThai}"/></span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <c:if test="${not empty r.moTa}">
                                                        <p class="card-text small text-muted">
                                                            <c:out value="${r.moTa}"/>
                                                        </p>
                                                    </c:if>

                                                    <div class="mt-auto d-flex justify-content-between align-items-center gap-2">
                                                        <button type="button" class="btn btn-warning btn-sm flex-fill btn-edit-room">
                                                            <i class="bi bi-pencil"></i> Sửa
                                                        </button>

                                                        <button type="button" class="btn btn-danger btn-sm flex-fill btn-del-room">
                                                            <i class="bi bi-trash"></i> Xóa
                                                        </button>

                                                        <form action="${pageContext.request.contextPath}/jsp/booking/bookingForm.jsp" method="get" class="flex-fill m-0">
                                                            <input type="hidden" name="maPhong" value="${r.maPhong}"/>
                                                            <button class="btn btn-primary btn-sm w-100">
                                                                <i class="bi bi-calendar-check"></i> Đặt phòng
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <div class="col-12 text-center">
                                        <div class="alert alert-warning">
                                            Hiện chưa có phòng nào trong hệ thống.
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
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

        <!-- Include các modal (Thêm, Sửa, Xóa) -->
        <%@ include file="../admin/room-modals.jsp" %>

        <%@ include file="../admin/layout/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const input = document.getElementById('searchInput');
                const container = document.getElementById('roomsContainer');
                const roomsCount = document.getElementById('roomsCount');
                const baseUploads = '${pageContext.request.contextPath}/uploads/';

                function applyFilter(q) {
                    const query = (q || '').trim().toLowerCase();
                    const cards = container.querySelectorAll('.room-card');
                    let visible = 0;
                    cards.forEach(card => {
                        const text = (card.dataset.ma + ' ' + card.dataset.ten + ' ' + (card.dataset.mota || '') + ' ' + (card.dataset.trangthai || '')).toLowerCase();
                        if (query === '' || text.includes(query)) {
                            card.classList.remove('room-card-hide');
                            visible++;
                        } else {
                            card.classList.add('room-card-hide');
                        }
                    });
                    roomsCount.textContent = visible;
                }

                input.addEventListener('input', e => applyFilter(e.target.value));
                applyFilter(input.value);

                // Delegation: xử lý click sửa/xóa cho các card (dynamic-safe)
                container.addEventListener('click', function (e) {
                    const editBtn = e.target.closest('.btn-edit-room');
                    const delBtn = e.target.closest('.btn-del-room');

                    if (editBtn) {
                        const card = editBtn.closest('.room-card');
                        const modalEl = document.getElementById('modalEditRoom');
                        const modal = new bootstrap.Modal(modalEl);

                        // set fields (sử dụng data-maloai cho select)
                        document.getElementById('editMaPhong').value = card.dataset.ma;
                        document.getElementById('editMaPhong').readOnly = true; // khoá mã khi edit
                        const maLoaiSel = document.getElementById('editMaLoaiPhong');
                        if (maLoaiSel)
                            maLoaiSel.value = card.dataset.maloai || '';
                        document.getElementById('editTrangThai').value = card.dataset.trangthai || '';
                        document.getElementById('editMoTa').value = card.dataset.mota || '';

                        const preview = document.getElementById('editHinhAnhPreview');
                        preview.src = card.dataset.hinh ? (baseUploads + card.dataset.hinh) : ('${pageContext.request.contextPath}/img/default-room.jpg');
                        document.getElementById('currentHinhAnh').value = card.dataset.hinh || '';

                        modal.show();
                    }

                    if (delBtn) {
                        const card = delBtn.closest('.room-card');
                        const modalEl = document.getElementById('modalDelRoom');
                        const modal = new bootstrap.Modal(modalEl);
                        document.getElementById('delMaPhong').value = card.dataset.ma;
                        document.getElementById('delRoomName').textContent = card.dataset.ma;
                        modal.show();
                    }
                });
            });
        </script>

    </body>
</html>
