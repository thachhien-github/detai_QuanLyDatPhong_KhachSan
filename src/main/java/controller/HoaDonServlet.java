package controller;

import dao.HoaDonDAO;
import model.HoaDon;
import utils.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/hoadon")
public class HoaDonServlet extends HttpServlet {

    private final HoaDonDAO hoaDonDAO = new HoaDonDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            List<HoaDon> list = hoaDonDAO.findAll(conn);
            req.setAttribute("hoaDonList", list);
            req.getRequestDispatcher("/jsp/invoice/hoadon-list.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(500, "Lỗi server: " + e.getMessage());
        }
    }
}
