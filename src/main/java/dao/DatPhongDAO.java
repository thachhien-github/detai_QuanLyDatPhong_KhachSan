package dao;

import model.DatPhong;
import utils.DBConnection;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class DatPhongDAO {

    // ==================================================
    // Lấy toàn bộ danh sách đặt phòng
    // ==================================================
    public List<DatPhong> getAll() {
        List<DatPhong> list = new ArrayList<>();
        String sql = "SELECT dp.*, kh.HoTen AS TenKhach, kh.SoDienThoai "
                + "FROM DatPhong dp "
                + "JOIN KhachHang kh ON dp.MaKhachHang = kh.MaKhachHang";

        try (Connection conn = DBConnection.getConnection(); Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                DatPhong dp = new DatPhong();
                dp.setMaDatPhong(rs.getInt("MaDatPhong"));
                dp.setMaKhachHang(rs.getInt("MaKhachHang"));
                dp.setMaPhong(rs.getString("MaPhong"));

                Timestamp tsDat = rs.getTimestamp("NgayDat");
                Date ngayNhan = rs.getDate("NgayNhanDuKien");
                Date ngayTra = rs.getDate("NgayTraDuKien");

                dp.setNgayDat(tsDat != null ? tsDat.toLocalDateTime() : null);
                dp.setNgayNhanDuKien(ngayNhan != null ? ngayNhan.toLocalDate() : null);
                dp.setNgayTraDuKien(ngayTra != null ? ngayTra.toLocalDate() : null);

                dp.setTrangThai(rs.getString("TrangThai"));
                dp.setGhiChu(rs.getString("GhiChu"));
                dp.setTenKhach(rs.getString("TenKhach"));
                dp.setSoDienThoai(rs.getString("SoDienThoai"));
                list.add(dp);
            }

            System.out.println("✅ Lấy " + list.size() + " đặt phòng từ DB.");

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi lấy danh sách đặt phòng: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // ==================================================
    // ✅ XÁC NHẬN ĐẶT PHÒNG
    // ==================================================
    public boolean xacNhanDatPhong(int maDatPhong) {
        String sqlCheck = "SELECT TrangThai, MaPhong FROM DatPhong WHERE MaDatPhong = ?";
        String sqlUpdateDatPhong = "UPDATE DatPhong SET TrangThai = N'Đã xác nhận' WHERE MaDatPhong = ?";
        String sqlUpdatePhong = "UPDATE Phong SET TrangThai = N'Đã đặt' WHERE MaPhong = ?";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            PreparedStatement psCheck = conn.prepareStatement(sqlCheck);
            psCheck.setInt(1, maDatPhong);
            ResultSet rs = psCheck.executeQuery();

            if (!rs.next()) {
                System.err.println("❌ Không tồn tại mã đặt phòng: " + maDatPhong);
                return false;
            }

            String trangThai = rs.getString("TrangThai");
            String maPhong = rs.getString("MaPhong");

            if (!"Chờ xác nhận".equalsIgnoreCase(trangThai)) {
                System.err.println("⚠️ Đặt phòng không ở trạng thái 'Chờ xác nhận'!");
                return false;
            }

            // Cập nhật DatPhong
            PreparedStatement psUpdateDP = conn.prepareStatement(sqlUpdateDatPhong);
            psUpdateDP.setInt(1, maDatPhong);
            psUpdateDP.executeUpdate();

            // Cập nhật Phong
            PreparedStatement psUpdatePhong = conn.prepareStatement(sqlUpdatePhong);
            psUpdatePhong.setString(1, maPhong);
            psUpdatePhong.executeUpdate();

            conn.commit();
            System.out.println("✅ Xác nhận đặt phòng thành công (Mã: " + maDatPhong + ")");
            return true;

        } catch (SQLException e) {
            System.err.println("Lỗi khi xác nhận đặt phòng: " + e.getMessage());
        }

        return false;
    }

    public boolean huyDatPhong(int maDatPhong) {
        String sql = "UPDATE DatPhong SET TrangThai = N'Đã hủy' WHERE MaDatPhong = ? AND TrangThai = N'Chờ xác nhận'";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maDatPhong);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi hủy đặt phòng: " + e.getMessage());
            return false;
        }
    }

    public boolean addBooking(DatPhong dp) {
        String sql = "INSERT INTO DatPhong(maKhachHang, maPhong, ngayDat, ngayNhanDuKien, ngayTraDuKien, trangThai, ghiChu) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, dp.getMaKhachHang());
            ps.setString(2, dp.getMaPhong());
            ps.setTimestamp(3, Timestamp.valueOf(dp.getNgayDat()));
            ps.setDate(4, Date.valueOf(dp.getNgayNhanDuKien()));
            ps.setDate(5, Date.valueOf(dp.getNgayTraDuKien()));
            ps.setString(6, dp.getTrangThai());
            ps.setString(7, dp.getGhiChu());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updateRoomStatus(String maPhong, String status) {
        String sql = "UPDATE Phong SET trangThai=? WHERE maPhong=?";
        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, maPhong);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // trong DatPhongDAO (thay thế stub bằng implementation này)
    public List<DatPhong> findConfirmedBookings(Connection conn) throws SQLException {
        List<DatPhong> list = new ArrayList<>();
        String sql = "SELECT dp.MaDatPhong, dp.MaPhong, kh.HoTen, dp.NgayNhanDuKien, dp.NgayTraDuKien "
                + "FROM DatPhong dp "
                + "JOIN KhachHang kh ON dp.MaKhachHang = kh.MaKhachHang "
                + "WHERE dp.TrangThai = N'Đã xác nhận' "
                + "ORDER BY dp.NgayNhanDuKien ASC";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                DatPhong dp = new DatPhong();
                dp.setMaDatPhong(rs.getInt("MaDatPhong"));
                dp.setMaPhong(rs.getString("MaPhong"));
                dp.setTenKhach(rs.getString("HoTen"));

                Date ngayNhan = rs.getDate("NgayNhanDuKien");
                Date ngayTra = rs.getDate("NgayTraDuKien");
                dp.setNgayNhanDuKien(ngayNhan != null ? ngayNhan.toLocalDate() : null);
                dp.setNgayTraDuKien(ngayTra != null ? ngayTra.toLocalDate() : null);

                // optionally set a default status and ghiChu if your model has them
                dp.setTrangThai("Đã xác nhận");

                list.add(dp);
            }
        }
        return list;
    }

}
