package lk.hasara.advanceprogrammingassingmentmy.controller.command;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import lk.hasara.advanceprogrammingassingmentmy.dao.CustomerDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.Customer;

import java.io.IOException;
import java.sql.SQLException;

public class UpdateCustomerCommand implements Command {
    private final CustomerDAO customerDAO;

    public UpdateCustomerCommand(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String name = request.getParameter("name");
        String accountNo = request.getParameter("accountNo");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        // Fetch existing customer
        Customer existingCustomer = customerDAO.getCustomerByAccountNo(accountNo);

        if (existingCustomer != null) {
            Customer updatedCustomer = new Customer(
                    existingCustomer.getId(),
                    name,
                    accountNo,
                    address,
                    phone
            );
            customerDAO.updateCustomer(updatedCustomer);

            // Add flash message
            request.getSession().setAttribute("successMessage", "Customer updated successfully.");
        } else {
            // Optional: flash error message if customer not found
            request.getSession().setAttribute("errorMessage", "Customer not found.");
        }

        // Redirect to customer list
        response.sendRedirect("customers?action=list");
    }
}
