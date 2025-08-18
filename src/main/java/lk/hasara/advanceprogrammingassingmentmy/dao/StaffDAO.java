package lk.hasara.advanceprogrammingassingmentmy.dao;

import lk.hasara.advanceprogrammingassingmentmy.model.User;
import lk.hasara.advanceprogrammingassingmentmy.util.DBUtil;
import lk.hasara.advanceprogrammingassingmentmy.util.PasswordUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {

    // List all staff or search by keyword
    public List<User> getAllStaff(String keyword) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE email LIKE ? OR role LIKE ? ORDER BY id";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String kw = "%" + (keyword == null ? "" : keyword.trim()) + "%";
            stmt.setString(1, kw);
            stmt.setString(2, kw);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getString("role"));
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Add new staff user (password hashed)
    public boolean addStaff(User user) {
        String sql = "INSERT INTO users (email, password, role) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getEmail());
            stmt.setString(2, PasswordUtil.hashPassword(user.getPassword()));
            stmt.setString(3, user.getRole());

            int affected = stmt.executeUpdate();
            return affected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update staff user; if password is blank, keep old password
    public boolean updateStaff(User user) {
        try (Connection conn = DBUtil.getConnection()) {
            String sql;
            PreparedStatement stmt;

            if (user.getPassword() == null || user.getPassword().isEmpty()) {
                // Update without password
                sql = "UPDATE users SET email = ?, role = ? WHERE id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, user.getEmail());
                stmt.setString(2, user.getRole());
                stmt.setInt(3, user.getId());
            } else {
                // Update including password (hashed)
                sql = "UPDATE users SET email = ?, password = ?, role = ? WHERE id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, user.getEmail());
                stmt.setString(2, PasswordUtil.hashPassword(user.getPassword()));
                stmt.setString(3, user.getRole());
                stmt.setInt(4, user.getId());
            }

            int affected = stmt.executeUpdate();
            return affected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete staff by id
    public boolean deleteStaff(int id) {
        String sql = "DELETE FROM users WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int affected = stmt.executeUpdate();
            return affected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get user by ID (for pre-filling form if needed)
    public User getStaffById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getString("role"));
                // don't set password
                return u;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
