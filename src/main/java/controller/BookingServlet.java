package controller;

import dao.BookingDAO;
import dao.CustomerDAO;
import dao.RoomDAO;
import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Booking;
import model.Customer;
import model.Room;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAO();
    private BookingDAO bookingDAO = new BookingDAO();
    private RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int maPhong = Integer.parseInt(request.getParameter("maPhong"));
            String hoTen = request.getParameter("hoTen");
            String sdt = request.getParameter("sdt");
            String email = request.getParameter("email");
            String diaChi = request.getParameter("diaChi");
            Date ngayNhan = Date.valueOf(request.getParameter("ngayNhan"));
            Date ngayTra = Date.valueOf(request.getParameter("ngayTra"));
            Date ngayDat = new Date(System.currentTimeMillis());

            Customer customer = new Customer(0, hoTen, sdt, email, diaChi);
            int maKH = customerDAO.insert(customer);
            customer.setMaKH(maKH);

            Room room = new Room();
            room.setMaPhong(maPhong);

            Booking booking = new Booking(0, room, customer, ngayDat, ngayNhan, ngayTra, "Chờ xử lý");
            boolean result = bookingDAO.insert(booking);

            if (result) {
                response.sendRedirect(request.getContextPath() + "/jsp/success.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/jsp/error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/jsp/error.jsp");
        }
    }
}
