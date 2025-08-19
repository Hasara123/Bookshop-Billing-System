<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${not empty sessionScope.successMessage}">
    <div id="flashMessage" style="background-color: #4CAF50; color: white; padding: 10px; text-align: center; margin-bottom: 15px; border-radius: 5px;">
            ${sessionScope.successMessage}
    </div>
    <%-- Remove the message from session after displaying --%>
    <c:remove var="successMessage" scope="session"/>
</c:if>

<script>
    // Hide the flash message after 3 seconds
    setTimeout(function() {
        var msg = document.getElementById("flashMessage");
        if (msg) {
            msg.style.display = "none";
        }
    }, 3000); // 3000ms = 3 seconds
</script>

<%
    String email = (String) request.getAttribute("email");
    String displayRole = (String) request.getAttribute("displayRole");

    Integer totalCustomers = (Integer) request.getAttribute("totalCustomers");
    Integer totalBills = (Integer) request.getAttribute("totalBills");
    Integer cashierCount = (Integer) request.getAttribute("cashierCount");
    Integer inventoryCount = (Integer) request.getAttribute("inventoryCount");


%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Pahana Edu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f5f7fa; font-family: 'Segoe UI', sans-serif; }
        .sidebar { width: 250px; height: 100vh; background: linear-gradient(180deg, #2c3e50, #34495e); color: #fff; position: fixed; top: 0; left: 0; padding: 20px 0; overflow-y: auto; }
        .sidebar h2 { text-align: center; font-weight: bold; margin-bottom: 30px; }
        .sidebar a { display: flex; align-items: center; padding: 12px 20px; color: #ecf0f1; text-decoration: none; font-size: 15px; transition: all 0.3s ease; }
        .sidebar a i { margin-right: 10px; }
        .sidebar a:hover { background: rgba(255,255,255,0.1); padding-left: 25px; }
        .main-content { margin-left: 250px; padding: 30px; min-height: 100vh; }
        .dashboard-header h1 { font-size: 28px; font-weight: 700; }
        .dashboard-header p { color: #555; font-size: 15px; }
        .card { border: none; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: transform 0.2s; }
        .card:hover { transform: translateY(-5px); }
        .card h5 { font-size: 16px; font-weight: 600; }
        .card p { font-size: 22px; font-weight: bold; }
        .icon-circle { width: 50px; height: 50px; display: flex; align-items: center; justify-content: center; border-radius: 50%; color: #fff; font-size: 20px; }
        .bg-primary { background-color: #007bff !important; }
        .bg-warning { background-color: #ffc107 !important; }
        .bg-info { background-color: #17a2b8 !important; }
        .bg-danger { background-color: #dc3545 !important; }
        @media (max-width: 768px) { .main-content { margin-left: 0; padding: 20px; } .sidebar { width: 100%; height: auto; position: relative; } }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h2>Pahana Edu</h2>
    <a href="AdminDashboard"><i class="fa-solid fa-gauge"></i> Dashboard</a>
    <a href="customers?action=list"><i class="fa-solid fa-users"></i> Manage Customers</a>
    <a href="items?action=list"><i class="fa-solid fa-box"></i> Manage Items</a>
    <a href="staff?action=list"><i class="fa-solid fa-user-tie"></i> Manage Staff</a>
    <a href="customers?action=display"><i class="fa-solid fa-id-card"></i> Account Details</a>
    <a href="../billing.jsp"><i class="fa-solid fa-receipt"></i> Calculate & Billing</a>
    <a href="#"><i class="fa-solid fa-circle-question"></i> Help</a>
    <a href="#"><i class="fa-solid fa-gear"></i> Settings</a>
    <a href="index.jsp" onclick="return confirm('Are you sure you want to logout?');"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="dashboard-header mb-4">
        <h1><%= displayRole %> Dashboard</h1>
        <p>Welcome, <strong><%= email %></strong> (<%= displayRole %>)</p>
    </div>

    <div class="row g-4">
        <div class="col-sm-6 col-lg-3">
            <div class="card p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h5>Total Customers</h5>
                        <p class="text-success"><%= totalCustomers %></p>
                    </div>
                    <div class="icon-circle bg-primary"><i class="fa-solid fa-users"></i></div>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-lg-3">
            <div class="card p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h5>Total Bills</h5>
                        <p class="text-warning"><%= totalBills %></p>
                    </div>
                    <div class="icon-circle bg-warning"><i class="fa-solid fa-receipt"></i></div>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-lg-3">
            <div class="card p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h5>Cashiers</h5>
                        <p class="text-info"><%= cashierCount %></p>
                    </div>
                    <div class="icon-circle bg-info"><i class="fa-solid fa-user-tie"></i></div>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-lg-3">
            <div class="card p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h5>Inventory Items</h5>
                        <p class="text-danger"><%= inventoryCount %></p>
                    </div>
                    <div class="icon-circle bg-danger"><i class="fa-solid fa-box"></i></div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
