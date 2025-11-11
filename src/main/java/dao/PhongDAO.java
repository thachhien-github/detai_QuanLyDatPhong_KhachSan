// PhongDAO.java
package dao;

import model.Phong;
import model.LoaiPhong;
import utils.DBConnection; // file DBConnection của bạn
import java.sql.*;
import java.util.*;
import java.math.BigDecimal;

public class PhongDAO {

    public PhongDAO() {
    }

    // Lấy tất cả phòng
    public List<Phong> getAll() throws SQLException {
        String sql = "SELECT p.maPhong, p.maLoaiPhong, lp.tenLoaiPhong, lp.donGia, "
                + "p.trangThai, p.moTa, p.hinhAnh "
                + "FROM Phong p "
                + "JOIN LoaiPhong lp ON p.maLoaiPhong = lp.maLoaiPhong "
                + "ORDER BY p.maPhong";
        List<Phong> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Phong p = new Phong();
                p.setMaPhong(rs.getString("maPhong"));
                p.setMaLoaiPhong(rs.getString("maLoaiPhong"));
                p.setTenLoaiPhong(rs.getString("tenLoaiPhong"));
                p.setDonGia(rs.getBigDecimal("donGia"));
                p.setTrangThai(rs.getString("trangThai"));
                p.setMoTa(rs.getString("moTa"));
                p.setHinhAnh(rs.getString("hinhAnh"));
                list.add(p);
            }
        }
        return list;
    }

    public boolean add(Phong p) throws SQLException {
        String sql = "INSERT INTO Phong(maPhong, maLoaiPhong, trangThai, moTa, hinhAnh) "
                + "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getMaPhong());
            ps.setString(2, p.getMaLoaiPhong());
            ps.setString(3, p.getTrangThai());
            ps.setString(4, p.getMoTa());
            ps.setString(5, p.getHinhAnh());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean update(Phong p) throws SQLException {
        String sql = "UPDATE Phong SET maLoaiPhong=?, trangThai=?, moTa=?, hinhAnh=? "
                + "WHERE maPhong=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getMaLoaiPhong());
            ps.setString(2, p.getTrangThai());
            ps.setString(3, p.getMoTa());
            ps.setString(4, p.getHinhAnh());
            ps.setString(5, p.getMaPhong());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(String maPhong) throws SQLException {
        String sql = "DELETE FROM Phong WHERE maPhong=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, maPhong);
            return ps.executeUpdate() > 0;
        }
    }

    public List<LoaiPhong> getAllRoomTypes() throws SQLException {
        String sql = "SELECT * FROM LoaiPhong";
        List<LoaiPhong> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                LoaiPhong lp = new LoaiPhong();
                lp.setMaLoaiPhong(rs.getString("maLoaiPhong"));
                lp.setTenLoaiPhong(rs.getString("tenLoaiPhong"));
                lp.setDonGia(rs.getBigDecimal("donGia"));
                lp.setMoTa(rs.getString("moTa"));
                list.add(lp);
            }
        }
        return list;
    }

    public int countAll(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Phong";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

}
