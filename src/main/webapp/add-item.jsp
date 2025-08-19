<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Item | Pahana Edu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f4f6f8;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
        }

        /* Sidebar included from component/sidebar.jsp */

        .main-container {
            flex: 1;
            padding: 30px;
        }

        .card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 25px;
            max-width: 600px;
            margin: auto;
        }

        .card h1 {
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            text-align: center;
            color: #333;
        }

        label {
            font-weight: 500;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 15px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 1rem;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus, input[type="number"]:focus {
            border-color: #0077cc;
            outline: none;
        }

        .btn-primary {
            background-color: #0077cc;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 1rem;
            transition: background 0.3s;
        }

        .btn-primary:hover {
            background-color: #005fa3;
        }

        .btn-secondary {
            background-color: #6c757d;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 1rem;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        #flashMessage {
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: bold;
            text-align: center;
        }

        #errorMessage {
            background-color: #f44336;
            color: white;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: bold;
            text-align: center;
        }

        @media (max-width: 768px) {
            .card {
                padding: 20px;
                margin: 20px;
            }
        }
    </style>
</head>
<body>

<%@ include file="component/sidebar.jsp" %>

<div class="main-container">
    <div class="card">

        <h1>Add New Item</h1>

        <!-- Flash messages -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div id="flashMessage">${sessionScope.successMessage}</div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>

        <c:if test="${not empty requestScope.errorMessage}">
            <div id="errorMessage">${requestScope.errorMessage}</div>
        </c:if>

        <!-- Item Form -->
        <form action="items" method="post">
            <input type="hidden" name="action" value="insert" />

            <label for="title">Title</label>
            <input type="text" id="title" name="title" required placeholder="Book Title">

            <label for="author">Author</label>
            <input type="text" id="author" name="author" required placeholder="Author Name">

            <label for="isbn">ISBN</label>
            <input type="text" id="isbn" name="isbn" required placeholder="Book ISBN">

            <label for="category">Category</label>
            <input type="text" id="category" name="category" required placeholder="Book Category">

            <label for="price">Price</label>
            <input type="number" step="0.01" id="price" name="price" required placeholder="Price in USD">

            <label for="stock">Stock</label>
            <input type="number" id="stock" name="stock" required placeholder="Available Quantity">

            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary">Add Item</button>
                <a href="items" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Hide flash message after 3 seconds
    setTimeout(function() {
        var msg = document.getElementById("flashMessage");
        if (msg) msg.style.display = "none";
    }, 3000);
</script>
</body>
</html>
