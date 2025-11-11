package controller;

import dao.PhongDAO;
import dao.DatPhongDAO;
import dao.LuuTruDAO;
import dao.HoaDonDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import utils.DBConnection;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private PhongDAO phongDAO = new PhongDAO();
    private DatPhongDAO datPhongDAO = new DatPhongDAO();
    private LuuTruDAO luuTruDAO = new LuuTruDAO();
    private HoaDonDAO hoaDonDAO = new HoaDonDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            // Tổng số phòng
            int tongPhong = phongDAO.countAll(conn);

            // Số khách đang ở
            int khachDangO = luuTruDAO.countDangO(conn);

            // Số đặt phòng hôm nay
            int datPhongHomNay = datPhongDAO.countDatPhongHomNay(conn);

            // Số phòng trống
            int phongTrong = tongPhong - luuTruDAO.countDangO(conn); // hoặc tính trực tiếp từ Phong.TrangThai

            // Doanh thu từng tháng (0-indexed)
            List<Double> doanhThuThang = hoaDonDAO.getDoanhThuTheoThang(conn);

            // Gửi lên JSP
            request.setAttribute("tongPhong", tongPhong);
            request.setAttribute("khachDangO", khachDangO);
            request.setAttribute("datPhongHomNay", datPhongHomNay);
            request.setAttribute("phongTrong", phongTrong);
            request.setAttribute("doanhThuThang", doanhThuThang);

            request.getRequestDispatcher("/jsp/admin/dashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi tải dữ liệu dashboard: " + e.getMessage());
            response.sendRedirect("dashboard.jsp");
        }
    }
}
