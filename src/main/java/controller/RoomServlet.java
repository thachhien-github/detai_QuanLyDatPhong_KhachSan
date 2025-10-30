package controller;

import dao.PhongDAO;
import model.Phong;
import model.LoaiPhong;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.math.BigDecimal;
import java.nio.file.*;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "RoomServlet", urlPatterns = {"/rooms-list"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 20 * 1024 * 1024
)
public class RoomServlet extends HttpServlet {

    private PhongDAO phongDAO;

    @Override
    public void init() throws ServletException {
        phongDAO = new PhongDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Phong> rooms = phongDAO.getAll();
            List<LoaiPhong> roomTypes = phongDAO.getAllRoomTypes();
            request.setAttribute("rooms", rooms); // Đồng bộ với JSP
            request.setAttribute("roomTypes", roomTypes);
            request.getRequestDispatcher("/jsp/room/roomList.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi truy xuất dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/jsp/room/roomList.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/rooms-list");
            return;
        }

        switch (action) {
            case "add":
                handleAdd(request, response);
                break;
            case "update":
                handleUpdate(request, response);
                break;
            case "delete":
                handleDelete(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/rooms-list");
        }
    }

    // RoomServlet.java (chỉ phần method)
    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String maPhong = request.getParameter("maPhong");
        String maLoaiPhong = request.getParameter("maLoaiPhong");
        String trangThai = request.getParameter("trangThai");
        String moTa = request.getParameter("moTa");
        String hinhAnh = null;
        try {
            hinhAnh = uploadFile(request.getPart("hinhAnh"), request);
        } catch (ServletException ex) {
            ex.printStackTrace();
        }

        Phong p = new Phong();
        p.setMaPhong(maPhong);
        p.setMaLoaiPhong(maLoaiPhong);
        p.setTrangThai(trangThai);
        p.setMoTa(moTa);
        // KHÔNG setDonGia ở đây vì giá lấy từ LoaiPhong khi hiển thị/ truy vấn JOIN
        p.setHinhAnh(hinhAnh);

        try {
            boolean success = phongDAO.add(p);
            if (success) {
                request.getSession().setAttribute("success", "Thêm phòng thành công!");
            } else {
                request.getSession().setAttribute("error", "Thêm phòng thất bại!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi SQL: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/rooms-list");
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String maPhong = request.getParameter("maPhong");
        String maLoaiPhong = request.getParameter("maLoaiPhong");
        String trangThai = request.getParameter("trangThai");
        String moTa = request.getParameter("moTa");
        String currentHinh = request.getParameter("currentHinhAnh");
        String newHinh = uploadFile(request.getPart("hinhAnh"), request);
        String hinhAnh = (newHinh != null && !newHinh.isEmpty()) ? newHinh : currentHinh;

        Phong p = new Phong();
        p.setMaPhong(maPhong);
        p.setMaLoaiPhong(maLoaiPhong);
        p.setTrangThai(trangThai);
        p.setMoTa(moTa);
        // KHÔNG setDonGia ở đây
        p.setHinhAnh(hinhAnh);

        try {
            boolean success = phongDAO.update(p);
            if (success) {
                request.getSession().setAttribute("success", "Cập nhật phòng thành công!");
            } else {
                request.getSession().setAttribute("error", "Cập nhật phòng thất bại!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi SQL: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/rooms-list");
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String maPhong = request.getParameter("maPhong");
        try {
            boolean success = phongDAO.delete(maPhong);
            if (success) {
                request.getSession().setAttribute("success", "Xóa phòng thành công!");
            } else {
                request.getSession().setAttribute("error", "Xóa phòng thất bại!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi SQL: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/rooms-list");
    }

    private String uploadFile(Part part, HttpServletRequest request) throws IOException {
        if (part == null || part.getSize() == 0) {
            return null;
        }

        String originalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        String ext = originalFileName.contains(".") ? originalFileName.substring(originalFileName.lastIndexOf(".")) : "";
        String fileName = System.currentTimeMillis() + ext; // đổi tên theo timestamp
        String uploadPath = request.getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        part.write(uploadPath + File.separator + fileName);
        return fileName;
    }
}
