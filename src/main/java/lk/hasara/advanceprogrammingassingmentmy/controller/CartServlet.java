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
        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        try {
            if ("add".equals(action)) {
                int id = Integer.parseInt(req.getParameter("itemId"));
                int qty = Integer.parseInt(req.getParameter("quantity"));
                Item item = itemDAO.getItemById(id);
                if (item != null) {
                    boolean found = false;
                    for (CartItem ci : cart) {
                        if (ci.getItem().getId() == id) {
                            ci.setQuantity(ci.getQuantity() + qty);
                            found = true;
                            break;
                        }
                    }
                    if (!found) cart.add(new CartItem(item, qty));
                }
            } else if ("remove".equals(action)) {
                int id = Integer.parseInt(req.getParameter("itemId"));
                Iterator<CartItem> it = cart.iterator();
                while (it.hasNext()) {
                    if (it.next().getItem().getId() == id) it.remove();
                }
            } else if ("update".equals(action)) {
                // update quantities: expects itemId and quantity parameters (single item)
                int id = Integer.parseInt(req.getParameter("itemId"));
                int qty = Integer.parseInt(req.getParameter("quantity"));
                for (CartItem ci : cart) {
                    if (ci.getItem().getId() == id) {
                        ci.setQuantity(qty);
                        break;
                    }
                }
            }
            session.setAttribute("cart", cart);
            resp.sendRedirect(req.getHeader("referer") != null ? req.getHeader("referer") : "catalog");
        } catch (NumberFormatException | SQLException e) {
            throw new ServletException(e);
        }
    }
}
