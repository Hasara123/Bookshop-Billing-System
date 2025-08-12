package lk.hasara.advanceprogrammingassingmentmy.controller.command;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.hasara.advanceprogrammingassingmentmy.dao.CustomerDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.Customer;

import java.io.IOException;
import java.sql.SQLException;

public class AddCustomerCommand implements Command {
    private final CustomerDAO customerDAO;

    public AddCustomerCommand(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        if ("GET".equalsIgnoreCase(request.getMethod())) {
            // Show AddCustomer form
            request.getRequestDispatcher("add-customer.jsp").forward(request, response);
        } else {
            // Handle POST to add customer
            String name = request.getParameter("name");
            String accountNo = request.getParameter("accountNo");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");

            Customer customer = new Customer(name, accountNo, address, phone);
            customerDAO.addCustomer(customer);
            response.sendRedirect("customers?action=list");
        }
    }
}
