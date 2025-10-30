// Phong.java
package model;

import java.math.BigDecimal;

public class Phong {

    private String maPhong;
    private String maLoaiPhong;
    private String tenLoaiPhong; // từ join với LoaiPhong
    private BigDecimal donGia;      // từ LoaiPhong
    private String trangThai;
    private String moTa;
    private String hinhAnh;

    public Phong() {
    }

    public Phong(String maPhong, String maLoaiPhong, String tenLoaiPhong, BigDecimal donGia, String trangThai, String moTa, String hinhAnh) {
        this.maPhong = maPhong;
        this.maLoaiPhong = maLoaiPhong;
        this.tenLoaiPhong = tenLoaiPhong;
        this.donGia = donGia;
        this.trangThai = trangThai;
        this.moTa = moTa;
        this.hinhAnh = hinhAnh;
    }

    public String getMaPhong() {
        return maPhong;
    }

    public void setMaPhong(String maPhong) {
        this.maPhong = maPhong;
    }

    public String getMaLoaiPhong() {
        return maLoaiPhong;
    }

    public void setMaLoaiPhong(String maLoaiPhong) {
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

    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }

    
}
