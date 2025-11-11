package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
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
    
    // Lấy danh sách (tìm kiếm theo q nếu có)
    public List<NhanVien> findAll(Connection conn, String q) throws SQLException {
        String sql = "SELECT MaNhanVien, HoTen, TenDangNhap, ChucVu, TrangThai FROM NhanVien";
        if (q != null && !q.trim().isEmpty()) {
            sql += " WHERE HoTen LIKE ? OR TenDangNhap LIKE ?";
        }
        sql += " ORDER BY MaNhanVien DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            if (q != null && !q.trim().isEmpty()) {
                String p = "%" + q.trim() + "%";
                ps.setString(1, p);
                ps.setString(2, p);
            }
            try (ResultSet rs = ps.executeQuery()) {
                List<NhanVien> res = new ArrayList<>();
                while (rs.next()) {
                    NhanVien nv = new NhanVien();
                    nv.setMaNhanVien(rs.getInt("MaNhanVien"));
                    nv.setHoTen(rs.getString("HoTen"));
                    nv.setTenDangNhap(rs.getString("TenDangNhap"));
                    nv.setChucVu(rs.getString("ChucVu"));
                    nv.setTrangThai(rs.getString("TrangThai"));
                    res.add(nv);
                }
                return res;
            }
        }
    }

    // Tạo mới (matKhau là plain text ở đây để tương thích DB mẫu)
    public int create(Connection conn, NhanVien nv) throws SQLException {
        String sql = "INSERT INTO NhanVien (HoTen, TenDangNhap, MatKhau, ChucVu, TrangThai) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, nv.getHoTen());
            ps.setString(2, nv.getTenDangNhap());
            ps.setString(3, nv.getMatKhau()); // plain or hashed
            ps.setString(4, nv.getChucVu());
            ps.setString(5, nv.getTrangThai() == null ? "Hoạt động" : nv.getTrangThai());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return -1;
    }

    // Update (không đổi mật khẩu)
    public boolean update(Connection conn, NhanVien nv) throws SQLException {
        String sql = "UPDATE NhanVien SET HoTen = ?, TenDangNhap = ?, ChucVu = ?, TrangThai = ? WHERE MaNhanVien = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nv.getHoTen());
            ps.setString(2, nv.getTenDangNhap());
            ps.setString(3, nv.getChucVu());
            ps.setString(4, nv.getTrangThai());
            ps.setInt(5, nv.getMaNhanVien());
            return ps.executeUpdate() > 0;
        }
    }

    // Delete
    public boolean delete(Connection conn, int maNhanVien) throws SQLException {
        String sql = "DELETE FROM NhanVien WHERE MaNhanVien = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maNhanVien);
            return ps.executeUpdate() > 0;
        }
    }

    // (Hỗ trợ) kiểm tra username tồn tại (dùng khi tạo/sửa)
    public boolean existsUsername(Connection conn, String username, Integer excludeId) throws SQLException {
        String sql = "SELECT 1 FROM NhanVien WHERE TenDangNhap = ?";
        if (excludeId != null) sql += " AND MaNhanVien <> ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            if (excludeId != null) ps.setInt(2, excludeId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }
}
