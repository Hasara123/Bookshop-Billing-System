<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="lk.hasara.advanceprogrammingassingmentmy.model.CartItem" %>


<!DOCTYPE html>
<html>
<head>
    <title>New Bill</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>

<head>
    <title>New Bill</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        .content-wrapper {
            margin-left: 250px;
        }
        @media (max-width: 768px) {
            .content-wrapper {
                margin-left: 0;
            }
        }
    </style>
</head>
<body class="bg-light">
<jsp:include page="component/cashierSidebar.jsp" />

<div class="content-wrapper p-4">
    <div class="container-fluid mt-4">
        <h2>Checkout</h2>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>

        <form action="checkout" method="post">
            <div class="mb-3">
                <label>Customer Account No (optional)</label>
                <input type="text" name="accountNo" class="form-control" />
                <small>If customer not registered, <a href="add-customer.jsp">add customer</a></small>
            </div>

            <h4>Cart Summary</h4>
            <div class="table-responsive">
                <table class="table table-striped table-bordered">
                    <thead>
                    <tr><th>Title</th><th>Qty</th><th>Price</th><th>Total</th></tr>
                    </thead>
                    <tbody>
                    <c:set var="grand" value="0" />
                    <c:forEach var="ci" items="${sessionScope.cart}">
                        <tr>
                            <td>${ci.item.title}</td>
                            <td>${ci.quantity}</td>
                            <td>Rs. ${ci.item.price}</td>
                            <td>Rs. ${ci.totalPrice}</td>
                        </tr>
                        <c:set var="grand" value="${grand + ci.totalPrice}" />
                    </c:forEach>
                    </tbody>
                    <tfoot>
                    <tr>
                        <th colspan="3" class="text-end">Grand Total</th>
                        <th>Rs. ${grand}</th>
                    </tr>
                    </tfoot>
                </table>
            </div>

            <div class="mb-3">
                <label>Payment Method</label>
                <select name="paymentMethod" class="form-select">
                    <option>Cash</option>
                    <option>Card</option>
                    <option>Other</option>
                </select>
            </div>

            <c:choose>
                <c:when test="${empty sessionScope.cart}">
                    <div class="alert alert-warning">Your cart is empty. Please add items before checkout.</div>
                    <button class="btn btn-success" disabled>Confirm & Pay</button>
                </c:when>
                <c:otherwise>
                    <button class="btn btn-success">Confirm & Pay</button>
                </c:otherwise>
            </c:choose>
        </form>
    </div>
</div>

</body>

</html>
