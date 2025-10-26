package controller;

import dao.RoomDAO;
import model.Room;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/rooms")
public class RoomServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // charset
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            List<Room> listRooms = roomDAO.getAllRooms();
            System.out.println("Rooms found: " + (listRooms == null ? 0 : listRooms.size()));
            if (listRooms != null) {
                for (Room r : listRooms) {
                    System.out.println(r);
                }
            }
            request.setAttribute("listRooms", listRooms);
            request.getRequestDispatcher("/jsp/rooms/listRooms.jsp").forward(request, response);
        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("listRooms", null);
            request.setAttribute("error", "Lỗi khi lấy dữ liệu phòng: " + ex.getMessage());
            request.getRequestDispatcher("/jsp/rooms/listRooms.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
