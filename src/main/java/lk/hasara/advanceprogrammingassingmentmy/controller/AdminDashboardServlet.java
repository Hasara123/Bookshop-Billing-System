package lk.hasara.advanceprogrammingassingmentmy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.hasara.advanceprogrammingassingmentmy.dao.DashboardDAO;

import java.io.IOException;

@WebServlet("/AdminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || session.getAttribute("role") == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"admin".equalsIgnoreCase(role)) {
            response.sendRedirect("Unauthorized.jsp");
            return;
        }

        DashboardDAO dao = new DashboardDAO();

        request.setAttribute("email", session.getAttribute("user"));
        request.setAttribute("displayRole", role.substring(0, 1).toUpperCase() + role.substring(1).toLowerCase());

        // Safe: provide default 0 if DAO returns null
        request.setAttribute("totalCustomers", dao.getCustomerCount() != 0? dao.getCustomerCount() : 0);
        request.setAttribute("totalBills", dao.getBillsCount() != 0 ? dao.getBillsCount() : 0);
        request.setAttribute("cashierCount", dao.getCashierCount() != 0 ? dao.getCashierCount() : 0);
        request.setAttribute("inventoryCount", dao.getInventoryCount() != 0 ? dao.getInventoryCount() : 0);

        request.getRequestDispatcher("DashBoard.jsp").forward(request, response);
    }
}
