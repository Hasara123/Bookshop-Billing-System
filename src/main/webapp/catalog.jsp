<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="lk.hasara.advanceprogrammingassingmentmy.model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Catalog - Pahana Edu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card-title {
            font-weight: 600;
            font-size: 1.1rem;
        }
        .card-text {
            font-size: 0.9rem;
        }
        .btn-primary, .btn-success {
            border-radius: 6px;
        }
        .cart-card {
            max-height: 75vh;
            overflow-y: auto;
        }
        .cart-item-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .cart-item-row input {
            width: 60px;
            margin-right: 5px;
        }
        @media (max-width: 992px) {
            .cart-col {
                margin-top: 20px;
            }
        }
    </style>
</head>
<body>

<jsp:include page="component/cashierSidebar.jsp" />

<div class="container-fluid" style="margin-left: 250px; padding-top: 20px;">
    <h1 class="mb-3">Book Catalog</h1>

    <!-- Search Bar -->
    <form method="get" action="catalog" class="row g-2 mb-4">
        <div class="col-md-8">
            <input type="text" name="search" class="form-control" placeholder="Search by title, author, or ISBN" value="${param.search}">
        </div>
        <div class="col-md-2">
            <button class="btn btn-primary w-100">Search</button>
        </div>
        <div class="col-md-2 text-end">
            <a href="billHistory" class="btn btn-outline-secondary w-100">Bill History</a>
        </div>
    </form>

    <div class="row">
        <!-- Book Cards -->
        <div class="col-lg-8">
            <div class="row row-cols-1 row-cols-md-2 g-3">
                <c:forEach var="item" items="${items}">
                    <div class="col">
                        <div class="card h-100 shadow-sm">
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">${item.title}</h5>
                                <p class="card-text mb-1"><strong>Author:</strong> ${item.author}</p>
                                <p class="card-text mb-1"><strong>Price:</strong> Rs. ${item.price}</p>
                                <p class="card-text mb-2"><strong>Stock:</strong> ${item.stock}</p>
                                <form action="cart" method="post" class="mt-auto d-flex gap-2">
                                    <input type="hidden" name="action" value="add"/>
                                    <input type="hidden" name="itemId" value="${item.id}"/>
                                    <input type="number" name="quantity" value="1" min="1" max="${item.stock}" class="form-control form-control-sm w-50"/>
                                    <button class="btn btn-success btn-sm" <c:if test="${item.stock <= 0}">disabled</c:if>>Add</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Cart Sidebar -->
        <div class="col-lg-4 cart-col">
            <div class="card cart-card sticky-top" style="top: 80px;">
                <div class="card-header bg-primary text-white fw-bold">Cart</div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty sessionScope.cart}">
                            <p>Your cart is empty.</p>
                        </c:when>
                        <c:otherwise>
                            <div class="list-group">
                                <c:set var="grandTotal" value="0"/>
                                <c:forEach var="ci" items="${sessionScope.cart}">
                                    <div class="list-group-item cart-item-row">
                                        <div>
                                            <strong>${ci.item.title}</strong>
                                        </div>
                                        <div class="d-flex align-items-center">
                                            <form action="cart" method="post" class="d-flex align-items-center">
                                                <input type="hidden" name="action" value="update"/>
                                                <input type="hidden" name="itemId" value="${ci.item.id}"/>
                                                <input type="number" name="quantity" value="${ci.quantity}" min="1" max="${ci.item.stock}" class="form-control form-control-sm"/>
                                                <button class="btn btn-sm btn-primary ms-1">Update</button>
                                            </form>
                                            <form action="cart" method="post" class="ms-2">
                                                <input type="hidden" name="action" value="remove"/>
                                                <input type="hidden" name="itemId" value="${ci.item.id}"/>
                                                <button class="btn btn-sm btn-danger">X</button>
                                            </form>
                                        </div>
                                        <c:set var="grandTotal" value="${grandTotal + ci.totalPrice}"/>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="mt-3 text-end">
                                <p class="fw-bold fs-6">Grand Total: Rs. ${grandTotal}</p>
                                <a href="newBill.jsp" class="btn btn-primary w-100">Checkout</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
