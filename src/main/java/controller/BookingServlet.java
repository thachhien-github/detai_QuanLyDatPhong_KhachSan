package controller;

import dao.DatPhongDAO;
import model.DatPhong;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/booking/bookings")
public class BookingServlet extends HttpServlet {

    private DatPhongDAO datPhongDAO = new DatPhongDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy danh sách đặt phòng
        List<DatPhong> listBookings = datPhongDAO.getAll();
        request.setAttribute("listBookings", listBookings);

        // Forward đến trang JSP
        request.getRequestDispatcher("/jsp/booking/bookingList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String idStr = request.getParameter("maDatPhong");

        HttpSession session = request.getSession();

        if (idStr != null && !idStr.trim().isEmpty()) {
            int maDatPhong = Integer.parseInt(idStr.trim());
            boolean result = false;

            if ("confirm".equalsIgnoreCase(action)) {
                result = datPhongDAO.xacNhanDatPhong(maDatPhong);
                if (result) {
                    session.setAttribute("success", "✅ Đã xác nhận đặt phòng #" + maDatPhong);
                } else {
                    session.setAttribute("error", "❌ Không thể xác nhận đặt phòng #" + maDatPhong);
                }
            } else if ("cancel".equalsIgnoreCase(action)) {
                result = datPhongDAO.huyDatPhong(maDatPhong);
                if (result) {
                    session.setAttribute("success", "🗑️ Đã hủy đặt phòng #" + maDatPhong);
                } else {
                    session.setAttribute("error", "⚠️ Không thể hủy đặt phòng #" + maDatPhong);
                }
            }
        } else {
            session.setAttribute("error", "❌ Thiếu mã đặt phòng!");
        }

        // Quay lại trang danh sách
        response.sendRedirect(request.getContextPath() + "/booking/bookings");
    }
}
