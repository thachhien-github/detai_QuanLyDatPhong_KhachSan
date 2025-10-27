package model;

public class Room {

    private int maPhong; // MaPhong
    private String soPhong; // SoPhong
    private int maLoaiPhong; // MaLoaiPhong
    private String trangThai; // TrangThai
    private String hinhAnh; // HinhAnh
    private String moTa; // MoTa

    public Room() {
    }

    public Room(int maPhong, String soPhong, int maLoaiPhong, String trangThai, String hinhAnh, String moTa) {
        this.maPhong = maPhong;
        this.soPhong = soPhong;
        this.maLoaiPhong = maLoaiPhong;
        this.trangThai = trangThai;
        this.hinhAnh = hinhAnh;
        this.moTa = moTa;
    }

    public Room(String soPhong, int maLoaiPhong, String trangThai, String hinhAnh, String moTa) {
        this.soPhong = soPhong;
        this.maLoaiPhong = maLoaiPhong;
        this.trangThai = trangThai;
        this.hinhAnh = hinhAnh;
        this.moTa = moTa;
    }

    public int getMaPhong() {
        return maPhong;
    }

    public void setMaPhong(int maPhong) {
        this.maPhong = maPhong;
    }

    public String getSoPhong() {
        return soPhong;
    }

    public void setSoPhong(String soPhong) {
        this.soPhong = soPhong;
    }

    public int getMaLoaiPhong() {
        return maLoaiPhong;
    }

    public void setMaLoaiPhong(int maLoaiPhong) {
        this.maLoaiPhong = maLoaiPhong;
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
                + "maPhong=" + maPhong
                + ", soPhong='" + soPhong + '\''
                + ", maLoaiPhong=" + maLoaiPhong
                + ", trangThai='" + trangThai + '\''
                + ", hinhAnh='" + hinhAnh + '\''
                + ", moTa='" + moTa + '\''
                + '}';
    }
}
