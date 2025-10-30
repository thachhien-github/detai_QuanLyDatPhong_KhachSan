package model;

import java.math.BigDecimal;

public class LoaiPhong {

    private String maLoaiPhong;
    private String tenLoaiPhong;
    private BigDecimal donGia;
    private String moTa;

    public LoaiPhong() {
    }

    public LoaiPhong(String maLoaiPhong, String tenLoaiPhong, BigDecimal donGia, String moTa) {
        this.maLoaiPhong = maLoaiPhong;
        this.tenLoaiPhong = tenLoaiPhong;
        this.donGia = donGia;
        this.moTa = moTa;
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

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    
}
