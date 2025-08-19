<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Manage Customers - Pahana Edu</title>
    <link rel="stylesheet" href="component/style.css" />
    <style>
        /* Flash messages */
        .alert-success {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            font-weight: bold;
            text-align: center;
        }

        .alert-error {
            background-color: #f44336;
            color: white;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            font-weight: bold;
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
    </style>
</head>
<body>

<%@ include file="component/sidebar.jsp" %>

<div class="main-container">
    <div class="content-wrapper">
        <h1>Customer Management</h1>
        <p>Manage all customers. Add, update, delete, and search records.</p>

        <!-- Flash messages -->
        <c:if test="${not empty requestScope.successMessage}">
            <div class="alert-success">${requestScope.successMessage}</div>
        </c:if>
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="alert-success">${sessionScope.successMessage}</div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        <c:if test="${not empty requestScope.errorMessage}">
            <div class="alert-error">${requestScope.errorMessage}</div>
        </c:if>
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="alert-error">${sessionScope.errorMessage}</div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

        <!-- Add Customer button -->
        <a href="add-customer.jsp">
            <button type="button" class="btn btn-primary">➕ Add Customer</button>
        </a>

        <!-- Search form -->
        <form action="customers" method="get" style="margin-top:15px; display:flex; gap:10px; align-items:center;">
            <input type="hidden" name="action" value="search" />
            <input type="text" name="keyword" placeholder="Search..." value="${param.keyword}" />
            <button type="submit">Search</button>
            <a href="customers"><button type="button" class="btn ghost">Reset</button></a>
        </form>

        <!-- Customer table -->
        <table class="user-table" style="margin-top:20px;">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Account No</th>
                <th>Address</th>
                <th>Phone</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty customers}">
                    <c:forEach var="c" items="${customers}">
                        <tr>
                            <td>${c.id}</td>
                            <td>${c.name}</td>
                            <td>${c.accountNo}</td>
                            <td>${c.address}</td>
                            <td>${c.phone}</td>
                            <td>
                                <!-- Edit button -->
                                <button type="button" class="update" onclick="showEdit(${c.id})">Edit</button>

                                <!-- Delete button -->
                                <a href="customers?action=delete&accountNo=${c.accountNo}" onclick="return confirm('Delete this customer?');">
                                    <button type="button" class="delete">Delete</button>
                                </a>

                                <!-- Inline edit form -->
                                <form id="edit-form-${c.id}" action="customers" method="post" style="display:none; margin-top:8px;">
                                    <input type="hidden" name="action" value="update" />
                                    <input type="hidden" name="id" value="${c.id}" />
                                    <input type="text" name="name" value="${c.name}" required />
                                    <input type="text" name="accountNo" value="${c.accountNo}" readonly required />
                                    <input type="text" name="address" value="${c.address}" required />
                                    <input type="text" name="phone" value="${c.phone}" required />
                                    <button type="submit" class="btn-small btn">Save</button>
                                    <button type="button" class="btn-small" onclick="hideEdit(${c.id})">Cancel</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="6" style="text-align:center; padding:20px;">No customers found.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>

<script>
    function showEdit(id) {
        document.getElementById('edit-form-' + id).style.display = 'block';
    }
    function hideEdit(id) {
        document.getElementById('edit-form-' + id).style.display = 'none';
    }

    // Auto-hide flash messages
    setTimeout(() => {
        document.querySelectorAll('.alert-success, .alert-error').forEach(el => el.style.display='none');
    }, 4000);
</script>

</body>
</html>
