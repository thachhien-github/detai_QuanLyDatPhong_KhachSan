package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Room;
import model.RoomType;
import utils.DBConnection;

public class RoomDAO {

    public List<Room> getAll() {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT p.maPhong, p.tenPhong, p.maLoai, p.gia, p.tinhTrang, p.hinhAnh, "
                + "lp.tenLoai, lp.moTa "
                + "FROM Phong p "
                + "JOIN LoaiPhong lp ON p.maLoai = lp.maLoai";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Room room = new Room(
                        rs.getInt("maPhong"),
                        rs.getString("tenPhong"),
                        rs.getInt("maLoai"),
                        rs.getDouble("gia"),
                        rs.getString("tinhTrang"),
                        rs.getString("hinhAnh")
                );
                list.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
