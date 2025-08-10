<%--
  Created by IntelliJ IDEA.
  User: Hasara Hithaishi
  Date: 7/24/2025
  Time: 8:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Register | Pahana Edu</title>
    <style>
        .backButton{
            position: absolute;
            top: 20px;
            left: 20px;
        }


        body {
            margin: 0;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background: #f1f5f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .register-container {
            background: white;
            padding: 2.5rem 3rem;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
        }

        .register-container h2 {
            margin-bottom: 1.5rem;
            text-align: center;
            color: #333;
        }

        .form-group {
            margin-bottom: 1.2rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.4rem;
            color: #555;
        }

        .form-group input {
            width: 100%;
            padding: 0.75rem;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 1rem;
            transition: border 0.3s ease;
        }

        .form-group input:focus {
            border-color: #0077cc;
            outline: none;
        }

        .register-btn {
            width: 100%;
            padding: 0.75rem;
            background: #0077cc;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .register-btn:hover {
            background: #005fa3;
        }

        .footer-text {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.9rem;
            color: #888;
        }
    </style>
</head>
<body>

<div class="backButton">
    <button onclick="window.location.href='index.jsp'">Back</button>
</div>

<div class="register-container">
    <h2>Create Your Account</h2>
    <form onsubmit="handleRegister(event)">
        <div class="form-group">
            <label for="fullname">Full Name</label>
            <input type="text" id="fullname" name="fullname" placeholder="Enter full name" required/>
        </div>

        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" placeholder="Enter email" required/>
        </div>

        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" placeholder="Choose a username" required/>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter password" required/>
        </div>

        <div class="form-group">
            <label for="confirm-password">Confirm Password</label>
            <input type="password" id="confirm-password" name="confirm-password" placeholder="Re-enter password" required/>
        </div>

        <button type="submit" class="register-btn">Register</button>
    </form>
    <p class="footer-text">© 2025 Pahana Edu Bookshop</p>
</div>

<script>
    function handleRegister(event) {
        event.preventDefault();

        // Later connect to backend (JSP/Servlet or DB)
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirm-password').value;

        if (password !== confirmPassword) {
            alert('Passwords do not match.');
            return;
        }

        // Redirect to login page (simulated)
        alert("Registered successfully!");
        window.location.href = 'Login.jsp';
    }
</script>
</body>
</html>

