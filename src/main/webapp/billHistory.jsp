<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bill History - Pahana Edu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
    <style>
        .content-wrapper { margin-left: 260px; padding-top: 20px; }
        @media (max-width: 768px) { .content-wrapper { margin-left: 0; } }

        .table-responsive { max-height: 600px; overflow-y: auto; }
        .table thead th { position: sticky; top: 0; background-color: #343a40; color: white; z-index: 1; }
    </style>
</head>
<body class="bg-light">

<jsp:include page="component/cashierSidebar.jsp" />

<div class="content-wrapper">
    <div class="container-fluid">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold">Bill History</h2>
            <form method="get" action="billHistory" class="d-flex gap-2">
                <input type="date" name="fromDate" class="form-control" placeholder="From"
                       value="${param.fromDate != null ? param.fromDate : ''}">
                <input type="date" name="toDate" class="form-control" placeholder="To"
                       value="${param.toDate != null ? param.toDate : ''}">
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-funnel-fill"></i> Filter
                </button>
            </form>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="card shadow-sm">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Date</th>
                            <th>Total (Rs.)</th>
                            <th>Payment Method</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty bills}">
                                <c:forEach var="bill" items="${bills}">
                                    <tr>
                                        <td>${bill.id}</td>
                                        <td><fmt:formatDate value="${bill.billDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                        <td>Rs. ${bill.total}</td>
                                        <td>${bill.paymentMethod}</td>
                                        <td>
                                            <button type="button" class="btn btn-sm btn-outline-primary"
                                                    onclick="window.open('printBill?billId=${bill.id}','_blank')">
                                                <i class="bi bi-printer"></i> Print
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="text-center text-muted">No bills found.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
