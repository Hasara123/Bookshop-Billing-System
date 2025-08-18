package lk.hasara.advanceprogrammingassingmentmy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.hasara.advanceprogrammingassingmentmy.dao.BillDAO;
import lk.hasara.advanceprogrammingassingmentmy.dao.CustomerDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.Bill;
import lk.hasara.advanceprogrammingassingmentmy.model.BillItem;
import lk.hasara.advanceprogrammingassingmentmy.model.CartItem;
import lk.hasara.advanceprogrammingassingmentmy.model.Customer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private CustomerDAO customerDAO;
    private BillDAO billDAO;

    @Override
    public void init() {
        customerDAO = new CustomerDAO();
        billDAO = new BillDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String accountNo = request.getParameter("accountNo");
        String paymentMethod = request.getParameter("paymentMethod");

        try {
            // 1️⃣ Get cart from session
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
                session.setAttribute("errorMessage", "Your cart is empty.");
                response.sendRedirect("newBill.jsp");
                return;
            }

            // 2️⃣ Prepare Bill object
            Bill bill = new Bill();
            bill.setBillDate(new Date());
            bill.setPaymentMethod(paymentMethod);
            bill.setCreatedBy((String) session.getAttribute("user"));

            if (accountNo != null && !accountNo.trim().isEmpty()) {
                bill.setAccountNo(accountNo.trim());
                Customer customer = customerDAO.getCustomerByAccountNo(accountNo.trim());
                if (customer != null) bill.setCustomerId(customer.getId());
            }

            // 3️⃣ Add BillItems
            List<BillItem> billItems = new ArrayList<>();
            double total = 0;
            for (CartItem ci : cart) {
                BillItem bi = new BillItem();
                bi.setBookId(ci.getItem().getId());
                bi.setQuantity(ci.getQuantity()); // ONLY the cart quantity
                bi.setPrice(ci.getTotalPrice());
                total += ci.getTotalPrice();
                billItems.add(bi);
            }
            bill.setItems(billItems);
            bill.setTotal(total);

            // 4️⃣ Save Bill (DAO handles transaction & stock decrement)
            int billId = billDAO.saveBill(bill);

            // 5️⃣ Send SMS (optional)
            Customer customer = customerDAO.getCustomerByAccountNo(accountNo);
            if (customer != null) {
                String phone = customer.getPhone();
                if (phone.startsWith("0")) phone = "+94" + phone.substring(1);
                Twilio.init("AC271e1bbf36d0a26c369fc3c76e0c3687", "c3af11c6ae3c2175460ff75c0f8168ff");
                Message.creator(new PhoneNumber(phone), new PhoneNumber("+15137173198"),
                        "Hello " + customer.getName() + ", your order of Rs." + total +
                                " has been received. Payment: " + paymentMethod
                ).create();
            }

            // 6️⃣ Clear cart and set success message
            session.removeAttribute("cart");
            session.setAttribute("message", "Checkout successful! Bill ID: " + billId);

            // Redirect to Bill History or newBill page
            response.sendRedirect("billHistory.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Checkout failed: " + e.getMessage());
            response.sendRedirect("newBill.jsp");
        }
    }
}
