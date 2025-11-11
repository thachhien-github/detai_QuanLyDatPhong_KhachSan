package dao;

import model.LuuTru;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class LuuTruDAO {

    // ================================
    // Lấy danh sách LuuTru kèm thông tin phòng, khách hàng và giá phòng
    // ================================
    public List<LuuTru> findAll(Connection conn) throws SQLException {
        String sql = "SELECT lt.MaLuuTru, lt.MaDatPhong, lt.CCCDKhach, lt.GioCheckIn, lt.GioCheckOut, lt.GhiChu, "
                + "dp.MaPhong, kh.HoTen, lp.DonGia "
                + "FROM LuuTru lt "
                + "JOIN DatPhong dp ON lt.MaDatPhong = dp.MaDatPhong "
                + "JOIN KhachHang kh ON dp.MaKhachHang = kh.MaKhachHang "
                + "JOIN Phong p ON dp.MaPhong = p.MaPhong "
                + "JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong "
                + "ORDER BY lt.GioCheckIn DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            List<LuuTru> list = new ArrayList<>();
            while (rs.next()) {
                LuuTru lt = new LuuTru();
                lt.setMaLuuTru(rs.getInt("MaLuuTru"));
                lt.setMaDatPhong(rs.getInt("MaDatPhong"));
                lt.setCccd(rs.getString("CCCDKhach"));

                Timestamp tIn = rs.getTimestamp("GioCheckIn");
                if (tIn != null) {
                    lt.setGioCheckIn(tIn);
                }

                Timestamp tOut = rs.getTimestamp("GioCheckOut");
                if (tOut != null) {
                    lt.setGioCheckOut(tOut);
                }

                lt.setGhiChu(rs.getString("GhiChu"));
                lt.setMaPhong(rs.getString("MaPhong"));
                lt.setHoTen(rs.getString("HoTen"));
                lt.setDonGia(rs.getBigDecimal("DonGia"));

                list.add(lt);
            }
            return list;
        }
    }

    // ================================
    // Check-in
    // ================================
    public int createCheckIn(Connection conn, int maDatPhong, String cccd, String ghiChu, int maNhanVien) throws SQLException {
        // 1. Thêm bản ghi LuuTru
        String sqlInsert = "INSERT INTO LuuTru (MaDatPhong, MaNhanVien, CCCDKhach, GhiChu) VALUES (?, ?, ?, ?)";
        int maLuuTru = -1;

        try (PreparedStatement ps = conn.prepareStatement(sqlInsert, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, maDatPhong);
            ps.setInt(2, maNhanVien);
            ps.setString(3, cccd);
            ps.setString(4, ghiChu);
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    maLuuTru = rs.getInt(1);
                }
            }
        }

        if (maLuuTru != -1) {
            // 2. Lấy mã phòng
            String maPhong = null;
            String sqlPhong = "SELECT MaPhong FROM DatPhong WHERE MaDatPhong = ?";
            try (PreparedStatement ps = conn.prepareStatement(sqlPhong)) {
                ps.setInt(1, maDatPhong);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        maPhong = rs.getString("MaPhong");
                    }
                }
            }

            if (maPhong != null) {
                // 3. Cập nhật trạng thái phòng
                String sqlUpdatePhong = "UPDATE Phong SET TrangThai = N'Đã đặt' WHERE MaPhong = ?";
                try (PreparedStatement ps = conn.prepareStatement(sqlUpdatePhong)) {
                    ps.setString(1, maPhong);
                    ps.executeUpdate();
                }

                // 4. Cập nhật trạng thái đặt phòng
                String sqlUpdateDatPhong = "UPDATE DatPhong SET TrangThai = N'Đã check-in' WHERE MaDatPhong = ?";
                try (PreparedStatement ps = conn.prepareStatement(sqlUpdateDatPhong)) {
                    ps.setInt(1, maDatPhong);
                    ps.executeUpdate();
                }
            }
        }

        return maLuuTru;
    }

    // ================================
    // Check-out
    // ================================
    public boolean checkOut(Connection conn, int maLuuTru) throws SQLException {
        // 1. Cập nhật thời gian check-out
        String sqlUpdate = "UPDATE LuuTru SET GioCheckOut = GETDATE() WHERE MaLuuTru = ? AND GioCheckOut IS NULL";
        try (PreparedStatement ps = conn.prepareStatement(sqlUpdate)) {
            ps.setInt(1, maLuuTru);
            int affected = ps.executeUpdate();
            if (affected == 0) {
                return false; // đã checkout trước đó
            }
        }

        // 2. Lấy mã phòng và MaDatPhong
        String maPhong = null;
        int maDatPhong = 0;
        String sqlPhong = "SELECT dp.MaPhong, dp.MaDatPhong FROM LuuTru lt "
                + "JOIN DatPhong dp ON lt.MaDatPhong = dp.MaDatPhong "
                + "WHERE lt.MaLuuTru = ?";
        try (PreparedStatement ps = conn.prepareStatement(sqlPhong)) {
            ps.setInt(1, maLuuTru);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    maPhong = rs.getString("MaPhong");
                    maDatPhong = rs.getInt("MaDatPhong");
                }
            }
        }

        if (maPhong != null) {
            // 3. Cập nhật trạng thái phòng
            String sqlPhongUpd = "UPDATE Phong SET TrangThai = N'Trống' WHERE MaPhong = ?";
            try (PreparedStatement ps = conn.prepareStatement(sqlPhongUpd)) {
                ps.setString(1, maPhong);
                ps.executeUpdate();
            }

            // 4. Cập nhật trạng thái đặt phòng
            String sqlDatPhongUpd = "UPDATE DatPhong SET TrangThai = N'Đã check-out' WHERE MaDatPhong = ?";
            try (PreparedStatement ps = conn.prepareStatement(sqlDatPhongUpd)) {
                ps.setInt(1, maDatPhong);
                ps.executeUpdate();
            }
        }

        return true;
    }

    public int countDangO(Connection conn) throws SQLException {
        String sql = "SELECT COUNT(*) FROM LuuTru WHERE GioCheckOut IS NULL";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

}
