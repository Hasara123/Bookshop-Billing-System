package lk.hasara.advanceprogrammingassingmentmy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.hasara.advanceprogrammingassingmentmy.dao.UserDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.User;
import lk.hasara.advanceprogrammingassingmentmy.util.PasswordUtil;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("Login attempt: email=" + email + ", hashed password=" + PasswordUtil.hashPassword(password));


        UserDAO dao = new UserDAO();
        User user = dao.login(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user.getEmail());
            session.setAttribute("role", user.getRole());

            // Redirect based on role
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("DashBoard.jsp");
            } else if ("CASHIER".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("CashierDashboard.jsp");
            } else {
                // default fallback
                response.sendRedirect("index.jsp");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}
