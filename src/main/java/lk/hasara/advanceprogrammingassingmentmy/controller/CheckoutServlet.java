package lk.hasara.advanceprogrammingassingmentmy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.hasara.advanceprogrammingassingmentmy.dao.BillDAO;
import lk.hasara.advanceprogrammingassingmentmy.dao.CustomerDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.Bill;
import lk.hasara.advanceprogrammingassingmentmy.model.BillItem;
import lk.hasara.advanceprogrammingassingmentmy.model.CartItem;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private BillDAO billDAO = new BillDAO();
    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accountNo = req.getParameter("accountNo");
        String paymentMethod = req.getParameter("paymentMethod");

        // Get cart from session
        List<CartItem> cart = (List<CartItem>) req.getSession().getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            req.setAttribute("errorMessage", "Cart is empty! Please add items.");
            req.getRequestDispatcher("newBill.jsp").forward(req, resp);
            return;
        }

        try {
            // Validate customer account number if provided
            if (accountNo != null && !accountNo.trim().isEmpty()) {
                boolean registered = customerDAO.isCustomerRegistered(accountNo.trim());
                if (!registered) {
                    req.setAttribute("errorMessage", "Customer account number not registered! Please add customer first.");
                    req.getRequestDispatcher("newBill.jsp").forward(req, resp);
                    return;
                }
            } else {
                accountNo = null; // Treat empty input as null
            }

            // Calculate total amount
            double totalAmount = 0;
            for (CartItem ci : cart) {
                totalAmount += ci.getTotalPrice();
            }

            // Create and populate Bill object
            Bill bill = new Bill();
            // If your Bill model expects customerId, convert accountNo to customerId here:
            if (accountNo != null) {
                Integer customerId = customerDAO.getCustomerByAccountNo(accountNo.trim()).getId();
                bill.setCustomerId(customerId);
            } else {
                bill.setCustomerId(null);
            }

            bill.setPaymentMethod(paymentMethod);
            bill.setTotal(totalAmount);
            bill.setBillDate(new java.util.Date());

            // Convert CartItem list to BillItem list and set on bill
            List<BillItem> billItems = new ArrayList<>();
            for (CartItem ci : cart) {
                BillItem bi = new BillItem();
                bi.setBookId(ci.getItem().getId());
                bi.setQuantity(ci.getQuantity());
                bi.setPrice(ci.getItem().getPrice());
                billItems.add(bi);
            }
            bill.setItems(billItems);

            // Save bill and bill items to DB
            billDAO.saveBill(bill); // You can modify DAO to only use bill.getItems()

            // Clear cart after successful checkout
            req.getSession().removeAttribute("cart");

            req.setAttribute("message", "Payment successful! Bill saved.");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Payment failed: " + e.getMessage());
        }

        req.getRequestDispatcher("newBill.jsp").forward(req, resp);
    }
}