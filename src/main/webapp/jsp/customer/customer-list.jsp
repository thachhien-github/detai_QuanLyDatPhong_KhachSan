<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.KhachHang" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8"/>
        <title>Quản lý Khách hàng - HCMCT Hotel</title>
        <%@ include file="../admin/layout/header.jsp" %>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-dashboard.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/roomtype-list.css"/>
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
                        <i class="bi bi-people text-primary me-2 text-warning"></i> Quản lý Khách hàng
                    </h2>
                    <hr/>

                    <div class="container mt-3 inner-container">
                        <div class="card-surface">
                            <div class="toolbar">
                                <div class="toolbar-left">
                                    <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#modalAddKH">
                                        <i class="bi bi-plus-lg me-1"></i> Thêm khách hàng
                                    </button>
                                    <div class="ms-2 text-muted small">
                                        Tổng: <strong id="itemsCountSmall">${khachHangs.size()}</strong>
                                    </div>
                                </div>

                                <div class="toolbar-right">
                                    <div class="toolbar search">
                                        <i class="bi bi-search"></i>
                                        <input type="text" id="searchInput" placeholder="Tìm theo tên hoặc CCCD..."/>
                                    </div>
                                </div>
                            </div>

                            <!-- Messages -->
                            <c:if test="${not empty success}">
                                <div class="alert alert-success alert-dismissible fade show mt-2">
                                    ${success}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <div class="table-wrap">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th style="width:80px;">Mã KH</th>
                                            <th>Họ tên</th>
                                            <th>Điện thoại</th>
                                            <th>Email</th>
                                            <th>CCCD</th>
                                            <th>Địa chỉ</th>
                                            <th style="width:140px;">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tblBody">
                                    <c:forEach var="kh" items="${khachHangs}">
                                        <tr class="kh-row"
                                            data-ma="${kh.maKhachHang}"
                                            data-ten="${kh.hoTen}"
                                            data-sdt="${kh.soDienThoai}"
                                            data-email="${kh.email}"
                                            data-cccd="${kh.cccd}"
                                            data-diachi="${kh.diaChi}">
                                            <td>${kh.maKhachHang}</td>
                                            <td>${kh.hoTen}</td>
                                            <td>${kh.soDienThoai}</td>
                                            <td>${kh.email}</td>
                                            <td>${kh.cccd}</td>
                                            <td>${kh.diaChi}</td>
                                            <td>
                                                <div class="actions">
                                                    <button class="btn btn-icon btn-edit"><i class="bi bi-pencil"></i></button>
                                                    <button class="btn btn-icon btn-delete"><i class="bi bi-trash"></i></button>
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

        <!-- Modal Add -->
        <div class="modal fade" id="modalAddKH" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/customers" method="post">
                        <input type="hidden" name="action" value="insert"/>
                        <div class="modal-header bg-success text-white">
                            <h5>Thêm khách hàng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input class="form-control mb-2" name="hoTen" placeholder="Họ tên" required/>
                            <input class="form-control mb-2" name="soDienThoai" placeholder="Số điện thoại"/>
                            <input class="form-control mb-2" name="email" placeholder="Email"/>
                            <input class="form-control mb-2" name="cccd" placeholder="CCCD"/>
                            <textarea class="form-control" name="diaChi" placeholder="Địa chỉ"></textarea>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-success">Thêm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal Edit -->
        <div class="modal fade" id="modalEditKH" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/customers" method="post">
                        <input type="hidden" name="action" value="update"/>
                        <div class="modal-header bg-warning">
                            <h5>Cập nhật khách hàng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" id="editMaKH" name="maKhachHang"/>
                            <input class="form-control mb-2" id="editHoTen" name="hoTen" placeholder="Họ tên"/>
                            <input class="form-control mb-2" id="editSoDienThoai" name="soDienThoai" placeholder="Số điện thoại"/>
                            <input class="form-control mb-2" id="editEmail" name="email" placeholder="Email"/>
                            <input class="form-control mb-2" id="editCCCD" name="cccd" placeholder="CCCD"/>
                            <textarea class="form-control" id="editDiaChi" name="diaChi" placeholder="Địa chỉ"></textarea>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-primary">Lưu thay đổi</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal Delete -->
        <div class="modal fade" id="modalDelKH" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/customers" method="post">
                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" id="delMaKH" name="maKhachHang"/>
                        <div class="modal-header bg-danger text-white">
                            <h5>Xóa khách hàng</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <p>Bạn có chắc muốn xóa khách hàng:</p>
                            <p class="fw-bold text-danger" id="delKHName"></p>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-danger">Xóa</button>
                            <button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%@ include file="../admin/layout/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', () => {
                const rows = document.querySelectorAll('tr.kh-row');
                const input = document.getElementById('searchInput');
                const itemsCount = document.getElementById('itemsCountSmall');

                function filter(q) {
                    q = q.toLowerCase();
                    let visible = 0;
                    rows.forEach(r => {
                        const text = (r.dataset.ten + r.dataset.cccd).toLowerCase();
                        if (!q || text.includes(q)) {
                            r.style.display = '';
                            visible++;
                        } else
                            r.style.display = 'none';
                    });
                    itemsCount.textContent = visible;
                }

                input.addEventListener('input', e => filter(e.target.value));
                filter('');

                document.getElementById('tblBody').addEventListener('click', e => {
                    const tr = e.target.closest('tr.kh-row');
                    if (!tr)
                        return;
                    if (e.target.closest('.btn-edit')) {
                        document.getElementById('editMaKH').value = tr.dataset.ma;
                        document.getElementById('editHoTen').value = tr.dataset.ten;
                        document.getElementById('editSoDienThoai').value = tr.dataset.sdt;
                        document.getElementById('editEmail').value = tr.dataset.email;
                        document.getElementById('editCCCD').value = tr.dataset.cccd;
                        document.getElementById('editDiaChi').value = tr.dataset.diachi;
                        new bootstrap.Modal(document.getElementById('modalEditKH')).show();
                    }
                    if (e.target.closest('.btn-delete')) {
                        document.getElementById('delMaKH').value = tr.dataset.ma;
                        document.getElementById('delKHName').textContent = tr.dataset.ten;
                        new bootstrap.Modal(document.getElementById('modalDelKH')).show();
                    }
                });
            });
        </script>
    </body>
</html>
