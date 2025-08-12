package lk.hasara.advanceprogrammingassingmentmy.controller.command;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.hasara.advanceprogrammingassingmentmy.dao.CustomerDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.Customer;

import java.io.IOException;
import java.sql.SQLException;

public class ShowEditFormCommand implements Command {
    private final CustomerDAO customerDAO;

    public ShowEditFormCommand(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String accountNo = request.getParameter("accountNo");
        Customer customer = customerDAO.getCustomerByAccountNo(accountNo);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("edit-customer.jsp").forward(request, response);
    }
}
