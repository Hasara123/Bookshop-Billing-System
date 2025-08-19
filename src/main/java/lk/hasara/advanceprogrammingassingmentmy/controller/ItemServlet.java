package lk.hasara.advanceprogrammingassingmentmy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.hasara.advanceprogrammingassingmentmy.dao.ItemDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.Item;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/items")
public class ItemServlet extends HttpServlet {
    private ItemDAO itemDAO;

    @Override
    public void init() {
        itemDAO = new ItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equalsIgnoreCase((String) session.getAttribute("role"))) {
            response.sendRedirect("DashBoard.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action != null ? action : "") {
                case "delete":
                    deleteItem(request, response, session);
                    break;
                case "search":
                    searchItems(request, response);
                    break;
                default:
                    listItems(request, response);
                    break;
            }
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect("items");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equalsIgnoreCase((String) session.getAttribute("role"))) {
            response.sendRedirect("DashBoard.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action != null ? action : "") {
                case "insert":
                    insertItem(request, response, session);
                    break;
                case "update":
                    updateItem(request, response, session);
                    break;
                default:
                    response.sendRedirect("items");
                    break;
            }
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect("items");
        }
    }

    private void listItems(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Item> itemList = itemDAO.getAllItems();
        List<String> categories = itemDAO.getAllCategories();

        request.setAttribute("itemList", itemList);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("ManageItems.jsp").forward(request, response);
    }

    private void searchItems(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String keyword = request.getParameter("search");
        String category = request.getParameter("category");

        List<Item> itemList = itemDAO.searchItems(keyword, category);
        List<String> categories = itemDAO.getAllCategories();

        request.setAttribute("itemList", itemList);
        request.setAttribute("categories", categories);
        request.setAttribute("search", keyword);
        request.setAttribute("selectedCategory", category);
        request.getRequestDispatcher("ManageItems.jsp").forward(request, response);
    }

    private void insertItem(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws SQLException, IOException, ServletException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        Item newItem = new Item(0, title, author, isbn, category, price, stock);

        try {
            itemDAO.addItem(newItem);
            session.setAttribute("successMessage", "Item '" + title + "' added successfully!");
            response.sendRedirect("items");
        } catch (SQLException e) {
            if (e.getMessage().contains("Duplicate") || e.getMessage().contains("UNIQUE")) {
                session.setAttribute("errorMessage", "ISBN already exists. Please use a unique ISBN.");
                response.sendRedirect("items");
            } else {
                throw e;
            }
        }
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        Item updatedItem = new Item(id, title, author, isbn, category, price, stock);

        itemDAO.updateItem(updatedItem);

        session.setAttribute("successMessage", "Item '" + title + "' updated successfully!");
        response.sendRedirect("items");
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Item item = itemDAO.getItemById(id);

        if (item != null) {
            itemDAO.deleteItem(id);
            session.setAttribute("successMessage", "Item '" + item.getTitle() + "' deleted successfully!");
        } else {
            session.setAttribute("errorMessage", "Item not found.");
        }
        response.sendRedirect("items");
    }
}
