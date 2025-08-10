<%--
  Created by IntelliJ IDEA.
  User: Hasara Hithaishi
  Date: 8/9/2025
  Time: 9:19 PM
  To change this template use File | Settings | File Templates.
--%>
<a href="#" onclick="return confirmLogout()">Exit</a>

<script>
    function confirmLogout() {
        if (confirm('Are you sure you want to exit?')) {
            // Redirect to dashboard.jsp on Yes
            window.location.href = 'index.jsp';
        }
        // If No, do nothing (stay on current page)
        return false; // prevent default link behavior in all cases
    }
</script>


