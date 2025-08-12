//package lk.hasara.advanceprogrammingassingmentmy.controller;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import lk.hasara.advanceprogrammingassingmentmy.dao.BillDAO;
//import lk.hasara.advanceprogrammingassingmentmy.dao.CustomerDAO;
//import lk.hasara.advanceprogrammingassingmentmy.model.Bill;
//import lk.hasara.advanceprogrammingassingmentmy.model.BillItem;
//import lk.hasara.advanceprogrammingassingmentmy.model.Customer;
//
//import java.io.IOException;
//import java.sql.SQLException;
//import java.util.List;
//
//@WebServlet("/printBill")
//public class PrintBillServlet extends HttpServlet {
//    private BillDAO billDAO;
//    private CustomerDAO customerDAO;
//
//    @Override
//    public void init() {
//        billDAO = new BillDAO();
//        customerDAO = new CustomerDAO();
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String billIdStr = req.getParameter("billId");
//        if (billIdStr == null) {
//            resp.sendRedirect("billHistory");
//            return;
//        }
//
//        try {
//            int billId = Integer.parseInt(billIdStr);
//            Bill bill = billDAO.getBillById(billId);
//            if (bill == null) {
//                req.setAttribute("errorMessage", "Bill not found");
//                req.getRequestDispatcher("billHistory.jsp").forward(req, resp);
//                return;
//            }
//
//            List<BillItem> items = billDAO.getBillItemsByBillId(billId);
//            Customer customer = null;/
//            if (bill.getCustomerId() != null) {
//                customer = customerDAO.getById(bill.getCustomerId()); // you may need to add getById in CustomerDAO
//            }
//
//            req.setAttribute("bill", bill);
//            req.setAttribute("billItems", items);
//            req.setAttribute("customer", customer);
//
//            req.getRequestDispatcher("printBill.jsp").forward(req, resp);
//        } catch (NumberFormatException | SQLException e) {
//            throw new ServletException(e);
//        }
//    }
//}
