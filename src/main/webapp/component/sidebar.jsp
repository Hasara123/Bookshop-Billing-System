<div class="sidebar">
    <h2>Pahana Edu</h2>
    <a href="#">Dashboard</a>
    <a href="customers?action=list">Manage Customers</a>
    <a href="items?action=list">Manage Items</a>
    <a href="customers?action=display">Account Details</a>
    <a href="Billing.jsp">Calculate and billing</a>
    <a href="#">Help</a>
    <a href="#">Settings</a>
    <a href="#" onclick="return confirmLogout()">Logout</a>

    <script>
        function confirmLogout() {
            if (confirm('Are you sure?')) {
                // If Yes, redirect to dashboard.jsp
                window.location.href = 'index.jsp';
                return false; // prevent default link behavior (just in case)
            } else {
                // If No, do nothing (stay)
                return false; // prevent default link behavior
            }
        }
    </script>




</div>
