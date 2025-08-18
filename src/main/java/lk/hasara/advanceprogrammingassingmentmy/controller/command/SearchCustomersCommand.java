package lk.hasara.advanceprogrammingassingmentmy.controller.command;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.hasara.advanceprogrammingassingmentmy.dao.CustomerDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.Customer;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class SearchCustomersCommand implements Command {
    private final CustomerDAO customerDAO;

    public SearchCustomersCommand(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String keyword = request.getParameter("keyword");
        if (keyword == null) keyword = "";

        List<Customer> customers = customerDAO.searchCustomers(keyword);

        request.setAttribute("customers", customers);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("ManageCustomers.jsp").forward(request, response);
    }
}
