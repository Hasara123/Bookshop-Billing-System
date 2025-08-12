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

    public void init() {
        itemDAO = new ItemDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equalsIgnoreCase((String) session.getAttribute("role"))) {
            response.sendRedirect("DashBoard.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action != null ? action : "") {
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteItem(request, response);
                    break;
                case "search":
                    searchItems(request, response);
                    break;
                default:
                    listItems(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("Error handling GET: " + e.getMessage(), e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equalsIgnoreCase((String) session.getAttribute("role"))) {
            response.sendRedirect("DashBoard.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action != null ? action : "") {
                case "insert":
                    insertItem(request, response);
                    break;
                case "update":
                    updateItem(request, response);
                    break;
                default:
                    response.sendRedirect("items");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("Error handling POST: " + e.getMessage(), e);
        }
    }

    private void listItems(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Item> itemList = itemDAO.getAllItems();
        List<String> categories = itemDAO.getAllCategories();

        request.setAttribute("itemList", itemList);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("ManageItems.jsp").forward(request, response);
    }

    private void searchItems(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
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

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Item existingItem = itemDAO.getItemById(id);
        request.setAttribute("item", existingItem);
        request.getRequestDispatcher("edit-item.jsp").forward(request, response);
    }

    private void insertItem(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock")); // NEW

        Item newItem = new Item(0, title, author, isbn, category, price, stock);
        try {
            itemDAO.addItem(newItem);
            response.sendRedirect("items");
        } catch (SQLException e) {
            if (e.getMessage().contains("Duplicate") || e.getMessage().contains("UNIQUE")) {
                request.setAttribute("errorMessage", "ISBN already exists. Please use a unique ISBN.");
                request.getRequestDispatcher("add-item.jsp").forward(request, response);
            } else {
                throw e;
            }
        }
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock")); // NEW

        Item updatedItem = new Item(id, title, author, isbn, category, price, stock);
        itemDAO.updateItem(updatedItem);
        response.sendRedirect("items");
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        itemDAO.deleteItem(id);
        response.sendRedirect("items");
    }
}
