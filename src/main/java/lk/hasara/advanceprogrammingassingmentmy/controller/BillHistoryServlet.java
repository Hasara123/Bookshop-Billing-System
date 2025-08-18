package lk.hasara.advanceprogrammingassingmentmy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.hasara.advanceprogrammingassingmentmy.dao.BillDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.Bill;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/billHistory")
public class BillHistoryServlet extends HttpServlet {
    private BillDAO billDAO;

    @Override
    public void init() {
        billDAO = new BillDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Bill> bills = billDAO.getAllBills();
            req.setAttribute("bills", bills);
            req.getRequestDispatcher("billHistory.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
