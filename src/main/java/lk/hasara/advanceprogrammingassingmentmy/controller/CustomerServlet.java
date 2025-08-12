package lk.hasara.advanceprogrammingassingmentmy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.hasara.advanceprogrammingassingmentmy.controller.command.*;

import lk.hasara.advanceprogrammingassingmentmy.dao.CustomerDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/customers")
public class CustomerServlet extends HttpServlet {

    private CustomerDAO customerDAO;
    private Map<String, Command> commands;

    @Override
    public void init() {
        customerDAO = new CustomerDAO();
        commands = new HashMap<>();
        commands.put("list", new ListCustomersCommand(customerDAO));
        commands.put("add", new AddCustomerCommand(customerDAO));
        commands.put("edit", new ShowEditFormCommand(customerDAO));
        commands.put("update", new UpdateCustomerCommand(customerDAO));
        commands.put("delete", new DeleteCustomerCommand(customerDAO));
        commands.put("search", new SearchCustomersCommand(customerDAO));
        commands.put("display", new DisplayAccountDetailsCommand(customerDAO));

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "list";
        }
        Command command = commands.get(action);
        if (command == null) {
            command = commands.get("list");  // fallback
        }
        try {
            command.execute(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Database error: " + e.getMessage());
            request.setAttribute("msgType", "error");

            // Choose JSP based on action for error display:
            if ("add".equals(action)) {
                request.getRequestDispatcher("add-customer.jsp").forward(request, response);
            } else if ("edit".equals(action)) {
                request.getRequestDispatcher("edit-customer.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("ManageCustomers.jsp").forward(request, response);
            }
        }
    }
}
