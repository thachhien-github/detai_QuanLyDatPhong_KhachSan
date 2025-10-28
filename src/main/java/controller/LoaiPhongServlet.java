package controller;

import dao.LoaiPhongDAO;
import model.LoaiPhong;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "LoaiPhongServlet", urlPatterns = {"/loai-phong"})
public class LoaiPhongServlet extends HttpServlet {

    private LoaiPhongDAO lpDAO;

    @Override
    public void init() throws ServletException {
        lpDAO = new LoaiPhongDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            listLoaiPhong(request, response);
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        HttpSession session = request.getSession();
        try {
            switch (action) {
                case "insert":
                    handleInsert(request, session);
                    break;
                case "update":
                    handleUpdate(request, session);
                    break;
                case "delete":
                    handleDelete(request, session);
                    break;
                default:
                    break;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            session.setAttribute("error", "Lỗi: " + ex.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/loai-phong");
    }

    private void listLoaiPhong(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        List<LoaiPhong> list = lpDAO.getAll();
        req.setAttribute("loaiPhongs", list);

        // messages (xóa sau khi read sẽ được set trong JSP từ request)
        HttpSession session = req.getSession(false);
        if (session != null) {
            if (session.getAttribute("success") != null) {
                req.setAttribute("success", session.getAttribute("success"));
                session.removeAttribute("success");
            }
            if (session.getAttribute("error") != null) {
                req.setAttribute("error", session.getAttribute("error"));
                session.removeAttribute("error");
            }
        }

        req.getRequestDispatcher("/jsp/room/loaiPhongList.jsp").forward(req, resp);
    }

    private void handleInsert(HttpServletRequest req, HttpSession session) throws SQLException {
        String ma = req.getParameter("maLoaiPhong");
        String ten = req.getParameter("tenLoaiPhong");
        String donGiaStr = req.getParameter("donGia");
        String moTa = req.getParameter("moTa");

        if (ma == null || ma.trim().isEmpty()) {
            session.setAttribute("error", "Mã loại phòng không được để trống.");
            return;
        }

        // kiem tra ton tai
        if (lpDAO.findById(ma) != null) {
            session.setAttribute("error", "Mã loại phòng đã tồn tại: " + ma);
            return;
        }

        BigDecimal donGia = BigDecimal.ZERO;
        try {
            if (donGiaStr != null && !donGiaStr.trim().isEmpty()) {
                donGia = new BigDecimal(donGiaStr.trim());
            }
        } catch (NumberFormatException ex) {
            session.setAttribute("error", "Giá không hợp lệ.");
            return;
        }

        LoaiPhong lp = new LoaiPhong(ma, ten, donGia, moTa);
        boolean ok = lpDAO.insert(lp);
        session.setAttribute(ok ? "success" : "error", ok ? "Thêm loại phòng thành công!" : "Không thể thêm loại phòng.");
    }

    private void handleUpdate(HttpServletRequest req, HttpSession session) throws SQLException {
        String ma = req.getParameter("maLoaiPhong");
        String ten = req.getParameter("tenLoaiPhong");
        String donGiaStr = req.getParameter("donGia");
        String moTa = req.getParameter("moTa");

        BigDecimal donGia = BigDecimal.ZERO;
        try {
            if (donGiaStr != null && !donGiaStr.trim().isEmpty()) {
                donGia = new BigDecimal(donGiaStr.trim());
            }
        } catch (NumberFormatException ex) {
            session.setAttribute("error", "Giá không hợp lệ.");
            return;
        }

        LoaiPhong lp = new LoaiPhong(ma, ten, donGia, moTa);
        boolean ok = lpDAO.update(lp);
        session.setAttribute(ok ? "success" : "error", ok ? "Cập nhật thành công!" : "Không thể cập nhật.");
    }

    private void handleDelete(HttpServletRequest req, HttpSession session) throws SQLException {
        String ma = req.getParameter("maLoaiPhong");
        boolean ok = lpDAO.delete(ma);
        session.setAttribute(ok ? "success" : "error", ok ? "Xóa thành công!" : "Không thể xóa (kiểm tra ràng buộc FK).");
    }
}
