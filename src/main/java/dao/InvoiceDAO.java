// dao/InvoiceDAO.java
package dao;
import model.Invoice;
import utils.DBConnection;
import java.sql.*;

public class InvoiceDAO {
    public int create(Invoice inv) throws SQLException {
        String sql = "INSERT INTO HoaDon (MaLuuTru, MaNhanVien, NgayLap, TongTien, GhiChu) VALUES (?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, inv.getMaLuuTru());
            ps.setInt(2, inv.getMaNhanVien());
            ps.setTimestamp(3, Timestamp.valueOf(inv.getNgayLap()));
            ps.setBigDecimal(4, inv.getTongTien());
            ps.setString(5, inv.getGhiChu());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return -1;
    }
}
