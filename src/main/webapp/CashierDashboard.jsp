<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link href="component/style.css" rel="stylesheet" type="text/css"/>
<c:if test="${not empty sessionScope.successMessage}">
    <div id="flashMessage">
            ${sessionScope.successMessage}
    </div>
    <c:remove var="successMessage" scope="session"/>
</c:if>

<script>
    setTimeout(function() {
        var msg = document.getElementById("flashMessage");
        if(msg) msg.style.display = "none";
    }, 3000);
</script>

<!-- Cashier content -->
<h1>Welcome, ${sessionScope.user}</h1>
<p>Cashier functionalities: Process Bills, View Customers, etc.</p>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cashier Dashboard | Pahana Edu</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        #flashMessage {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            text-align: center;
            margin-bottom: 15px;
            border-radius: 5px;
            font-weight: bold;
        }
    </style>
</head>
<body>



</body>
</html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Cashier/Admin Dashboard - Pahana Edu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { background-color: #f5f7fa; font-family: 'Segoe UI', sans-serif; overflow-x: hidden; }
        .sidebar { width: 250px; height: 100vh; background: linear-gradient(180deg, #2c3e50, #34495e); color: #fff; position: fixed; top: 0; left: 0; padding: 20px 0; overflow-y: auto; }
        .sidebar h2 { text-align: center; margin-bottom: 30px; }
        .sidebar a { display: flex; align-items: center; padding: 12px 20px; color: #ecf0f1; text-decoration: none; font-size: 15px; transition: 0.3s; }
        .sidebar a i { margin-right: 10px; }
        .sidebar a:hover, .sidebar a.active { background: rgba(255,255,255,0.2); padding-left: 25px; }
        .main-content { margin-left: 250px; padding: 20px; min-height: 100vh; }
        .card { border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .icon-circle { width:50px; height:50px; display:flex; align-items:center; justify-content:center; border-radius:50%; color:#fff; font-size:20px; }
        @media (max-width: 768px) { .main-content { margin-left: 0; padding: 20px; } .sidebar { width: 100%; height: auto; position: relative; } }
    </style>
</head>
<body>

<jsp:include page="component/cashierSidebar.jsp" />


<div class="main-content">
    <!-- Dashboard Cards -->
    <div class="row g-4 mb-4">
        <div class="col-md-3 col-sm-6">
            <div class="card p-4 text-center">
                <div class="icon-circle bg-primary mb-2"><i class="bi bi-currency-dollar fs-3"></i></div>
                <h5>Total Sales</h5>
                <h3>Rs. <c:out value="${totalSales != null ? totalSales : 0}"/></h3>
                <small class="text-muted">This month</small>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card p-4 text-center">
                <div class="icon-circle bg-warning mb-2"><i class="bi bi-receipt fs-3"></i></div>
                <h5>Total Bills</h5>
                <h3><c:out value="${totalBills != null ? totalBills : 0}"/></h3>
                <small class="text-muted">This month</small>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card p-4 text-center">
                <div class="icon-circle bg-info mb-2"><i class="bi bi-people fs-3"></i></div>
                <h5>Customers Served</h5>
                <h3><c:out value="${customersServed != null ? customersServed : 0}"/></h3>
                <small class="text-muted">This month</small>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card p-4 text-center">
                <div class="icon-circle bg-danger mb-2"><i class="bi bi-exclamation-triangle fs-3"></i></div>
                <h5>Stock Alerts</h5>
                <h3><c:out value="${fn:length(lowStockItems)}"/></h3>
                <small class="text-muted">Items low in stock</small>
            </div>
        </div>
    </div>

    <!-- Charts -->
    <div class="row g-4 mb-4">
        <div class="col-lg-6">
            <div class="card p-3">
                <h5>Most Selling Books</h5>
                <canvas id="mostSellingBooksChart"></canvas>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="card p-3">
                <h5>Monthly Revenue</h5>
                <canvas id="monthlyRevenueChart"></canvas>
            </div>
        </div>
    </div>

    <!-- Recent Bills Table -->
    <div class="row g-4">
        <div class="col-lg-8">
            <div class="card p-3">
                <h5>Recent Bills</h5>
                <table class="table table-hover mt-3">
                    <thead>
                    <tr>
                        <th>Bill ID</th>
                        <th>Account No</th>
                        <th>Total (Rs.)</th>
                        <th>Payment Method</th>
                        <th>Date</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="bill" items="${recentBills}">
                        <tr>
                            <td><c:out value="${bill.id}"/></td>
                            <td><c:out value="${bill.accountNo}"/></td>
                            <td><c:out value="${bill.total}"/></td>
                            <td><c:out value="${bill.paymentMethod}"/></td>
                            <td><c:out value="${bill.billDate}"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Low Stock Items -->
        <div class="col-lg-4">
            <div class="card p-3">
                <h5>Stock Alerts</h5>
                <ul class="list-group mt-3">
                    <c:forEach var="item" items="${lowStockItems}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <c:out value="${item.title}"/>
                            <span class="badge bg-danger rounded-pill"><c:out value="${item.stock}"/> left</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Most Selling Books Chart
    const mostSellingBooksCtx = document.getElementById('mostSellingBooksChart').getContext('2d');
    const mostSellingBooksChart = new Chart(mostSellingBooksCtx, {
        type: 'bar',
        data: {
            labels: [
                <c:forEach var="book" items="${mostSellingBooks}" varStatus="status">
                '${book.title}'<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ],
            datasets: [{
                label: 'Sold Quantity',
                data: [
                    <c:forEach var="book" items="${mostSellingBooks}" varStatus="status">
                    ${book.totalSold}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ],
                backgroundColor: 'rgba(54, 162, 235, 0.7)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: { responsive: true, scales: { y: { beginAtZero: true } } }
    });

    // Monthly Revenue Chart
    const monthlyRevenueCtx = document.getElementById('monthlyRevenueChart').getContext('2d');
    const monthlyRevenueChart = new Chart(monthlyRevenueCtx, {
        type: 'line',
        data: {
            labels: [
                <c:forEach var="month" items="${monthlyRevenue.keySet()}" varStatus="status">
                '${month}'<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ],
            datasets: [{
                label: 'Revenue',
                data: [
                    <c:forEach var="amount" items="${monthlyRevenue.values()}" varStatus="status">
                    ${amount}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ],
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 2,
                fill: true,
                tension: 0.3
            }]
        },
        options: { responsive: true, scales: { y: { beginAtZero: true } } }
    });

    function confirmLogout() {
        if (confirm('Are you sure?')) {
            window.location.href = 'index.jsp';
            return false;
        } else {
            return false;
        }
    }
</script>
</body>
</html>
