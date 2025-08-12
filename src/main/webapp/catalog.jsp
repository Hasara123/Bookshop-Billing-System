<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="lk.hasara.advanceprogrammingassingmentmy.model.CartItem" %>


<!DOCTYPE html>
<html>
<head>
    <title>Book Catalog</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
<body class="bg-light">
<jsp:include page="component/cashierSidebar.jsp" />

<div class="content-wrapper p-4" style="margin-left: 250px;">
    <div class="container-fluid">
        <h1>Book Catalog</h1>

        <!-- Search and Bill History -->
        <form method="get" action="catalog" class="mb-3 row g-2">
            <div class="col-md-8">
                <input name="search" class="form-control" placeholder="Search by title/author/isbn" value="${param.search}"/>
            </div>
            <div class="col-md-2">
                <button class="btn btn-primary w-100">Search</button>
            </div>
            <div class="col-md-2 text-end">
                <a href="billHistory" class="btn btn-outline-secondary w-100">Bill History</a>
            </div>
        </form>

        <div class="row">
            <!-- Books List -->
            <div class="col-md-8">
                <div class="row">
                    <c:forEach var="item" items="${items}">
                        <div class="col-md-6 mb-3">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title">${item.title}</h5>
                                    <p class="card-text">Author: ${item.author}</p>
                                    <p class="card-text">Price: Rs. ${item.price}</p>
                                    <p class="card-text">Stock: ${item.stock}</p>
                                    <form action="cart" method="post" class="d-flex gap-2">
                                        <input type="hidden" name="action" value="add"/>
                                        <input type="hidden" name="itemId" value="${item.id}"/>
                                        <input type="number" name="quantity" value="1" min="1" max="${item.stock}" class="form-control w-50"/>
                                        <button class="btn btn-sm btn-success" <c:if test="${item.stock <= 0}">disabled</c:if>>Add</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Cart -->
            <div class="col-md-4">
                <div class="card sticky-top" style="top: 80px;">
                    <div class="card-header">Cart</div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty cart}">
                                <p>Your cart is empty.</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-sm mb-2">
                                        <thead><tr><th>Title</th><th>Qty</th><th>Total</th><th></th></tr></thead>
                                        <tbody>
                                        <c:set var="grand" value="0" />
                                        <c:forEach var="ci" items="${cart}">
                                            <tr>
                                                <td>${ci.item.title}</td>
                                                <td>${ci.quantity}</td>
                                                <td>Rs. ${ci.totalPrice}</td>
                                                <td>
                                                    <form action="cart" method="post">
                                                        <input type="hidden" name="action" value="remove"/>
                                                        <input type="hidden" name="itemId" value="${ci.item.id}"/>
                                                        <button class="btn btn-sm btn-danger" aria-label="Remove from cart">X</button>
                                                    </form>
                                                </td>
                                            </tr>
                                            <c:set var="grand" value="${grand + ci.totalPrice}" />
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <p><strong>Grand: Rs. ${grand}</strong></p>
                                <a href="newBill.jsp" class="btn btn-primary w-100">Checkout</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>

</head>
</html>
