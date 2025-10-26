package model;

import java.math.BigDecimal;

public class LoaiPhong {

    private int maLoaiPhong;
    private String tenLoaiPhong;
    private BigDecimal donGia;
    private String moTa;

    public LoaiPhong() {
    }

    public LoaiPhong(int maLoaiPhong, String tenLoaiPhong, BigDecimal donGia, String moTa) {
        this.maLoaiPhong = maLoaiPhong;
        this.tenLoaiPhong = tenLoaiPhong;
        this.donGia = donGia;
        this.moTa = moTa;
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

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    @Override
    public String toString() {
        return "LoaiPhong{"
                + "maLoaiPhong=" + maLoaiPhong
                + ", tenLoaiPhong='" + tenLoaiPhong + '\''
                + ", donGia=" + donGia
                + ", moTa='" + moTa + '\''
                + '}';
    }
}
