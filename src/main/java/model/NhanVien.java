package model;

public class NhanVien {

    private int maNhanVien;
    private String hoTen;
    private String tenDangNhap;
    private String matKhau;
    private String chucVu;
    private String trangThai;

    public NhanVien() {
    }

    public NhanVien(int maNhanVien, String hoTen, String tenDangNhap, String matKhau, String chucVu, String trangThai) {
        this.maNhanVien = maNhanVien;
        this.hoTen = hoTen;
        this.tenDangNhap = tenDangNhap;
        this.matKhau = matKhau;
        this.chucVu = chucVu;
        this.trangThai = trangThai;
    }
    
    

    // getters & setters
    public int getMaNhanVien() {
        return maNhanVien;
    }

    public void setMaNhanVien(int maNhanVien) {
        this.maNhanVien = maNhanVien;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getTenDangNhap() {
        return tenDangNhap;
    }

    public void setTenDangNhap(String tenDangNhap) {
        this.tenDangNhap = tenDangNhap;
    }

    public String getMatKhau() {
        return matKhau;
    }

    public void setMatKhau(String matKhau) {
        this.matKhau = matKhau;
    }

    public String getChucVu() {
        return chucVu;
    }

    public void setChucVu(String chucVu) {
        this.chucVu = chucVu;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
}
