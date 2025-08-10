<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Dashboard - Pahana Edu</title>
    <style>
        /* Your styles here */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        body {
            display: flex;
            height: 100vh;
            background-color: #f4f4f4;
        }
        .sidebar {
            width: 220px;
            background-color: #2c3e50;
            color: #fff;
            padding: 20px 10px;
        }
        .sidebar h2 {
            text-align: center;
            margin-bottom: 30px;
        }
        .sidebar a {
            display: block;
            padding: 10px;
            margin: 10px 0;
            text-decoration: none;
            color: #fff;
            border-radius: 5px;
        }
        .sidebar a:hover {
            background-color: #34495e;
        }
        .main-content {
            flex: 1;
            padding: 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .header h1 {
            color: #333;
        }
        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        .card {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .card h3 {
            color: #2c3e50;
            margin-bottom: 10px;
        }
        .card p {
            font-size: 1.5em;
            font-weight: bold;
            color: #27ae60;
        }
    </style>
</head>
<body>

<%@ include file="component/sidebar.jsp" %>

<div class="main-content">
    <div class="header">
        <h1>Admin Dashboard</h1>
        <p>Welcome, Admin</p>
    </div>
    <div class="cards">
        <div class="card">
            <h3>Total Customers</h3>
            <p>500</p>
        </div>
        <div class="card">
            <h3>Total Bills</h3>
            <p>1200</p>
        </div>
        <div class="card">
            <h3>Cashiers</h3>
            <p>5</p>
        </div>
        <div class="card">
            <h3>Inventory Items</h3>
            <p>950</p>
        </div>
    </div>
</div>
</body>
</html>
