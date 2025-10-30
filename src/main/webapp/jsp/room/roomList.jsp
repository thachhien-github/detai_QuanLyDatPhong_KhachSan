<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Phong" %>
<%@ page import="model.LoaiPhong" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


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
        <style>
            .room-card-hide {
                display: none !important;
            }
            .room-img {
                height: 160px;
                object-fit: cover;
                border-radius: 8px;
            }
            .modal img.rounded {
                max-height: 220px;
                object-fit: cover;
            }
            /* active page */
            .pagination .page-item.active .page-link {
                z-index: 1;
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
                    <h2 class="text-dark"><i class="bi bi-door-open text-warning me-2"></i> Danh sách phòng</h2>
                    <hr/>

                    <div class="container mt-3">
                        <!-- Toolbar -->
                        <div class="d-flex align-items-center justify-content-between mb-3 gap-2 flex-wrap">
                            <div class="d-flex gap-2">
                                <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#modalAddRoom">
                                    <i class="bi bi-plus-circle"></i> Thêm phòng
                                </button>
                            </div>
                            <input type="text" id="searchInput" class="form-control w-auto" placeholder="Tìm kiếm phòng..." autocomplete="off"/>
                        </div>

                        <!-- Message -->
                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                ${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <div class="mb-3 d-flex align-items-center gap-3">
                            <div><strong>Tổng số phòng:</strong> <span id="roomsCount"><c:out value="${fn:length(rooms)}"/></span></div>
                        </div>

                        <!-- Card View -->
                        <div class="row" id="roomsContainer">
                            <c:forEach var="r" items="${rooms}">
                                <div class="col-md-3 mb-4 room-card"
                                     data-ma="${r.maPhong}"
                                     data-maloai="${r.maLoaiPhong}"
                                     data-ten="${r.tenLoaiPhong}"
                                     data-trangthai="${r.trangThai}"
                                     data-mota="${r.moTa}"
                                     data-hinh="${r.hinhAnh}"
                                     data-dongia="${r.donGia}">
                                    <div class="card shadow-sm h-100">
                                        <img src="${pageContext.request.contextPath}/uploads/${r.hinhAnh}"
                                             class="card-img-top room-img"
                                             alt="Room ${r.maPhong}"
                                             onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/img/default-room.jpg';"/>
                                        <div class="card-body d-flex flex-column">
                                            <h5 class="card-title text-primary mb-1"><c:out value="${r.maPhong}"/></h5>
                                            <p class="mb-1"><strong>Loại:</strong> ${r.tenLoaiPhong}</p>
                                            <p class="mb-1">
                                                <strong>Giá:</strong>
                                                <span class="text-danger fw-bold">
                                                    <fmt:formatNumber value="${r.donGia}" type="number" maxFractionDigits="0" /> đ/đêm
                                                </span>
                                            </p>

                                            <p class="mb-2"><strong>Trạng thái:</strong>
                                                <c:choose>
                                                    <c:when test="${r.trangThai eq 'Trống'}"><span class="text-success">${r.trangThai}</span></c:when>
                                                    <c:otherwise><span class="text-danger">${r.trangThai}</span></c:otherwise>
                                                </c:choose>
                                            </p>

                                            <div class="mt-auto d-flex justify-content-between gap-2">
                                                <button class="btn btn-warning btn-sm flex-fill btn-edit-room">
                                                    <i class="bi bi-pencil"></i> Sửa
                                                </button>
                                                <button class="btn btn-danger btn-sm flex-fill btn-del-room">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </button>
                                                <!-- Đặt phòng button -->
                                                <button class="btn btn-primary btn-sm flex-fill btn-book-room" type="button">
                                                    <i class="bi bi-cart-plus"></i> Đặt phòng
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Pagination controls -->
                        <nav aria-label="Rooms pagination">
                            <ul class="pagination justify-content-center" id="pagination"></ul>
                        </nav>

                    </div>
                </div>
            </div>
        </div>

        <!-- BOOKING MODAL -->
        <div class="modal fade" id="modalBookRoom" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/book-room" method="post">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title"><i class="bi bi-cart-plus"></i> Đặt phòng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="maPhong" id="bookMaPhong"/>
                            <div class="mb-2">
                                <label class="form-label">Mã phòng</label>
                                <input type="text" id="bookMaPhongDisplay" class="form-control" readonly/>
                            </div>
                            <div class="mb-2">
                                <label class="form-label">Giá (đ/đêm)</label>
                                <input type="text" id="bookDonGia" class="form-control" readonly/>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Tên khách</label>
                                <input type="text" name="tenKhach" class="form-control" required/>
                            </div>
                            <div class="row g-2">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">SĐT</label>
                                    <input type="tel" name="sdt" class="form-control" required/>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" name="email" class="form-control" />
                                </div>
                            </div>

                            <div class="row g-2">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Ngày đến</label>
                                    <input type="date" name="ngayDen" class="form-control" required/>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Ngày đi</label>
                                    <input type="date" name="ngayDi" class="form-control" required/>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Số người</label>
                                <input type="number" name="soNguoi" class="form-control" min="1" value="1" required/>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Ghi chú</label>
                                <textarea name="ghiChu" class="form-control" rows="2"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">Xác nhận đặt</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- existing modals: Add/Edit/Delete (kept unchanged) -->
        <!-- MODAL: Thêm phòng -->
        <div class="modal fade" id="modalAddRoom" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/rooms-list" method="post" enctype="multipart/form-data">
                        <div class="modal-header bg-success text-white">
                            <h5 class="modal-title"><i class="bi bi-plus-circle"></i> Thêm phòng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="action" value="add"/>
                            <div class="mb-3">
                                <label class="form-label">Mã phòng</label>
                                <input type="text" name="maPhong" class="form-control" required/>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Loại phòng</label>
                                <select id="addMaLoaiPhong" name="maLoaiPhong" class="form-select" required>
                                    <option value="">-- Chọn loại phòng --</option>
                                    <c:forEach var="lp" items="${roomTypes}">
                                        <option value="${lp.maLoaiPhong}" data-dongia="${lp.donGia}">${lp.tenLoaiPhong}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Giá (đ/đêm)</label>
                                <input type="number" id="addDonGia" class="form-control" readonly/>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Trạng thái</label>
                                <select name="trangThai" class="form-select">
                                    <option value="Trống">Trống</option>
                                    <option value="Đã đặt">Đã đặt</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mô tả</label>
                                <textarea name="moTa" class="form-control"></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Hình ảnh</label>
                                <input type="file" id="addHinhAnhInput" name="hinhAnh" class="form-control" accept="image/*"/>
                                <img id="addHinhAnhPreview" src="${pageContext.request.contextPath}/img/default-room.jpg" alt="Preview" class="mt-2 rounded" width="100%"/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button class="btn btn-success" type="submit">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- MODAL: Sửa phòng -->
        <div class="modal fade" id="modalEditRoom" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/rooms-list" method="post" enctype="multipart/form-data">
                        <div class="modal-header bg-warning">
                            <h5 class="modal-title"><i class="bi bi-pencil"></i> Cập nhật phòng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="action" value="update"/>
                            <div class="mb-3">
                                <label class="form-label">Mã phòng</label>
                                <input type="text" id="editMaPhong" name="maPhong" class="form-control" readonly/>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Loại phòng</label>
                                <select id="editMaLoaiPhong" name="maLoaiPhong" class="form-select" required>
                                    <c:forEach var="lp" items="${roomTypes}">
                                        <option value="${lp.maLoaiPhong}" data-dongia="${lp.donGia}">${lp.tenLoaiPhong}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Trạng thái</label>
                                <select id="editTrangThai" name="trangThai" class="form-select">
                                    <option value="Trống">Trống</option>
                                    <option value="Đã đặt">Đã đặt</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mô tả</label>
                                <textarea id="editMoTa" name="moTa" class="form-control"></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Hình ảnh</label>
                                <input type="file" name="hinhAnh" class="form-control" accept="image/*"/>
                                <input type="hidden" id="currentHinhAnh" name="currentHinhAnh"/>
                                <img id="editHinhAnhPreview" src="${pageContext.request.contextPath}/img/default-room.jpg" alt="Preview" class="mt-2 rounded" width="100%"/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button class="btn btn-warning" type="submit">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- MODAL: Xóa phòng -->
        <div class="modal fade" id="modalDelRoom" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/rooms-list" method="post">
                        <div class="modal-header bg-danger text-white">
                            <h5 class="modal-title"><i class="bi bi-trash"></i> Xóa phòng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <p>Bạn có chắc muốn xóa phòng <strong id="delRoomName"></strong> không?</p>
                            <input type="hidden" id="delMaPhong" name="maPhong"/>
                            <input type="hidden" name="action" value="delete"/>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button class="btn btn-danger" type="submit">Xóa</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const container = document.getElementById('roomsContainer');
                const input = document.getElementById('searchInput');
                const roomsCount = document.getElementById('roomsCount');
                const perPage = 4; // hiển thị 4 card 1 trang
                let currentPage = 1;
                let filteredCards = []; // sẽ chứa DOM elements khớp filter

                // placeholder khi không có kết quả
                const noResultsEl = document.createElement('div');
                noResultsEl.className = 'text-center w-100 py-4';
                noResultsEl.id = 'noResults';
                noResultsEl.style.display = 'none';
                noResultsEl.innerHTML = '<p class="text-muted mb-0">Không tìm thấy phòng nào khớp.</p>';
                container.parentNode.insertBefore(noResultsEl, container.nextSibling);

                function updateRoomsCount() {
                    roomsCount.textContent = filteredCards.length;
                }

                function renderPage(page) {
                    const allCards = Array.from(container.querySelectorAll('.room-card'));
                    const totalPages = Math.max(1, Math.ceil(filteredCards.length / perPage));
                    if (page < 1)
                        page = 1;
                    if (page > totalPages)
                        page = totalPages;
                    currentPage = page;

                    // ẩn tất cả card trước
                    allCards.forEach(card => card.classList.add('room-card-hide'));

                    // nếu không có kết quả -> hiển thị noResults
                    if (filteredCards.length === 0) {
                        noResultsEl.style.display = 'block';
                    } else {
                        noResultsEl.style.display = 'none';
                        const start = (currentPage - 1) * perPage;
                        const end = start + perPage;
                        const pageSlice = filteredCards.slice(start, end);
                        pageSlice.forEach(card => card.classList.remove('room-card-hide'));
                    }

                    updatePagination(Math.max(1, Math.ceil(filteredCards.length / perPage)), currentPage);
                }

                function updatePagination(totalPages, activePage) {
                    const ul = document.getElementById('pagination');
                    ul.innerHTML = '';

                    function makeLi(label, page, disabled, active) {
                        const li = document.createElement('li');
                        li.className = 'page-item' + (disabled ? ' disabled' : '') + (active ? ' active' : '');
                        const a = document.createElement('button');
                        a.className = 'page-link';
                        a.type = 'button';
                        a.textContent = label;
                        if (!disabled) {
                            a.addEventListener('click', function () {
                                renderPage(page);
                            });
                        }
                        li.appendChild(a);
                        return li;
                    }

                    // prev
                    ul.appendChild(makeLi('‹', activePage - 1, activePage === 1, false));

                    // pages
                    const maxVisible = 7;
                    let start = Math.max(1, activePage - Math.floor(maxVisible / 2));
                    let end = Math.min(totalPages, start + maxVisible - 1);
                    if (end - start < maxVisible - 1)
                        start = Math.max(1, end - maxVisible + 1);

                    if (start > 1) {
                        ul.appendChild(makeLi('1', 1, false, activePage === 1));
                        if (start > 2) {
                            const li = document.createElement('li');
                            li.className = 'page-item disabled';
                            li.innerHTML = '<span class="page-link">…</span>';
                            ul.appendChild(li);
                        }
                    }

                    for (let p = start; p <= end; p++) {
                        ul.appendChild(makeLi(p, p, false, p === activePage));
                    }

                    if (end < totalPages) {
                        if (end < totalPages - 1) {
                            const li = document.createElement('li');
                            li.className = 'page-item disabled';
                            li.innerHTML = '<span class="page-link">…</span>';
                            ul.appendChild(li);
                        }
                        ul.appendChild(makeLi(totalPages, totalPages, false, activePage === totalPages));
                    }

                    // next
                    ul.appendChild(makeLi('›', activePage + 1, activePage === totalPages, false));
                }

                // ---------- Search helpers ----------
                function stripDiacritics(str) {
                    if (!str)
                        return '';
                    return str.normalize ? str.normalize('NFD').replace(/[\u0300-\u036f]/g, '') : str;
                }

                function normalizeForSearch(s) {
                    return stripDiacritics(String(s || '')).toLowerCase().replace(/\s+/g, ' ').trim();
                }

                function parseKNotation(q) {
                    const m = String(q || '').trim().match(/^(\d+(?:[.,]\d+)?)[\s]*k$/i);
                    if (m) {
                        const num = parseFloat(m[1].replace(',', '.'));
                        if (!isNaN(num))
                            return String(Math.round(num * 1000));
                    }
                    return null;
                }

                function applyFilter(q) {
                    const rawQuery = String(q || '');
                    const queryNorm = normalizeForSearch(rawQuery);

                    // numeric query extraction (for matching donGia)
                    const numericFromQuery = rawQuery.replace(/[^\d]/g, ''); // only digits
                    const kConverted = parseKNotation(rawQuery); // e.g. 500k -> 500000

                    const cards = Array.from(container.querySelectorAll('.room-card'));
                    filteredCards = cards.filter(card => {
                        // collect searchable fields
                        const ma = card.dataset.ma || '';
                        const ten = card.dataset.ten || '';            // tên loại phòng
                        const maloai = card.dataset.maloai || '';
                        const trangthai = card.dataset.trangthai || '';
                        const mota = card.dataset.mota || '';
                        const dongia = card.dataset.dongia || '';      // raw number string

                        // combined normalized text
                        const combined = [ma, ten, maloai, trangthai, mota].join(' ');
                        const norm = normalizeForSearch(combined);

                        // if user didn't type anything -> keep all
                        if (!queryNorm)
                            return true;

                        // 1) text match (unicode-insensitive)
                        if (norm.includes(queryNorm))
                            return true;

                        // 2) match when user types room id with non-letter chars (eg "P01" or "p01")
                        if (normalizeForSearch(ma).includes(queryNorm))
                            return true;

                        // 3) numeric matching against dongia (ignore formatting)
                        const dongiaDigits = String(dongia || '').replace(/[^\d]/g, '');
                        if (numericFromQuery && dongiaDigits && dongiaDigits.includes(numericFromQuery))
                            return true;

                        // 4) k-notation match (e.g., "500k")
                        if (kConverted && dongiaDigits && dongiaDigits.includes(kConverted))
                            return true;

                        // 5) allow matching when user types a number spelled with separators (e.g., "500.000" or "500,000")
                        const qDigits = rawQuery.replace(/[^\d]/g, '');
                        if (qDigits && dongiaDigits && dongiaDigits.includes(qDigits))
                            return true;

                        return false;
                    });

                    updateRoomsCount();
                    renderPage(1);
                }

                // attach input listener (debounce for smoother typing)
                let debounceTimer = null;
                input.addEventListener('input', e => {
                    if (debounceTimer)
                        clearTimeout(debounceTimer);
                    debounceTimer = setTimeout(() => applyFilter(e.target.value), 150);
                });

                // initial render
                // set filteredCards to all initially
                filteredCards = Array.from(container.querySelectorAll('.room-card'));
                updateRoomsCount();
                renderPage(1);

                // ---------- existing container click handlers (edit/del/book) ----------
                container.addEventListener('click', function (e) {
                    const editBtn = e.target.closest('.btn-edit-room');
                    const delBtn = e.target.closest('.btn-del-room');
                    const bookBtn = e.target.closest('.btn-book-room');

                    if (editBtn) {
                        const card = editBtn.closest('.room-card');
                        document.getElementById('editMaPhong').value = card.dataset.ma;
                        document.getElementById('editMaLoaiPhong').value = card.dataset.maloai;
                        document.getElementById('editTrangThai').value = card.dataset.trangthai;
                        document.getElementById('editMoTa').value = card.dataset.mota;
                        document.getElementById('currentHinhAnh').value = card.dataset.hinh || '';
                        document.getElementById('editHinhAnhPreview').src = '${pageContext.request.contextPath}/uploads/' + (card.dataset.hinh || 'default-room.jpg');
                        new bootstrap.Modal(document.getElementById('modalEditRoom')).show();
                    }

                    if (delBtn) {
                        const card = delBtn.closest('.room-card');
                        document.getElementById('delMaPhong').value = card.dataset.ma;
                        document.getElementById('delRoomName').textContent = card.dataset.ma;
                        new bootstrap.Modal(document.getElementById('modalDelRoom')).show();
                    }

                    if (bookBtn) {
                        const card = bookBtn.closest('.room-card');
                        const status = card.dataset.trangthai;
                        if (status && status !== 'Trống') {
                            alert('Phòng ' + card.dataset.ma + ' hiện đang: ' + status + '\nVui lòng chọn phòng khác.');
                            return;
                        }
                        document.getElementById('bookMaPhong').value = card.dataset.ma;
                        document.getElementById('bookMaPhongDisplay').value = card.dataset.ma;
                        const dg = card.dataset.dongia || '';
                        if (dg !== '') {
                            const n = Number(dg);
                            document.getElementById('bookDonGia').value = n.toLocaleString('vi-VN', {maximumFractionDigits: 0}) + ' đ/đêm';
                        } else {
                            document.getElementById('bookDonGia').value = '';
                        }
                        new bootstrap.Modal(document.getElementById('modalBookRoom')).show();
                    }
                });

                // ========== ADD modal: cập nhật donGia khi chọn loại và preview ảnh ==========
                const addSelect = document.getElementById('addMaLoaiPhong');
                const addDonGia = document.getElementById('addDonGia');
                const addFileInput = document.getElementById('addHinhAnhInput');
                const addPreview = document.getElementById('addHinhAnhPreview');

                if (addSelect) {
                    addSelect.addEventListener('change', function () {
                        const sel = this.options[this.selectedIndex];
                        const dg = sel ? sel.dataset.dongia : '';
                        if (dg !== undefined)
                            addDonGia.value = dg || '';
                    });

                    const modalAddEl = document.getElementById('modalAddRoom');
                    modalAddEl.addEventListener('show.bs.modal', function () {
                        const sel = addSelect.options[addSelect.selectedIndex];
                        addDonGia.value = sel && sel.dataset.dongia ? sel.dataset.dongia : '';
                        addPreview.src = '${pageContext.request.contextPath}/img/default-room.jpg';
                        if (addFileInput)
                            addFileInput.value = '';
                    });
                }

                if (addFileInput && addPreview) {
                    addFileInput.addEventListener('change', function (e) {
                        const file = e.target.files && e.target.files[0];
                        if (!file) {
                            addPreview.src = '${pageContext.request.contextPath}/img/default-room.jpg';
                            return;
                        }
                        const reader = new FileReader();
                        reader.onload = function (ev) {
                            addPreview.src = ev.target.result;
                        };
                        reader.readAsDataURL(file);
                    });
                }

                // ========== EDIT modal preview ==========
                const editFileInput = document.querySelector('#modalEditRoom input[name="hinhAnh"]');
                const editPreview = document.getElementById('editHinhAnhPreview');
                if (editFileInput && editPreview) {
                    editFileInput.addEventListener('change', function (e) {
                        const file = e.target.files && e.target.files[0];
                        if (!file)
                            return;
                        const reader = new FileReader();
                        reader.onload = function (ev) {
                            editPreview.src = ev.target.result;
                        };
                        reader.readAsDataURL(file);
                    });
                }

                document.querySelectorAll('.alert-dismissible').forEach(a => {
                    setTimeout(() => bootstrap.Alert.getOrCreateInstance(a).close(), 4500);
                });
            });
        </script>


    </body>
</html>
