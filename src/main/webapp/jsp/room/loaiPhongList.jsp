<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.LoaiPhong" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8"/>
        <title>Quản lý Loại Phòng - HCMCT Hotel</title>
        <%@ include file="../admin/layout/header.jsp" %>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/roomtype-list.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-dashboard.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css"/>
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
                        <i class="bi bi-tags me-2 text-warning"></i> Quản lý Loại phòng
                    </h2>
                    <hr/>

                    <div class="container mt-3 inner-container">
                        <div class="card-surface">
                            <div class="toolbar">
                                <div class="toolbar-left">
                                    <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#modalAddLoaiPhong">
                                        <i class="bi bi-plus-lg me-1"></i> Thêm loại phòng
                                    </button>
                                    <div class="ms-2 text-muted small">
                                        Tổng: <strong id="itemsCountSmall">${fn:length(loaiPhongs)}</strong>
                                    </div>
                                </div>

                                <div class="toolbar-right">
                                    <form id="searchForm" class="d-flex" method="get" action="loai-phong">
                                        <div class="toolbar search">
                                            <i class="bi bi-search"></i>
                                            <input type="text" id="searchInput" name="q" placeholder="Tìm theo mã hoặc tên..." value="${fn:escapeXml(param.q)}" />
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Messages -->
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

                            <div class="table-wrap">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th style="width:110px">Mã</th>
                                            <th>Tên loại</th>
                                            <th style="width:160px">Đơn giá (VNĐ)</th>
                                            <th>Mô tả</th>
                                            <th style="width:160px">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tblBody">
                                        <c:forEach var="lp" items="${loaiPhongs}">
                                            <tr class="lp-row" 
                                                data-ma="${lp.maLoaiPhong}" 
                                                data-ten="${lp.tenLoaiPhong}" 
                                                data-dongia="${lp.donGia}" 
                                                data-mota="${lp.moTa}">
                                                <td><c:out value="${lp.maLoaiPhong}"/></td>
                                                <td><c:out value="${lp.tenLoaiPhong}"/></td>
                                                <td>
                                                    <fmt:formatNumber value="${lp.donGia}" type="number" groupingUsed="true" />
                                                </td>
                                                <td>
                                                    <span class="desc-cell">
                                                        <c:out value="${fn:length(lp.moTa) > 80 ? fn:substring(lp.moTa,0,77) + '...' : lp.moTa}"/>
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="actions">
                                                        <button type="button" class="btn btn-icon btn-edit" title="Sửa" data-bs-toggle="tooltip">
                                                            <i class="bi bi-pencil"></i>
                                                        </button>
                                                        <button type="button" class="btn btn-icon btn-delete" title="Xóa" data-bs-toggle="tooltip">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </div>
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
        </div>

        <!-- ========== MODALS ========== -->
        <!-- Modal Add -->
        <div class="modal fade" id="modalAddLoaiPhong" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/loai-phong" method="post">
                        <input type="hidden" name="action" value="insert">
                        <div class="modal-header bg-success text-white">
                            <h5 class="modal-title">Thêm loại phòng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Mã loại phòng</label>
                                <input type="text" name="maLoaiPhong" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Tên loại phòng</label>
                                <input type="text" name="tenLoaiPhong" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Đơn giá (VNĐ)</label>
                                <input type="number" name="donGia" step="1000" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mô tả</label>
                                <textarea name="moTa" class="form-control"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-success">Thêm mới</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal Edit -->
        <div class="modal fade" id="modalEditLoaiPhong" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/loai-phong" method="post">
                        <input type="hidden" name="action" value="update">
                        <div class="modal-header bg-warning">
                            <h5 class="modal-title">Cập nhật loại phòng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Mã loại phòng</label>
                                <input type="text" id="editMaLoaiPhong" name="maLoaiPhong" class="form-control" readonly>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Tên loại phòng</label>
                                <input type="text" id="editTenLoaiPhong" name="tenLoaiPhong" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Đơn giá (VNĐ)</label>
                                <input type="number" id="editDonGia" name="donGia" step="1000" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mô tả</label>
                                <textarea id="editMoTa" name="moTa" class="form-control"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal Delete -->
        <div class="modal fade" id="modalDelLoaiPhong" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/loai-phong" method="post">
                        <input type="hidden" name="action" value="delete">
                        <div class="modal-header bg-danger text-white">
                            <h5 class="modal-title">Xóa loại phòng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <p>Bạn có chắc muốn xóa loại phòng:</p>
                            <p class="fw-bold text-danger" id="delLoaiPhongName"></p>
                            <input type="hidden" name="maLoaiPhong" id="delMaLoaiPhong">
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-danger">Xóa</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%@ include file="../admin/layout/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const input = document.getElementById('searchInput');
                const rows = document.querySelectorAll('tr.lp-row');
                const itemsCount = document.getElementById('itemsCountSmall');

                function applyFilter(q) {
                    const query = (q || '').trim().toLowerCase();
                    let visible = 0;
                    rows.forEach(r => {
                        const text = ((r.dataset.ma || '') + ' ' + (r.dataset.ten || '')).toLowerCase();
                        if (!query || text.includes(query)) {
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

                document.getElementById('tblBody').addEventListener('click', function (e) {
                    const edit = e.target.closest('.btn-edit');
                    const del = e.target.closest('.btn-delete');
                    const tr = e.target.closest('tr.lp-row');
                    if (!tr)
                        return;

                    if (edit) {
                        document.getElementById('editMaLoaiPhong').value = tr.dataset.ma;
                        document.getElementById('editTenLoaiPhong').value = tr.dataset.ten;
                        document.getElementById('editDonGia').value = tr.dataset.dongia;
                        document.getElementById('editMoTa').value = tr.dataset.mota;
                        new bootstrap.Modal(document.getElementById('modalEditLoaiPhong')).show();
                    }

                    if (del) {
                        document.getElementById('delMaLoaiPhong').value = tr.dataset.ma;
                        document.getElementById('delLoaiPhongName').textContent = tr.dataset.ma + ' - ' + tr.dataset.ten;
                        new bootstrap.Modal(document.getElementById('modalDelLoaiPhong')).show();
                    }
                });

                document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(t => new bootstrap.Tooltip(t));

                document.querySelectorAll('.alert-dismissible').forEach(a => {
                    setTimeout(() => bootstrap.Alert.getOrCreateInstance(a).close(), 4500);
                });
            });
        </script>
    </body>
</html>
