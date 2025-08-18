package lk.hasara.advanceprogrammingassingmentmy.dao;

import lk.hasara.advanceprogrammingassingmentmy.model.Customer;
import lk.hasara.advanceprogrammingassingmentmy.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    // Add new customer
    public void addCustomer(Customer customer) throws SQLException {
        String sql = "INSERT INTO customers (name, accountNo, address, phone) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getAccountNo());
            stmt.setString(3, customer.getAddress());
            stmt.setString(4, customer.getPhone());

            stmt.executeUpdate();
        }
    }

    // Get all customers
    public List<Customer> getAllCustomers() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                customers.add(new Customer(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("accountNo"),
                        rs.getString("address"),
                        rs.getString("phone")
                ));
            }
        }

        return customers;
    }

    // Search customers by keyword (name, address, phone)
    public List<Customer> searchCustomers(String keyword) throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers WHERE name LIKE ? OR address LIKE ? OR phone LIKE ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String likeKeyword = "%" + keyword + "%";
            stmt.setString(1, likeKeyword);
            stmt.setString(2, likeKeyword);
            stmt.setString(3, likeKeyword);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                customers.add(new Customer(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("accountNo"),
                        rs.getString("address"),
                        rs.getString("phone")
                ));
            }
        }

        return customers;
    }


    // Get customer by account number (unique)
    public Customer getCustomerByAccountNo(String accountNo) throws SQLException {
        String sql = "SELECT * FROM customers WHERE accountNo = ?";
        Customer customer = null;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, accountNo);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                customer = new Customer(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("accountNo"),
                        rs.getString("address"),
                        rs.getString("phone")
                );
            }
        }
        return customer;
    }
    // in CustomerDAO
    public Customer getById(int id) throws SQLException {
        String sql = "SELECT * FROM customers WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Customer c = new Customer();
                    c.setId(rs.getInt("id"));
                    c.setAccountNo(rs.getString("account_no"));
                    c.setName(rs.getString("name"));
                    c.setPhone(rs.getString("phone"));
                    c.setAddress(rs.getString("address"));
                    return c;
                }
            }
        }
        return null;
    }

    public boolean isCustomerRegistered(String accountNo) throws Exception {
        String sql = "SELECT COUNT(*) FROM customers WHERE accountNo = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, accountNo);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    // Update existing customer
    public void updateCustomer(Customer customer) throws SQLException {
        String sql = "UPDATE customers SET name=?, address=?, phone=? WHERE accountNo=?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getAddress());
            stmt.setString(3, customer.getPhone());
            stmt.setString(4, customer.getAccountNo());

            stmt.executeUpdate();
        }
    }

    public void deleteCustomer(String id) throws SQLException {
        String sql = "DELETE FROM customers WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            stmt.executeUpdate();
        }
    }

}
