// dao/CustomerDAO.java
package dao;

import model.Customer;
import utils.DBConnection;
import java.sql.*;

public class CustomerDAO {

    public int insert(Customer c) throws SQLException {
        String sql = "INSERT INTO KhachHang (HoTen, SoDienThoai, Email, CCCD, DiaChi) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, c.getHoTen());
            ps.setString(2, c.getSoDienThoai());
            ps.setString(3, c.getEmail());
            ps.setString(4, c.getCccd());
            ps.setString(5, c.getDiaChi());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }

    // Tùy chọn: tìm theo sđt để tránh duplicate
    public Customer findByPhone(String phone) throws SQLException {
        String sql = "SELECT * FROM KhachHang WHERE SoDienThoai = ?";
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, phone);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Customer k = new Customer();
                    k.setMaKhachHang(rs.getInt("MaKhachHang"));
                    k.setHoTen(rs.getString("HoTen"));
                    k.setSoDienThoai(rs.getString("SoDienThoai"));
                    k.setEmail(rs.getString("Email"));
                    k.setCccd(rs.getString("CCCD"));
                    k.setDiaChi(rs.getString("DiaChi"));
                    return k;
                }
            }
        }
        return null;
    }

    public void updateCccd(int maKh, String cccd) throws SQLException {
        String sql = "UPDATE KhachHang SET CCCD = ? WHERE MaKhachHang = ?";
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, cccd);
            ps.setInt(2, maKh);
            ps.executeUpdate();
        }
    }
}
