
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
        String sql = "SELECT p.*, lp.tenLoai, lp.moTa FROM Phong p "
                   + "JOIN LoaiPhong lp ON p.maLoai = lp.maLoai";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                RoomType rt = new RoomType(
                    rs.getInt("maLoai"),
                    rs.getString("tenLoai"),
                    rs.getString("moTa")
                );

                Room room = new Room(
                    rs.getInt("maPhong"),
                    rs.getString("tenPhong"),
                    rt,
                    rs.getDouble("gia"),
                    rs.getString("tinhTrang")
                );

                list.add(room);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
