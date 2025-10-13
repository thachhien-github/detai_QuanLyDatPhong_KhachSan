package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Booking;
import model.Customer;
import model.Room;
import utils.DBConnection;

public class BookingDAO {

    public List<Booking> getAll() {
        List<Booking> list = new ArrayList<>();

        String sql = "SELECT dp.maDP, dp.ngayDat, dp.ngayNhan, dp.ngayTra, dp.trangThai, "
                + "kh.maKH, kh.hoTen, kh.sdt, kh.email, kh.diaChi, "
                + "p.maPhong, p.tenPhong "
                + "FROM DatPhong dp "
                + "JOIN KhachHang kh ON dp.maKH = kh.maKH "
                + "JOIN Phong p ON dp.maPhong = p.maPhong";

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Booking b = new Booking();
                b.setMaDP(rs.getInt("maDP"));
                b.setNgayDat(rs.getDate("ngayDat"));
                b.setNgayNhan(rs.getDate("ngayNhan"));
                b.setNgayTra(rs.getDate("ngayTra"));
                b.setTrangThai(rs.getString("trangThai"));

                Customer c = new Customer();
                c.setMaKH(rs.getInt("maKH"));
                c.setHoTen(rs.getString("hoTen"));
                c.setSdt(rs.getString("sdt"));
                c.setEmail(rs.getString("email"));
                c.setDiaChi(rs.getString("diaChi"));
                b.setCustomer(c);

                Room r = new Room();
                r.setMaPhong(rs.getInt("maPhong"));
                r.setTenPhong(rs.getString("tenPhong"));
                b.setRoom(r);

                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean insert(Booking b) {
        String sql = "INSERT INTO DatPhong (maPhong, maKH, ngayDat, ngayNhan, ngayTra, trangThai) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, b.getRoom().getMaPhong());
            ps.setInt(2, b.getCustomer().getMaKH());
            ps.setDate(3, b.getNgayDat());
            ps.setDate(4, b.getNgayNhan());
            ps.setDate(5, b.getNgayTra());
            ps.setString(6, b.getTrangThai());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStatus(int maBooking, String status) {
        String sql = "UPDATE DatPhong SET trangThai = ? WHERE MaDP = ?";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, maBooking);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
