<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Account Details</title>
</head>
<body>
<h2>Customer Account Details</h2>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Account Number</th>
        <th>Address</th>
        <th>Phone</th>
    </tr>
    <c:forEach var="customer" items="${customers}">
        <tr>
            <td>${customer.id}</td>
            <td>${customer.name}</td>
            <td>${customer.accountNo}</td>
            <td>${customer.address}</td>
            <td>${customer.phone}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
