package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Invoice {

    private int maHoaDon;
    private int maLuuTru;
    private int maNhanVien;
    private LocalDateTime ngayLap;
    private BigDecimal tongTien;
    private String ghiChu;

    public Invoice() {
    }

    public Invoice(int maHoaDon, int maLuuTru, int maNhanVien, LocalDateTime ngayLap, BigDecimal tongTien, String ghiChu) {
        this.maHoaDon = maHoaDon;
        this.maLuuTru = maLuuTru;
        this.maNhanVien = maNhanVien;
        this.ngayLap = ngayLap;
        this.tongTien = tongTien;
        this.ghiChu = ghiChu;
    }

    public int getMaHoaDon() {
        return maHoaDon;
    }

    public void setMaHoaDon(int maHoaDon) {
        this.maHoaDon = maHoaDon;
    }

    public int getMaLuuTru() {
        return maLuuTru;
    }

    public void setMaLuuTru(int maLuuTru) {
        this.maLuuTru = maLuuTru;
    }

    public int getMaNhanVien() {
        return maNhanVien;
    }

    public void setMaNhanVien(int maNhanVien) {
        this.maNhanVien = maNhanVien;
    }

    public LocalDateTime getNgayLap() {
        return ngayLap;
    }

    public void setNgayLap(LocalDateTime ngayLap) {
        this.ngayLap = ngayLap;
    }

    public BigDecimal getTongTien() {
        return tongTien;
    }

    public void setTongTien(BigDecimal tongTien) {
        this.tongTien = tongTien;
    }

    public String getGhiChu() {
        return ghiChu;
    }

    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }

    @Override
    public String toString() {
        return "Invoice{"
                + "maHoaDon=" + maHoaDon
                + ", maLuuTru=" + maLuuTru
                + ", maNhanVien=" + maNhanVien
                + ", ngayLap=" + ngayLap
                + ", tongTien=" + tongTien
                + ", ghiChu='" + ghiChu + '\''
                + '}';
    }
}
