<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />  <!-- important for responsiveness -->
    <title>Cashier Sidebar Example</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            overflow-x: hidden; /* prevent horizontal scroll when sidebar hidden */
        }
        /* Sidebar */
        #sidebar {
            position: fixed;
            top: 0; left: 0;
            height: 100vh;
            width: 250px;
            background-color: #343a40;
            color: white;
            padding: 1rem;
            transition: transform 0.3s ease;
            z-index: 1050;
            overflow-y: auto;
        }
        #sidebar a {
            display: block;
            color: white;
            padding: 0.75rem 1rem;
            margin-bottom: 0.5rem;
            text-decoration: none;
            border-radius: 0.375rem;
            font-weight: 500;
        }
        #sidebar a:hover,
        #sidebar a.active {
            background-color: #495057;
        }

        /* Sidebar hidden */
        #sidebar.collapsed {
            transform: translateX(-100%);
        }

        /* Main content */
        #content {
            margin-left: 250px;
            padding: 1rem;
            transition: margin-left 0.3s ease;
        }
        #content.expanded {
            margin-left: 0;
        }

        /* Toggle button */
        #sidebarToggle {
            position: fixed;
            top: 15px;
            left: 15px;
            background-color: #343a40;
            border: none;
            color: white;
            padding: 0.5rem 0.75rem;
            font-size: 1.5rem;
            border-radius: 0.375rem;
            z-index: 1050;
            cursor: pointer;
        }

        /* Hide toggle button on desktop */
        @media(min-width: 768px) {
            #sidebarToggle {
                display: none;
            }
            #sidebar {
                transform: none !important;
            }
            #content {
                margin-left: 250px !important;
            }
        }
    </style>
</head>
<body>

<button id="sidebarToggle">&#9776;</button> <!-- Hamburger icon -->

<nav id="sidebar">
    <div class="text-center mb-4">
        <h3>Pahana Edu</h3>
        <small>Cashier Panel</small>
    </div>
    <a href="CashierDashboard.jsp" class="active">🏠 Dashboard</a>
    <a href="newBill.jsp">🧾 New Bill</a>
    <a href="catalog.jsp">📚 Book Catalog</a>
    <a href="billHistory.jsp">🧾 Sales History</a>
    <a href="settings.jsp">⚙️ Settings</a>
    <a href="#" onclick="return confirmLogout()">🚪 Logout</a>

    <script>
        function confirmLogout() {
            if (confirm('Are you sure?')) {
                // If Yes, redirect to index.jsp (logout)
                window.location.href = 'index.jsp';
                return false; // prevent default link behavior (just in case)
            } else {
                // If No, do nothing (stay)
                return false; // prevent default link behavior
            }
        }
    </script>

</nav>


<script>
    const toggleBtn = document.getElementById('sidebarToggle');
    const sidebar = document.getElementById('sidebar');
    const content = document.getElementById('content');

    toggleBtn.addEventListener('click', () => {
        sidebar.classList.toggle('collapsed');
        content.classList.toggle('expanded');
    });
</script>

</body>
</html>
