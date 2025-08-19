<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Item | Pahana Edu</title>
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
    </style>
</head>
<body>

<%@ include file="component/sidebar.jsp" %>

<div class="main-container">
    <div class="content-wrapper">
        <h1>Edit Item</h1>

        <!-- Flash messages -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div id="flashMessage">${sessionScope.successMessage}</div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.errorMessage}">
            <div id="errorMessage">${sessionScope.errorMessage}</div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

        <!-- Edit Item Form -->
        <form action="items" method="post">
            <input type="hidden" name="action" value="update" />
            <input type="hidden" name="id" value="${item.id}" />

            <label for="title">Title</label><br/>
            <input type="text" id="title" name="title" value="${item.title}" required /><br/>

            <label for="author">Author</label><br/>
            <input type="text" id="author" name="author" value="${item.author}" required /><br/>

            <label for="isbn">ISBN</label><br/>
            <input type="text" id="isbn" name="isbn" value="${item.isbn}" required /><br/>

            <label for="category">Category</label><br/>
            <input type="text" id="category" name="category" value="${item.category}" required /><br/>

            <label for="stock">Stock</label><br/>
            <input type="number" id="stock" name="stock" value="${item.stock}" required /><br/>

            <label for="price">Price</label><br/>
            <input type="number" step="0.01" id="price" name="price" value="${item.price}" required /><br/>

            <button type="submit">Update Item</button>
            <a href="items"><button type="button">Cancel</button></a>
        </form>
    </div>
</div>

<script>
    // Hide flash message after 3 seconds
    setTimeout(function() {
        var msg = document.getElementById("flashMessage");
        if(msg) msg.style.display = "none";

        var err = document.getElementById("errorMessage");
        if(err) err.style.display = "none";
    }, 3000);
</script>
</body>
</html>
