package lk.hasara.advanceprogrammingassingmentmy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.hasara.advanceprogrammingassingmentmy.dao.BillDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.Bill;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/billHistory")
public class BillHistoryServlet extends HttpServlet {

    private BillDAO billDAO;

    @Override
    public void init() {
        billDAO = new BillDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fromDateStr = request.getParameter("fromDate");
        String toDateStr = request.getParameter("toDate");

        List<Bill> bills = new ArrayList<>();

        try {
            bills = billDAO.getAllBills(); // Get all bills initially

            // Optional: filter by date if provided
            if (fromDateStr != null && !fromDateStr.isEmpty() &&
                    toDateStr != null && !toDateStr.isEmpty()) {

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date fromDate = sdf.parse(fromDateStr);
                Date toDate = sdf.parse(toDateStr);

                List<Bill> filtered = new ArrayList<>();
                for (Bill b : bills) {
                    if (!b.getBillDate().before(fromDate) && !b.getBillDate().after(toDate)) {
                        filtered.add(b);
                    }
                }
                bills = filtered;
            }

            request.setAttribute("bills", bills);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load bills: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
        }

        request.getRequestDispatcher("billHistory.jsp").forward(request, response);
    }
}
