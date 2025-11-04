package dao;

import java.sql.*;
import java.time.temporal.ChronoUnit;
import java.time.LocalDate;

public class HoaDonDAO {

    /**
     * Tạo hoá đơn đơn giản cho MaLuuTru: - Lấy MaDatPhong, NgayNhanDuKien,
     * NgayTraDuKien, MaPhong - Lấy DonGia từ LoaiPhong - Tính số đêm (số ngày
     * giữa NgayNhanDuKien và NgayTraDuKien) - Insert HoaDon (MaLuuTru,
     * MaNhanVien, NgayLap, TongTien)
     *
     * Trả về MaHoaDon (generated) hoặc -1 nếu lỗi.
     */
    public int createInvoiceForLuuTru(Connection conn, int maLuuTru, int maNhanVien) throws SQLException {
        // 1) lấy data
        String sql = "SELECT dp.MaDatPhong, dp.NgayNhanDuKien, dp.NgayTraDuKien, dp.MaPhong, lp.DonGia "
                + "FROM LuuTru lt "
                + "JOIN DatPhong dp ON lt.MaDatPhong = dp.MaDatPhong "
                + "JOIN Phong p ON dp.MaPhong = p.MaPhong "
                + "JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong "
                + "WHERE lt.MaLuuTru = ?";
        Date ngayDen = null, ngayDi = null;
        double donGia = 0;
        int maDatPhong = -1;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maLuuTru);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    maDatPhong = rs.getInt("MaDatPhong");
                    ngayDen = rs.getDate("NgayNhanDuKien");
                    ngayDi = rs.getDate("NgayTraDuKien");
                    donGia = rs.getDouble("DonGia");
                } else {
                    return -1;
                }
            }
        }

        // tính số đêm
        LocalDate d1 = ngayDen.toLocalDate();
        LocalDate d2 = ngayDi.toLocalDate();
        long nights = ChronoUnit.DAYS.between(d1, d2);
        if (nights <= 0) {
            nights = 1; // fallback
        }
        double tong = nights * donGia;

        // insert HoaDon
        String ins = "INSERT INTO HoaDon (MaLuuTru, MaNhanVien, TongTien, GhiChu, MaKhachHang) VALUES (?, ?, ?, ?, (SELECT MaKhachHang FROM DatPhong WHERE MaDatPhong = ?))";
        try (PreparedStatement ps = conn.prepareStatement(ins, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, maLuuTru);
            ps.setInt(2, maNhanVien);
            ps.setDouble(3, tong);
            ps.setString(4, "Hoá đơn tự động khi checkout");
            ps.setInt(5, maDatPhong);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }

        return -1;
    }
}
