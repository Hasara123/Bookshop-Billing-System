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

        HttpSession session = request.getSession(true);
        String action = request.getParameter("action");

        try {
            if ("search".equalsIgnoreCase(action)) {
                String keyword = request.getParameter("keyword");
                List<User> staffList = dao.getAllStaff(keyword);
                request.setAttribute("staffList", staffList);

            } else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean deleted = dao.deleteStaff(id);

                // Set flash message
                session.setAttribute("message", deleted ? "Staff deleted successfully" : "Failed to delete staff");
                session.setAttribute("msgType", deleted ? "success" : "error");

                // Redirect to show message immediately
                response.sendRedirect("staff");
                return;
            }

            // Default: list all staff
            List<User> staffList = dao.getAllStaff(null);
            request.setAttribute("staffList", staffList);

            // Forward to JSP
            request.getRequestDispatcher("staff.jsp").forward(request, response);

        } catch (Exception e) {
            session.setAttribute("message", "Error: " + e.getMessage());
            session.setAttribute("msgType", "error");
            response.sendRedirect("staff");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        String action = request.getParameter("action");

        try {
            if ("add".equalsIgnoreCase(action)) {
                String email = request.getParameter("email").trim();
                String password = request.getParameter("password").trim();
                String role = request.getParameter("role").trim();

                User user = new User();
                user.setEmail(email);
                user.setPassword(password);
                user.setRole(role);

                boolean added = dao.addStaff(user);
                session.setAttribute("message", added ? "Staff added successfully" : "Failed to add staff");
                session.setAttribute("msgType", added ? "success" : "error");

                response.sendRedirect("staff");

            } else if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String email = request.getParameter("email").trim();
                String password = request.getParameter("password").trim();
                String role = request.getParameter("role").trim();

                User user = new User();
                user.setId(id);
                user.setEmail(email);
                // Only update password if provided
                if (!password.isEmpty()) {
                    user.setPassword(password);
                } else {
                    user.setPassword(dao.getStaffById(id).getPassword());
                }
                user.setRole(role);

                boolean updated = dao.updateStaff(user);
                session.setAttribute("message", updated ? "Staff updated successfully" : "Failed to update staff");
                session.setAttribute("msgType", updated ? "success" : "error");

                response.sendRedirect("staff");
            }
        } catch (Exception e) {
            session.setAttribute("message", "Error: " + e.getMessage());
            session.setAttribute("msgType", "error");
            response.sendRedirect("staff");
        }
    }
}
