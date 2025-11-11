package controller;

import dao.NhanVienDAO;
import model.NhanVien;
import utils.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/admin/accounts")
public class AccountServlet extends HttpServlet {

    private final NhanVienDAO nvDao = new NhanVienDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // simple auth check (optional)
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("maNhanVien") == null) {
            resp.sendRedirect(req.getContextPath() + "/auth"); // hoặc trang login của bạn
            return;
        }

        String q = req.getParameter("q");
        try (Connection conn = DBConnection.getConnection()) {
            List<NhanVien> list = (List<NhanVien>) nvDao.findAll(conn, q);
            req.setAttribute("accounts", list);
            req.getRequestDispatcher("/jsp/admin/account-management.jsp").forward(req, resp);
        } catch (Exception ex) {
            ex.printStackTrace();
            resp.sendError(500, "Lỗi server: " + ex.getMessage());
        }
    }

    // POST xử lý create / edit / delete (param 'action' phân biệt)
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        // auth check
        if (session == null || session.getAttribute("maNhanVien") == null) {
            resp.sendRedirect(req.getContextPath() + "/auth");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            if ("create".equalsIgnoreCase(action)) {
                String hoTen = req.getParameter("hoTen");
                String tenDangNhap = req.getParameter("tenDangNhap");
                String matKhau = req.getParameter("matKhau"); // plain text for compatibility
                String chucVu = req.getParameter("chucVu");
                String trangThai = req.getParameter("trangThai");

                if (hoTen == null || tenDangNhap == null || matKhau == null
                        || tenDangNhap.trim().isEmpty() || matKhau.trim().isEmpty()) {
                    session.setAttribute("error", "Tên đăng nhập và mật khẩu không được rỗng.");
                    resp.sendRedirect(req.getContextPath() + "/admin/accounts");
                    return;
                }

                if (nvDao.existsUsername(conn, tenDangNhap, null)) {
                    session.setAttribute("error", "Tên đăng nhập đã tồn tại.");
                    resp.sendRedirect(req.getContextPath() + "/admin/accounts");
                    return;
                }

                NhanVien nv = new NhanVien();
                nv.setHoTen(hoTen);
                nv.setTenDangNhap(tenDangNhap);
                nv.setMatKhau(matKhau); // lưu plain (tương thích DB mẫu)
                nv.setChucVu(chucVu == null ? "Nhân viên" : chucVu);
                nv.setTrangThai(trangThai == null ? "Hoạt động" : trangThai);

                int id = nvDao.create(conn, nv);
                if (id > 0) {
                    session.setAttribute("success", "Tạo tài khoản thành công.");
                } else {
                    session.setAttribute("error", "Tạo thất bại.");
                }

            } else if ("edit".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(req.getParameter("maNhanVien"));
                String hoTen = req.getParameter("hoTen");
                String tenDangNhap = req.getParameter("tenDangNhap");
                String chucVu = req.getParameter("chucVu");
                String trangThai = req.getParameter("trangThai");

                if (nvDao.existsUsername(conn, tenDangNhap, id)) {
                    session.setAttribute("error", "Tên đăng nhập đã tồn tại.");
                    resp.sendRedirect(req.getContextPath() + "/admin/accounts");
                    return;
                }

                NhanVien nv = new NhanVien();
                nv.setMaNhanVien(id);
                nv.setHoTen(hoTen);
                nv.setTenDangNhap(tenDangNhap);
                nv.setChucVu(chucVu);
                nv.setTrangThai(trangThai);

                boolean ok = nvDao.update(conn, nv);
                session.setAttribute(ok ? "success" : "error", ok ? "Cập nhật thành công." : "Cập nhật thất bại.");

            } else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(req.getParameter("maNhanVien"));
                boolean ok = nvDao.delete(conn, id);
                session.setAttribute(ok ? "success" : "error", ok ? "Xóa thành công." : "Xóa thất bại.");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            session.setAttribute("error", "Lỗi server: " + ex.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/accounts");
    }
}
