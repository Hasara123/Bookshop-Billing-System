//package lk.hasara.advanceprogrammingassingmentmy.controller;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import lk.hasara.advanceprogrammingassingmentmy.dao.BillDAO;
//import lk.hasara.advanceprogrammingassingmentmy.model.Bill;
//
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet("/CashierServlet")
//public class CashierServlet extends HttpServlet {
//
//    private BillDAO billDAO = new BillDAO();
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // Get logged-in user email from session
//        String cashierEmail = (String) request.getSession().getAttribute("user");
//        String role = (String) request.getSession().getAttribute("role");
//
//        if (cashierEmail == null || role == null || !role.equalsIgnoreCase("CASHIER")) {
//            response.sendRedirect("Login.jsp");
//            return;
//        }
//
//        // Fetch bills created by this cashier
//        List<Bill> bills = billDAO.getBillsByCashier(cashierEmail);
//
//        // Set bills in request scope to display in JSP
//        request.setAttribute("bills", bills);
//
//        // Forward to JSP page
//        request.getRequestDispatcher("CashierDashboard.jsp").forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String action = request.getParameter("action");
//        if ("addBill".equals(action)) {
//            addBill(request, response);
//        } else {
//            response.sendRedirect("CashierServlet"); // reload to refresh data
//        }
//    }
//
//    private void addBill(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//        String accountNo = request.getParameter("accountNo");
//        int unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));
//        String cashierEmail = (String) request.getSession().getAttribute("user");
//
//        // Calculate amount (same logic as billing)
//        double amount = 0;
//        if (unitsConsumed <= 50) {
//            amount = unitsConsumed * 5;
//        } else if (unitsConsumed <= 100) {
//            amount = 50 * 5 + (unitsConsumed - 50) * 7;
//        } else {
//            amount = 50 * 5 + 50 * 7 + (unitsConsumed - 100) * 10;
//        }
//
//        Bill bill = new Bill();
//        bill.setAccountNo(accountNo);
//        bill.setUnitsConsumed(unitsConsumed);
//        bill.setTotalAmount(amount);
//        bill.setCashierEmail(cashierEmail);
//
//        boolean success = billDAO.addBill(bill);
//        if (success) {
//            request.getSession().setAttribute("message", "Bill added successfully.");
//        } else {
//            request.getSession().setAttribute("message", "Failed to add bill.");
//        }
//
//        // Redirect to GET method to show updated bill list
//        response.sendRedirect("CashierServlet");
//    }
//}
