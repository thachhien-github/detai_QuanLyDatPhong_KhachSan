package dao;

import java.sql.*;
import model.NhanVien;
import utils.DBConnection;

public class NhanVienDAO {

    public NhanVien login(String username, String password) throws SQLException {
        String sql = "SELECT * FROM NhanVien WHERE TenDangNhap = ? AND MatKhau = ? AND TrangThai = N'Hoạt động'";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new NhanVien(
                            rs.getInt("MaNhanVien"),
                            rs.getString("HoTen"),
                            rs.getString("TenDangNhap"),
                            rs.getString("MatKhau"),
                            rs.getString("ChucVu"),
                            rs.getString("TrangThai")
                    );
                }
            }
        }
        return null;
    }
}
