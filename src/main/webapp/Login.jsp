<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login | Pahana Edu Bookshop</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #e6f2ff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('img/img2.jpg');
            background-size: cover;
            background-position: center;
        }

        .login-container {
            background: rgba(0, 0, 0, 0.6);
            padding: 2.5rem;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 400px;
            color: white;
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            font-size: 1.8rem;
            color: #fff;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.4rem;
            color: #ddd;
            font-size: 0.95rem;
        }

        .form-group input {
            width: 100%;
            padding: 0.7rem;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 1rem;
            background: #f9f9f9;
            color: #333;
        }

        .form-group input:focus {
            border-color: #0077cc;
            outline: none;
        }

        .password-wrapper {
            position: relative;
        }

        .toggle-password {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1.1rem;
            color: #333;
        }

        .login-btn {
            width: 100%;
            padding: 0.8rem;
            background: #0077cc;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .login-btn:hover {
            background: #005fa3;
        }

        .footer-text {
            margin-top: 1.5rem;
            text-align: center;
            color: #ccc;
            font-size: 0.85rem;
        }

        .error-msg {
            color: red;
            text-align: center;
            margin-top: 0.8rem;
        }

        .backButton {
            position: absolute;
            top: 20px;
            left: 20px;
        }

        .backButton button {
            background: #0077cc;
            color: white;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .backButton button:hover {
            background: #005fa3;
        }
    </style>
</head>
<body>
<div class="backButton">
    <button onclick="window.location.href='index.jsp'">Back</button>
</div>

<div class="login-container">
    <h2>Login to Pahana Edu</h2>

    <form action="LoginServlet" method="post">
        <div class="form-group">
            <label for="username">Email Address</label>
            <input type="text" id="username" name="username" required placeholder="Enter your email" autocomplete="email">
        </div>

        <div class="form-group password-wrapper">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required placeholder="Enter your password" autocomplete="current-password">
            <button type="button" class="toggle-password" onclick="togglePassword()">👁</button>
        </div>

        <button type="submit" class="login-btn">Login</button>

        <p class="error-msg">${errorMessage}</p>
    </form>

    <p class="footer-text">© 2025 Pahana Edu Bookshop. All rights reserved.</p>
</div>

<script>
    function togglePassword() {
        const pwd = document.getElementById("password");
        pwd.type = pwd.type === "password" ? "text" : "password";
    }
</script>
</body>
</html>
