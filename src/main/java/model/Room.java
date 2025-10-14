package model;

public class Room {

    private int maPhong;
    private String tenPhong;
    private int maLoai;
    private double gia;
    private String tinhTrang;
    private String hinhAnh;

    public Room() {
    }

    public Room(int maPhong, String tenPhong, int maLoai, double gia, String tinhTrang, String hinhAnh) {
        this.maPhong = maPhong;
        this.tenPhong = tenPhong;
        this.maLoai = maLoai;
        this.gia = gia;
        this.tinhTrang = tinhTrang;
        this.hinhAnh = hinhAnh;
    }

    public int getMaPhong() {
        return maPhong;
    }

    public void setMaPhong(int maPhong) {
        this.maPhong = maPhong;
    }

    public String getTenPhong() {
        return tenPhong;
    }

    public void setTenPhong(String tenPhong) {
        this.tenPhong = tenPhong;
    }

    public int getMaLoai() {
        return maLoai;
    }

    public void setMaLoai(int maLoai) {
        this.maLoai = maLoai;
    }

    public double getGia() {
        return gia;
    }

    public void setGia(double gia) {
        this.gia = gia;
    }

    public String getTinhTrang() {
        return tinhTrang;
    }

    public void setTinhTrang(String tinhTrang) {
        this.tinhTrang = tinhTrang;
    }

    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }

}
