<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Customer - Pahana Edu</title>
    <link rel="stylesheet" href="component/style.css">
    <style>
        #flashMessage {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            font-weight: bold;
            text-align: center;
        }

        #errorMessage {
            background-color: #f44336;
            color: white;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            font-weight: bold;
            text-align: center;
        }

        form input, form button {
            margin-bottom: 10px;
            padding: 8px;
            width: 100%;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        form button {
            background-color: #0077cc;
            color: white;
            border: none;
            cursor: pointer;
        }

        form button:hover {
            background-color: #005fa3;
        }
    </style>
</head>
<body>

<%@ include file="component/sidebar.jsp" %>

<div class="main-container">
    <div class="content-wrapper">
        <h1>Add New Customer</h1>

        <!-- Success message -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div id="flashMessage">${sessionScope.successMessage}</div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>

        <!-- Error message -->
        <c:if test="${not empty requestScope.errorMessage}">
            <div id="errorMessage">${requestScope.errorMessage}</div>
        </c:if>

        <form action="customers" method="post">
            <input type="hidden" name="action" value="add" />

            <label for="name">Name</label><br/>
            <input type="text" id="name" name="name" required /><br/>

            <label for="accountNo">Account Number</label><br/>
            <input type="text" id="accountNo" name="accountNo" required /><br/>

            <label for="address">Address</label><br/>
            <input type="text" id="address" name="address" required /><br/>

            <label for="phone">Phone</label><br/>
            <input type="text" id="phone" name="phone" required /><br/>

            <button type="submit">Add Customer</button>
            <a href="customers"><button type="button">Cancel</button></a>
        </form>
    </div>
</div>

<script>
    // Hide success flash message after 3 seconds
    setTimeout(function() {
        var msg = document.getElementById("flashMessage");
        if(msg) msg.style.display = "none";
    }, 3000);
</script>

</body>
</html>
