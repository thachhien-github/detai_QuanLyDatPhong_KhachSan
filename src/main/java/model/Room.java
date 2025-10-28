package model;

public class Room {

    private String maPhong;
    private String maLoaiPhong;
    private String tenLoaiPhong; // ✅ thêm thuộc tính này để show ra tên loại phòng
    private String trangThai;
    private String hinhAnh;
    private String moTa;

    public Room() {
    }

    public Room(String maPhong, String maLoaiPhong, String tenLoaiPhong, String trangThai, String hinhAnh, String moTa) {
        this.maPhong = maPhong;
        this.maLoaiPhong = maLoaiPhong;
        this.tenLoaiPhong = tenLoaiPhong;
        this.trangThai = trangThai;
        this.hinhAnh = hinhAnh;
        this.moTa = moTa;
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

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
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
                + "maPhong='" + maPhong + '\''
                + ", maLoaiPhong='" + maLoaiPhong + '\''
                + ", tenLoaiPhong='" + tenLoaiPhong + '\''
                + ", trangThai='" + trangThai + '\''
                + ", hinhAnh='" + hinhAnh + '\''
                + ", moTa='" + moTa + '\''
                + '}';
    }
}
