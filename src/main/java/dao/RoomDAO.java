package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Room;
import utils.DBConnection; // Assumes you already have utils.DBConnection.getConnection()

public class RoomDAO {

// SQL statements
    private static final String SQL_SELECT_ALL = "SELECT MaPhong, SoPhong, MaLoaiPhong, TrangThai, HinhAnh, MoTa FROM Phong ORDER BY MaPhong";
    private static final String SQL_SELECT_BY_ID = "SELECT MaPhong, SoPhong, MaLoaiPhong, TrangThai, HinhAnh, MoTa FROM Phong WHERE MaPhong = ?";
    private static final String SQL_INSERT = "INSERT INTO Phong (SoPhong, MaLoaiPhong, TrangThai, HinhAnh, MoTa) VALUES (?, ?, ?, ?, ?)";
    private static final String SQL_UPDATE = "UPDATE Phong SET SoPhong = ?, MaLoaiPhong = ?, TrangThai = ?, HinhAnh = ?, MoTa = ? WHERE MaPhong = ?";
    private static final String SQL_DELETE = "DELETE FROM Phong WHERE MaPhong = ?";

    public List<Room> getAll() throws SQLException {
        List<Room> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(SQL_SELECT_ALL); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Room r = mapRow(rs);
                list.add(r);
            }
        }
        return list;
    }

    public Room findById(int id) throws SQLException {
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(SQL_SELECT_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        }
        return null;
    }

    public boolean insert(Room room) throws SQLException {
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(SQL_INSERT)) {
            ps.setString(1, room.getSoPhong());
            ps.setInt(2, room.getMaLoaiPhong());
            ps.setString(3, room.getTrangThai());
            ps.setString(4, room.getHinhAnh());
            ps.setString(5, room.getMoTa());
            int affected = ps.executeUpdate();
            return affected > 0;
        }
    }

    public boolean update(Room room) throws SQLException {
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(SQL_UPDATE)) {
            ps.setString(1, room.getSoPhong());
            ps.setInt(2, room.getMaLoaiPhong());
            ps.setString(3, room.getTrangThai());
            ps.setString(4, room.getHinhAnh());
            ps.setString(5, room.getMoTa());
            ps.setInt(6, room.getMaPhong());
            int affected = ps.executeUpdate();
            return affected > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(SQL_DELETE)) {
            ps.setInt(1, id);
            int affected = ps.executeUpdate();
            return affected > 0;
        }
    }

    private Room mapRow(ResultSet rs) throws SQLException {
        Room r = new Room();
        r.setMaPhong(rs.getInt("MaPhong"));
        r.setSoPhong(rs.getString("SoPhong"));
        r.setMaLoaiPhong(rs.getInt("MaLoaiPhong"));
        r.setTrangThai(rs.getString("TrangThai"));
        r.setHinhAnh(rs.getString("HinhAnh"));
        r.setMoTa(rs.getString("MoTa"));
        return r;
    }
}
