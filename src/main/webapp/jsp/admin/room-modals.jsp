<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Modal: Thêm phòng -->
<div class="modal fade" id="modalAddRoom" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="<c:url value='/rooms'/>" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="insert" />
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title"><i class="bi bi-plus-circle me-2"></i> Thêm phòng mới</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Mã phòng</label>
                        <input type="text" name="maPhong" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Loại phòng</label>
                        <select name="maLoaiPhong" id="addMaLoaiPhong" class="form-select" required>
                            <!-- Nếu servlet set sẵn `loaiPhongs` (array/string[]), nó sẽ render ở đây -->
                            <c:forEach var="lp" items="${loaiPhongs}">
                                <option value="${lp}">${lp}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Trạng thái</label>
                        <select name="trangThai" class="form-select">
                            <option value="Trống">Trống</option>
                            <option value="Đã đặt">Đã đặt</option>
                            <option value="Đang sửa chữa">Đang sửa chữa</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Mô tả</label>
                        <textarea name="moTa" class="form-control" rows="2"></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Hình ảnh</label>
                        <input type="file" name="hinhAnh" class="form-control" accept="image/*" id="addHinhAnhInput">
                        <div class="mt-2">
                            <small>Preview:</small><br>
                            <img id="addHinhAnhPreview" class="img-thumbnail" width="120" src="${pageContext.request.contextPath}/img/default-room.jpg"/>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal" type="button">Hủy</button>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal: Sửa phòng -->
<div class="modal fade" id="modalEditRoom" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="<c:url value='/rooms'/>" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="update" />
                <!-- giữ ảnh hiện tại nếu không upload ảnh mới -->
                <input type="hidden" name="currentHinhAnh" id="currentHinhAnh" value=""/>
                <div class="modal-header bg-warning text-dark">
                    <h5 class="modal-title"><i class="bi bi-pencil-square me-2"></i> Sửa thông tin phòng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Mã phòng</label>
                        <input type="text" class="form-control" name="maPhong" id="editMaPhong" readonly>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Loại phòng</label>
                        <select name="maLoaiPhong" id="editMaLoaiPhong" class="form-select" required>
                            <c:forEach var="lp" items="${loaiPhongs}">
                                <option value="${lp}">${lp}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Trạng thái</label>
                        <select name="trangThai" class="form-select" id="editTrangThai">
                            <option value="Trống">Trống</option>
                            <option value="Đã đặt">Đã đặt</option>
                            <option value="Đang sửa chữa">Đang sửa chữa</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Mô tả</label>
                        <textarea name="moTa" class="form-control" rows="2" id="editMoTa"></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Hình ảnh mới (tùy chọn)</label>
                        <input type="file" name="hinhAnh" class="form-control" accept="image/*" id="editHinhAnhInput">
                        <div class="mt-2">
                            <small>Ảnh hiện tại:</small><br>
                            <img id="editHinhAnhPreview" class="img-thumbnail" width="120" src="${pageContext.request.contextPath}/img/default-room.jpg">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal" type="button">Hủy</button>
                    <button type="submit" class="btn btn-warning text-white">Cập nhật</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal: Xác nhận xóa phòng -->
<div class="modal fade" id="modalDelRoom" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="<c:url value='/rooms'/>" method="post">
                <input type="hidden" name="action" value="delete" />
                <input type="hidden" name="maPhong" id="delMaPhong" />
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title"><i class="bi bi-exclamation-triangle me-2"></i> Xác nhận xóa phòng</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    Bạn có chắc chắn muốn <b>xóa phòng <span id="delRoomName"></span></b> không?
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-danger">Xóa</button>
                    <button class="btn btn-secondary" data-bs-dismiss="modal" type="button">Hủy</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Preview ảnh khi chọn file (Add)
    document.getElementById('addHinhAnhInput')?.addEventListener('change', function (e) {
        const file = this.files && this.files[0];
        if (!file)
            return;
        const url = URL.createObjectURL(file);
        document.getElementById('addHinhAnhPreview').src = url;
    });

    // Preview ảnh khi chọn file (Edit)
    document.getElementById('editHinhAnhInput')?.addEventListener('change', function (e) {
        const file = this.files && this.files[0];
        if (!file)
            return;
        const url = URL.createObjectURL(file);
        document.getElementById('editHinhAnhPreview').src = url;
    });

    // NOTE:
    // roomList.js hiện dùng delegation để set các field khi người dùng nhấn Sửa / Xóa.
    // Vì vậy ở đây không dùng show.bs.modal với relatedTarget.
</script>
