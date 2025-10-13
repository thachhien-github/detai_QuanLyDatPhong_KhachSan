
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import model.Customer;
import utils.DBConnection;

public class CustomerDAO {
    public int insert(Customer c) {
        String sql = "INSERT INTO KhachHang (hoTen, sdt, email, diaChi) "
                   + "VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, c.getHoTen());
            ps.setString(2, c.getSdt());
            ps.setString(3, c.getEmail());
            ps.setString(4, c.getDiaChi());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Trả về maKH mới tạo
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}
