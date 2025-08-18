<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Item</title>
    <style>
        .alert-success { color: green; }
        .alert-error { color: red; }
    </style>
</head>
<body>
<h2>Edit Item</h2>

<!-- Success and error messages -->
<c:if test="${not empty successMessage}">
    <div class="alert-success">${successMessage}</div>
</c:if>
<c:if test="${not empty errorMessage}">
    <div class="alert-error">${errorMessage}</div>
</c:if>

<form action="items" method="post">
    <input type="hidden" name="action" value="update" />
    <input type="hidden" name="id" value="${item.id}" />

    <label>Title: <input type="text" name="title"
                         value="${title != null ? title : item.title}" required /></label><br/>
    <label>Author: <input type="text" name="author"
                          value="${author != null ? author : item.author}" required /></label><br/>
    <label>ISBN: <input type="text" name="isbn"
                        value="${isbn != null ? isbn : item.isbn}" required /></label><br/>
    <label>Category: <input type="text" name="category"
                            value="${category != null ? category : item.category}" required /></label><br/>
    <label>Price: <input type="number" step="0.01" name="price"
                         value="${price != null ? price : item.price}" required /></label><br/>
    <button type="submit">Update Item</button>
</form>

<a href="items">Back to Manage Items</a>
</body>
</html>
