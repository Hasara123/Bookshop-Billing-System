package lk.hasara.advanceprogrammingassingmentmy.dao;

import lk.hasara.advanceprogrammingassingmentmy.model.Bill;
import lk.hasara.advanceprogrammingassingmentmy.model.BillItem;
import lk.hasara.advanceprogrammingassingmentmy.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class BillDAO {

    /**
     * Saves bill and items, checks & decrements stock for each item within the same transaction.
     * Returns generated bill id.
     */
    public int saveBill(Bill bill) throws SQLException {
        String sqlBill = "INSERT INTO bills (customer_id, bill_date, total, created_by, payment_method, accountNo) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlItem = "INSERT INTO bill_items (bill_id, book_id, quantity, price) VALUES (?, ?, ?, ?)";
        String sqlSelectStock = "SELECT stock FROM items WHERE id = ? FOR UPDATE";
        String sqlUpdateStock = "UPDATE items SET stock = ? WHERE id = ?";

        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);
            int billId;

            try {
                // Insert bill
                try (PreparedStatement ps = conn.prepareStatement(sqlBill, Statement.RETURN_GENERATED_KEYS)) {
                    if (bill.getCustomerId() == null)
                        ps.setNull(1, Types.INTEGER);
                    else
                        ps.setInt(1, bill.getCustomerId());

                    ps.setTimestamp(2, new Timestamp(bill.getBillDate().getTime()));
                    ps.setDouble(3, bill.getTotal());

                    if (bill.getCreatedBy() == null)
                        ps.setNull(4, Types.VARCHAR);
                    else
                        ps.setString(4, bill.getCreatedBy());

                    if (bill.getPaymentMethod() == null)
                        ps.setNull(5, Types.VARCHAR);
                    else
                        ps.setString(5, bill.getPaymentMethod());

                    if (bill.getAccountNo() == null)
                        ps.setNull(6, Types.VARCHAR);
                    else
                        ps.setString(6, bill.getAccountNo());

                    ps.executeUpdate();

                    try (ResultSet g = ps.getGeneratedKeys()) {
                        if (g.next()) billId = g.getInt(1);
                        else throw new SQLException("Failed to obtain bill id");
                    }
                }

                // For each bill item: check stock, insert bill_item, decrement stock
                try (PreparedStatement psSelectStock = conn.prepareStatement(sqlSelectStock);
                     PreparedStatement psUpdateStock = conn.prepareStatement(sqlUpdateStock);
                     PreparedStatement psInsertItem = conn.prepareStatement(sqlItem)) {

                    for (BillItem bi : bill.getItems()) {
                        int bookId = bi.getBookId();
                        int qty = bi.getQuantity();

                        // Lock and check stock
                        psSelectStock.setInt(1, bookId);
                        try (ResultSet rs = psSelectStock.executeQuery()) {
                            if (!rs.next()) {
                                throw new SQLException("Item not found (id=" + bookId + ")");
                            }
                            int currentStock = rs.getInt("stock");
                            if (currentStock < qty) {
                                throw new SQLException("Insufficient stock for item id=" + bookId +
                                        ". Available: " + currentStock + ", required: " + qty);
                            }

                            int newStock = currentStock - qty; // ✅ direct assignment
                            // 🔍 Debug logs
                            System.out.println("Processing BookID=" + bookId);
                            System.out.println("   Current Stock = " + currentStock);
                            System.out.println("   Quantity Sold = " + qty);
                            System.out.println("   New Stock     = " + newStock);

                            // Insert bill_items row
                            psInsertItem.setInt(1, billId);
                            psInsertItem.setInt(2, bookId);
                            psInsertItem.setInt(3, qty);
                            psInsertItem.setDouble(4, bi.getPrice());
                            psInsertItem.addBatch();

                            // Update stock with direct assignment
                            psUpdateStock.setInt(1, newStock);
                            psUpdateStock.setInt(2, bookId);
                            psUpdateStock.addBatch();
                        }
                    }

                    psInsertItem.executeBatch();
                    psUpdateStock.executeBatch();
                }

                conn.commit();
                return billId;

            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    /**
     * Get bill basic info by bill id, including items
     */
    public Bill getBillById(int billId) throws SQLException {
        String sql = "SELECT b.*, c.name AS customer_name FROM bills b LEFT JOIN customers c ON b.accountNo = c.accountNo WHERE b.id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, billId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Bill b = new Bill();
                    b.setId(rs.getInt("id"));

                    String accountNo = rs.getString("accountNo");
                    if (rs.wasNull()) accountNo = null;
                    b.setAccountNo(accountNo);

                    b.setBillDate(rs.getTimestamp("bill_date"));
                    b.setTotal(rs.getDouble("total"));
                    b.setCreatedBy(rs.getString("created_by"));
                    b.setPaymentMethod(rs.getString("payment_method"));

                    // Load items
                    b.setItems(getBillItemsByBillId(billId));
                    return b;
                }
            }
        }
        return null;
    }

    /**
     * Get bill items for a bill
     */
    public List<BillItem> getBillItemsByBillId(int billId) throws SQLException {
        String sql = "SELECT bi.*, i.title FROM bill_items bi LEFT JOIN items i ON bi.book_id = i.id WHERE bi.bill_id = ?";
        List<BillItem> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, billId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BillItem bi = new BillItem();
                    bi.setId(rs.getInt("id"));
                    bi.setBillId(rs.getInt("bill_id"));
                    bi.setBookId(rs.getInt("book_id"));
                    bi.setQuantity(rs.getInt("quantity"));
                    bi.setPrice(rs.getDouble("price"));
                    // Optional: add title if BillItem has it
                    list.add(bi);
                }
            }
        }
        return list;
    }

    /**
     * Get all bills (for bill history)
     */
    public List<Bill> getAllBills() throws SQLException {
        String sql = "SELECT b.id, b.accountNo, b.bill_date, b.total, b.created_by, b.payment_method, c.name AS customer_name " +
                "FROM bills b LEFT JOIN customers c ON b.accountNo = c.accountNo ORDER BY b.bill_date DESC";
        List<Bill> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Bill b = new Bill();
                b.setId(rs.getInt("id"));
                String accountNo = rs.getString("accountNo");
                if (rs.wasNull()) accountNo = null;
                b.setAccountNo(accountNo);
                b.setBillDate(rs.getTimestamp("bill_date"));
                b.setTotal(rs.getDouble("total"));
                b.setCreatedBy(rs.getString("created_by"));
                b.setPaymentMethod(rs.getString("payment_method"));
                list.add(b);
            }
        }
        return list;
    }

    /** Additional helper methods for dashboard/statistics **/

    public int getTotalBills() throws SQLException {
        String sql = "SELECT COUNT(*) AS total FROM bills";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt("total");
        }
        return 0;
    }

    public double getTotalSalesThisMonth() throws SQLException {
        String sql = "SELECT IFNULL(SUM(total),0) AS total_sales FROM bills WHERE MONTH(bill_date)=MONTH(CURRENT_DATE()) AND YEAR(bill_date)=YEAR(CURRENT_DATE())";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getDouble("total_sales");
        }
        return 0;
    }

    public int getCustomersServedThisMonth() throws SQLException {
        String sql = "SELECT COUNT(DISTINCT accountNo) AS customers FROM bills WHERE MONTH(bill_date)=MONTH(CURRENT_DATE()) AND YEAR(bill_date)=YEAR(CURRENT_DATE())";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt("customers");
        }
        return 0;
    }

    public List<Bill> getRecentBills(int limit) throws SQLException {
        String sql = "SELECT b.id, b.accountNo, b.bill_date, b.total, b.payment_method FROM bills b ORDER BY b.bill_date DESC LIMIT ?";
        List<Bill> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Bill b = new Bill();
                    b.setId(rs.getInt("id"));
                    b.setAccountNo(rs.getString("accountNo"));
                    b.setBillDate(rs.getTimestamp("bill_date"));
                    b.setTotal(rs.getDouble("total"));
                    b.setPaymentMethod(rs.getString("payment_method"));
                    list.add(b);
                }
            }
        }
        return list;
    }

    public Map<String, Double> getMonthlyRevenue(int lastNMonths) throws SQLException {
        Map<String, Double> revenueMap = new LinkedHashMap<>();
        String sql = "SELECT DATE_FORMAT(bill_date, '%Y-%m') AS month, IFNULL(SUM(total),0) AS revenue " +
                "FROM bills WHERE bill_date >= DATE_SUB(CURDATE(), INTERVAL ? MONTH) " +
                "GROUP BY month ORDER BY month ASC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lastNMonths);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    revenueMap.put(rs.getString("month"), rs.getDouble("revenue"));
                }
            }
        }
        return revenueMap;
    }
}
