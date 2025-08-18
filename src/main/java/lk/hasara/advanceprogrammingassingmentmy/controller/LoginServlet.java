package lk.hasara.advanceprogrammingassingmentmy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.hasara.advanceprogrammingassingmentmy.dao.UserDAO;
import lk.hasara.advanceprogrammingassingmentmy.model.User;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String csrfToken = UUID.randomUUID().toString();
        request.getSession().setAttribute("csrfToken", csrfToken);


        request.getRequestDispatcher("Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String formToken = request.getParameter("csrfToken");
        String sessionToken = (String) session.getAttribute("csrfToken");
        if (sessionToken == null || !sessionToken.equals(formToken)) {
            request.setAttribute("errorMessage", "Invalid request. Please refresh and try again.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        // --- Get credentials from form ---
        String email = request.getParameter("username");
        String password = request.getParameter("password");

        // --- Validate user with DAO ---
        User user = userDAO.login(email, password);

        if (user != null) {
            // Invalidate old session & create new one
            session.invalidate();
            session = request.getSession(true);

            session.setAttribute("user", user.getEmail());
            session.setAttribute("role", user.getRole());

            // Set session timeout (15 minutes)
            session.setMaxInactiveInterval(15 * 60);

            // Secure session cookie
            Cookie jsession = new Cookie("JSESSIONID", session.getId());
            jsession.setHttpOnly(true);
            if (request.isSecure()) {
                jsession.setSecure(true);
            }
            response.addCookie(jsession);

            // --- Set success message in session ---
            session.setAttribute("successMessage", "Login successful. Welcome, " + user.getEmail() + "!");

            // --- Role-based redirect ---
            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("DashBoard.jsp");
            } else if ("CASHIER".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("CashierDashboard.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }

        } else {
            // Invalid login → back to login page
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}
