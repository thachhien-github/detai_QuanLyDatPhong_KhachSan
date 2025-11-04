package dao;

import model.LuuTru;
import model.DatPhong; // nếu có model DatPhong
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class LuuTruDAO {

    // Lấy danh sách LuuTru (có thể fetch cả khách info)
    public List<LuuTru> findAll(Connection conn) throws SQLException {
        String sql = "SELECT lt.MaLuuTru, lt.MaDatPhong, lt.CCCDKhach, lt.GioCheckIn, lt.GioCheckOut, lt.GhiChu, dp.MaPhong, kh.HoTen "
                + "FROM LuuTru lt "
                + "LEFT JOIN DatPhong dp ON lt.MaDatPhong = dp.MaDatPhong "
                + "LEFT JOIN KhachHang kh ON dp.MaKhachHang = kh.MaKhachHang "
                + "ORDER BY lt.GioCheckIn DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            List<LuuTru> list = new ArrayList<>();
            while (rs.next()) {
                LuuTru lt = new LuuTru();
                lt.setMaLuuTru(rs.getInt("MaLuuTru"));
                lt.setMaDatPhong(rs.getInt("MaDatPhong"));
                lt.setCccd(rs.getString("CCCDKhach"));
                Timestamp tIn = rs.getTimestamp("GioCheckIn");
                if (tIn != null) {
                    lt.setGioCheckIn(tIn);
                }
                Timestamp tOut = rs.getTimestamp("GioCheckOut");
                if (tOut != null) {
                    lt.setGioCheckOut(tOut);
                }
                lt.setGhiChu(rs.getString("GhiChu"));
                lt.setMaPhong(rs.getString("MaPhong"));
                lt.setHoTen(rs.getString("HoTen"));
                list.add(lt);
            }
            return list;
        }
    }

    /**
     * Tạo LuuTru (check-in). Caller phải quản lý transaction
     * (conn.setAutoCommit(false)). Thao tác: - Insert LuuTru (MaDatPhong,
     * MaNhanVien? -> ở đây giữ NULL hoặc lấy from session nếu cần) - Update
     * DatPhong.TrangThai hoặc Phong.TrangThai nếu cần.
     */
    public int createCheckIn(Connection conn, int maDatPhong, String cccd, String ghiChu, int maNhanVien) throws SQLException {
        String sql = "INSERT INTO LuuTru (MaDatPhong, MaNhanVien, CCCDKhach, GhiChu) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, maDatPhong);
            ps.setInt(2, maNhanVien);
            ps.setString(3, cccd);
            ps.setString(4, ghiChu);
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }

    /**
     * Check-out: cập nhật GioCheckOut = GETDATE(), cập nhật Phong.TrangThai =
     * 'Trống' Trả về true nếu thành công.
     */
    public boolean checkOut(Connection conn, int maLuuTru) throws SQLException {
        // 1) set GioCheckOut
        String updOut = "UPDATE LuuTru SET GioCheckOut = GETDATE() WHERE MaLuuTru = ? AND GioCheckOut IS NULL";
        try (PreparedStatement ps = conn.prepareStatement(updOut)) {
            ps.setInt(1, maLuuTru);
            int affected = ps.executeUpdate();
            if (affected == 0) {
                return false; // đã checkout trước đó hoặc không tồn tại
            }
        }

        // 2) lấy MaDatPhong để biết phòng -> update Phong
        String sel = "SELECT dp.MaPhong FROM LuuTru lt JOIN DatPhong dp ON lt.MaDatPhong = dp.MaDatPhong WHERE lt.MaLuuTru = ?";
        String maPhong = null;
        try (PreparedStatement ps = conn.prepareStatement(sel)) {
            ps.setInt(1, maLuuTru);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    maPhong = rs.getString("MaPhong");
                }
            }
        }

        if (maPhong != null) {
            String updPhong = "UPDATE Phong SET TrangThai = N'Trống' WHERE MaPhong = ?";
            try (PreparedStatement ps = conn.prepareStatement(updPhong)) {
                ps.setString(1, maPhong);
                ps.executeUpdate();
            }
        }

        return true;
    }

    // (optional) lấy LuuTru theo MaDatPhong (nếu cần)
    public LuuTru findByMaDatPhong(Connection conn, int maDatPhong) throws SQLException {
        String sql = "SELECT * FROM LuuTru WHERE MaDatPhong = ? ORDER BY GioCheckIn DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maDatPhong);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    LuuTru lt = new LuuTru();
                    lt.setMaLuuTru(rs.getInt("MaLuuTru"));
                    lt.setMaDatPhong(rs.getInt("MaDatPhong"));
                    lt.setCccd(rs.getString("CCCDKhach"));
                    lt.setGioCheckIn(rs.getTimestamp("GioCheckIn"));
                    lt.setGioCheckOut(rs.getTimestamp("GioCheckOut"));
                    lt.setGhiChu(rs.getString("GhiChu"));
                    return lt;
                }
            }
        }
        return null;
    }
}
