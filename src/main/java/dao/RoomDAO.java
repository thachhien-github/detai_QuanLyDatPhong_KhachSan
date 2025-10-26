package dao;

import model.Room;
import utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class RoomDAO {

    // Thử đọc từ view trước; nếu view không tồn tại bạn có thể đổi sang query join
    public List<Room> getAllRooms() throws SQLException {
        List<Room> list = new ArrayList<>();

        // Option 1: nếu bạn có view v_TinhTrangPhong
        String sqlView = "SELECT maPhong, soPhong, tenLoaiPhong, donGia, trangThai, moTa FROM v_TinhTrangPhong";

        // Option 2: nếu không có view, dùng JOIN (bỏ comment và sửa tên bảng/cột nếu cần)
        String sqlJoin = "SELECT p.MaPhong, p.SoPhong, l.TenLoaiPhong, l.DonGia, p.TrangThai, p.MoTa "
                + "FROM Phong p LEFT JOIN LoaiPhong l ON p.MaLoaiPhong = l.MaLoaiPhong "
                + "ORDER BY p.SoPhong";

        Connection conn = DBConnection.getConnection();
        if (conn == null) {
            throw new SQLException("Không thể kết nối đến DB.");
        }

        // Thử chạy sqlView trước; nếu ném lỗi (view không tồn tại) thì dùng sqlJoin
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(sqlView);
            rs = ps.executeQuery();
        } catch (SQLException ex) {
            // view có thể không tồn tại -> thử dùng JOIN
            if (ps != null) try {
                ps.close();
            } catch (Exception e) {
            }
            ps = conn.prepareStatement(sqlJoin);
            rs = ps.executeQuery();
        }

        while (rs.next()) {
            int maPhong = getIntIgnoreCase(rs, "maPhong");
            String soPhong = getStringIgnoreCase(rs, "soPhong");
            String tenLoai = getStringIgnoreCase(rs, "tenLoaiPhong");
            BigDecimal donGia = getBigDecimalIgnoreCase(rs, "donGia");
            String trangThai = getStringIgnoreCase(rs, "trangThai");
            String moTa = getStringIgnoreCase(rs, "moTa");

            Room r = new Room(maPhong, soPhong, tenLoai, donGia, trangThai, moTa);
            list.add(r);
        }

        if (rs != null) try {
            rs.close();
        } catch (Exception e) {
        }
        if (ps != null) try {
            ps.close();
        } catch (Exception e) {
        }
        if (conn != null) try {
            conn.close();
        } catch (Exception e) {
        }

        return list;
    }

    // helper: ResultSet may have different case for column labels
    private String getStringIgnoreCase(ResultSet rs, String col) throws SQLException {
        try {
            return rs.getString(col);
        } catch (SQLException e) {
            // try uppercase
            try {
                return rs.getString(col.toUpperCase());
            } catch (SQLException ex) {
                return null;
            }
        }
    }

    private int getIntIgnoreCase(ResultSet rs, String col) throws SQLException {
        try {
            return rs.getInt(col);
        } catch (SQLException e) {
            try {
                return rs.getInt(col.toUpperCase());
            } catch (SQLException ex) {
                return 0;
            }
        }
    }

    private BigDecimal getBigDecimalIgnoreCase(ResultSet rs, String col) throws SQLException {
        try {
            return rs.getBigDecimal(col);
        } catch (SQLException e) {
            try {
                return rs.getBigDecimal(col.toUpperCase());
            } catch (SQLException ex) {
                return null;
            }
        }
    }

    // (Các method insert/update/delete khác nếu cần)
}
