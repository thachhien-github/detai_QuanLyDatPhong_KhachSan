package controller;

import dao.RoomDAO;
import model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "RoomServlet", urlPatterns = {"/rooms"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 5 * 1024 * 1024, // 5MB
        maxRequestSize = 10 * 1024 * 1024)
public class RoomServlet extends HttpServlet {

    private RoomDAO rDAO;

    @Override
    public void init() throws ServletException {
        rDAO = new RoomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            if ("edit".equalsIgnoreCase(action)) {
                showEditForm(request, response);
            } else if ("new".equalsIgnoreCase(action)) {
                showNewForm(request, response);
            } else {
                listRooms(request, response);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Đặt charset để nhận đúng tiếng Việt
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        HttpSession session = request.getSession();
        try {
            switch (action) {
                case "insert":
                    handleInsert(request, session);
                    break;
                case "update":
                    handleUpdate(request, session);
                    break;
                case "delete":
                    handleDelete(request, session);
                    break;
                default:
                    break;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            session.setAttribute("error", "Lỗi: " + ex.getMessage());
        }

        // redirect về list (dùng context path cho chính xác)
        response.sendRedirect(request.getContextPath() + "/rooms");
    }

    private void listRooms(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Room> rooms = rDAO.getAll();
        request.setAttribute("rooms", rooms);

        // Tĩnh ví dụ, bạn có thể lấy từ DB
        String[] loaiPhongs = {"LP01", "LP02", "LP03"};
        request.setAttribute("loaiPhongs", loaiPhongs);

        // Lấy message từ session (và xóa) để show 1 lần
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object success = session.getAttribute("success");
            Object error = session.getAttribute("error");
            if (success != null) {
                request.setAttribute("success", success);
                session.removeAttribute("success");
            }
            if (error != null) {
                request.setAttribute("error", error);
                session.removeAttribute("error");
            }
        }

        request.getRequestDispatcher("/jsp/room/roomList.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // dữ liệu dropdown, etc.
        String[] loaiPhongs = {"LP01", "LP02", "LP03"};
        request.setAttribute("loaiPhongs", loaiPhongs);
        request.getRequestDispatcher("/jsp/room/roomForm.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String maPhong = request.getParameter("id");
        if (maPhong == null) {
            response.sendRedirect(request.getContextPath() + "/rooms");
            return;
        }
        Room room = rDAO.findById(maPhong);
        if (room == null) {
            request.getSession().setAttribute("error", "Không tìm thấy phòng: " + maPhong);
            response.sendRedirect(request.getContextPath() + "/rooms");
            return;
        }
        request.setAttribute("room", room);
        String[] loaiPhongs = {"LP01", "LP02", "LP03"};
        request.setAttribute("loaiPhongs", loaiPhongs);
        request.getRequestDispatcher("/jsp/room/roomForm.jsp").forward(request, response);
    }

    private void handleInsert(HttpServletRequest request, HttpSession session) throws Exception {
        String maPhong = request.getParameter("maPhong");
        String maLoaiPhong = request.getParameter("maLoaiPhong");
        String trangThai = request.getParameter("trangThai");
        String moTa = request.getParameter("moTa");

        // Kiểm tra tồn tại
        if (rDAO.findById(maPhong) != null) {
            session.setAttribute("error", "Mã phòng đã tồn tại: " + maPhong);
            return;
        }

        String hinhAnh = saveUploadedFile(request.getPart("hinhAnh"), request, "default-room.jpg");

        Room room = new Room(maPhong, maLoaiPhong, "", trangThai, hinhAnh, moTa);
        boolean ok = rDAO.insert(room);
        session.setAttribute(ok ? "success" : "error", ok ? "Thêm phòng thành công!" : "Không thể thêm phòng.");
    }

    private void handleUpdate(HttpServletRequest request, HttpSession session) throws Exception {
        String maPhong = request.getParameter("maPhong");
        String maLoaiPhong = request.getParameter("maLoaiPhong");
        String trangThai = request.getParameter("trangThai");
        String moTa = request.getParameter("moTa");

        // lấy tên ảnh hiện tại từ hidden field nếu không upload file mới
        String currentHinh = request.getParameter("currentHinhAnh");
        String hinhAnh = saveUploadedFile(request.getPart("hinhAnh"), request, currentHinh != null ? currentHinh : "default-room.jpg");

        Room room = new Room(maPhong, maLoaiPhong, "", trangThai, hinhAnh, moTa);
        boolean ok = rDAO.update(room);
        session.setAttribute(ok ? "success" : "error", ok ? "Cập nhật phòng thành công!" : "Không thể cập nhật phòng.");
    }

    private void handleDelete(HttpServletRequest request, HttpSession session) throws Exception {
        String maPhong = request.getParameter("maPhong");
        boolean ok = rDAO.delete(maPhong);
        session.setAttribute(ok ? "success" : "error", ok ? "Xóa phòng thành công!" : "Không thể xóa phòng.");
    }

    /**
     * Lưu file upload vào webapp/uploads, trả về tên file được lưu (hoặc
     * fallbackName).
     */
    private String saveUploadedFile(Part filePart, HttpServletRequest request, String fallbackName) {
        try {
            if (filePart != null && filePart.getSize() > 0) {
                String submitted = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                // tạo tên file unique để tránh trùng
                String fileName = System.currentTimeMillis() + "_" + submitted;

                String uploadsPath = request.getServletContext().getRealPath("/uploads");
                if (uploadsPath == null) {
                    // fallback nếu container không cho realPath (nghiêm trọng nhưng hiếm)
                    uploadsPath = System.getProperty("java.io.tmpdir") + File.separator + "uploads";
                }
                File uploadsDir = new File(uploadsPath);
                if (!uploadsDir.exists()) {
                    uploadsDir.mkdirs();
                }

                File file = new File(uploadsDir, fileName);
                try (InputStream in = filePart.getInputStream()) {
                    Files.copy(in, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }
                return fileName;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return fallbackName;
    }
}
