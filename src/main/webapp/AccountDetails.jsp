<%--
  Created by IntelliJ IDEA.
  User: Hasara Hithaishi
  Date: 7/23/2025
  Time: 1:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>View Account Details | Pahana Edu</title>
    <style>
        body {
            margin: 0;
            padding: 2rem;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background: #f1f5f9;
        }

        .container {
            max-width: 700px;
            margin: auto;
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #333;
        }

        .search-section {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            justify-content: center;
        }

        .search-section input {
            padding: 0.7rem;
            font-size: 1rem;
            border-radius: 6px;
            border: 1px solid #ccc;
            width: 100%;
            max-width: 250px;
        }

        .search-section button {
            padding: 0.7rem 1.2rem;
            background-color: #0077cc;
            color: white;
            font-size: 1rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .search-section button:hover {
            background-color: #005fa3;
        }

        .details-box {
            margin-top: 1rem;
            border-top: 1px solid #ddd;
            padding-top: 1.5rem;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 0.6rem 0;
            border-bottom: 1px solid #eee;
        }

        .detail-row label {
            font-weight: 600;
            color: #444;
        }

        .detail-row span {
            color: #333;
        }

        .footer-text {
            text-align: center;
            margin-top: 2rem;
            font-size: 0.9rem;
            color: #888;
        }
    </style>
</head>
<body>

<div class="backButton">
    <button onclick="window.location.href='DashBoard.jsp'">Back</button>
</div>

<div class="container">
    <h2>View Customer Account Details</h2>

    <div class="search-section">
        <input type="text" id="searchAccount" placeholder="Search by Account Number" />
        <input type="text" id="searchName" placeholder="Search by Name" />
        <button type="button" id="searchBtn">Search</button>
    </div>

    <div class="details-box" id="detailsBox" style="display: none;">
        <div class="detail-row">
            <label>Account Number:</label>
            <span id="accNumber"></span>
        </div>
        <div class="detail-row">
            <label>Customer Name:</label>
            <span id="custName"></span>
        </div>
        <div class="detail-row">
            <label>Address:</label>
            <span id="address"></span>
        </div>
        <div class="detail-row">
            <label>Telephone:</label>
            <span id="telephone"></span>
        </div>
        <div class="detail-row">
            <label>Units Consumed:</label>
            <span id="units"></span>
        </div>
    </div>

    <p class="footer-text">© 2025 Pahana Edu Bookshop</p>
</div>

<script>
    // Sample customer data
    const customers = [
        {
            accountNumber: "1002",
            name: "Kasun Perera",
            address: "45, Temple Road, Colombo",
            telephone: "0712345678",
            units: 18
        },
        {
            accountNumber: "1003",
            name: "Nadeesha Silva",
            address: "12A, Flower Lane, Kandy",
            telephone: "0779876543",
            units: 34
        }
    ];

    const searchBtn = document.getElementById("searchBtn");
    const searchAccount = document.getElementById("searchAccount");
    const searchName = document.getElementById("searchName");

    const detailsBox = document.getElementById("detailsBox");
    const accNumber = document.getElementById("accNumber");
    const custName = document.getElementById("custName");
    const address = document.getElementById("address");
    const telephone = document.getElementById("telephone");
    const units = document.getElementById("units");

    searchBtn.addEventListener("click", () => {
        const accInput = searchAccount.value.trim();
        const nameInput = searchName.value.trim().toLowerCase();

        const result = customers.find(c =>
            (accInput && c.accountNumber === accInput) ||
            (nameInput && c.name.toLowerCase().includes(nameInput))
        );

        if (result) {
            accNumber.textContent = result.accountNumber;
            custName.textContent = result.name;
            address.textContent = result.address;
            telephone.textContent = result.telephone;
            units.textContent = result.units;
            detailsBox.style.display = "block";
        } else {
            alert("No matching customer found.");
            detailsBox.style.display = "none";
        }
    });
</script>
</body>
</html>

