
package model;

public class Room {
    private int maPhong;
    private String tenPhong;
    private RoomType loaiPhong; // liên kết
    private double gia;
    private String tinhTrang;

    public Room() {
    }

    public Room(int maPhong, String tenPhong, RoomType loaiPhong, double gia, String tinhTrang) {
        this.maPhong = maPhong;
        this.tenPhong = tenPhong;
        this.loaiPhong = loaiPhong;
        this.gia = gia;
        this.tinhTrang = tinhTrang;
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

    public RoomType getLoaiPhong() {
        return loaiPhong;
    }

    public void setLoaiPhong(RoomType loaiPhong) {
        this.loaiPhong = loaiPhong;
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
    
    
}
