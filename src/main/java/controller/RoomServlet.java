package controller;

import dao.RoomDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Room;

@WebServlet("/rooms")
public class RoomServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Room> listRooms = roomDAO.getAll();
        request.setAttribute("listRooms", listRooms);

        request.getRequestDispatcher("/jsp/rooms/listRooms.jsp").forward(request, response);
    }
}
