package model;

import java.time.LocalDateTime;

public class Stay {

    private int maLuuTru;
    private int maDatPhong;
    private int maNhanVien;
    private String cccd;
    private LocalDateTime gioCheckIn;
    private LocalDateTime gioCheckOut;
    private String ghiChu;

    public Stay() {
    }

    public Stay(int maLuuTru, int maDatPhong, int maNhanVien, String cccd, LocalDateTime gioCheckIn, LocalDateTime gioCheckOut, String ghiChu) {
        this.maLuuTru = maLuuTru;
        this.maDatPhong = maDatPhong;
        this.maNhanVien = maNhanVien;
        this.cccd = cccd;
        this.gioCheckIn = gioCheckIn;
        this.gioCheckOut = gioCheckOut;
        this.ghiChu = ghiChu;
    }

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

    public int getMaNhanVien() {
        return maNhanVien;
    }

    public void setMaNhanVien(int maNhanVien) {
        this.maNhanVien = maNhanVien;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public LocalDateTime getGioCheckIn() {
        return gioCheckIn;
    }

    public void setGioCheckIn(LocalDateTime gioCheckIn) {
        this.gioCheckIn = gioCheckIn;
    }

    public LocalDateTime getGioCheckOut() {
        return gioCheckOut;
    }

    public void setGioCheckOut(LocalDateTime gioCheckOut) {
        this.gioCheckOut = gioCheckOut;
    }

    public String getGhiChu() {
        return ghiChu;
    }

    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }

    @Override
    public String toString() {
        return "Stay{"
                + "maLuuTru=" + maLuuTru
                + ", maDatPhong=" + maDatPhong
                + ", maNhanVien=" + maNhanVien
                + ", cccd='" + cccd + '\''
                + ", gioCheckIn=" + gioCheckIn
                + ", gioCheckOut=" + gioCheckOut
                + ", ghiChu='" + ghiChu + '\''
                + '}';
    }
}
