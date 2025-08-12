package lk.hasara.advanceprogrammingassingmentmy.controller.command;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.hasara.advanceprogrammingassingmentmy.dao.CustomerDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.Customer;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class DisplayAccountDetailsCommand implements Command {

    private final CustomerDAO customerDAO;

    public DisplayAccountDetailsCommand(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        List<Customer> customers = customerDAO.getAllCustomers();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("DisplayAccountDetails.jsp").forward(request, response);
    }
}
