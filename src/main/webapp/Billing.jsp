<%--
  Created by IntelliJ IDEA.
  User: Hasara Hithaishi
  Date: 7/23/2025
  Time: 1:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Customer Billing - Pahana Edu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
            display: flex;
            justify-content: center;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
            width: 100%;
            max-width: 600px;
        }
        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
        }
        input {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            width: 100%;
            padding: 12px;
            background-color: #27ae60;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #219150;
        }
        .bill {
            margin-top: 30px;
            background-color: #ecf0f1;
            padding: 20px;
            border-left: 5px solid #27ae60;
            display: none;
        }
        .bill h3 {
            margin-top: 0;
            color: #2c3e50;
        }
        .bill p {
            margin: 5px 0;
        }
        .print-btn {
            background-color: #2980b9;
            margin-top: 15px;
        }
        .print-btn:hover {
            background-color: #1c5986;
        }


    </style>
</head>
<body>

<div class="backButton">
    <button onclick="window.location.href='DashBoard.jsp'">Back</button>
</div>

<div class="container">
    <h2>Customer Billing - Pahana Edu</h2>
    <div class="form-group">
        <label for="accountNumber">Account Number</label>
        <input type="text" id="accountNumber" placeholder="Enter account number" required>
    </div>
    <div class="form-group">
        <label for="name">Customer Name</label>
        <input type="text" id="name" placeholder="Enter name" required>
    </div>
    <div class="form-group">
        <label for="address">Address</label>
        <input type="text" id="address" placeholder="Enter address" required>
    </div>
    <div class="form-group">
        <label for="telephone">Telephone Number</label>
        <input type="tel" id="telephone" placeholder="Enter telephone number" required>
    </div>
    <div class="form-group">
        <label for="units">Units Consumed</label>
        <input type="number" id="units" placeholder="Enter number of units" required>
    </div>
    <button onclick="calculateBill()">Generate Bill</button>

    <div class="bill" id="billSection">
        <h3>Bill Details</h3>
        <p><strong>Account Number:</strong> <span id="billAccount"></span></p>
        <p><strong>Name:</strong> <span id="billName"></span></p>
        <p><strong>Address:</strong> <span id="billAddress"></span></p>
        <p><strong>Telephone:</strong> <span id="billTelephone"></span></p>
        <p><strong>Units Consumed:</strong> <span id="billUnits"></span></p>
        <p><strong>Total Amount:</strong> Rs. <span id="billAmount"></span></p>
        <button class="print-btn" onclick="window.print()">Print Bill</button>
    </div>
</div>

<script>
    function calculateBill() {
        const accountNumber = document.getElementById("accountNumber").value.trim();
        const name = document.getElementById("name").value.trim();
        const address = document.getElementById("address").value.trim();
        const telephone = document.getElementById("telephone").value.trim();
        const units = parseFloat(document.getElementById("units").value);

        if (!accountNumber || !name || !address || !telephone || isNaN(units) || units < 0) {
            alert("Please fill out all fields correctly.");
            return;
        }

        let amount = 0;

        // Billing logic
        if (units <= 50) {
            amount = units * 5;
        } else if (units <= 100) {
            amount = (50 * 5) + ((units - 50) * 7);
        } else {
            amount = (50 * 5) + (50 * 7) + ((units - 100) * 10);
        }

        // Fill bill section
        document.getElementById("billAccount").innerText = accountNumber;
        document.getElementById("billName").innerText = name;
        document.getElementById("billAddress").innerText = address;
        document.getElementById("billTelephone").innerText = telephone;
        document.getElementById("billUnits").innerText = units;
        document.getElementById("billAmount").innerText = amount.toFixed(2);

        // Show bill
        document.getElementById("billSection").style.display = "block";
    }
</script>

</body>
</html>

