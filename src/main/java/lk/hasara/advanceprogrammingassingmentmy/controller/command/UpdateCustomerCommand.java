package lk.hasara.advanceprogrammingassingmentmy.controller.command;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.hasara.advanceprogrammingassingmentmy.dao.CustomerDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.Customer;

import jakarta.servlet.ServletException;
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

        // You might want to fetch the id by accountNo or include it in the form
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
        }

        response.sendRedirect("customers?action=list");
    }
}
