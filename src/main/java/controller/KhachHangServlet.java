package controller;

import dao.KhachHangDAO;
import model.KhachHang;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/customers")
public class KhachHangServlet extends HttpServlet {

    private KhachHangDAO dao = new KhachHangDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<KhachHang> list = dao.getAll();
        req.setAttribute("khachHangs", list);
        req.getRequestDispatcher("/jsp/customer/customer-list.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("insert".equals(action)) {
            KhachHang kh = new KhachHang();
            kh.setHoTen(req.getParameter("hoTen"));
            kh.setSoDienThoai(req.getParameter("soDienThoai"));
            kh.setEmail(req.getParameter("email"));
            kh.setCccd(req.getParameter("cccd"));
            kh.setDiaChi(req.getParameter("diaChi"));
            dao.insert(kh);
            req.setAttribute("success", "Thêm khách hàng thành công!");
        } else if ("update".equals(action)) {
            KhachHang kh = new KhachHang();
            kh.setMaKhachHang(Integer.parseInt(req.getParameter("maKhachHang")));
            kh.setHoTen(req.getParameter("hoTen"));
            kh.setSoDienThoai(req.getParameter("soDienThoai"));
            kh.setEmail(req.getParameter("email"));
            kh.setCccd(req.getParameter("cccd"));
            kh.setDiaChi(req.getParameter("diaChi"));
            dao.update(kh);
            req.setAttribute("success", "Cập nhật thành công!");
        } else if ("delete".equals(action)) {
            dao.delete(Integer.parseInt(req.getParameter("maKhachHang")));
            req.setAttribute("success", "Xóa khách hàng thành công!");
        }

        doGet(req, resp);
    }
}
