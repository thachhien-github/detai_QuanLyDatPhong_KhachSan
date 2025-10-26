// dao/StayDAO.java  (ghi LuuTru)
package dao;
import model.Stay;
import utils.DBConnection;
import java.sql.*;

public class StayDAO {
    public int insert(Stay s) throws SQLException {
        String sql = "INSERT INTO LuuTru (MaDatPhong, MaNhanVien, CCCDKhach, GioCheckIn, GhiChu) VALUES (?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, s.getMaDatPhong());
            ps.setInt(2, s.getMaNhanVien());
            ps.setString(3, s.getCccd());
            ps.setTimestamp(4, Timestamp.valueOf(s.getGioCheckIn()));
            ps.setString(5, s.getGhiChu());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return -1;
    }

    public void updateCheckOut(int maLuuTru) throws SQLException {
        String sql = "UPDATE LuuTru SET GioCheckOut = GETDATE() WHERE MaLuuTru = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, maLuuTru);
            ps.executeUpdate();
        }
    }

    public Stay findByBooking(int maDatPhong) throws SQLException {
        String sql = "SELECT * FROM LuuTru WHERE MaDatPhong = ? AND GioCheckOut IS NULL";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, maDatPhong);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Stay s = new Stay();
                    s.setMaLuuTru(rs.getInt("MaLuuTru"));
                    s.setMaDatPhong(rs.getInt("MaDatPhong"));
                    s.setMaNhanVien(rs.getInt("MaNhanVien"));
                    s.setCccd(rs.getString("CCCDKhach"));
                    s.setGioCheckIn(rs.getTimestamp("GioCheckIn").toLocalDateTime());
                    return s;
                }
            }
        }
        return null;
    }
}
