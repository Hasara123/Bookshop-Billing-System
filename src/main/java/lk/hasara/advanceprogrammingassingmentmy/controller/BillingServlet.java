package lk.hasara.advanceprogrammingassingmentmy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.hasara.advanceprogrammingassingmentmy.dao.ItemDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.Item;
import lk.hasara.advanceprogrammingassingmentmy.model.CartItem;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@WebServlet("/billing")
public class BillingServlet extends HttpServlet {

    private ItemDAO itemDAO;

    @Override
    public void init() {
        itemDAO = new ItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchKeyword = request.getParameter("search");

        try {
            List<Item> items;

            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                // Search items by keyword using your existing DAO method
                items = itemDAO.searchItems(searchKeyword.trim(), null);
                request.setAttribute("search", searchKeyword);
            } else {
                items = itemDAO.getAllItems();
            }

            request.setAttribute("items", items);

            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }
            request.setAttribute("cart", cart);

            request.getRequestDispatcher("billing.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error loading items for billing page", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("billing");
            return;
        }

        try {
            switch (action) {
                case "add":
                    addToCart(request, response);
                    break;
                case "remove":
                    removeFromCart(request, response);
                    break;
                case "calculateBill":
                    calculateBill(request, response);
                    break;
                default:
                    response.sendRedirect("billing");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            doGet(request, response);
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Item item = itemDAO.getItemById(itemId);
        if (item == null) {
            response.sendRedirect("billing?error=ItemNotFound");
            return;
        }

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        boolean found = false;
        for (CartItem cartItem : cart) {
            if (cartItem.getItem().getId() == itemId) {
                cartItem.setQuantity(cartItem.getQuantity() + quantity);
                found = true;
                break;
            }
        }

        if (!found) {
            cart.add(new CartItem(item, quantity));
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("billing");
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int itemId = Integer.parseInt(request.getParameter("itemId"));

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart != null) {
            Iterator<CartItem> iterator = cart.iterator();
            while (iterator.hasNext()) {
                CartItem cartItem = iterator.next();
                if (cartItem.getItem().getId() == itemId) {
                    iterator.remove();
                    break;
                }
            }
            session.setAttribute("cart", cart);
        }

        response.sendRedirect("billing");
    }

    private void calculateBill(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            request.setAttribute("errorMessage", "Cart is empty. Please add items first.");
            doGet(request, response);
            return;
        }

        // TODO: Implement bill saving to DB here using BillDAO

        session.removeAttribute("cart");
        request.setAttribute("message", "Bill processed successfully!");

        doGet(request, response);
    }
}
