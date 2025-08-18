<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Add New Item</title>
    <style>
        .alert {
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
            font-weight: bold;
        }
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
        }
        .alert-error {
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
<h2>Add New Item</h2>

<!-- Success message -->
<c:if test="${not empty successMessage}">
    <div class="alert alert-success">${successMessage}</div>
</c:if>

<!-- Error message -->
<c:if test="${not empty errorMessage}">
    <div class="alert alert-error">${errorMessage}</div>
</c:if>

<form action="items" method="post">
    <input type="hidden" name="action" value="insert" />
    <label>Title: <input type="text" name="title" value="${param.title}" required /></label><br/>
    <label>Author: <input type="text" name="author" value="${param.author}" required /></label><br/>
    <label>ISBN: <input type="text" name="isbn" value="${param.isbn}" required /></label><br/>
    <label>Category: <input type="text" name="category" value="${param.category}" required /></label><br/>
    <label>Price: <input type="number" step="0.01" name="price" value="${param.price}" required /></label><br/>
    <button type="submit">Add Item</button>
</form>
<a href="items">Back to Manage Items</a>

<script>
    // Auto-hide alerts after 3 seconds
    setTimeout(() => {
        const alerts = document.querySelectorAll(".alert");
        alerts.forEach(alert => alert.style.display = "none");
    }, 3000);
</script>
</body>
</html>
