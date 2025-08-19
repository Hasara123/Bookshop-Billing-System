<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Customer - Pahana Edu</title>
    <link rel="stylesheet" href="component/style.css">
    <style>
        #flashMessage {
            background-color: #28a745;
            color: white;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            font-weight: bold;
            text-align: center;
        }

        #errorMessage {
            background-color: #dc3545;
            color: white;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            font-weight: bold;
            text-align: center;
        }
    </style>
</head>
<body>

<%@ include file="component/sidebar.jsp" %>

<div class="main-container">
    <div class="content-wrapper">
        <h1>Edit Customer</h1>

        <!-- Flash messages -->
        <c:if test="${not empty successMessage}">
            <div id="flashMessage">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div id="errorMessage">${errorMessage}</div>
        </c:if>

        <form action="customers" method="post">
            <input type="hidden" name="action" value="update" />
            <input type="hidden" name="id" value="${customer.id}" />

            <label for="name">Name</label><br/>
            <input type="text" id="name" name="name" value="${customer.name}" required /><br/>

            <label for="accountNo">Account Number</label><br/>
            <input type="text" id="accountNo" name="accountNo" value="${customer.accountNo}" readonly /><br/>

            <label for="address">Address</label><br/>
            <input type="text" id="address" name="address" value="${customer.address}" required /><br/>

            <label for="phone">Phone</label><br/>
            <input type="text" id="phone" name="phone" value="${customer.phone}" required /><br/>

            <button type="submit">Update Customer</button>
            <a href="customers"><button type="button">Cancel</button></a>
        </form>
    </div>
</div>

<script>
    // Hide flash messages after 3 seconds
    setTimeout(() => {
        const flash = document.getElementById("flashMessage");
        if(flash) flash.style.display = "none";
        const error = document.getElementById("errorMessage");
        if(error) error.style.display = "none";
    }, 3000);
</script>

</body>
</html>
