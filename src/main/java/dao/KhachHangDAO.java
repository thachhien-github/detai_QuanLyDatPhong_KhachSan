package dao;

import model.KhachHang;
import utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class KhachHangDAO {

    public List<KhachHang> getAll() {
        List<KhachHang> list = new ArrayList<>();
        String sql = "SELECT * FROM KhachHang";

        try (Connection conn = DBConnection.getConnection(); Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                KhachHang kh = new KhachHang();
                kh.setMaKhachHang(rs.getInt("MaKhachHang"));
                kh.setHoTen(rs.getString("HoTen"));
                kh.setSoDienThoai(rs.getString("SoDienThoai"));
                kh.setEmail(rs.getString("Email"));
                kh.setCccd(rs.getString("CCCD"));
                kh.setDiaChi(rs.getString("DiaChi"));
                list.add(kh);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách khách hàng: " + e.getMessage());
        }
        return list;
    }

    public boolean insert(KhachHang kh) {
        String sql = "INSERT INTO KhachHang (HoTen, SoDienThoai, Email, CCCD, DiaChi) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, kh.getHoTen());
            ps.setString(2, kh.getSoDienThoai());
            ps.setString(3, kh.getEmail());
            ps.setString(4, kh.getCccd());
            ps.setString(5, kh.getDiaChi());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm khách hàng: " + e.getMessage());
            return false;
        }
    }
}
