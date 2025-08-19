package lk.hasara.advanceprogrammingassingmentmy.dao;

import lk.hasara.advanceprogrammingassingmentmy.model.Item;
import lk.hasara.advanceprogrammingassingmentmy.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {

    // Get all items
    public List<Item> getAllItems() throws SQLException {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                items.add(mapRowToItem(rs));
            }
        }
        return items;
    }

    // Get item by ID
    public Item getItemById(int id) throws SQLException {
        String sql = "SELECT * FROM items WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToItem(rs);
                }
            }
        }
        return null;
    }

    // Search items
    public List<Item> searchItems(String keyword, String category) {
        List<Item> items = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM items WHERE 1=1");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (title LIKE ? OR author LIKE ? OR isbn LIKE ?)");
        }
        if (category != null && !category.trim().isEmpty()) {
            sql.append(" AND category = ?");
        }

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int index = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String likeKeyword = "%" + keyword + "%";
                stmt.setString(index++, likeKeyword);
                stmt.setString(index++, likeKeyword);
                stmt.setString(index++, likeKeyword);
            }
            if (category != null && !category.trim().isEmpty()) {
                stmt.setString(index++, category);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                items.add(mapRowToItem(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }

    // Add item
    public boolean addItem(Item item) throws SQLException {
        String sql = "INSERT INTO items (title, author, isbn, category, price, stock) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, item.getTitle());
            stmt.setString(2, item.getAuthor());
            stmt.setString(3, item.getIsbn());
            stmt.setString(4, item.getCategory());
            stmt.setDouble(5, item.getPrice());
            stmt.setInt(6, item.getStock());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            if (e.getErrorCode() == 1062 && e.getMessage().contains("unique_isbn")) {
                throw new SQLException("Duplicate ISBN: " + item.getIsbn(), e);
            }
            throw e;
        }
    }

    // Update existing item
    public boolean updateItem(Item item) throws SQLException {
        String sql = "UPDATE items SET title=?, author=?, isbn=?, category=?, price=?, stock=? WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, item.getTitle());
            stmt.setString(2, item.getAuthor());
            stmt.setString(3, item.getIsbn());
            stmt.setString(4, item.getCategory());
            stmt.setDouble(5, item.getPrice());
            stmt.setInt(6, item.getStock());
            stmt.setInt(7, item.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    // Delete item by ID
    public boolean deleteItem(int id) throws SQLException {
        String sql = "DELETE FROM items WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    // Get all categories
    public List<String> getAllCategories() throws SQLException {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM items ORDER BY category";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        }
        return categories;
    }

    // Map result set row to Item object
    private Item mapRowToItem(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setId(rs.getInt("id"));
        item.setTitle(rs.getString("title"));
        item.setAuthor(rs.getString("author"));
        item.setIsbn(rs.getString("isbn"));
        item.setCategory(rs.getString("category"));
        item.setPrice(rs.getDouble("price"));
        item.setStock(rs.getInt("stock"));
        return item;
    }

    // Get low stock items (threshold)
    public List<Item> getLowStockItems(int threshold) throws SQLException {
        String sql = "SELECT id, title, stock FROM items WHERE stock <= ? ORDER BY stock ASC";
        List<Item> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, threshold);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Item item = new Item();
                    item.setId(rs.getInt("id"));
                    item.setTitle(rs.getString("title"));
                    item.setStock(rs.getInt("stock"));
                    list.add(item);
                }
            }
        }
        return list;
    }

    // Get most selling books (top N)
    public List<Item> getMostSellingBooks(int limit) throws SQLException {
        String sql = "SELECT i.id, i.title, SUM(bi.quantity) AS totalSold " +
                "FROM bill_items bi " +
                "JOIN items i ON bi.book_id = i.id " +
                "GROUP BY i.id, i.title " +
                "ORDER BY totalSold DESC " +
                "LIMIT ?";
        List<Item> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Item item = new Item();
                    item.setId(rs.getInt("id"));
                    item.setTitle(rs.getString("title"));
                    item.setTotalSold(rs.getInt("totalSold")); // Ensure your Item model has totalSold field
                    list.add(item);
                }
            }
        }
        return list;
    }
}
