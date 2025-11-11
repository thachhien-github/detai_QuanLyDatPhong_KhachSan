package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.HoaDon;

public class HoaDonDAO {

    // Giữ nguyên hàm create
    public int createInvoiceForLuuTru(Connection conn, int maLuuTru, int maNhanVien) throws SQLException {
        int maHoaDon = -1;

        String sqlInsert = "INSERT INTO HoaDon (MaLuuTru, MaNhanVien, MaKhachHang, NgayLap, TongTien) "
                + "SELECT lt.MaLuuTru, ?, dp.MaKhachHang, GETDATE(), "
                + "       DATEDIFF(DAY, lt.GioCheckIn, lt.GioCheckOut) * lp.DonGia "
                + "FROM LuuTru lt "
                + "JOIN DatPhong dp ON lt.MaDatPhong = dp.MaDatPhong "
                + "JOIN Phong p ON dp.MaPhong = p.MaPhong "
                + "JOIN LoaiPhong lp ON p.MaLoaiPhong = lp.MaLoaiPhong "
                + "WHERE lt.MaLuuTru = ?";

        try (PreparedStatement ps = conn.prepareStatement(sqlInsert, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, maNhanVien);
            ps.setInt(2, maLuuTru);
            int affected = ps.executeUpdate();

            if (affected == 0) {
                throw new SQLException("Không tạo được hóa đơn cho Lưu Trú: " + maLuuTru);
            }

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    maHoaDon = rs.getInt(1);
                }
            }
        }

        return maHoaDon;
    }

    public List<HoaDon> findAll(Connection conn) throws SQLException {
        List<HoaDon> list = new ArrayList<>();

        String sql = "SELECT hd.MaHoaDon, hd.MaLuuTru, hd.MaNhanVien, hd.MaKhachHang, "
                + "       hd.NgayLap, hd.TongTien, hd.GhiChu, "
                + "       nv.HoTen AS TenNhanVien, kh.HoTen AS TenKhach, p.MaPhong "
                + "FROM HoaDon hd "
                + "LEFT JOIN LuuTru lt ON hd.MaLuuTru = lt.MaLuuTru "
                + "LEFT JOIN DatPhong dp ON lt.MaDatPhong = dp.MaDatPhong "
                + "LEFT JOIN Phong p ON dp.MaPhong = p.MaPhong "
                + "LEFT JOIN KhachHang kh ON hd.MaKhachHang = kh.MaKhachHang "
                + "LEFT JOIN NhanVien nv ON hd.MaNhanVien = nv.MaNhanVien "
                + "ORDER BY hd.NgayLap DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                HoaDon hd = new HoaDon();
                hd.setMaHoaDon(rs.getInt("MaHoaDon"));
                hd.setMaLuuTru(rs.getInt("MaLuuTru"));
                hd.setMaNhanVien(rs.getInt("MaNhanVien"));
                hd.setMaKhachHang(rs.getInt("MaKhachHang"));
                hd.setNgayLap(rs.getTimestamp("NgayLap"));
                hd.setTongTien(rs.getDouble("TongTien"));
                hd.setGhiChu(rs.getString("GhiChu"));
                hd.setTenNhanVien(rs.getString("TenNhanVien")); // HoTen từ NhanVien
                hd.setTenKhach(rs.getString("TenKhach"));       // HoTen từ KhachHang
                hd.setMaPhong(rs.getString("MaPhong"));
                list.add(hd);
            }
        }

        return list;
    }

    public List<Double> getDoanhThuTheoThang(Connection conn) throws SQLException {
        List<Double> doanhThu = new ArrayList<>();
        // Khởi tạo 12 tháng = 0
        for (int i = 0; i < 12; i++) {
            doanhThu.add(0.0);
        }

        String sql = "SELECT MONTH(NgayLap) AS Thang, SUM(TongTien) AS DoanhThu "
                + "FROM HoaDon "
                + "WHERE YEAR(NgayLap) = YEAR(GETDATE()) "
                + "GROUP BY MONTH(NgayLap)";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int thang = rs.getInt("Thang");       // Lấy chính xác tháng
                double dt = rs.getDouble("DoanhThu"); // Lấy tổng tiền
                doanhThu.set(thang - 1, dt);         // -1 vì list 0-indexed
            }
        }
        return doanhThu;
    }

}
