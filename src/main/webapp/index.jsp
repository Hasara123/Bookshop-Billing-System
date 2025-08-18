<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Pahana Edu Bookshop</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    /* Top bar */
    .top-bar {
      background-color: #0d1b2a;
      color: white;
      padding: 10px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 14px;
    }

    .top-bar-left span,
    .top-bar-right a {
      margin-right: 15px;
      color: white;
      text-decoration: none;
    }

    .top-bar-right a:hover {
      text-decoration: underline;
    }

    /* Header */
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 15px 30px;
      background-color: #fff;
      border-bottom: 1px solid #eee;
    }

    .logo h2 {
      color: #0077cc;
      margin: 0;
    }

    .search-bar {
      display: flex;
      align-items: center;
    }

    .search-bar input {
      padding: 10px;
      width: 300px;
      border: 1px solid #ccc;
      border-radius: 4px 0 0 4px;
    }

    .search-bar button {
      padding: 10px 15px;
      background-color: black;
      color: white;
      border: none;
      border-radius: 0 4px 4px 0;
      cursor: pointer;
    }

    /* Navigation */
    .nav {
      background-color: #f9f9f9;
      display: flex;
      justify-content: center;
      padding: 10px 0;
      border-bottom: 1px solid #ddd;
    }

    .nav a {
      margin: 0 15px;
      text-decoration: none;
      color: #333;
      font-weight: 500;
      transition: color 0.3s ease;
    }

    .nav a:hover {
      color: #0077cc;
    }

    /* Banner */
    .hero {
      width: 100%;
      height: 450px;
      background-image: url('img/img1.jpg'); /* path relative to JSP */
      background-size: cover;
      background-position: center;
    }


    /* Footer Top Banner */
    .footer-banner {
      display: flex;
      justify-content: space-around;
      align-items: center;
      background-color: #1f3c88;
      color: white;
      padding: 30px 10px;
      flex-wrap: wrap;
      text-align: center;
      margin-top: 50px;
    }

    .footer-banner div {
      flex: 1 1 200px;
      padding: 10px;
    }

    .footer-banner i {
      font-size: 24px;
      margin-bottom: 10px;
    }

    /* Footer Main */
    .footer {
      background-color: #f2f2f2;
      padding: 40px 30px;
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
    }

    .footer-section {
      flex: 1 1 220px;
      margin: 10px;
    }

    .footer h3 {
      margin-bottom: 15px;
      font-size: 18px;
      color: #333;
    }

    .footer input[type="email"] {
      padding: 10px;
      width: 70%;
      border: 1px solid #ccc;
      border-radius: 4px 0 0 4px;
    }

    .footer button {
      padding: 10px 15px;
      border: none;
      background-color: #4dc9de;
      color: white;
      border-radius: 0 4px 4px 0;
      cursor: pointer;
    }

    .footer a {
      display: block;
      text-decoration: none;
      color: #555;
      margin-bottom: 8px;
      font-size: 14px;
    }

    .footer a:hover {
      color: #0077cc;
    }

    .contact-info p {
      margin: 5px 0;
      font-size: 14px;
      color: #444;
    }

    .footer-bottom {
      text-align: center;
      background-color: #ddd;
      padding: 15px;
      font-size: 14px;
      color: #555;
    }




    @media (max-width: 768px) {
      .search-bar input {
        width: 150px;
      }

      .nav {
        flex-wrap: wrap;
      }
    }
  </style>
</head>
<body>



<!-- Top Bar -->
<div class="top-bar">
  <div class="top-bar-left">
    <span>📞 077 777 7777</span>
    <span>📧 pahanaedu@gmail.com</span>
  </div>
  <div class="top-bar-right">
    <a href="Login.jsp">🔐 Login</a>
    <a href="Register.jsp">👤 Register</a>
  </div>
</div>

<!-- Header -->
<div class="header">
  <div class="logo">
    <h2>Pahana Edu</h2>
  </div>
  <div class="search-bar">
    <input type="text" placeholder="Search here...">
    <button>Search</button>
  </div>
</div>

<!-- Navigation -->
<div class="nav">
  <a href="#">Home</a>
  <a href="#">Medical</a>
  <a href="#">Fiction</a>
  <a href="#">School</a>
  <a href="#">Children</a>
  <a href="#">Gift Vouchers</a>
  <a href="#">Categories</a>
  <a href="#">Catalog</a>
  <a href="#">About</a>
  <a href="#">Contact Us</a>
</div>

<!-- Hero Section -->
<div class="hero">
  <img src="img1" alt="Image 1">
</div>

<!-- Footer Top Banner -->
<div class="footer-banner">
  <div>
    <i>🚚</i>
    <h4>Islandwide Delivery</h4>
    <p>Ensuring convenience</p>
  </div>
  <div>
    <i>💳</i>
    <h4>Secure Payments</h4>
    <p>Safe and efficient</p>
  </div>
  <div>
    <i>💰</i>
    <h4>Best Price</h4>
    <p>Ultimate affordability</p>
  </div>
  <div>
    <i>⚡</i>
    <h4>Fast Delivery</h4>
    <p>Customer focused</p>
  </div>
</div>

<!-- Main Footer -->
<div class="footer">
  <div class="footer-section">
    <h3>Receive The Latest Offers & Updates Via Email</h3>
    <p>Signup to be the first to hear about exclusive deals, special offers and upcoming collections.</p>
    <form>
      <input type="email" placeholder="Enter Your Email">
      <button type="submit">Subscribe</button>
    </form>
  </div>

  <div class="footer-section">
    <h3>Categories</h3>
    <a href="#">School List</a>
    <a href="#">Medical Books</a>
    <a href="#">Children</a>
    <a href="#">Gift Packs</a>
    <a href="#">By Language</a>
  </div>

  <div class="footer-section">
    <h3>Quick Links</h3>
    <a href="#">Home</a>
    <a href="#">About Us</a>
    <a href="#">Awards</a>
    <a href="#">Contact Us</a>
    <a href="#">Login</a>
  </div>

  <div class="footer-section contact-info">
    <h3>Contact Details</h3>
    <p>📍 No.00, Stanley Thilakarathne Mawatha, Nugegoda, Sri Lanka</p>
    <p>📞 077 777 7777</p>
    <p>📧 pahanaedu@gmail.com</p>
  </div>
</div>

<!-- Footer Bottom -->
<div class="footer-bottom">
  © 2025 Pahana Edu Bookshop. All Rights Reserved.
</div>


</body>
</html>