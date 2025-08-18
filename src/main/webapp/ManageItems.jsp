<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Items - Pahana Edu</title>
    <link rel="stylesheet" href="component/style.css">
</head>
<body>

<!-- Sidebar -->
<%@ include file="component/sidebar.jsp" %>

<div class="main-container">
    <div class="content-wrapper">
        <h1>Manage Items</h1>
        <p>Monitor, update, and control all book inventory from a single dashboard. Keep your catalog up to date.</p>

        <form action="items" method="get" id="filterForm">
            <input type="text" name="search" placeholder="🔍 Search books..." value="${param.search}" />

            <select name="category" onchange="document.getElementById('filterForm').submit();">
                <option value="" <c:if test="${empty param.category}">selected</c:if>>All Categories</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat}" <c:if test="${param.category == cat}">selected</c:if>>${cat}</option>
                </c:forEach>
            </select>

            <input type="hidden" name="action" value="search" />
            <button type="submit">Search</button>
        </form>


        <!-- Action Bar -->
        <div class="action-bar">
            <div class="right">
                <button class="export" type="button">Export</button>
                <a href="add-item.jsp"><button type="button" class="add-user">+ Add Item</button></a>
            </div>
        </div>

        <!-- Item Table -->
        <table class="user-table">
            <thead>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>ISBN</th>
                <th>Category</th>
                <th>Price (Rs.)</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${itemList}">
                <tr>
                    <td>${item.title}</td>
                    <td>${item.author}</td>
                    <td>${item.isbn}</td>
                    <td>${item.category}</td>
                    <td>${item.price}</td>
                    <td>
                        <a href="items?action=edit&id=${item.id}">
                            <button class="update" type="button">Update</button>
                        </a>
                        <a href="items?action=delete&id=${item.id}" onclick="return confirm('Are you sure you want to delete this item?');">
                            <button class="delete" type="button">Delete</button>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    // ✅ Auto-hide alerts after 3 seconds
    setTimeout(() => {
        const alerts = document.querySelectorAll(".alert");
        alerts.forEach(alert => alert.style.display = "none");
    }, 3000);
</script>

</body>
</html>
