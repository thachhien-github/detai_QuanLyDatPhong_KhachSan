<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Modal: Add Booking -->
<div class="modal fade" id="modalAddBooking" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/bookings" method="post" class="needs-validation" novalidate>
                <input type="hidden" name="action" value="insert"/>
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Tạo đặt phòng mới</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Mã phòng</label>
                            <input type="text" name="maPhong" class="form-control" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Ngày nhận (yyyy-mm-dd)</label>
                            <input type="date" name="ngayNhan" class="form-control" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Ngày trả (yyyy-mm-dd)</label>
                            <input type="date" name="ngayTra" class="form-control" required>
                        </div>

                        <div class="col-md-12"><hr/></div>

                        <div class="col-md-6">
                            <label class="form-label">Họ tên khách</label>
                            <input type="text" name="khHoTen" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Số điện thoại</label>
                            <input type="text" name="khSoDienThoai" class="form-control">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email</label>
                            <input type="email" name="khEmail" class="form-control">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">CCCD</label>
                            <input type="text" name="khCCCD" class="form-control">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Địa chỉ</label>
                            <input type="text" name="khDiaChi" class="form-control">
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">Ghi chú</label>
                            <textarea name="ghiChu" class="form-control" rows="2"></textarea>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Tạo đặt phòng</button>
                </div>
            </form>
        </div>
    </div>
</div>
