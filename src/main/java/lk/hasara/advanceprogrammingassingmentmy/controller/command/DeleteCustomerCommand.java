package lk.hasara.advanceprogrammingassingmentmy.controller.command;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.hasara.advanceprogrammingassingmentmy.dao.CustomerDAO;

import java.io.IOException;
import java.sql.SQLException;

public class DeleteCustomerCommand implements Command {
    private final CustomerDAO customerDAO;

    public DeleteCustomerCommand(CustomerDAO customerDAO) {
        this.customerDAO = customerDAO;
    }

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws IOException, SQLException {
        String id = request.getParameter("id");

        // Delete customer
        customerDAO.deleteCustomer(id);

        // Add flash message in session
        request.getSession().setAttribute("successMessage", "Customer deleted successfully.");

        // Redirect to customer listing
        response.sendRedirect("customers?action=list");
    }
}
