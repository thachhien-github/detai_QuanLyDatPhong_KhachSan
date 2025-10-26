package model;

import java.time.LocalDate;

public class Booking {

    private int maDatPhong;
    private int maKhachHang;
    private int maPhong;
    private LocalDate ngayDat;
    private LocalDate ngayNhanDuKien;
    private LocalDate ngayTraDuKien;
    private String trangThai;
    private String ghiChu;

    // optional convenience fields for display
    private String tenKhach;
    private String soPhong;

    public Booking() {
    }

    public Booking(int maDatPhong, int maKhachHang, int maPhong, LocalDate ngayDat,
            LocalDate ngayNhanDuKien, LocalDate ngayTraDuKien, String trangThai, String ghiChu) {
        this.maDatPhong = maDatPhong;
        this.maKhachHang = maKhachHang;
        this.maPhong = maPhong;
        this.ngayDat = ngayDat;
        this.ngayNhanDuKien = ngayNhanDuKien;
        this.ngayTraDuKien = ngayTraDuKien;
        this.trangThai = trangThai;
        this.ghiChu = ghiChu;
    }

    public int getMaDatPhong() {
        return maDatPhong;
    }

    public void setMaDatPhong(int maDatPhong) {
        this.maDatPhong = maDatPhong;
    }

    public int getMaKhachHang() {
        return maKhachHang;
    }

    public void setMaKhachHang(int maKhachHang) {
        this.maKhachHang = maKhachHang;
    }

    public int getMaPhong() {
        return maPhong;
    }

    public void setMaPhong(int maPhong) {
        this.maPhong = maPhong;
    }

    public LocalDate getNgayDat() {
        return ngayDat;
    }

    public void setNgayDat(LocalDate ngayDat) {
        this.ngayDat = ngayDat;
    }

    public LocalDate getNgayNhanDuKien() {
        return ngayNhanDuKien;
    }

    public void setNgayNhanDuKien(LocalDate ngayNhanDuKien) {
        this.ngayNhanDuKien = ngayNhanDuKien;
    }

    public LocalDate getNgayTraDuKien() {
        return ngayTraDuKien;
    }

    public void setNgayTraDuKien(LocalDate ngayTraDuKien) {
        this.ngayTraDuKien = ngayTraDuKien;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public String getGhiChu() {
        return ghiChu;
    }

    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }

    public String getTenKhach() {
        return tenKhach;
    }

    public void setTenKhach(String tenKhach) {
        this.tenKhach = tenKhach;
    }

    public String getSoPhong() {
        return soPhong;
    }

    public void setSoPhong(String soPhong) {
        this.soPhong = soPhong;
    }

    @Override
    public String toString() {
        return "Booking{"
                + "maDatPhong=" + maDatPhong
                + ", maKhachHang=" + maKhachHang
                + ", maPhong=" + maPhong
                + ", ngayDat=" + ngayDat
                + ", ngayNhanDuKien=" + ngayNhanDuKien
                + ", ngayTraDuKien=" + ngayTraDuKien
                + ", trangThai='" + trangThai + '\''
                + ", ghiChu='" + ghiChu + '\''
                + '}';
    }
}
