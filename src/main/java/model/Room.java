package model;

import java.math.BigDecimal;

public class Room {

    private int maPhong;
    private String soPhong;
    private int maLoaiPhong;
    private String tenLoaiPhong;
    private BigDecimal donGia;
    private String trangThai;
    private String moTa;

    public Room() {
    }

    // Constructor dùng khi đọc từ view / join
    public Room(int maPhong, String soPhong, String tenLoaiPhong, BigDecimal donGia, String trangThai, String moTa) {
        this.maPhong = maPhong;
        this.soPhong = soPhong;
        this.tenLoaiPhong = tenLoaiPhong;
        this.donGia = donGia;
        this.trangThai = trangThai;
        this.moTa = moTa;
    }

    // Constructor dùng cho insert/update (từ bảng Phong)
    public Room(int maPhong, String soPhong, int maLoaiPhong, String trangThai, String moTa) {
        this.maPhong = maPhong;
        this.soPhong = soPhong;
        this.maLoaiPhong = maLoaiPhong;
        this.trangThai = trangThai;
        this.moTa = moTa;
    }

    // getters & setters
    public int getMaPhong() {
        return maPhong;
    }

    public void setMaPhong(int maPhong) {
        this.maPhong = maPhong;
    }

    public String getSoPhong() {
        return soPhong;
    }

    public void setSoPhong(String soPhong) {
        this.soPhong = soPhong;
    }

    public int getMaLoaiPhong() {
        return maLoaiPhong;
    }

    public void setMaLoaiPhong(int maLoaiPhong) {
        this.maLoaiPhong = maLoaiPhong;
    }

    public String getTenLoaiPhong() {
        return tenLoaiPhong;
    }

    public void setTenLoaiPhong(String tenLoaiPhong) {
        this.tenLoaiPhong = tenLoaiPhong;
    }

    public BigDecimal getDonGia() {
        return donGia;
    }

    public void setDonGia(BigDecimal donGia) {
        this.donGia = donGia;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    @Override
    public String toString() {
        return "Room{"
                + "maPhong=" + maPhong
                + ", soPhong='" + soPhong + '\''
                + ", tenLoaiPhong='" + tenLoaiPhong + '\''
                + ", donGia=" + donGia
                + ", trangThai='" + trangThai + '\''
                + '}';
    }
}
