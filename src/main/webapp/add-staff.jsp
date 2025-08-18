<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Staff - Pahana Edu</title>
    <link rel="stylesheet" href="component/style.css">
    <style>
        /* Flash messages */
        .alert-success {
            background-color: #28a745;
            color: white;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            font-weight: bold;
            text-align: center;
        }
        .alert-error {
            background-color: #dc3545;
            color: white;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            font-weight: bold;
            text-align: center;
        }

        /* Form styling */
        .form-container {
            max-width: 500px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 6px;
            background-color: #f9f9f9;
        }
        .form-container h2 {
            margin-bottom: 15px;
            text-align: center;
        }
        .form-container label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        .form-container input, .form-container select {
            width: 100%;
            padding: 8px 10px;
            margin-top: 5px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        .form-container button {
            margin-top: 15px;
            padding: 8px 15px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        .btn-submit { background-color: #0077cc; color: white; }
        .btn-submit:hover { background-color: #005fa3; }
        .btn-back { background-color: #ccc; color: #333; margin-left: 5px; }
        .btn-back:hover { background-color: #999; }
    </style>
</head>
<body>

<%@ include file="component/sidebar.jsp" %>

<div class="main-container">
    <div class="content-wrapper">
        <div class="form-container">
            <h2>Add New Staff</h2>

            <!-- Flash messages -->
            <c:if test="${not empty sessionScope.message}">
                <div class="${sessionScope.msgType == 'success' ? 'alert-success' : 'alert-error'}">
                        ${sessionScope.message}
                </div>
                <c:remove var="message" scope="session"/>
                <c:remove var="msgType" scope="session"/>
            </c:if>

            <form action="staff" method="post">
                <input type="hidden" name="action" value="add" />

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" placeholder="Enter email" required />

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter password" required />

                <label for="role">Role:</label>
                <select id="role" name="role" required>
                    <option value="">Select role</option>
                    <option value="ADMIN">Admin</option>
                    <option value="CASHIER">Cashier</option>
                </select>

                <button type="submit" class="btn-submit">Add Staff</button>
                <a href="staff"><button type="button" class="btn-back">Back</button></a>
            </form>
        </div>
    </div>
</div>

<script>
    // Auto-hide flash messages after 4 seconds
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert-success, .alert-error');
        alerts.forEach(alert => alert.style.display = 'none');
    }, 4000);
</script>

</body>
</html>
