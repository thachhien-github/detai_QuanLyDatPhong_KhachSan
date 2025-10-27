<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Room" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8"/>
        <title>Trang Quản Trị Khách Sạn</title>
        <%@ include file="../admin/layout/header.jsp" %>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style-dashboard.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/room-list.css"/>
        <style>
            /* nhỏ: highlight khi search */
            .room-card-hide {
                display: none !important;
            }
        </style>
    </head>
    <body>
        <%@ include file="../admin/layout/nav.jsp" %>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-2 p-0">
                    <%@ include file="../admin/layout/sidebar.jsp" %>
                </div>

                <!-- Main Content -->
                <div class="col-md-10 mt-3">
                    <h2 class="text-dark">
                        <i class="bi bi-speedometer2 me-2 text-warning"></i>
                        Bảng điều khiển khách sạn - Phòng
                    </h2>
                    <hr/>

                    <div class="container mt-3">
                        <!-- Toolbar: Add + Search -->
                        <div class="d-flex align-items-center justify-content-between mb-3 gap-2 flex-wrap">
                            <div class="d-flex gap-2">
                                <!-- Nút thêm phòng: đổi đường dẫn nếu bạn có trang add khác -->
                                <a href="${pageContext.request.contextPath}/jsp/room/addRoom.jsp" class="btn btn-success">
                                    <i class="bi bi-plus-lg"></i> Thêm phòng
                                </a>
                            </div>

                            <!-- Search form gửi GET về chính trang (param q) -->
                            <form id="searchForm" class="d-flex ms-auto" method="get" action="">
                                <input type="text" name="q" id="searchInput" class="form-control me-2" placeholder="Tìm theo số phòng, mô tả, trạng thái..." 
                                       value="${fn:escapeXml(param.q)}" autocomplete="off" />
                            </form>
                            
                        </div>

                        <!-- debug info từ servlet (tùy servlet có set) -->
                        <c:if test="${not empty debugJspRealPath or not empty debugJspResource}">
                            <div class="mb-3">
                                <small class="text-muted">
                                    debugJspResource: <c:out value="${debugJspResource}"/> |
                                    debugJspRealPath: <c:out value="${debugJspRealPath}"/> |
                                    debugJspExists: <c:out value="${debugJspExists}"/>
                                </small>
                            </div>
                        </c:if>

                        <!-- summary / lỗi -->
                        <div class="mb-3">
                            <strong>Rooms size: </strong><span id="roomsCount"><c:out value="${fn:length(rooms)}" /></span>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger mt-2"><c:out value="${error}"/></div>
                            </c:if>
                        </div>

                        <!-- Cards list -->
                        <div class="row" id="roomsContainer">
                            <c:choose>
                                <c:when test="${not empty rooms}">
                                    <c:forEach var="r" items="${rooms}">
                                        <%-- chuẩn hóa tên ảnh (trim) và tạo đường dẫn an toàn --%>
                                        <c:set var="imgName" value="${fn:trim(r.hinhAnh)}" />
                                        <c:choose>
                                            <c:when test="${not empty imgName}">
                                                <c:set var="imgPath"><c:url value="/img/${imgName}" /></c:set>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="imgPath"><c:url value="/img/default-room.jpg" /></c:set>
                                            </c:otherwise>
                                        </c:choose>

                                        <div class="col-md-3 mb-4 room-card" data-soPhong="${fn:toLowerCase(r.soPhong)}" data-moTa="${fn:toLowerCase(r.moTa)}" data-trangThai="${fn:toLowerCase(r.trangThai)}" >
                                            <div class="card shadow-sm h-100">
                                                <img src="${imgPath}"
                                                     class="card-img-top room-img"
                                                     alt="Room ${r.soPhong}"
                                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/default-room.jpg';" />

                                                <div class="card-body d-flex flex-column">
                                                    <h5 class="card-title mb-3 text-primary"><c:out value="${r.soPhong}"/></h5>

                                                    <p class="card-text mb-2"><strong>Loại:</strong> <c:out value="${r.maLoaiPhong}"/></p>

                                                    <c:if test="${not empty r.moTa}">
                                                        <p class="card-text mb-2"><small><c:out value="${r.moTa}"/></small></p>
                                                            </c:if>

                                                    <p class="card-text mb-3"><strong>Tình trạng:</strong> <c:out value="${r.trangThai}"/></p>

                                                    <form action="${pageContext.request.contextPath}/jsp/booking/bookingForm.jsp" method="get" class="mt-auto">
                                                        <input type="hidden" name="maPhong" value="${r.maPhong}"/>
                                                        <button class="btn btn-primary w-100">Đặt phòng ngay</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <div class="col-12 text-center">
                                        <div class="alert alert-warning">
                                            Hiện chưa có phòng nào được thêm vào hệ thống.
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Nút quay về dashboard -->
                        <div class="text-center mt-4">
                            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-secondary">
                                ← Quay về trang chủ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="../admin/layout/footer.jsp" %>

        <%-- nếu cần JS bootstrap --%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Live filter trên client: tìm theo số phòng, mô tả hoặc trạng thái
            (function () {
                const input = document.getElementById('searchInput');
                const container = document.getElementById('roomsContainer');
                const roomsCount = document.getElementById('roomsCount');

                function applyFilter(q) {
                    const ql = q.trim().toLowerCase();
                    const cards = container.querySelectorAll('.room-card');
                    let visible = 0;
                    cards.forEach(card => {
                        const soPhong = (card.dataset.sophong || '').toLowerCase();
                        const moTa = (card.dataset.mota || '').toLowerCase();
                        const trangThai = (card.dataset.trangthai || '').toLowerCase();
                        const text = soPhong + ' ' + moTa + ' ' + trangThai;
                        if (ql === '' || text.indexOf(ql) !== -1) {
                            card.classList.remove('room-card-hide');
                            visible++;
                        } else {
                            card.classList.add('room-card-hide');
                        }
                    });
                    roomsCount.textContent = visible;
                }

                // live typing (client-side)
                input.addEventListener('input', function (e) {
                    applyFilter(e.target.value);
                });

                // init: nếu có param q (server-side), apply it on load
                (function init() {
                    const qFromServer = '${fn:escapeXml(param.q)}';
                    if (qFromServer) {
                        input.value = qFromServer;
                        applyFilter(qFromServer);
                    } else {
                        // count initial visible cards
                        applyFilter('');
                    }
                })();
            })();
        </script>
    </body>
</html>
