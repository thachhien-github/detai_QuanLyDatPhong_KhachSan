package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class LuuTru {

    private int maLuuTru;
    private int maDatPhong;
    private String cccd;
    private Timestamp gioCheckIn;
    private Timestamp gioCheckOut;
    private String ghiChu;
    private String maPhong; // từ join Phong
    private String hoTen;   // từ join KhachHang
    private BigDecimal donGia; // giá phòng

    // Constructor đầy đủ
    public LuuTru(int maLuuTru, int maDatPhong, String cccd, Timestamp gioCheckIn, Timestamp gioCheckOut,
            String ghiChu, String maPhong, String hoTen, BigDecimal donGia) {
        this.maLuuTru = maLuuTru;
        this.maDatPhong = maDatPhong;
        this.cccd = cccd;
        this.gioCheckIn = gioCheckIn;
        this.gioCheckOut = gioCheckOut;
        this.ghiChu = ghiChu;
        this.maPhong = maPhong;
        this.hoTen = hoTen;
        this.donGia = donGia;
    }

    // Constructor rỗng
    public LuuTru() {
    }

    // Getter & Setter
    public int getMaLuuTru() {
        return maLuuTru;
    }

    public void setMaLuuTru(int maLuuTru) {
        this.maLuuTru = maLuuTru;
    }

    public int getMaDatPhong() {
        return maDatPhong;
    }

    public void setMaDatPhong(int maDatPhong) {
        this.maDatPhong = maDatPhong;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public Timestamp getGioCheckIn() {
        return gioCheckIn;
    }

    public void setGioCheckIn(Timestamp gioCheckIn) {
        this.gioCheckIn = gioCheckIn;
    }

    public Timestamp getGioCheckOut() {
        return gioCheckOut;
    }

    public void setGioCheckOut(Timestamp gioCheckOut) {
        this.gioCheckOut = gioCheckOut;
    }

    public String getGhiChu() {
        return ghiChu;
    }

    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }

    public String getMaPhong() {
        return maPhong;
    }

    public void setMaPhong(String maPhong) {
        this.maPhong = maPhong;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public BigDecimal getDonGia() {
        return donGia;
    }

    public void setDonGia(BigDecimal donGia) {
        this.donGia = donGia;
    }

    @Override
    public String toString() {
        return "LuuTru{"
                + "maLuuTru=" + maLuuTru
                + ", maDatPhong=" + maDatPhong
                + ", cccd='" + cccd + '\''
                + ", gioCheckIn=" + gioCheckIn
                + ", gioCheckOut=" + gioCheckOut
                + ", ghiChu='" + ghiChu + '\''
                + ", maPhong='" + maPhong + '\''
                + ", hoTen='" + hoTen + '\''
                + ", donGia=" + donGia
                + '}';
    }
}
