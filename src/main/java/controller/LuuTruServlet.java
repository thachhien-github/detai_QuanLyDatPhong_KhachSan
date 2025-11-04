package controller;

import utils.DBConnection;
import dao.LuuTruDAO;
import dao.HoaDonDAO;
import dao.DatPhongDAO;
import model.DatPhong;
import model.LuuTru;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/luutru")
public class LuuTruServlet extends HttpServlet {

    private final LuuTruDAO luuDao = new LuuTruDAO();
    private final DatPhongDAO bookingDAO = new DatPhongDAO();
    private final HoaDonDAO hoaDonDAO = new HoaDonDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            List<LuuTru> list = luuDao.findAll(conn);
            List<DatPhong> confirmed = bookingDAO.findConfirmedBookings(conn);
            req.setAttribute("luutruList", list);
            req.setAttribute("confirmedBookings", confirmed);
            req.getRequestDispatcher("/jsp/admin/luutru-list.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "Lỗi server: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            if ("checkin".equalsIgnoreCase(action)) {
                String maDatPhongStr = req.getParameter("maDatPhong");
                String cccd = req.getParameter("cccd");
                String ghiChu = req.getParameter("ghiChu");

                if (maDatPhongStr == null || maDatPhongStr.trim().isEmpty()) {
                    session.setAttribute("error", "Thiếu mã đặt phòng.");
                    resp.sendRedirect(req.getContextPath() + "/luutru");
                    return;
                }

                int maDatPhong;
                try {
                    maDatPhong = Integer.parseInt(maDatPhongStr);
                } catch (NumberFormatException ex) {
                    session.setAttribute("error", "Mã đặt phòng không hợp lệ.");
                    resp.sendRedirect(req.getContextPath() + "/luutru");
                    return;
                }

                // Lấy MaNhanVien từ session
                Integer maNhanVien = (Integer) session.getAttribute("maNhanVien");
                if (maNhanVien == null) {
                    session.setAttribute("error", "Bạn chưa đăng nhập hoặc session hết hạn.");
                    resp.sendRedirect(req.getContextPath() + "/login.jsp");
                    return;
                }

                try {
                    int maLuuTru = luuDao.createCheckIn(conn, maDatPhong, cccd, ghiChu, maNhanVien);
                    conn.commit();
                    session.setAttribute("success", "Check-in thành công (Mã Lưu Trú: " + maLuuTru + ").");
                } catch (Exception ex) {
                    try {
                        conn.rollback();
                    } catch (Exception ignore) {
                    }
                    ex.printStackTrace();
                    session.setAttribute("error", "Check-in thất bại: " + ex.getMessage());
                }

            } else if ("checkout".equalsIgnoreCase(action)) {
                String maLuuTruStr = req.getParameter("maLuuTru");

                if (maLuuTruStr == null || maLuuTruStr.trim().isEmpty()) {
                    session.setAttribute("error", "Thiếu mã lưu trú để check-out.");
                    resp.sendRedirect(req.getContextPath() + "/luutru");
                    return;
                }

                int maLuuTru;
                try {
                    maLuuTru = Integer.parseInt(maLuuTruStr);
                } catch (NumberFormatException ex) {
                    session.setAttribute("error", "Mã lưu trú không hợp lệ.");
                    resp.sendRedirect(req.getContextPath() + "/luutru");
                    return;
                }

                // Lấy MaNhanVien từ session
                Integer maNhanVien = (Integer) session.getAttribute("maNhanVien");
                if (maNhanVien == null) {
                    session.setAttribute("error", "Bạn chưa đăng nhập hoặc session hết hạn.");
                    resp.sendRedirect(req.getContextPath() + "/login.jsp");
                    return;
                }

                try {
                    boolean ok = luuDao.checkOut(conn, maLuuTru);
                    if (!ok) {
                        conn.rollback();
                        session.setAttribute("error", "Check-out thất bại (đã check-out trước đó hoặc không tồn tại).");
                    } else {
                        int maHoaDon = hoaDonDAO.createInvoiceForLuuTru(conn, maLuuTru, maNhanVien);
                        conn.commit();
                        session.setAttribute("success", "Check-out thành công. Hoá đơn: " + (maHoaDon > 0 ? maHoaDon : "Không tạo"));
                    }
                } catch (Exception ex) {
                    try {
                        conn.rollback();
                    } catch (Exception ignore) {
                    }
                    ex.printStackTrace();
                    session.setAttribute("error", "Check-out lỗi: " + ex.getMessage());
                }

            } else {
                session.setAttribute("error", "Hành động không được hỗ trợ: " + action);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            session.setAttribute("error", "Lỗi kết nối DB: " + ex.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/luutru");
    }
}
