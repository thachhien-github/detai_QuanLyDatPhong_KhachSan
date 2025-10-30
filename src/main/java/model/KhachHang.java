package model;

public class KhachHang {

    private int maKhachHang;
    private String hoTen;
    private String soDienThoai;
    private String email;
    private String cccd;
    private String diaChi;

    public KhachHang() {
    }

    public KhachHang(int ma, String hoTen, String sdt, String email, String cccd, String diaChi) {
        this.maKhachHang = ma;
        this.hoTen = hoTen;
        this.soDienThoai = sdt;
        this.email = email;
        this.cccd = cccd;
        this.diaChi = diaChi;
    }

    // getters & setters
    public int getMaKhachHang() {
        return maKhachHang;
    }

    public void setMaKhachHang(int maKhachHang) {
        this.maKhachHang = maKhachHang;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getSoDienThoai() {
        return soDienThoai;
    }

    public void setSoDienThoai(String soDienThoai) {
        this.soDienThoai = soDienThoai;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }
}
