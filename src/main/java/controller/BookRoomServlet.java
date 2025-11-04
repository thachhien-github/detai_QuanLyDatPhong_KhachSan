package controller;

import dao.DatPhongDAO;
import dao.KhachHangDAO;
import model.DatPhong;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;

@WebServlet("/book-room")
public class BookRoomServlet extends HttpServlet {

    private final DatPhongDAO datPhongDAO = new DatPhongDAO();
    private final KhachHangDAO khachHangDAO = new KhachHangDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain; charset=UTF-8");
        response.getWriter().println("Servlet /book-room hoạt động (GET)");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("👉 [BookRoomServlet] Nhận POST đặt phòng");
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            // lấy tham số (tên trường phải khớp với form)
            String maPhong = request.getParameter("maPhong");
            String tenKhach = request.getParameter("tenKhach");
            String sdt = request.getParameter("sdt");
            String email = request.getParameter("email");
            String ghiChu = request.getParameter("ghiChu");

            String ngayNhanStr = request.getParameter("ngayNhanDuKien");
            String ngayTraStr = request.getParameter("ngayTraDuKien");

            System.out.println("params: maPhong=" + maPhong + ", tenKhach=" + tenKhach + ", sdt=" + sdt + ", ngayNhan=" + ngayNhanStr + ", ngayTra=" + ngayTraStr);

            // validate cơ bản
            if (maPhong == null || maPhong.isEmpty() || sdt == null || sdt.isEmpty()
                    || ngayNhanStr == null || ngayTraStr == null) {
                request.setAttribute("error", "Thiếu thông tin bắt buộc (phòng / sđt / ngày).");
                request.getRequestDispatcher("/rooms-list").forward(request, response);
                return;
            }

            LocalDate ngayNhanDuKien = LocalDate.parse(ngayNhanStr);
            LocalDate ngayTraDuKien = LocalDate.parse(ngayTraStr);

            // 1) Lấy hoặc tạo khách hàng
            int maKhachHang = khachHangDAO.layHoacTaoKhachHang(tenKhach, sdt, email);
            if (maKhachHang <= 0) {
                request.setAttribute("error", "Không thể tạo hoặc lấy thông tin khách hàng.");
                request.getRequestDispatcher("/rooms-list").forward(request, response);
                return;
            }

            // 2) Tạo DatPhong
            DatPhong dp = new DatPhong();
            dp.setMaKhachHang(maKhachHang);
            dp.setMaPhong(maPhong);
            dp.setNgayDat(LocalDateTime.now());
            dp.setNgayNhanDuKien(ngayNhanDuKien);
            dp.setNgayTraDuKien(ngayTraDuKien);
            // ⚠️ giá trị đúng theo ràng buộc CHECK trong DB
            dp.setTrangThai("Chờ xác nhận");
            dp.setGhiChu(ghiChu);

            boolean ok = datPhongDAO.addBooking(dp);
            System.out.println("[BookRoomServlet] addBooking returned: " + ok);

            if (ok) {
                // cập nhật trạng thái phòng (nếu muốn)
                datPhongDAO.updateRoomStatus(maPhong, "Đã đặt");
                request.setAttribute("success", "Đặt phòng thành công!");
            } else {
                request.setAttribute("error", "Không thể đặt phòng. Vui lòng thử lại.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý: " + e.getMessage());
        }

        // quay lại danh sách phòng (hoặc dùng redirect tuỳ bạn)
        request.getRequestDispatcher("/rooms-list").forward(request, response);
    }
}
