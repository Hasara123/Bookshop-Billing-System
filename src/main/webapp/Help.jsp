<%--
  Created by IntelliJ IDEA.
  User: Hasara Hithaishi
  Date: 8/9/2025
  Time: 9:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Help - Pahana Edu</title>
    <link rel="stylesheet" href="component/style.css">
</head>
<body>
<%@ include file="component/sidebar.jsp" %>

<div class="main-container">
    <div class="content-wrapper">
        <h1>Help & Support</h1>

        <section>
            <h2>System Overview</h2>
            <p>This system allows you to manage book inventory, customers, and billing efficiently. You can add items, create bills, and track sales.</p>
        </section>

        <section>
            <h2>Using the System</h2>
            <ul>
                <li><strong>Add Customer:</strong> Go to "Add Customer" and fill in the details.</li>
                <li><strong>Add Book/Item:</strong> Use "Manage Items" to add new books or update stock.</li>
                <li><strong>Create Bill:</strong> Go to "New Bill", add items to the cart, select customer, and confirm payment.</li>
                <li><strong>Bill History:</strong> View all previous bills and print receipts if needed.</li>
            </ul>
        </section>

        <section>
            <h2>Frequently Asked Questions</h2>
            <ul>
                <li><strong>Q:</strong> What if stock is insufficient?<br/>
                    <strong>A:</strong> The system will alert you and prevent checkout until stock is updated.</li>
                <li><strong>Q:</strong> How do I send SMS notifications to customers?<br/>
                    <strong>A:</strong> SMS is sent automatically upon successful checkout (Twilio integration).</li>
                <li><strong>Q:</strong> Can I edit a bill after checkout?<br/>
                    <strong>A:</strong> No, bills are final. Cancel and create a new one if needed.</li>
            </ul>
        </section>

        <section>
            <h2>Contact Support</h2>
            <p>If you face issues, contact the system administrator at <a href="mailto:support@pahanaedu.com">support@pahanaedu.com</a>.</p>
        </section>

    </div>
</div>

</body>
</html>
