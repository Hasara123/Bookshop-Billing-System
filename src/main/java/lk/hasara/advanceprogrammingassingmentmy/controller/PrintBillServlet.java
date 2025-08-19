package lk.hasara.advanceprogrammingassingmentmy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.hasara.advanceprogrammingassingmentmy.dao.BillDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.Bill;
import lk.hasara.advanceprogrammingassingmentmy.model.BillItem;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/printBill")
public class PrintBillServlet extends HttpServlet {

    private BillDAO billDAO;

    @Override
    public void init() {
        billDAO = new BillDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String billIdStr = request.getParameter("billId");
        if (billIdStr == null || billIdStr.isEmpty()) {
            response.getWriter().println("Invalid bill ID");
            return;
        }

        int billId = Integer.parseInt(billIdStr);

        try {
            Bill bill = billDAO.getBillById(billId);
            List<BillItem> items = billDAO.getBillItemsByBillId(billId);

            if (bill == null) {
                response.getWriter().println("Bill not found");
                return;
            }

            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();

            out.println("<!DOCTYPE html>");
            out.println("<html><head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<title>Bill #" + bill.getId() + "</title>");
            out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'/>");
            out.println("<style>body{margin:20px;} .table td, .table th{padding:0.5rem;}</style>");
            out.println("<script>window.onload=function(){window.print();}</script>");
            out.println("</head><body>");
            out.println("<div class='container'>");
            out.println("<h2 class='text-center mb-4'>Pahana Edu - Bill #" + bill.getId() + "</h2>");

            // Bill Info
            out.println("<p><strong>Date:</strong> " + bill.getBillDate() + "</p>");
            out.println("<p><strong>Account No:</strong> " + (bill.getAccountNo() != null ? bill.getAccountNo() : "N/A") + "</p>");
            out.println("<p><strong>Payment Method:</strong> " + bill.getPaymentMethod() + "</p>");
            out.println("<p><strong>Created By:</strong> " + bill.getCreatedBy() + "</p>");

            // Items Table
            out.println("<table class='table table-bordered'>");
            out.println("<thead><tr><th>Title</th><th>Qty</th><th>Price</th><th>Total</th></tr></thead>");
            out.println("<tbody>");
            double grandTotal = 0;
            for (BillItem item : items) {
                double total = item.getQuantity() * item.getPrice();
                grandTotal += total;
                out.println("<tr>");
                out.println("<td>" + item.getBookId() + "</td>"); // optionally get item title from DB
                out.println("<td>" + item.getQuantity() + "</td>");
                out.println("<td>Rs. " + item.getPrice() + "</td>");
                out.println("<td>Rs. " + total + "</td>");
                out.println("</tr>");
            }
            out.println("</tbody>");
            out.println("<tfoot>");
            out.println("<tr><th colspan='3' class='text-end'>Grand Total</th><th>Rs. " + grandTotal + "</th></tr>");
            out.println("</tfoot>");
            out.println("</table>");

            out.println("</div></body></html>");

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error loading bill: " + e.getMessage());
        }
    }
}
