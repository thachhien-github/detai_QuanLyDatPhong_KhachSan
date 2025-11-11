<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.HoaDon" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8"/>
        <title>Quản lý Hóa Đơn - HCMCT Hotel</title>
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
                    <h2 class="text-dark">
                        <i class="bi bi-receipt me-2 text-warning"></i> Quản lý Hóa Đơn
                    </h2>
                    <hr/>

                    <div class="card-surface p-3">
                        <!-- Toolbar -->
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="ms-2 text-muted small">
                                Tổng: <strong id="itemsCountSmall">${empty hoaDonList ? 0 : fn:length(hoaDonList)}</strong>
                            </div>
                            <form id="searchForm" class="d-flex" method="get" action="${pageContext.request.contextPath}/hoadon">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-search"></i></span>
                                    <input type="text" id="searchInput" name="q" class="form-control"
                                           placeholder="Tìm theo Mã HĐ, Nhân viên, Khách, Phòng..." value="${fn:escapeXml(param.q)}"/>
                                </div>
                            </form>
                        </div>

                        <!-- Alert -->
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

                        <!-- Table Hóa Đơn -->
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>#</th>
                                        <th>Mã Hóa Đơn</th>
                                        <th>Khách</th>
                                        <th>Nhân Viên</th>
                                        <th>Phòng</th>
                                        <th>Ngày Lập</th>
                                        <th>Tổng Tiền</th>
                                        <th>Ghi Chú</th>
                                        <th>Thao Tác</th> <!-- Cột In -->
                                    </tr>
                                </thead>
                                <tbody id="tbodyHoaDon">
                                    <c:forEach var="hd" items="${hoaDonList}" varStatus="s">
                                        <tr class="hd-row"
                                            data-search="${hd.maHoaDon} ${hd.tenKhach} ${hd.tenNhanVien} ${hd.maPhong}">
                                            <td>${s.index + 1}</td>
                                            <td>${hd.maHoaDon}</td>
                                            <td>${hd.tenKhach != null ? hd.tenKhach : '—'}</td>
                                            <td>${hd.tenNhanVien != null ? hd.tenNhanVien : '—'}</td>
                                            <td>${hd.maPhong != null ? hd.maPhong : '—'}</td>
                                            <td>${hd.ngayLap}</td>
                                            <td>${hd.tongTien}</td>
                                            <td>${hd.ghiChu != null ? hd.ghiChu : ''}</td>
                                            <td>
                                                <button class="btn btn-sm btn-primary" onclick="printInvoice('${hd.maHoaDon}')">
                                                    <i class="bi bi-printer"></i> In
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty hoaDonList}">
                                        <tr>
                                            <td colspan="9" class="text-center text-muted">Chưa có hóa đơn nào.</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <jsp:include page="../admin/layout/footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                                                    document.addEventListener('DOMContentLoaded', function () {
                                                        const input = document.getElementById('searchInput');
                                                        const rows = document.querySelectorAll('#tbodyHoaDon .hd-row');
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

                                                        // Auto close alerts
                                                        document.querySelectorAll('.alert-dismissible').forEach(a => {
                                                            setTimeout(() => bootstrap.Alert.getOrCreateInstance(a).close(), 4000);
                                                        });
                                                    });

                                                    // Chuyển số thành chữ (VNĐ)
                                                    function numberToVietnameseText(number) {
                                                        const ChuSo = ["không", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín"];
                                                        const SoDonVi = ["", "nghìn", "triệu", "tỷ", "nghìn tỷ", "triệu tỷ", "tỷ tỷ"];
                                                        number = Math.round(number);
                                                        if (number === 0)
                                                            return "không đồng";

                                                        let i = 0, text = "", tmpNumber = number;
                                                        while (tmpNumber > 0) {
                                                            let three = tmpNumber % 1000;
                                                            if (three != 0)
                                                                text = readThree(three) + " " + SoDonVi[i] + " " + text;
                                                            tmpNumber = Math.floor(tmpNumber / 1000);
                                                            i++;
                                                        }
                                                        return text.trim() + " đồng";

                                                        function readThree(number) {
                                                            let hundreds = Math.floor(number / 100);
                                                            let tens = Math.floor((number % 100) / 10);
                                                            let units = number % 10;
                                                            let str = "";
                                                            if (hundreds > 0)
                                                                str += ChuSo[hundreds] + " trăm ";
                                                            if (tens > 1)
                                                                str += ChuSo[tens] + " mươi ";
                                                            else if (tens === 1)
                                                                str += "mười ";
                                                            if (units > 0) {
                                                                if (tens != 0 && units === 5)
                                                                    str += "lăm ";
                                                                else
                                                                    str += ChuSo[units] + " ";
                                                            }
                                                            return str.trim();
                                                        }
                                                    }

                                                    // In hóa đơn chuyên nghiệp
                                                    // Thay hàm printInvoice cũ bằng đoạn này
                                                    function printInvoice(invoiceId) {
                                                        const rows = document.querySelectorAll('#tbodyHoaDon .hd-row');
                                                        let row = null;
                                                        rows.forEach(r => {
                                                            if (r.dataset.search.toLowerCase().includes(invoiceId.toLowerCase())) {
                                                                row = r;
                                                            }
                                                        });

                                                        if (!row) {
                                                            alert("Không tìm thấy hóa đơn!");
                                                            return;
                                                        }

                                                        const cells = row.children;
                                                        const maHoaDon = cells[1].textContent;
                                                        const khach = cells[2].textContent;
                                                        const nhanVien = cells[3].textContent;
                                                        const phong = cells[4].textContent;
                                                        const ngayLap = cells[5].textContent;
                                                        const tongTien = parseFloat(cells[6].textContent.replace(/,/g, '') || 0);
                                                        const ghiChu = cells[7].textContent;
                                                        const tongTienChu = numberToVietnameseText(tongTien);

                                                        const printWindow = window.open('', '', 'width=900,height=700');
                                                        printWindow.document.write(`
        <html>
        <head>
            <title>Hóa đơn ${maHoaDon}</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
            <style>
                body { font-family: 'Times New Roman', serif; padding: 40px; background: #fff; color: #000; }
                .invoice-box { max-width: 800px; margin: auto; border: 1px solid #ddd; padding: 30px; box-shadow: 0 0 10px rgba(0,0,0,0.15); }
                h1, h2, h3 { text-align: center; }
                .header { border-bottom: 2px solid #000; margin-bottom: 20px; padding-bottom: 10px; }
                .info-table td { padding: 6px 4px; }
                .total-text { font-size: 18px; font-weight: bold; margin-top: 10px; }
                .signature { margin-top: 60px; text-align: right; }
                .signature p { margin-right: 60px; }
                .footer-note { margin-top: 40px; text-align: center; font-style: italic; color: gray; }
                table.table-bordered th, table.table-bordered td { border: 1px solid #333 !important; }
            </style>
        </head>
        <body onload="window.print()">
            <div class="invoice-box">
                <div class="header">
                    <h1>HCMCT HOTEL</h1>
                    <h3>HÓA ĐƠN THANH TOÁN</h3>
                </div>
                <table class="table table-borderless info-table">
                    <tr><td><strong>Mã Hóa Đơn:</strong></td><td>${maHoaDon}</td></tr>
                    <tr><td><strong>Khách hàng:</strong></td><td>${khach}</td></tr>
                    <tr><td><strong>Nhân viên lập:</strong></td><td>${nhanVien}</td></tr>
                    <tr><td><strong>Phòng:</strong></td><td>${phong}</td></tr>
                    <tr><td><strong>Ngày lập:</strong></td><td>${ngayLap}</td></tr>
                    <tr><td><strong>Ghi chú:</strong></td><td>${ghiChu}</td></tr>
                </table>
                <table class="table table-bordered mt-4">
                    <thead class="table-light">
                        <tr>
                            <th width="10%">STT</th>
                            <th>Nội dung</th>
                            <th width="30%">Số tiền (VNĐ)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>Thanh toán tiền phòng</td>
                            <td>${tongTien.toLocaleString()}</td>
                        </tr>
                    </tbody>
                </table>
                <p class="total-text">Tổng cộng: ${tongTien.toLocaleString()} VNĐ</p>
                <p class="total-text">Bằng chữ: ${tongTienChu}</p>
                <div class="signature">
                    <p><strong>Người lập hóa đơn</strong></p>
                    <br><br><br>
                    <p>(Ký & ghi rõ họ tên)</p>
                </div>
                <div class="footer-note">
                    <p>Xin cảm ơn quý khách đã sử dụng dịch vụ của HCMCT Hotel!</p>
                </div>
            </div>
        </body>
        </html>
    `);
                                                    }


        </script>
