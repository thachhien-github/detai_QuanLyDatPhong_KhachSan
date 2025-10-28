<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Modal Add -->
<div class="modal fade" id="modalAddLoaiPhong" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="<c:url value='/loai-phong'/>" method="post">
                <input type="hidden" name="action" value="insert"/>
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Thêm Loại Phòng</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
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
                        <input type="number" name="donGia" step="0.01" min="0" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mô tả</label>
                        <textarea name="moTa" class="form-control" rows="3"></textarea>
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

<!-- Modal Edit -->
<div class="modal fade" id="modalEditLoaiPhong" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="<c:url value='/loai-phong'/>" method="post">
                <input type="hidden" name="action" value="update"/>
                <div class="modal-header bg-warning text-dark">
                    <h5 class="modal-title">Sửa Loại Phòng</h5>
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
                        <input type="number" id="editDonGia" name="donGia" step="0.01" min="0" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mô tả</label>
                        <textarea id="editMoTa" name="moTa" class="form-control" rows="3"></textarea>
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

<!-- Modal Delete -->
<div class="modal fade" id="modalDelLoaiPhong" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="<c:url value='/loai-phong'/>" method="post">
                <input type="hidden" name="action" value="delete"/>
                <input type="hidden" id="delMaLoaiPhong" name="maLoaiPhong"/>
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">Xóa Loại Phòng</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    Bạn có chắc chắn muốn xóa <b><span id="delLoaiPhongName"></span></b> không? <br/>
                    <small class="text-muted">Lưu ý: nếu có ràng buộc FK từ bảng Phong, thao tác có thể thất bại.</small>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-danger">Xóa</button>
                    <button class="btn btn-secondary" data-bs-dismiss="modal" type="button">Hủy</button>
                </div>
            </form>
        </div>
    </div>
</div>
