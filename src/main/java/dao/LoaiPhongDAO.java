package dao;

import model.LoaiPhong;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LoaiPhongDAO {

    public List<LoaiPhong> getAll() throws SQLException {
        List<LoaiPhong> list = new ArrayList<>();
        String sql = "SELECT MaLoaiPhong, TenLoaiPhong, DonGia, MoTa FROM LoaiPhong";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                LoaiPhong lp = new LoaiPhong();
                lp.setMaLoaiPhong(rs.getString("MaLoaiPhong"));
                lp.setTenLoaiPhong(rs.getString("TenLoaiPhong"));
                lp.setDonGia(rs.getBigDecimal("DonGia"));
                lp.setMoTa(rs.getString("MoTa"));
                list.add(lp);
            }
        }
        return list;
    }

    public LoaiPhong findById(String id) throws SQLException {
        String sql = "SELECT MaLoaiPhong, TenLoaiPhong, DonGia, MoTa FROM LoaiPhong WHERE MaLoaiPhong = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    LoaiPhong lp = new LoaiPhong();
                    lp.setMaLoaiPhong(rs.getString("MaLoaiPhong"));
                    lp.setTenLoaiPhong(rs.getString("TenLoaiPhong"));
                    lp.setDonGia(rs.getBigDecimal("DonGia"));
                    lp.setMoTa(rs.getString("MoTa"));
                    return lp;
                }
            }
        }
        return null;
    }

    public boolean insert(LoaiPhong lp) throws SQLException {
        String sql = "INSERT INTO LoaiPhong (MaLoaiPhong, TenLoaiPhong, DonGia, MoTa) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, lp.getMaLoaiPhong());
            ps.setString(2, lp.getTenLoaiPhong());
            ps.setBigDecimal(3, lp.getDonGia());
            ps.setString(4, lp.getMoTa());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean update(LoaiPhong lp) throws SQLException {
        String sql = "UPDATE LoaiPhong SET TenLoaiPhong=?, DonGia=?, MoTa=? WHERE MaLoaiPhong=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, lp.getTenLoaiPhong());
            ps.setBigDecimal(2, lp.getDonGia());
            ps.setString(3, lp.getMoTa());
            ps.setString(4, lp.getMaLoaiPhong());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(String id) throws SQLException {
        String sql = "DELETE FROM LoaiPhong WHERE MaLoaiPhong=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}
