/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author ThachHien
 */
public class LuuTru {

    private int maLuuTru;
    private int maDatPhong;
    private String cccd;
    private Timestamp gioCheckIn;
    private Timestamp gioCheckOut;
    private String ghiChu;
    private String maPhong; // join
    private String hoTen;

    public LuuTru(int maLuuTru, int maDatPhong, String cccd, Timestamp gioCheckIn, Timestamp gioCheckOut, String ghiChu, String maPhong, String hoTen) {
        this.maLuuTru = maLuuTru;
        this.maDatPhong = maDatPhong;
        this.cccd = cccd;
        this.gioCheckIn = gioCheckIn;
        this.gioCheckOut = gioCheckOut;
        this.ghiChu = ghiChu;
        this.maPhong = maPhong;
        this.hoTen = hoTen;
    }

    public LuuTru() {

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

}
