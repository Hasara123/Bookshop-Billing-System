package lk.hasara.advanceprogrammingassingmentmy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.hasara.advanceprogrammingassingmentmy.dao.BillDAO;
import lk.hasara.advanceprogrammingassingmentmy.dao.ItemDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/CashierDashboard")
public class CashierServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        BillDAO billDAO = new BillDAO();
        ItemDAO itemDAO = new ItemDAO();

        try {
            // Fetch data
            double totalSales = billDAO.getTotalSalesThisMonth();
            int totalBills = billDAO.getTotalBills();
            int customersServed = billDAO.getCustomersServedThisMonth();
            var recentBills = billDAO.getRecentBills(5);
            var lowStockItems = itemDAO.getLowStockItems(5);
            var mostSellingBooks = itemDAO.getMostSellingBooks(5);
            var monthlyRevenue = billDAO.getMonthlyRevenue(6);

            // Debug logging
            System.out.println("=== Dashboard Data ===");
            System.out.println("Total Sales: " + totalSales);
            System.out.println("Total Bills: " + totalBills);
            System.out.println("Customers Served: " + customersServed);
            System.out.println("Recent Bills count: " + (recentBills != null ? recentBills.size() : 0));
            System.out.println("Low Stock Items count: " + (lowStockItems != null ? lowStockItems.size() : 0));
            System.out.println("Most Selling Books count: " + (mostSellingBooks != null ? mostSellingBooks.size() : 0));
            System.out.println("Monthly Revenue: " + monthlyRevenue);

            // Set attributes for JSP
            request.setAttribute("totalSales", totalSales);
            request.setAttribute("totalBills", totalBills);
            request.setAttribute("customersServed", customersServed);
            request.setAttribute("recentBills", recentBills != null ? recentBills : new ArrayList<>());
            request.setAttribute("lowStockItems", lowStockItems != null ? lowStockItems : new ArrayList<>());
            request.setAttribute("mostSellingBooks", mostSellingBooks != null ? mostSellingBooks : new ArrayList<>());
            request.setAttribute("monthlyRevenue", monthlyRevenue != null ? monthlyRevenue : new java.util.HashMap<>());

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }

        // Forward to JSP
        request.getRequestDispatcher("CashierDashboard.jsp").forward(request, response);
    }
}
