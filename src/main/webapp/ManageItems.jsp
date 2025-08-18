<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Items - Pahana Edu</title>
    <link rel="stylesheet" href="component/style.css">
    <style>
        .alert-success {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            text-align: center;
        }

        .alert-error {
            background-color: #f44336;
            color: white;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            text-align: center;
        }

        .update, .delete {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .update { background-color: #4CAF50; color: white; }
        .update:hover { background-color: #3e8e41; }
        .delete { background-color: #f44336; color: white; }
        .delete:hover { background-color: #da190b; }

        form.inline-edit input[type="text"], form.inline-edit input[type="number"] {
            width: 90px;
            padding: 3px;
            margin-right: 5px;
        }

        form.inline-edit button { padding: 3px 6px; margin-left: 3px; }
        .btn-primary {
            background-color: #0077cc;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-primary:hover {
            background-color: #005fa3;
        }

    </style>
</head>
<body>

<%@ include file="component/sidebar.jsp" %>

<div class="main-container">
    <div class="content-wrapper">
        <h1>Manage Items</h1>

        <!-- Flash messages -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert-success">${sessionScope.successMessage}</div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="alert-error">${sessionScope.errorMessage}</div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

        <!-- Add Item button -->
        <a href="add-item.jsp"><button class="btn-primary">➕ Add Item</button></a>

        <!-- Item Table -->
        <table class="user-table" style="margin-top:20px;">
            <thead>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>ISBN</th>
                <th>Category</th>
                <th>Stock</th>
                <th>Price</th>
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
                    <td>${item.stock}</td>
                    <td>${item.price}</td>
                    <td>
                        <!-- Edit / Delete buttons -->
                        <button type="button" class="update" onclick="showEdit(${item.id})">Edit</button>
                        <a href="items?action=delete&id=${item.id}" onclick="return confirm('Delete this item?');">
                            <button type="button" class="delete">Delete</button>
                        </a>

                        <!-- Inline edit form -->
                        <form id="edit-form-${item.id}" class="inline-edit" action="items" method="post" style="display:none;">
                            <input type="hidden" name="action" value="update" />
                            <input type="hidden" name="id" value="${item.id}" />
                            <input type="text" name="title" value="${item.title}" required />
                            <input type="text" name="author" value="${item.author}" required />
                            <input type="text" name="isbn" value="${item.isbn}" required readonly />
                            <input type="text" name="category" value="${item.category}" required />
                            <input type="number" name="stock" value="${item.stock}" required />
                            <input type="number" step="0.01" name="price" value="${item.price}" required />
                            <button type="submit" class="update">Save</button>
                            <button type="button" class="delete" onclick="hideEdit(${item.id})">Cancel</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    function showEdit(id) { document.getElementById('edit-form-' + id).style.display = 'block'; }
    function hideEdit(id) { document.getElementById('edit-form-' + id).style.display = 'none'; }

    // Auto-hide messages
    setTimeout(() => {
        const alerts = document.querySelectorAll(".alert-success, .alert-error");
        alerts.forEach(a => a.style.display = "none");
    }, 4000);
</script>
</body>
</html>
