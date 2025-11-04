package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import utils.DBConnection;

@WebServlet(name = "AuthServlet", urlPatterns = {"/auth"})
public class AuthServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String redirectPage = "/login.jsp"; // Mặc định quay về login nếu lỗi

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT MaNhanVien, HoTen, ChucVu FROM NhanVien WHERE TenDangNhap = ? AND MatKhau = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, username);
                ps.setString(2, password);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        int maNhanVien = rs.getInt("MaNhanVien");
                        String hoTen = rs.getString("HoTen");
                        String chucVu = rs.getString("ChucVu");

                        session.removeAttribute("error");

                        session.setAttribute("maNhanVien", maNhanVien); // ✅ thêm
                        session.setAttribute("user", hoTen);
                        session.setAttribute("role", chucVu);
                        session.setAttribute("success", "Đăng nhập thành công!");

                        redirectPage = "/jsp/admin/dashboard.jsp";
                    } else {
                        session.removeAttribute("success");
                        session.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            session.removeAttribute("success");
            session.setAttribute("error", "Lỗi kết nối cơ sở dữ liệu!");
        } catch (Exception e) {
            e.printStackTrace();
            session.removeAttribute("success");
            session.setAttribute("error", "Lỗi hệ thống, vui lòng thử lại!");
        }

        response.sendRedirect(request.getContextPath() + redirectPage);
    }
}
