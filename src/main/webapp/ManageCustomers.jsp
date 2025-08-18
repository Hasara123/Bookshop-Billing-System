<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Manage Customers - Pahana Edu</title>
    <link rel="stylesheet" href="component/style.css" />
</head>
<body>

<%@ include file="component/sidebar.jsp" %>

<div class="main-container">
    <div class="content-wrapper">
        <h1>Customer Management</h1>
        <p>Manage all customers. Add, update, delete, and search records.</p>

        <!-- Alert messages -->
        <c:if test="${not empty message}">
            <div class="alert ${msgType == 'success' ? 'success' : 'error'}">${message}</div>
        </c:if>

        <!-- Add Customer button/link -->
        <a href="add-customer.jsp"><button type="button" class="btn">Add Customer</button></a>


        <!-- Search form -->
        <div style="margin-top:12px; display:flex; justify-content:space-between; align-items:center;">
            <form action="customers" method="get">
                <input type="hidden" name="action" value="search" />
                <input type="text" name="keyword" placeholder="Search..." value="${param.keyword}" />
                <button type="submit">Search</button>
            </form>

            <div>
                <a href="customers"><button type="button" class="btn ghost">Reset</button></a>
            </div>
        </div>

        <!-- Customer table -->
        <table class="user-table" aria-label="Customer list" style="margin-top:20px;">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
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
                            <td>${c.address}</td>
                            <td>${c.phone}</td>
                            <td>
                                <!-- Edit button -->
                                <button type="button" class="update" onclick="showEdit(${c.id})">Edit</button>

                                <!-- Delete button -->
                                <a href="customers?action=delete&id=${c.id}" onclick="return confirm('Delete this customer?');">
                                    <button type="button" class="delete">Delete</button>
                                </a>


                                <!-- Inline edit form hidden by default -->
                                <form id="edit-form-${c.id}" action="customers" method="post" style="display:none; margin-top:8px;">
                                    <input type="hidden" name="action" value="update" />
                                    <input type="hidden" name="id" value="${c.id}" />
                                    <input type="text" name="name" value="${c.name}" required />
                                    <input type="text" name="accountNo" value="${c.accountNo}" required readonly />
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
                        <td colspan="5" style="text-align:center; padding:20px;">No customers found.</td>
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

    // Auto-hide alerts after 4 seconds
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => alert.style.display = 'none');
    }, 4000);
</script>

</body>
</html>
