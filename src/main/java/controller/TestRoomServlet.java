package controller;

import dao.RoomDAO;
import model.Room;
import utils.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "TestServlet", urlPatterns = {"/test"})
public class TestRoomServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            out.println("<!doctype html><html><head><meta charset='utf-8'><title>Test DB & RoomDAO</title>");
            out.println("<style>body{font-family:Arial, Helvetica, sans-serif;padding:20px;} table{border-collapse:collapse;width:100%;} th,td{border:1px solid #ccc;padding:8px;text-align:left;} th{background:#f5f5f5;}</style>");
            out.println("</head><body>");
            out.println("<h2>Test kết nối Database và RoomDAO</h2>");

            // 1) Test DB connection
            out.println("<h3>1) Kiểm tra kết nối DB</h3>");
            try (Connection conn = DBConnection.getConnection()) {
                if (conn != null && !conn.isClosed()) {
                    out.println("<div style='color:green;'>Kết nối DB thành công.</div>");
                } else {
                    out.println("<div style='color:orange;'>Kết nối DB trả về null / closed.</div>");
                }
            } catch (SQLException ex) {
                out.println("<div style='color:red;'>Lỗi khi kết nối DB:</div>");
                out.println("<pre>" + escapeHtml(ex.toString()) + "</pre>");
                // stop here if no DB
                out.println("</body></html>");
                return;
            } catch (Exception ex) {
                out.println("<div style='color:red;'>Ngoại lệ khi kiểm tra DB:</div>");
                out.println("<pre>" + escapeHtml(ex.toString()) + "</pre>");
                out.println("</body></html>");
                return;
            }

            // 2) Test RoomDAO.getAll()
            out.println("<h3>2) Gọi RoomDAO.getAll()</h3>");
            try {
                List<Room> rooms = roomDAO.getAll();
                out.println("<div>RoomDAO trả về <strong>" + (rooms == null ? 0 : rooms.size()) + "</strong> bản ghi.</div>");

                if (rooms != null && !rooms.isEmpty()) {
                    out.println("<table>");
                    out.println("<thead><tr><th>MaPhong</th><th>SoPhong</th><th>MaLoaiPhong</th><th>TrangThai</th><th>HinhAnh</th><th>MoTa</th></tr></thead>");
                    out.println("<tbody>");
                    for (Room r : rooms) {
                        out.println("<tr>"
                                + "<td>" + r.getMaPhong() + "</td>"
                                + "<td>" + escapeHtml(r.getSoPhong()) + "</td>"
                                + "<td>" + r.getMaLoaiPhong() + "</td>"
                                + "<td>" + escapeHtml(r.getTrangThai()) + "</td>"
                                + "<td>" + escapeHtml(r.getHinhAnh()) + "</td>"
                                + "<td>" + escapeHtml(r.getMoTa()) + "</td>"
                                + "</tr>");
                    }
                    out.println("</tbody></table>");
                } else {
                    out.println("<div style='color:orange;'>Danh sách phòng rỗng.</div>");
                }
            } catch (SQLException ex) {
                out.println("<div style='color:red;'>SQLException khi gọi RoomDAO.getAll():</div>");
                out.println("<pre>" + escapeHtml(getStackTrace(ex)) + "</pre>");
            } catch (Exception ex) {
                out.println("<div style='color:red;'>Ngoại lệ khi gọi RoomDAO.getAll():</div>");
                out.println("<pre>" + escapeHtml(getStackTrace(ex)) + "</pre>");
            }

            out.println("<hr/>");
            out.println("<div>Gợi ý debug: nếu kết nối thành công nhưng danh sách rỗng -> kiểm tra bảng <code>Phong</code> có dữ liệu không (SELECT COUNT(*) FROM Phong)</div>");
            out.println("</body></html>");
        }
    }

    // utility: escape HTML simple
    private static String escapeHtml(String s) {
        if (s == null) {
            return "";
        }
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;");
    }

    // get stack trace as string
    private static String getStackTrace(Throwable t) {
        StringBuilder sb = new StringBuilder();
        sb.append(t.toString()).append("\\n");
        for (StackTraceElement el : t.getStackTrace()) {
            sb.append("    at ").append(el.toString()).append("\\n");
        }
        if (t.getCause() != null) {
            sb.append("Caused by: ").append(t.getCause().toString()).append("\\n");
            for (StackTraceElement el : t.getCause().getStackTrace()) {
                sb.append("    at ").append(el.toString()).append("\\n");
            }
        }
        return sb.toString();
    }
}
