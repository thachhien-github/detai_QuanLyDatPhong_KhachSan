<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.NhanVien" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8"/>
        <title>Quản lý Tài khoản - HCMCT Hotel</title>
        <jsp:include page="../admin/layout/header.jsp" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/roomtype-list.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-dashboard.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css"/>
    </head>
    <body>
        <jsp:include page="../admin/layout/nav.jsp" />

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2 p-0">
                    <jsp:include page="../admin/layout/sidebar.jsp" />
                </div>

                <div class="col-md-10 mt-3">
                    <h2 class="text-dark mb-3">
                        <i class="bi bi-person-badge me-2 text-warning"></i> Quản lý Tài khoản
                    </h2>
                    <hr/>

                    <div class="card-surface p-3">
                        <!-- Toolbar -->
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="d-flex align-items-center gap-2">
                                <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#modalCreate">
                                    <i class="bi bi-plus-lg me-1"></i> Thêm
                                </button>
                                <div class="ms-2 text-muted small">
                                    Tổng: <strong id="itemsCountSmall">${empty accounts ? 0 : fn:length(accounts)}</strong>
                                </div>
                            </div>

                            <form id="searchForm" class="d-flex" method="get" action="${pageContext.request.contextPath}/admin/accounts">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-search"></i></span>
                                    <input type="text" id="searchInput" name="q" class="form-control"
                                           placeholder="Tìm theo tên, username, chức vụ..." value="${fn:escapeXml(param.q)}"/>
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

                        <!-- Table Accounts -->
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>#</th>
                                        <th>Họ tên</th>
                                        <th>Tên đăng nhập</th>
                                        <th>Chức vụ</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody id="tbodyAccounts">
                                    <c:forEach var="nv" items="${accounts}" varStatus="st">
                                        <tr class="a-row"
                                            data-search="${nv.hoTen} ${nv.tenDangNhap} ${nv.chucVu} ${nv.trangThai}"
                                            data-trangthai="${nv.trangThai}">
                                            <td>${st.index + 1}</td>
                                            <td>${nv.hoTen}</td>
                                            <td>${nv.tenDangNhap}</td>
                                            <td>${nv.chucVu}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${nv.trangThai eq 'Hoạt động'}">
                                                        <span class="badge bg-success">${nv.trangThai}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${nv.trangThai}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <button class="btn btn-sm btn-primary btn-edit" data-bs-toggle="modal" data-bs-target="#modalEdit">Sửa</button>
                                                <form action="${pageContext.request.contextPath}/admin/accounts" method="post" style="display:inline" onsubmit="return confirm('Xác nhận xóa?');">
                                                    <input type="hidden" name="action" value="delete"/>
                                                    <input type="hidden" name="maNhanVien" class="del-id" value=""/>
                                                    <button class="btn btn-sm btn-danger" type="submit">Xóa</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty accounts}">
                                        <tr><td colspan="6" class="text-center">Không có tài khoản</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Modal Create -->
                    <div class="modal fade" id="modalCreate" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog">
                            <form class="modal-content" action="${pageContext.request.contextPath}/admin/accounts" method="post">
                                <input type="hidden" name="action" value="create"/>
                                <div class="modal-header">
                                    <h5 class="modal-title">Tạo tài khoản</h5>
                                    <button class="btn-close" data-bs-dismiss="modal" type="button"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="mb-2"><label>Họ tên</label><input name="hoTen" class="form-control" required/></div>
                                    <div class="mb-2"><label>Username</label><input name="tenDangNhap" class="form-control" required/></div>
                                    <div class="mb-2"><label>Mật khẩu</label><input name="matKhau" type="password" class="form-control" required/></div>
                                    <div class="mb-2"><label>Chức vụ</label>
                                        <select name="chucVu" class="form-select">
                                            <option>Nhân viên</option>
                                            <option>Quản trị viên</option>
                                        </select>
                                    </div>
                                    <div class="mb-2"><label>Trạng thái</label>
                                        <select name="trangThai" class="form-select">
                                            <option>Hoạt động</option>
                                            <option>Ngưng hoạt động</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-primary" type="submit">Lưu</button>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Modal Edit -->
                    <div class="modal fade" id="modalEdit" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog">
                            <form class="modal-content" id="formEdit" action="${pageContext.request.contextPath}/admin/accounts" method="post">
                                <input type="hidden" name="action" value="edit"/>
                                <input type="hidden" name="maNhanVien" id="editId"/>
                                <div class="modal-header">
                                    <h5 class="modal-title">Sửa tài khoản</h5>
                                    <button class="btn-close" data-bs-dismiss="modal" type="button"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="mb-2"><label>Họ tên</label><input name="hoTen" id="editHoTen" class="form-control" required/></div>
                                    <div class="mb-2"><label>Username</label><input name="tenDangNhap" id="editUsername" class="form-control" required/></div>
                                    <div class="mb-2"><label>Chức vụ</label>
                                        <select name="chucVu" id="editChucVu" class="form-select">
                                            <option>Nhân viên</option>
                                            <option>Quản trị viên</option>
                                        </select>
                                    </div>
                                    <div class="mb-2"><label>Trạng thái</label>
                                        <select name="trangThai" id="editTrangThai" class="form-select">
                                            <option>Hoạt động</option>
                                            <option>Ngưng hoạt động</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-primary" type="submit">Lưu</button>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <jsp:include page="../admin/layout/footer.jsp" />

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                    document.addEventListener('DOMContentLoaded', function () {
                                                        // Gán dữ liệu cho modal Sửa + input delete
                                                        document.querySelectorAll('.btn-edit').forEach(btn => {
                                                            btn.addEventListener('click', e => {
                                                                const tr = e.target.closest('tr');
                                                                document.getElementById('editId').value = tr.dataset.id || '';
                                                                document.getElementById('editHoTen').value = tr.dataset.hotename || '';
                                                                document.getElementById('editUsername').value = tr.dataset.username || '';
                                                                document.getElementById('editChucVu').value = tr.dataset.chucvu || 'Nhân viên';
                                                                document.getElementById('editTrangThai').value = tr.dataset.trangthai || 'Hoạt động';
                                                            });
                                                        });

                                                        // Gán id xóa cho form delete
                                                        document.querySelectorAll('form').forEach(f => {
                                                            const del = f.querySelector('.del-id');
                                                            if (del) {
                                                                const tr = f.closest('tr');
                                                                if (tr)
                                                                    del.value = tr.dataset.id || '';
                                                            }
                                                        });

                                                        // Search filter
                                                        const input = document.getElementById('searchInput');
                                                        const rows = document.querySelectorAll('#tbodyAccounts .a-row');
                                                        const itemsCount = document.getElementById('itemsCountSmall');
                                                        function applyFilter(q) {
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
                                                        input && input.addEventListener('input', e => applyFilter(e.target.value));
                                                        applyFilter(input ? input.value : '');
                                                    });
        </script>
    </body>
</html>
