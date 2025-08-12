<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Bill History - Pahana Edu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
</head>
<body>

<!-- Include sidebar -->
<jsp:include page="component/cashierSidebar.jsp" />

<!-- Main content -->
<main class="content container" style="margin-left: 260px; padding-top: 20px;">

    <h2 class="mb-4">Bill History</h2>

    <!-- Filter form (GET method) -->
    <form method="get" action="billHistory" class="row g-3 mb-4 align-items-end">

        <div class="col-md-4">
            <label for="fromDate" class="form-label">From Date</label>
            <input
                    type="date"
                    id="fromDate"
                    name="fromDate"
                    class="form-control"
                    value="${param.fromDate != null ? param.fromDate : ''}"
                    max="${param.toDate != null ? param.toDate : ''}"
            />
        </div>

        <div class="col-md-4">
            <label for="toDate" class="form-label">To Date</label>
            <input
                    type="date"
                    id="toDate"
                    name="toDate"
                    class="form-control"
                    value="${param.toDate != null ? param.toDate : ''}"
                    min="${param.fromDate != null ? param.fromDate : ''}"
            />
        </div>

        <div class="col-md-4">
            <button type="submit" class="btn btn-primary w-100">
                <i class="bi bi-funnel-fill"></i> Filter
            </button>
        </div>

    </form>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <!-- Bill history table -->
    <div class="table-responsive">
        <table class="table table-striped table-hover align-middle">
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
                            <td><fmt:formatDate value="${bill.billDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                            <td>${bill.total}</td>
                            <td>${bill.paymentMethod}</td>
                            <td>
                                <a href="printBill?billId=${bill.id}" target="_blank" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-printer"></i> Print
                                </a>
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
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>


