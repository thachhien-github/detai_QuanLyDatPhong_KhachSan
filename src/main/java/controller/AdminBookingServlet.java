//// AdminBookingServlet.java
//package controller;
//
//import dao.DatPhongDAO;
//import model.DatPhong;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import java.io.IOException;
//import java.sql.SQLException;
//import java.util.List;
//
//@WebServlet("/admin/bookings")
//public class AdminBookingServlet extends HttpServlet {
//
//    private DatPhongDAO bookingDAO;
//
//    @Override
//    public void init() throws ServletException {
//        bookingDAO = new DatPhongDAO();
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
//            throws ServletException, IOException {
//
//        req.setCharacterEncoding("UTF-8");
//
//        String status = req.getParameter("status"); // filter tùy chọn
//
//        try {
//            List<DatPhong> bookings = bookingDAO.listBookings(status);
//            req.setAttribute("bookings", bookings);
//
//            req.getRequestDispatcher("/jsp/admin/bookingList.jsp").forward(req, resp);
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//            req.getSession().setAttribute("error", "Lỗi khi tải danh sách đặt phòng: " + e.getMessage());
//            resp.sendRedirect(req.getContextPath() + "/jsp/admin/dashboard.jsp");
//        }
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
//            throws ServletException, IOException {
//
//        req.setCharacterEncoding("UTF-8");
//        String action = req.getParameter("action");
//        String maPhong = req.getParameter("maPhong");
//        int maDatPhong = Integer.parseInt(req.getParameter("maDatPhong"));
//
//        try {
//            switch (action) {
//                case "confirm":
//                    bookingDAO.confirmBooking(maDatPhong, maPhong);
//                    req.getSession().setAttribute("success", "Đã xác nhận đặt phòng #" + maDatPhong);
//                    break;
//                case "cancel":
//                    bookingDAO.cancelBooking(maDatPhong, maPhong);
//                    req.getSession().setAttribute("success", "Đã hủy đặt phòng #" + maDatPhong);
//                    break;
//                default:
//                    req.getSession().setAttribute("error", "Hành động không hợp lệ!");
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            req.getSession().setAttribute("error", "Lỗi xử lý đặt phòng: " + e.getMessage());
//        }
//
//        // Quay lại danh sách
//        resp.sendRedirect(req.getContextPath() + "/admin/bookings");
//    }
//}
