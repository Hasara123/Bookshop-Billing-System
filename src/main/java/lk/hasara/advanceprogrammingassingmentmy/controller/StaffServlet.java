package lk.hasara.advanceprogrammingassingmentmy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.hasara.advanceprogrammingassingmentmy.dao.StaffDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/staff")
public class StaffServlet extends HttpServlet {

    private StaffDAO dao;

    @Override
    public void init() {
        dao = new StaffDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("search".equalsIgnoreCase(action)) {
            String keyword = request.getParameter("keyword");
            List<User> staffList = dao.getAllStaff(keyword);
            request.setAttribute("staffList", staffList);
            request.getRequestDispatcher("staff.jsp").forward(request, response);

        } else if ("delete".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean deleted = dao.deleteStaff(id);
            request.setAttribute("message", deleted ? "Staff deleted successfully" : "Failed to delete staff");
            request.setAttribute("msgType", deleted ? "success" : "error");
            List<User> staffList = dao.getAllStaff(null);
            request.setAttribute("staffList", staffList);
            request.getRequestDispatcher("staff.jsp").forward(request, response);

        } else {
            // Default: list all staff
            List<User> staffList = dao.getAllStaff(null);
            request.setAttribute("staffList", staffList);
            request.getRequestDispatcher("staff.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            User user = new User();
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            boolean added = dao.addStaff(user);
            if (added) {
                response.sendRedirect("staff?message=Staff+added+successfully&msgType=success");
            } else {
                request.setAttribute("message", "Failed to add staff");
                request.setAttribute("msgType", "error");
                request.getRequestDispatcher("add-staff.jsp").forward(request, response);
            }

        } else if ("update".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String email = request.getParameter("email");
            String password = request.getParameter("password"); // can be blank
            String role = request.getParameter("role");

            User user = new User();
            user.setId(id);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            boolean updated = dao.updateStaff(user);
            if (updated) {
                response.sendRedirect("staff?message=Staff+updated+successfully&msgType=success");
            } else {
                request.setAttribute("message", "Failed to update staff");
                request.setAttribute("msgType", "error");
                doGet(request, response); // reload list with error
            }
        }
    }
}
