package lk.hasara.advanceprogrammingassingmentmy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.hasara.advanceprogrammingassingmentmy.dao.ItemDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.CartItem;
import lk.hasara.advanceprogrammingassingmentmy.model.Item;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private ItemDAO itemDAO;

    @Override
    public void init() {
        itemDAO = new ItemDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        String action = req.getParameter("action");
        try {
            int itemId;
            int quantity;
            Item item;

            switch (action) {
                case "add":
                    itemId = Integer.parseInt(req.getParameter("itemId"));
                    quantity = Integer.parseInt(req.getParameter("quantity"));
                    item = itemDAO.getItemById(itemId);
                    if (item != null) {
                        boolean found = false;
                        for (CartItem ci : cart) {
                            if (ci.getItem().getId() == itemId) {
                                ci.setQuantity(ci.getQuantity() + quantity);
                                found = true;
                                break;
                            }
                        }
                        if (!found) cart.add(new CartItem(item, quantity));
                    }
                    break;

                case "remove":
                    itemId = Integer.parseInt(req.getParameter("itemId"));
                    cart.removeIf(ci -> ci.getItem().getId() == itemId);
                    break;

                case "update":
                    itemId = Integer.parseInt(req.getParameter("itemId"));
                    quantity = Integer.parseInt(req.getParameter("quantity"));
                    for (CartItem ci : cart) {
                        if (ci.getItem().getId() == itemId) {
                            ci.setQuantity(quantity);
                            break;
                        }
                    }
                    break;
            }

            session.setAttribute("cart", cart);
            resp.sendRedirect(req.getHeader("referer") != null ? req.getHeader("referer") : "catalog");

        } catch (NumberFormatException | SQLException e) {
            throw new ServletException(e);
        }
    }
}
