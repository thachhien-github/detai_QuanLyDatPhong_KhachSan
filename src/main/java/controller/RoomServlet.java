package controller;

import dao.RoomDAO;
import model.Room;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * RoomServlet - pattern PRG, session flash messages, validation URL: /rooms
 */
@WebServlet(name = "RoomServlet", urlPatterns = {"/rooms"})
public class RoomServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private RoomDAO rDAO;

    @Override
    public void init() throws ServletException {
        rDAO = new RoomDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        // encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = safeTrim(request.getParameter("action"));
        if (action.isEmpty()) {
            action = "list";
        }

        HttpSession session = request.getSession();

        switch (action) {
            case "list":
                // lấy danh sách và forward tới JSP
                List<Room> rooms = rDAO.getAll();
                request.setAttribute("rooms", rooms);
                request.getRequestDispatcher("/jsp/room/roomList.jsp").forward(request, response);
                break;

//            case "search":
//                String keyword = safeTrim(request.getParameter("keyword"));
//                List<Room> found = (keyword.isEmpty()) ? rDAO.getAll() : rDAO.search(keyword);
//                request.setAttribute("rooms", found);
//                request.getRequestDispatcher("/jsp/room/roomList.jsp").forward(request, response);
//                break;

            case "insert":
                handleInsert(request, response);
                break;

            case "showEdit":
                try {
                    int id = parseIntOrDefault(request.getParameter("maPhong"), -1);
                    if (id > 0) {
                        Room editRoom = rDAO.findById(id);
                        request.setAttribute("rooms", rDAO.getAll());
                        request.setAttribute("editRoom", editRoom);
                    } else {
                        session.setAttribute("error", "Mã phòng không hợp lệ.");
                        request.setAttribute("rooms", rDAO.getAll());
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    session.setAttribute("error", "Lỗi khi lấy thông tin phòng.");
                    request.setAttribute("rooms", rDAO.getAll());
                }
                request.getRequestDispatcher("/jsp/room/roomList.jsp").forward(request, response);
                break;

            case "update":
                handleUpdate(request, response);
                break;

            case "alertDel":
                try {
                    int idDel = parseIntOrDefault(request.getParameter("maPhong"), -1);
                    if (idDel > 0) {
                        Room rDel = rDAO.findById(idDel);
                        request.setAttribute("rooms", rDAO.getAll());
                        request.setAttribute("delRoom", rDel);
                    } else {
                        session.setAttribute("error", "Mã phòng không hợp lệ.");
                        request.setAttribute("rooms", rDAO.getAll());
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    session.setAttribute("error", "Lỗi khi chuẩn bị xóa phòng.");
                    request.setAttribute("rooms", rDAO.getAll());
                }
                request.getRequestDispatcher("/jsp/room/roomList.jsp").forward(request, response);
                break;

            case "delete":
                handleDelete(request, response);
                break;

            default:
                // action không hợp lệ -> show list
                request.setAttribute("rooms", rDAO.getAll());
                request.getRequestDispatcher("/jsp/room/roomList.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            System.getLogger(RoomServlet.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            System.getLogger(RoomServlet.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
    }

    // ----------------- helper methods -----------------
    private int parseIntOrDefault(String s, int defaultValue) {
        if (s == null) {
            return defaultValue;
        }
        try {
            return Integer.parseInt(s.trim());
        } catch (NumberFormatException ex) {
            return defaultValue;
        }
    }

    private String safeTrim(String s) {
        return s == null ? "" : s.trim();
    }

    // ---------- handlers for CRUD (PRG + flash via session) ----------
    private void handleInsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            String soPhong = safeTrim(request.getParameter("soPhong"));
            int maLoaiPhong = parseIntOrDefault(request.getParameter("maLoaiPhong"), 0);
            String trangThai = safeTrim(request.getParameter("trangThai"));
            String hinhAnh = safeTrim(request.getParameter("hinhAnh")); // filename or path
            String moTa = safeTrim(request.getParameter("moTa"));

            // validation
            if (soPhong.isEmpty()) {
                session.setAttribute("error", "Số phòng không được để trống.");
                response.sendRedirect("rooms?action=list");
                return;
            }

            Room newRoom = new Room(soPhong, maLoaiPhong, trangThai, hinhAnh, moTa);
            boolean ok = rDAO.insert(newRoom);
            if (ok) {
                session.setAttribute("success", "Thêm phòng thành công.");
            } else {
                session.setAttribute("error", "Thêm phòng thất bại. Kiểm tra log server.");
            }

            response.sendRedirect("rooms?action=list");
        } catch (Exception ex) {
            ex.printStackTrace();
            session.setAttribute("error", "Có lỗi khi thêm phòng: " + ex.getMessage());
            response.sendRedirect("rooms?action=list");
        }
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int maPhong = parseIntOrDefault(request.getParameter("maPhong"), -1);
            if (maPhong <= 0) {
                session.setAttribute("error", "Mã phòng không hợp lệ.");
                response.sendRedirect("rooms?action=list");
                return;
            }

            String soPhong = safeTrim(request.getParameter("soPhong"));
            int maLoaiPhong = parseIntOrDefault(request.getParameter("maLoaiPhong"), 0);
            String trangThai = safeTrim(request.getParameter("trangThai"));
            String hinhAnh = safeTrim(request.getParameter("hinhAnh"));
            String moTa = safeTrim(request.getParameter("moTa"));

            if (soPhong.isEmpty()) {
                session.setAttribute("error", "Số phòng không được để trống.");
                response.sendRedirect("rooms?action=showEdit&maPhong=" + maPhong);
                return;
            }

            Room update = new Room(maPhong, soPhong, maLoaiPhong, trangThai, hinhAnh, moTa);
            boolean ok = rDAO.update(update);
            if (ok) {
                session.setAttribute("success", "Cập nhật phòng thành công.");
            } else {
                session.setAttribute("error", "Cập nhật thất bại. Có thể phòng không tồn tại.");
            }

            response.sendRedirect("rooms?action=list");
        } catch (Exception ex) {
            ex.printStackTrace();
            session.setAttribute("error", "Có lỗi khi cập nhật: " + ex.getMessage());
            response.sendRedirect("rooms?action=list");
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int maPhong = parseIntOrDefault(request.getParameter("maPhong"), -1);
            if (maPhong <= 0) {
                session.setAttribute("error", "Mã phòng không hợp lệ.");
                response.sendRedirect("rooms?action=list");
                return;
            }

            boolean ok = rDAO.delete(maPhong);
            if (ok) {
                session.setAttribute("success", "Xóa phòng thành công.");
            } else {
                session.setAttribute("error", "Xóa phòng thất bại. Kiểm tra ràng buộc FK hoặc log.");
            }

            response.sendRedirect("rooms?action=list");
        } catch (Exception ex) {
            ex.printStackTrace();
            session.setAttribute("error", "Có lỗi khi xóa: " + ex.getMessage());
            response.sendRedirect("rooms?action=list");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet quản lý phòng - PRG, validation, flash message.";
    }
}
