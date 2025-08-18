package lk.hasara.advanceprogrammingassingmentmy.dao;

import lk.hasara.advanceprogrammingassingmentmy.model.Bill;
import lk.hasara.advanceprogrammingassingmentmy.model.BillItem;
import lk.hasara.advanceprogrammingassingmentmy.model.CartItem;
import lk.hasara.advanceprogrammingassingmentmy.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    /**
     * Saves bill and items, checks & decrements stock for each item within the same transaction.
     * Returns generated bill id.
     */
    public int saveBill(Bill bill) throws SQLException {
        String sqlBill = "INSERT INTO bills (customer_id, bill_date, total, created_by, payment_method, accountNo) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlItem = "INSERT INTO bill_items (bill_id, book_id, quantity, price) VALUES (?, ?, ?, ?)";
        String sqlSelectStock = "SELECT stock FROM items WHERE id = ? FOR UPDATE";
        String sqlUpdateStock = "UPDATE items SET stock = stock - ? WHERE id = ?";

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
                            int stock = rs.getInt("stock");
                            if (stock < qty) {
                                throw new SQLException("Insufficient stock for item id=" + bookId + ". Available: " + stock + ", required: " + qty);
                            }
                        }

                        // Insert bill_items row
                        psInsertItem.setInt(1, billId);
                        psInsertItem.setInt(2, bookId);
                        psInsertItem.setInt(3, qty);
                        psInsertItem.setDouble(4, bi.getPrice());
                        psInsertItem.addBatch();

                        // Decrement stock
                        psUpdateStock.setInt(1, qty);
                        psUpdateStock.setInt(2, bookId);
                        psUpdateStock.addBatch();
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
     * Get bill basic info by bill id
     */
    public Bill getBillById(int billId) throws SQLException {
        String sql = "SELECT b.*, c.name as customer_name FROM bills b LEFT JOIN customers c ON b.accountNo = c.accountNo WHERE b.id = ?";
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

                    // optionally store customer_name if needed
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
                    // optionally add item title to BillItem class if desired
                    list.add(bi);
                }
            }
        }
        return list;
    }

    /**
     * Get all bills (with optional customer names)
     */
    public List<Bill> getAllBills() throws SQLException {
        String sql = "SELECT b.id, b.accountNo, b.bill_date, b.total, b.created_by, b.payment_method, c.name as customer_name " +
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

                // optionally add customer_name to Bill model if needed
                list.add(b);
            }
        }
        return list;
    }
}
