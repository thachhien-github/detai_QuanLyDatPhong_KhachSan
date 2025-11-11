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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>

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
            .pagination .page-item.active .page-link {
                z-index: 1;
            }
        </style>
    </head>

    <body>

        <!-- ======= Navbar ======= -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top px-4">
            <div class="container-fluid">
                <a class="navbar-brand fw-bold d-flex align-items-center" href="${pageContext.request.contextPath}/index.jsp">
                    <i class="bi bi-building me-2 text-warning"></i> HCMCT Hotel
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                    <ul class="navbar-nav align-items-center gap-3">
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/roomindex">Phòng</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#services">Dịch vụ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="contact.jsp">Liên hệ</a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-warning px-3 py-1 d-flex align-items-center">
                                <i class="bi bi-box-arrow-in-right me-2"></i> Đăng nhập
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container-fluid mt-5 pt-3">
            <div class="row">
                <div class="col-md-12 mt-3">

                    <h2 class="text-center text-dark">
                         Danh sách phòng
                    </h2>
                    <hr/>

                    <div class="container mt-3">

                        <!-- Toolbar -->
                        <div class="d-flex align-items-center justify-content-between mb-3 gap-2 flex-wrap">
                            <input type="text" id="searchInput" class="form-control w-auto" placeholder="Tìm kiếm phòng..." autocomplete="off"/>
                        </div>

                        <div class="mb-3 d-flex align-items-center gap-3">
                            <div>
                                <strong>Tổng số phòng:</strong> 
                                <span id="roomsCount"><c:out value="${fn:length(phong)}"/></span>
                            </div>
                        </div>

                        <!-- Card View -->
                        <div class="row" id="roomsContainer">
                            <c:forEach var="r" items="${phong}">
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
                                            <p class="mb-2">
                                                <strong>Trạng thái:</strong>
                                                <c:choose>
                                                    <c:when test="${r.trangThai eq 'Trống'}">
                                                        <span class="text-success">${r.trangThai}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-danger">${r.trangThai}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>

                                            <div class="mt-auto d-flex justify-content-between gap-2">
                                                <button type="button" class="btn btn-warning btn-sm flex-fill btn-edit-room">
                                                    <i class="bi bi-eye"></i> Chi tiết
                                                </button>
                                                <button class="btn btn-primary btn-sm flex-fill btn-book-room" type="button">
                                                    <i class="bi bi-cart-plus"></i> Đặt phòng
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Pagination -->
                        <nav aria-label="Rooms pagination">
                            <ul class="pagination justify-content-center" id="pagination"></ul>
                        </nav>

                    </div>
                </div>
            </div>
        </div>

        <!-- ======= Footer ======= -->
        <footer id="contact" class="text-center py-4 bg-dark text-light">
            <p class="mb-0">
                © 2025 HCMCT Hotel. All rights reserved. | Designed by <span class="text-warning">Team NHPK </span>
            </p>
        </footer>

        <!-- ======= Modals ======= -->

        <!-- Detail Modal -->
        <div class="modal fade" id="detailModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Chi tiết phòng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-5">
                                <img id="detail_image" src="" alt="Hình phòng" class="img-fluid rounded">
                            </div>
                            <div class="col-md-7">
                                <h4 id="detail_maPhong"></h4>
                                <p><strong>Loại phòng:</strong> <span id="detail_loaiPhong"></span></p>
                                <p><strong>Giá:</strong> <span id="detail_gia"></span></p>
                                <p><strong>Trạng thái:</strong> <span id="detail_trangThai"></span></p>
                                <hr>
                                <p id="detail_moTa"></p>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="detail_book_now" type="button" class="btn btn-primary">Đặt phòng này</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Booking Modal -->
        <div class="modal fade" id="modalBookRoom" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content shadow-lg border-0 rounded-3">
                    <form action="${pageContext.request.contextPath}/book-room" method="post">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title"><i class="bi bi-cart-plus"></i> Đặt phòng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <div class="modal-body">
                            <input type="hidden" name="maPhong" id="bookMaPhong" />
                            <div class="row g-2">
                                <div class="col-md-6 mb-2">
                                    <label class="form-label fw-semibold">Mã phòng</label>
                                    <input type="text" id="bookMaPhongDisplay" class="form-control" readonly />
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">Giá (đ/đêm)</label>
                                    <input type="text" id="bookDonGia" class="form-control" readonly />
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Tên khách hàng</label>
                                <input type="text" name="tenKhach" id="bookTenKhach" class="form-control" required />
                            </div>

                            <div class="row g-2">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">Số điện thoại</label>
                                    <input type="tel" name="sdt" id="bookSDT" class="form-control" required />
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">Email</label>
                                    <input type="email" name="email" id="bookEmail" class="form-control" />
                                </div>
                            </div>

                            <div class="row g-2">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">Ngày nhận phòng</label>
                                    <input type="date" name="ngayNhanDuKien" id="bookNgayNhan" class="form-control" required />
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">Ngày trả dự kiến</label>
                                    <input type="date" name="ngayTraDuKien" id="bookNgayTra" class="form-control" required />
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-semibold">Ghi chú</label>
                                <textarea name="ghiChu" id="bookGhiChu" class="form-control" rows="2"></textarea>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-circle"></i> Xác nhận đặt
                            </button>
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
                const perPage = 4;
                let currentPage = 1;
                let filteredCards = [];

                // No results placeholder
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

                    allCards.forEach(c => c.classList.add('room-card-hide'));

                    if (filteredCards.length === 0)
                        noResultsEl.style.display = 'block';
                    else {
                        noResultsEl.style.display = 'none';
                        const start = (currentPage - 1) * perPage;
                        const end = start + perPage;
                        filteredCards.slice(start, end).forEach(c => c.classList.remove('room-card-hide'));
                    }
                    updatePagination(totalPages, currentPage);
                }

                function updatePagination(totalPages, activePage) {
                    const ul = document.getElementById('pagination');
                    ul.innerHTML = '';

                    function makeLi(label, page, disabled, active) {
                        const li = document.createElement('li');
                        li.className = 'page-item' + (disabled ? ' disabled' : '') + (active ? ' active' : '');
                        const btn = document.createElement('button');
                        btn.className = 'page-link';
                        btn.type = 'button';
                        btn.textContent = label;
                        if (!disabled)
                            btn.addEventListener('click', () => renderPage(page));
                        li.appendChild(btn);
                        return li;
                    }

                    ul.appendChild(makeLi('‹', activePage - 1, activePage === 1, false));

                    const maxVisible = 8;
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

                    for (let p = start; p <= end; p++)
                        ul.appendChild(makeLi(p, p, false, p === activePage));

                    if (end < totalPages) {
                        if (end < totalPages - 1) {
                            const li = document.createElement('li');
                            li.className = 'page-item disabled';
                            li.innerHTML = '<span class="page-link">…</span>';
                            ul.appendChild(li);
                        }
                        ul.appendChild(makeLi(totalPages, totalPages, false, activePage === totalPages));
                    }

                    ul.appendChild(makeLi('›', activePage + 1, activePage === totalPages, false));
                }

                function normalizeForSearch(s) {
                    return (s || '').normalize ? s.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase().trim() : '';
                }

                function applyFilter(q) {
                    const queryNorm = normalizeForSearch(q);
                    const cards = Array.from(container.querySelectorAll('.room-card'));
                    filteredCards = cards.filter(card => {
                        const combined = [card.dataset.ma, card.dataset.ten, card.dataset.maloai, card.dataset.trangthai, card.dataset.mota].join(' ');
                        if (!queryNorm)
                            return true;
                        return normalizeForSearch(combined).includes(queryNorm);
                    });
                    updateRoomsCount();
                    renderPage(1);
                }

                input.addEventListener('input', e => {
                    setTimeout(() => applyFilter(e.target.value), 150);
                });

                filteredCards = Array.from(container.querySelectorAll('.room-card'));
                updateRoomsCount();
                renderPage(1);

                container.addEventListener('click', e => {
                    const editBtn = e.target.closest('.btn-edit-room');
                    const bookBtn = e.target.closest('.btn-book-room');

                    if (editBtn) {
                        const card = editBtn.closest('.room-card');
                        const ma = card.dataset.ma || '';
                        const ten = card.dataset.ten || '';
                        const gia = card.dataset.dongia || '';
                        const trangthai = card.dataset.trangthai || '';
                        const mota = card.dataset.mota || '';
                        const hinh = card.dataset.hinh || '';

                        document.getElementById('detail_maPhong').textContent = ma;
                        document.getElementById('detail_loaiPhong').textContent = ten;
                        document.getElementById('detail_gia').textContent = gia ? Number(gia).toLocaleString('vi-VN') + ' đ/đêm' : '';
                        document.getElementById('detail_trangThai').textContent = trangthai;
                        document.getElementById('detail_moTa').textContent = mota;
                        document.getElementById('detail_image').src = hinh ? '${pageContext.request.contextPath}/uploads/' + hinh : '${pageContext.request.contextPath}/img/default-room.jpg';

                        new bootstrap.Modal(document.getElementById('detailModal')).show();
                    }

                    if (bookBtn) {
                        const card = bookBtn.closest('.room-card');
                        if (card.dataset.trangthai !== 'Trống') {
                            alert('Phòng ' + card.dataset.ma + ' đang: ' + card.dataset.trangthai);
                            return;
                        }
                        document.getElementById('bookMaPhong').value = card.dataset.ma;
                        document.getElementById('bookMaPhongDisplay').value = card.dataset.ma;
                        document.getElementById('bookDonGia').value = card.dataset.dongia ? Number(card.dataset.dongia).toLocaleString('vi-VN') + ' đ/đêm' : '';
                        new bootstrap.Modal(document.getElementById('modalBookRoom')).show();
                    }
                });

                document.getElementById('detail_book_now')?.addEventListener('click', () => {
                    const ma = document.getElementById('detail_maPhong').textContent || '';
                    const gia = document.getElementById('detail_gia').textContent || '';
                    document.getElementById('bookMaPhong').value = ma;
                    document.getElementById('bookMaPhongDisplay').value = ma;
                    document.getElementById('bookDonGia').value = gia;

                    const modal = bootstrap.Modal.getInstance(document.getElementById('detailModal'));
                    if (modal)
                        modal.hide();
                    new bootstrap.Modal(document.getElementById('modalBookRoom')).show();
                });

            });
        </script>

    </body>
</html>
