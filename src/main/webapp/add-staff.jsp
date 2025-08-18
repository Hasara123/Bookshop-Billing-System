<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Add Staff - Pahana Edu</title>
    <link rel="stylesheet" href="component/style.css" />
</head>
<body>

<%@ include file="component/sidebar.jsp" %>

<div class="main-container">
    <div class="content-wrapper">
        <h1>Add New Staff</h1>

        <form action="staff" method="post">
            <input type="hidden" name="action" value="add" />

            <label for="email">Email</label><br />
            <input type="email" name="email" id="email" required /><br /><br />

            <label for="password">Password</label><br />
            <input type="password" name="password" id="password" required /><br /><br />

            <label for="role">Role</label><br />
            <select name="role" id="role" required>
                <option value="ADMIN">Admin</option>
                <option value="CASHIER">Cashier</option>
            </select><br /><br />

            <button type="submit" class="btn">Add Staff</button>
        </form>
    </div>
</div>

</body>
</html>
