<%--
  Created by IntelliJ IDEA.
  User: Hasara Hithaishi
  Date: 8/8/2025
  Time: 10:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Customer - Pahana Edu</title>
    <link rel="stylesheet" href="component/style.css">
</head>
<body>

<!-- Sidebar -->
<%@ include file="component/sidebar.jsp" %>

<div class="main-container">
    <div class="content-wrapper">
        <h1>Add New Customer</h1>

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

</body>
</html>
