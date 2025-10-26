/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.RoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import model.Room;

/**
 *
 * @author ThachHien
 */
@WebServlet(name = "TestRoomServlet", urlPatterns = {"/TestRoomServlet"})
public class TestRoomServlet extends HttpServlet {

    private RoomDAO dao = new RoomDAO();

    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = resp.getWriter()) {
            out.println("<!doctype html><html lang='vi'><head><meta charset='utf-8'/>");
            out.println("<title>Test Rooms</title>");
            out.println("<link rel='stylesheet' href='" + req.getContextPath() + "/resources/css/bootstrap.min.css' />");
            out.println("</head><body class='p-4'>");
            out.println("<h3>Test: Danh sách phòng (từ v_TinhTrangPhong)</h3>");

            List<Room> rooms;
            try {
                rooms = roomDAO.getAllRooms();
            } catch (SQLException ex) {
                out.println("<div class='alert alert-danger'>Lỗi khi truy vấn DB: " + ex.getMessage() + "</div>");
                out.println("</body></html>");
                return;
            }

            if (rooms == null || rooms.isEmpty()) {
                out.println("<div class='alert alert-warning'>Không có bản ghi nào trả về.</div>");
            } else {
                out.println("<table class='table table-bordered table-striped'>");
                out.println("<thead><tr><th>MaPhong</th><th>SoPhong</th><th>LoaiPhong</th><th>DonGia</th><th>TrangThai</th></tr></thead>");
                out.println("<tbody>");
                NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
                for (Room r : rooms) {
                    String dg = r.getDonGia() != null ? nf.format(r.getDonGia()) : "";
                    out.println("<tr>");
                    out.println("<td>" + r.getMaPhong() + "</td>");
                    out.println("<td>" + escape(r.getSoPhong()) + "</td>");
                    out.println("<td>" + escape(r.getTenLoaiPhong()) + "</td>");
                    out.println("<td class='text-end'>" + dg + " VNĐ</td>");
                    out.println("<td>" + escape(r.getTrangThai()) + "</td>");
                    out.println("</tr>");
                }
                out.println("</tbody></table>");
            }

            out.println("<a class='btn btn-sm btn-secondary' href='" + req.getContextPath() + "/rooms?action=list'>Xem trang danh sách phòng</a>");
            out.println("</body></html>");
        }
    }

    // nhỏ: tránh null pointer / escape html cơ bản
    private String escape(String s) {
        if (s == null) {
            return "";
        }
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#x27;");
    }

}
