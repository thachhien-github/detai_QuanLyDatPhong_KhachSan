package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Room;
import utils.DBConnection;

public class RoomDAO {

    private static final String SQL_SELECT_ALL
            = "SELECT p.MaPhong, p.MaLoaiPhong, lp.TenLoaiPhong, p.TrangThai, p.HinhAnh, p.MoTa "
            + "FROM Phong p JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong "
            + "ORDER BY p.MaPhong";

    private static final String SQL_SELECT_BY_ID
            = "SELECT p.MaPhong, p.MaLoaiPhong, lp.TenLoaiPhong, p.TrangThai, p.HinhAnh, p.MoTa "
            + "FROM Phong p JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong "
            + "WHERE p.MaPhong = ?";

    private static final String SQL_INSERT
            = "INSERT INTO Phong (MaPhong, MaLoaiPhong, TrangThai, HinhAnh, MoTa) VALUES (?, ?, ?, ?, ?)";

    private static final String SQL_UPDATE
            = "UPDATE Phong SET MaLoaiPhong = ?, TrangThai = ?, HinhAnh = ?, MoTa = ? WHERE MaPhong = ?";

    private static final String SQL_DELETE
            = "DELETE FROM Phong WHERE MaPhong = ?";

    public List<Room> getAll() throws SQLException {
        List<Room> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(SQL_SELECT_ALL); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public Room findById(String maPhong) throws SQLException {
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(SQL_SELECT_BY_ID)) {

            ps.setString(1, maPhong);
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

            ps.setString(1, room.getMaPhong());
            ps.setString(2, room.getMaLoaiPhong());
            ps.setString(3, room.getTrangThai());
            ps.setString(4, room.getHinhAnh());
            ps.setString(5, room.getMoTa());

            return ps.executeUpdate() > 0;
        }
    }

    public boolean update(Room room) throws SQLException {
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(SQL_UPDATE)) {

            ps.setString(1, room.getMaLoaiPhong());
            ps.setString(2, room.getTrangThai());
            ps.setString(3, room.getHinhAnh());
            ps.setString(4, room.getMoTa());
            ps.setString(5, room.getMaPhong());

            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(String maPhong) throws SQLException {
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(SQL_DELETE)) {

            ps.setString(1, maPhong);
            return ps.executeUpdate() > 0;
        }
    }

    private Room mapRow(ResultSet rs) throws SQLException {
        Room r = new Room();
        r.setMaPhong(rs.getString("MaPhong"));
        r.setMaLoaiPhong(rs.getString("MaLoaiPhong"));
        r.setTenLoaiPhong(rs.getString("TenLoaiPhong")); // <--- lấy tên loại phòng
        r.setTrangThai(rs.getString("TrangThai"));
        r.setHinhAnh(rs.getString("HinhAnh"));
        r.setMoTa(rs.getString("MoTa"));
        return r;
    }
}
