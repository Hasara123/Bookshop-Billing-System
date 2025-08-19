<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Billing Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body class="bg-light">
<div class="container mt-5">
    <h1>Billing</h1>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <h3>Available Items</h3>
    <form method="get" action="billing" class="mb-3">
        <div class="input-group">
            <input type="text" name="search" class="form-control" placeholder="Search books by title" value="${param.search}"/>
            <button type="submit" class="btn btn-outline-secondary">Search</button>
        </div>
    </form>

    <form action="billing" method="post" class="row g-2 align-items-center mb-4">
        <input type="hidden" name="action" value="add"/>
        <div class="col-auto">
            <select name="itemId" class="form-select" required>
                <option value="" disabled selected>Select item</option>
                <c:forEach var="item" items="${items}">
                    <option value="${item.id}">${item.title} - Rs.${item.price}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-auto">
            <input type="number" name="quantity" min="1" value="1" class="form-control" required/>
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">Add to Cart</button>
        </div>
    </form>

    <h3>Cart</h3>
    <c:if test="${empty cart}">
        <p>Your cart is empty.</p>
    </c:if>
    <c:if test="${not empty cart}">
        <table class="table table-bordered bg-white">
            <thead class="table-dark">
            <tr>
                <th>Title</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <c:set var="grandTotal" value="0" />
            <c:forEach var="cartItem" items="${cart}">
                <tr>
                    <td>${cartItem.item.title}</td>
                    <td>${cartItem.quantity}</td>
                    <td>Rs. ${cartItem.item.price}</td>
                    <td>Rs. ${cartItem.totalPrice}</td>
                    <td>
                        <form action="billing" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="remove"/>
                            <input type="hidden" name="itemId" value="${cartItem.item.id}"/>
                            <button type="submit" class="btn btn-sm btn-danger">Remove</button>
                        </form>
                    </td>
                </tr>
                <c:set var="grandTotal" value="${grandTotal + cartItem.totalPrice}" />
            </c:forEach>
            </tbody>
        </table>

        <h4>Grand Total: Rs. ${grandTotal}</h4>

        <form action="billing" method="post">
            <input type="hidden" name="action" value="calculateBill"/>
            <button type="submit" class="btn btn-success">Checkout & Print</button>
        </form>
    </c:if>
</div>
</body>
</html>
