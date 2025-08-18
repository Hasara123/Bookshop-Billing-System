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
import java.util.List;

@WebServlet("/catalog")
public class CatalogServlet extends HttpServlet {
    private ItemDAO itemDAO;

    @Override
    public void init() {
        itemDAO = new ItemDAO(); // uses your existing ItemDAO
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String search = req.getParameter("search");
        try {
            List<Item> items;
            if (search != null && !search.trim().isEmpty()) {
                items = itemDAO.searchItems(search.trim(), null);
            } else {
                items = itemDAO.getAllItems();
            }
            req.setAttribute("items", items);

            HttpSession session = req.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) cart = new ArrayList<>();
            req.setAttribute("cart", cart);

            req.getRequestDispatcher("catalog.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
