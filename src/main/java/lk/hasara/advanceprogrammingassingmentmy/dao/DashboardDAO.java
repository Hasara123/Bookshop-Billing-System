package lk.hasara.advanceprogrammingassingmentmy.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import lk.hasara.advanceprogrammingassingmentmy.util.DBUtil;


public class DashboardDAO {

    public int getCustomerCount() {
        return getCount("SELECT COUNT(*) FROM customers");
    }

    public int getBillsCount() {
        return getCount("SELECT COUNT(*) FROM bills");
    }

    public int getCashierCount() {
        return getCount("SELECT COUNT(*) FROM users WHERE role='Cashier'");
    }

    public int getInventoryCount() {
        return getCount("SELECT COUNT(*) FROM items");
    }

    private int getCount(String query) {
        int count = 0;
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
