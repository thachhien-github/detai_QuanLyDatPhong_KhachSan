//package controller;
//
//import dao.DatPhongDAO;
//import dao.KhachHangDAO;
//import model.DatPhong;
//import model.KhachHang;
//import utils.DBConnection;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.sql.Connection;
//import java.util.List;
//
//@WebServlet("/test-db")
//public class TestDBServlet extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
//
//        out.println("<html><head><title>Test DB Connection</title>");
//        out.println("<style>body{font-family:Arial;line-height:1.5;} table{border-collapse:collapse;width:100%;} td,th{border:1px solid #ccc;padding:6px;}</style>");
//        out.println("</head><body>");
//        out.println("<h2>🧠 Kiểm tra kết nối CSDL HotelDB</h2>");
//
//        // ==============================
//        // 1️⃣ Kiểm tra kết nối DB
//        // ==============================
//        Connection conn = DBConnection.getConnection();
//        if (conn != null) {
//            out.println("<p style='color:green;'>✅ Kết nối thành công!</p>");
//        } else {
//            out.println("<p style='color:red;'>❌ Kết nối thất bại!</p>");
//        }
//
//        // ==============================
//        // 2️⃣ Test lấy danh sách khách hàng
//        // ==============================
//        out.println("<h3>📋 Danh sách khách hàng</h3>");
//        KhachHangDAO khDAO = new KhachHangDAO();
//        List<KhachHang> dsKH = khDAO.getAll();
//
//        if (dsKH.isEmpty()) {
//            out.println("<p style='color:orange;'>⚠️ Không có khách hàng nào trong DB!</p>");
//        } else {
//            out.println("<table>");
//            out.println("<tr><th>Mã KH</th><th>Họ tên</th><th>SĐT</th><th>Email</th><th>CCCD</th><th>Địa chỉ</th></tr>");
//            for (KhachHang kh : dsKH) {
//                out.println("<tr>");
//                out.println("<td>" + kh.getMaKhachHang() + "</td>");
//                out.println("<td>" + kh.getHoTen() + "</td>");
//                out.println("<td>" + kh.getSoDienThoai() + "</td>");
//                out.println("<td>" + kh.getEmail() + "</td>");
//                out.println("<td>" + kh.getCccd() + "</td>");
//                out.println("<td>" + kh.getDiaChi() + "</td>");
//                out.println("</tr>");
//            }
//            out.println("</table>");
//        }
//
//        // ==============================
//        // 3️⃣ Test lấy danh sách đặt phòng
//        // ==============================
//        out.println("<h3>🏨 Danh sách đặt phòng</h3>");
//        DatPhongDAO dpDAO = new DatPhongDAO();
//        List<DatPhong> dsDP = dpDAO.getAll();
//
//        if (dsDP.isEmpty()) {
//            out.println("<p style='color:orange;'>⚠️ Không có dữ liệu đặt phòng!</p>");
//        } else {
//            out.println("<table>");
//            out.println("<tr><th>Mã ĐP</th><th>Mã KH</th><th>Mã Phòng</th><th>Khách</th><th>SĐT</th><th>Ngày nhận</th><th>Ngày trả</th><th>Trạng thái</th></tr>");
//            for (DatPhong dp : dsDP) {
//                out.println("<tr>");
//                out.println("<td>" + dp.getMaDatPhong() + "</td>");
//                out.println("<td>" + dp.getMaKhachHang() + "</td>");
//                out.println("<td>" + dp.getMaPhong() + "</td>");
//                out.println("<td>" + dp.getTenKhach() + "</td>");
//                out.println("<td>" + dp.getSoDienThoai() + "</td>");
//                out.println("<td>" + (dp.getNgayNhanDuKien() != null ? dp.getNgayNhanDuKien() : "") + "</td>");
//                out.println("<td>" + (dp.getNgayTraDuKien() != null ? dp.getNgayTraDuKien() : "") + "</td>");
//                out.println("<td>" + dp.getTrangThai() + "</td>");
//                out.println("</tr>");
//            }
//            out.println("</table>");
//        }
//
//        out.println("</body></html>");
//    }
//}
