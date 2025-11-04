package dao;

import model.KhachHang;
import utils.DBConnection;

import java.sql.*;
import java.util.*;

public class KhachHangDAO {

    public List<KhachHang> getAll() {
        List<KhachHang> list = new ArrayList<>();
        String sql = "SELECT * FROM KhachHang";

        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new KhachHang(
                        rs.getInt("MaKhachHang"),
                        rs.getString("HoTen"),
                        rs.getString("SoDienThoai"),
                        rs.getString("Email"),
                        rs.getString("CCCD"),
                        rs.getString("DiaChi")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insert(KhachHang kh) {
        String sql = "INSERT INTO KhachHang(HoTen, SoDienThoai, Email, CCCD, DiaChi) VALUES (?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, kh.getHoTen());
            ps.setString(2, kh.getSoDienThoai());
            ps.setString(3, kh.getEmail());
            ps.setString(4, kh.getCccd());
            ps.setString(5, kh.getDiaChi());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(KhachHang kh) {
        String sql = "UPDATE KhachHang SET HoTen=?, SoDienThoai=?, Email=?, CCCD=?, DiaChi=? WHERE MaKhachHang=?";
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, kh.getHoTen());
            ps.setString(2, kh.getSoDienThoai());
            ps.setString(3, kh.getEmail());
            ps.setString(4, kh.getCccd());
            ps.setString(5, kh.getDiaChi());
            ps.setInt(6, kh.getMaKhachHang());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM KhachHang WHERE MaKhachHang=?";
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Lấy MaKhachHang theo số điện thoại nếu tồn tại, nếu chưa có thì tạo mới
     * và trả về id mới. Trả về -1 nếu có lỗi.
     */
    public int layHoacTaoKhachHang(String ten, String sdt, String email) {
        if (sdt == null || sdt.trim().isEmpty()) {
            System.out.println("[KhachHangDAO] SoDienThoai trống");
            return -1;
        }

        try (Connection con = DBConnection.getConnection()) {
            // kiểm tra khách đã tồn tại chưa (sử dụng cột SoDienThoai)
            String check = "SELECT MaKhachHang FROM KhachHang WHERE SoDienThoai = ?";
            try (PreparedStatement ps = con.prepareStatement(check)) {
                ps.setString(1, sdt);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        int existingId = rs.getInt("MaKhachHang");
                        System.out.println("[KhachHangDAO] Khách đã tồn tại, MaKhachHang=" + existingId);
                        return existingId;
                    }
                }
            }

            // chưa có → tạo mới, trả về generated key
            String insert = "INSERT INTO KhachHang(HoTen, SoDienThoai, Email) VALUES (?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, ten);
                ps.setString(2, sdt);
                ps.setString(3, email);
                int rows = ps.executeUpdate();
                if (rows > 0) {
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) {
                            int newId = rs.getInt(1);
                            System.out.println("[KhachHangDAO] Tạo khách hàng mới MaKhachHang=" + newId);
                            return newId;
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

}
