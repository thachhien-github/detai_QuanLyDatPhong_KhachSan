// File: controller/PhongServlet.java
package controller;

import dao.PhongDAO;
import model.LoaiPhong;
import model.Phong;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "PhongServlet", urlPatterns = {"/roomindex"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 20 * 1024 * 1024
)
public class PhongServlet extends HttpServlet {

    private PhongDAO phongDAO;

    @Override
    public void init() throws ServletException {
        phongDAO = new PhongDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy danh sách phòng và loại phòng từ DB
            List<Phong> rooms = phongDAO.getAll();
            List<LoaiPhong> roomTypes = phongDAO.getAllRoomTypes();

            // GÁN ATTRIBUTE THEO TÊN MÀ JSP ĐANG DÙNG: "phong"
            request.setAttribute("phong", rooms);
            request.setAttribute("roomTypes", roomTypes);

            // forward tới JSP (đường dẫn giữ y như project của bạn)
            request.getRequestDispatcher("/jsp/room/roomindex.jsp").forward(request, response);

        } catch (SQLException e) {
            // log và forward lỗi để JSP hiển thị thông báo
            e.printStackTrace();
            request.setAttribute("error", "Lỗi truy xuất danh sách phòng: " + e.getMessage());
            request.getRequestDispatcher("/jsp/room/roomindex.jsp").forward(request, response);
        }
    }

    // Nếu bạn muốn hỗ trợ POST (ví dụ upload/sửa), có thể implement doPost ở đây.
}
