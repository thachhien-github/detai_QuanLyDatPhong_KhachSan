package dao;

import model.LoaiPhong;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class LoaiPhongDAO {

    private static final String SQL_SELECT_ALL = "SELECT MaLoaiPhong, TenLoaiPhong, DonGia, MoTa FROM LoaiPhong ORDER BY MaLoaiPhong";
    private static final String SQL_SELECT_BY_ID = "SELECT MaLoaiPhong, TenLoaiPhong, DonGia, MoTa FROM LoaiPhong WHERE MaLoaiPhong = ?";
    private static final String SQL_INSERT = "INSERT INTO LoaiPhong (MaLoaiPhong, TenLoaiPhong, DonGia, MoTa) VALUES (?, ?, ?, ?)";
    private static final String SQL_UPDATE = "UPDATE LoaiPhong SET TenLoaiPhong = ?, DonGia = ?, MoTa = ? WHERE MaLoaiPhong = ?";
    private static final String SQL_DELETE = "DELETE FROM LoaiPhong WHERE MaLoaiPhong = ?";

    public List<LoaiPhong> getAll() throws SQLException {
        List<LoaiPhong> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public LoaiPhong findById(String maLoai) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_BY_ID)) {

            ps.setString(1, maLoai);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public boolean insert(LoaiPhong lp) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_INSERT)) {

            ps.setString(1, lp.getMaLoaiPhong());
            ps.setString(2, lp.getTenLoaiPhong());
            ps.setBigDecimal(3, lp.getDonGia() != null ? lp.getDonGia() : BigDecimal.ZERO);
            ps.setString(4, lp.getMoTa());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean update(LoaiPhong lp) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_UPDATE)) {

            ps.setString(1, lp.getTenLoaiPhong());
            ps.setBigDecimal(2, lp.getDonGia() != null ? lp.getDonGia() : BigDecimal.ZERO);
            ps.setString(3, lp.getMoTa());
            ps.setString(4, lp.getMaLoaiPhong());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(String maLoai) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_DELETE)) {
            ps.setString(1, maLoai);
            return ps.executeUpdate() > 0;
        }
    }

    private LoaiPhong mapRow(ResultSet rs) throws SQLException {
        LoaiPhong lp = new LoaiPhong();
        lp.setMaLoaiPhong(rs.getString("MaLoaiPhong"));
        lp.setTenLoaiPhong(rs.getString("TenLoaiPhong"));
        lp.setDonGia(rs.getBigDecimal("DonGia"));
        lp.setMoTa(rs.getString("MoTa"));
        return lp;
    }
}
