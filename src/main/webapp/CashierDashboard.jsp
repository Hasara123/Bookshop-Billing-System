<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Cashier Dashboard - Pahana Edu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
    />
    <style>
        body {
            background-color: #f8f9fa;
            overflow-x: hidden; /* prevent horizontal scroll */
        }
        /* sticky header inside content */
        .dashboard-header {
            position: sticky;
            top: 0;
            background: white;
            padding: 1rem 0;
            border-bottom: 1px solid #dee2e6;
            z-index: 100;
        }
    </style>
</head>
<body>

<jsp:include page="component/cashierSidebar.jsp" />

<div id="content">

    <div class="dashboard-header d-flex justify-content-between align-items-center px-3">
        <h2>Dashboard</h2>
        <div>
            <button class="btn btn-outline-primary me-2">Refresh</button>
            <button class="btn btn-primary">New Bill</button>
        </div>
    </div>

    <div class="container-fluid mt-4 px-3">
        <div class="row g-4">

            <!-- Total Sales -->
            <div class="col-md-3 col-sm-6">
                <div class="card p-4 text-center">
                    <div class="text-primary mb-2"><i class="bi bi-currency-dollar fs-1"></i></div>
                    <h5>Total Sales</h5>
                    <h3>Rs. 150,000</h3>
                    <small class="text-muted">This month</small>
                </div>
            </div>

            <!-- Total Bills -->
            <div class="col-md-3 col-sm-6">
                <div class="card p-4 text-center">
                    <div class="text-success mb-2"><i class="bi bi-receipt fs-1"></i></div>
                    <h5>Total Bills</h5>
                    <h3>120</h3>
                    <small class="text-muted">This month</small>
                </div>
            </div>

            <!-- Customers Served -->
            <div class="col-md-3 col-sm-6">
                <div class="card p-4 text-center">
                    <div class="text-warning mb-2"><i class="bi bi-people fs-1"></i></div>
                    <h5>Customers Served</h5>
                    <h3>85</h3>
                    <small class="text-muted">This month</small>
                </div>
            </div>

            <!-- Stock Alerts -->
            <div class="col-md-3 col-sm-6">
                <div class="card p-4 text-center">
                    <div class="text-danger mb-2"><i class="bi bi-exclamation-triangle fs-1"></i></div>
                    <h5>Stock Alerts</h5>
                    <h3>7</h3>
                    <small class="text-muted">Items low in stock</small>
                </div>
            </div>

        </div>

        <div class="row mt-5">
            <!-- Recent Bills Table -->
            <div class="col-lg-8">
                <div class="card p-3">
                    <h5 class="mb-4">Recent Bills</h5>
                    <table class="table table-hover">
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
                        <tr>
                            <td>101</td>
                            <td>ACC12345</td>
                            <td>4500.00</td>
                            <td>Cash</td>
                            <td>2025-08-12</td>
                        </tr>
                        <tr>
                            <td>102</td>
                            <td>ACC23456</td>
                            <td>7500.00</td>
                            <td>Card</td>
                            <td>2025-08-12</td>
                        </tr>
                        <tr>
                            <td>103</td>
                            <td>Guest</td>
                            <td>3500.00</td>
                            <td>Cash</td>
                            <td>2025-08-11</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Stock Alerts / Notifications -->
            <div class="col-lg-4">
                <div class="card p-3">
                    <h5 class="mb-4">Stock Alerts</h5>
                    <ul class="list-group">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            "Book Title 1"
                            <span class="badge bg-danger rounded-pill">2 left</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            "Book Title 2"
                            <span class="badge bg-danger rounded-pill">5 left</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            "Book Title 3"
                            <span class="badge bg-danger rounded-pill">1 left</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
