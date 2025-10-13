package controller;

import dao.BookingDAO;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/booking/approve")
public class BookingApprovalServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String action = request.getParameter("action");

            if ("approve".equals(action)) {
                bookingDAO.updateStatus(id, "Đã xác nhận");
            } else if ("reject".equals(action)) {
                bookingDAO.updateStatus(id, "Từ chối");
            }

            response.sendRedirect(request.getContextPath() + "/booking/list");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
}
