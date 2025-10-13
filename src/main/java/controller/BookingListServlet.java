package controller;

import dao.BookingDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Booking;

@WebServlet("/booking/list")
public class BookingListServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Booking> listBookings = bookingDAO.getAll();
        request.setAttribute("listBookings", listBookings);

        request.getRequestDispatcher("/jsp/booking/bookingList.jsp")
                .forward(request, response);
    }
}
