
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | Pacelet</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        :root {
            --bg: #f6f7f9;
            --surface: #ffffff;
            --text: #171717;
            --muted: #777b84;
            --border: #e9eaed;
            --sidebar: #111111;
            --sidebar-muted: #a3a3a3;
            --accent: #111111;
            --green: #15803d;
            --orange: #b45309;
            --red: #b91c1c;
        }

        body {
            font-family: "Inter", sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
        }

        button, a {
            font: inherit;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        button {
            cursor: pointer;
        }

        .admin-layout {
            min-height: 100vh;
        }

        /* SIDEBAR */
        .sidebar {
            position: fixed;
            inset: 0 auto 0 0;
            z-index: 100;
            width: 248px;
            padding: 26px 17px;
            background: var(--sidebar);
            color: #fff;
            display: flex;
            flex-direction: column;
            transition: transform .25s ease;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 0 10px 30px;
            border-bottom: 1px solid #303030;
        }

        .brand-mark {
            width: 39px;
            height: 39px;
            border: 1px solid #777;
            border-radius: 50%;
            display: grid;
            place-items: center;
            font-family: "Plus Jakarta Sans", sans-serif;
            font-size: 19px;
            font-weight: 800;
        }

        .brand-name {
            font-family: "Plus Jakarta Sans", sans-serif;
            font-size: 19px;
            font-weight: 800;
            letter-spacing: .13em;
        }

        .brand-subtitle {
            margin-top: 4px;
            color: var(--sidebar-muted);
            font-size: 9px;
            letter-spacing: .16em;
            text-transform: uppercase;
        }

        .nav-label {
            padding: 27px 12px 12px;
            color: #777;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: .12em;
            text-transform: uppercase;
        }

        .sidebar-nav {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 13px;
            min-height: 46px;
            padding: 0 13px;
            border-radius: 8px;
            color: #b7b7b7;
            font-size: 12px;
            font-weight: 500;
            transition: .2s ease;
        }

        .nav-link:hover {
            background: #242424;
            color: white;
        }

        .nav-link.active {
            background: #fff;
            color: #111;
            font-weight: 700;
        }

        .nav-icon {
            width: 20px;
            text-align: center;
            font-size: 16px;
        }

        .sidebar-bottom {
            margin-top: auto;
            padding-top: 20px;
            border-top: 1px solid #303030;
        }

        .store-status {
            display: flex;
            align-items: center;
            gap: 9px;
            padding: 13px 10px;
            color: #d4d4d4;
            font-size: 11px;
        }

        .status-dot {
            width: 8px;
            height: 8px;
            flex-shrink: 0;
            border-radius: 50%;
            background: #4ade80;
        }

        /* MAIN */
        .main-content {
            min-height: 100vh;
            margin-left: 248px;
            min-width: 0;
        }

        .topbar {
            position: sticky;
            top: 0;
            z-index: 50;
            min-height: 78px;
            padding: 15px 34px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            background: rgba(255,255,255,.94);
            border-bottom: 1px solid var(--border);
            backdrop-filter: blur(12px);
        }

        .topbar-left {
            display: flex;
            align-items: center;
            gap: 13px;
            min-width: 0;
        }

        .menu-toggle {
            display: none;
            width: 38px;
            height: 38px;
            border: 1px solid var(--border);
            background: white;
            border-radius: 8px;
            font-size: 19px;
        }

        .topbar-title {
            font-family: "Plus Jakarta Sans", sans-serif;
            font-size: 19px;
            font-weight: 800;
        }

        .breadcrumb {
            margin-top: 5px;
            color: var(--muted);
            font-size: 11px;
        }

        .admin-profile {
            display: flex;
            align-items: center;
            gap: 11px;
        }

        .admin-avatar {
            width: 39px;
            height: 39px;
            display: grid;
            place-items: center;
            border-radius: 50%;
            background: #171717;
            color: white;
            font-weight: 700;
            font-size: 12px;
        }

        .admin-name {
            font-size: 12px;
            font-weight: 700;
        }

        .admin-role {
            margin-top: 4px;
            color: var(--muted);
            font-size: 10px;
        }

        .dashboard {
            width: 100%;
            max-width: 1600px;
            padding: 32px 34px 45px;
            margin: 0 auto;
        }

        .welcome-row {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 18px;
            margin-bottom: 28px;
        }

        .welcome-title {
            font-family: "Plus Jakarta Sans", sans-serif;
            font-size: clamp(23px, 2.2vw, 29px);
            font-weight: 800;
            letter-spacing: -.04em;
        }

        .welcome-text {
            margin-top: 9px;
            color: var(--muted);
            font-size: 12px;
            line-height: 1.7;
        }

        .date-label {
            flex-shrink: 0;
            padding: 11px 14px;
            background: white;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 11px;
            color: #555;
        }

        /* METRICS */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 17px;
            margin-bottom: 26px;
        }

        .stat-card {
            padding: 21px;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 12px;
            min-width: 0;
        }

        .stat-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
        }

        .stat-label {
            color: var(--muted);
            font-size: 11px;
            font-weight: 500;
        }

        .stat-icon {
            width: 36px;
            height: 36px;
            display: grid;
            place-items: center;
            flex-shrink: 0;
            border-radius: 9px;
            background: #f1f2f4;
            font-size: 17px;
        }

        .stat-value {
            margin-top: 19px;
            font-family: "Plus Jakarta Sans", sans-serif;
            font-size: clamp(23px, 2vw, 31px);
            font-weight: 800;
            letter-spacing: -.04em;
            overflow-wrap: anywhere;
        }

        .stat-note {
            margin-top: 9px;
            color: var(--muted);
            font-size: 10px;
            line-height: 1.5;
        }

        .stat-note strong {
            color: var(--green);
        }

        /* CONTENT GRID */
        .content-grid {
            display: grid;
            grid-template-columns: minmax(0, 1.65fr) minmax(260px, .9fr);
            gap: 20px;
            align-items: start;
        }

        .panel {
            background: white;
            border: 1px solid var(--border);
            border-radius: 12px;
            min-width: 0;
            overflow: hidden;
        }

        .panel-header {
            padding: 21px 22px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            border-bottom: 1px solid var(--border);
        }

        .panel-title {
            font-family: "Plus Jakarta Sans", sans-serif;
            font-size: 14px;
            font-weight: 800;
        }

        .panel-subtitle {
            margin-top: 5px;
            color: var(--muted);
            font-size: 10px;
        }

        .text-link {
            color: #333;
            font-size: 10px;
            font-weight: 700;
            white-space: nowrap;
        }

        .text-link:hover {
            text-decoration: underline;
        }

        /* ORDERS TABLE */
        .table-scroll {
            width: 100%;
            overflow-x: auto;
        }

        .orders-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            white-space: nowrap;
        }

        .orders-table th {
            padding: 13px 18px;
            background: #fafafa;
            color: var(--muted);
            font-size: 9px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .07em;
        }

        .orders-table td {
            padding: 17px 18px;
            border-top: 1px solid #f0f0f0;
            font-size: 11px;
        }

        .order-number {
            font-weight: 700;
        }

        .customer-name {
            font-weight: 600;
        }

        .customer-email {
            margin-top: 4px;
            color: var(--muted);
            font-size: 9px;
        }

        .order-amount {
            font-weight: 700;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            padding: 6px 9px;
            border-radius: 20px;
            font-size: 9px;
            font-weight: 700;
        }

        .badge-pending {
            color: var(--orange);
            background: #fff7ed;
        }

        .badge-processing {
            color: #1d4ed8;
            background: #eff6ff;
        }

        .badge-delivered {
            color: var(--green);
            background: #f0fdf4;
        }

        .badge-cancelled {
            color: var(--red);
            background: #fef2f2;
        }

        /* INVENTORY */
        .inventory-list {
            padding: 4px 20px;
        }

        .inventory-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .inventory-item:last-child {
            border-bottom: 0;
        }

        .product-thumb {
            width: 53px;
            height: 53px;
            flex-shrink: 0;
            border-radius: 8px;
            object-fit: cover;
            background: #f1f2f4;
        }

        .inventory-info {
            flex: 1;
            min-width: 0;
        }

        .inventory-name {
            font-size: 11px;
            font-weight: 700;
            line-height: 1.5;
            overflow-wrap: anywhere;
        }

        .inventory-category {
            margin-top: 5px;
            color: var(--muted);
            font-size: 10px;
        }

        .stock-count {
            margin-top: 7px;
            color: var(--red);
            font-size: 10px;
            font-weight: 700;
        }

        .stock-count.low {
            color: var(--orange);
        }

        .inventory-footer {
            padding: 15px 20px;
            border-top: 1px solid var(--border);
        }

        .inventory-footer a {
            display: block;
            text-align: center;
            padding: 12px;
            background: #111;
            color: white;
            border-radius: 7px;
            font-size: 10px;
            font-weight: 700;
        }

        .inventory-footer a:hover {
            background: #333;
        }

        .demo-notice {
            margin-top: 22px;
            color: #8a8d94;
            font-size: 10px;
            line-height: 1.6;
        }

        .sidebar-overlay {
            display: none;
        }

        /* TABLET */
        @media (max-width: 1150px) {
            .sidebar {
                width: 220px;
            }

            .main-content {
                margin-left: 220px;
            }

            .dashboard {
                padding: 27px 22px 38px;
            }

            .topbar {
                padding: 15px 22px;
            }

            .stats-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .content-grid {
                grid-template-columns: minmax(0, 1fr);
            }
        }

        /* MOBILE */
        @media (max-width: 760px) {
            .sidebar {
                width: 265px;
                max-width: 85vw;
                transform: translateX(-100%);
            }

            .sidebar.open {
                transform: translateX(0);
            }

            .sidebar-overlay.visible {
                display: block;
                position: fixed;
                inset: 0;
                z-index: 90;
                background: rgba(0,0,0,.42);
            }

            .main-content {
                margin-left: 0;
            }

            .topbar {
                min-height: 68px;
                padding: 12px 16px;
            }

            .menu-toggle {
                display: block;
                flex-shrink: 0;
            }

            .topbar-title {
                font-size: 16px;
            }

            .admin-profile {
                gap: 8px;
            }

            .admin-avatar {
                width: 35px;
                height: 35px;
            }

            .admin-name {
                font-size: 10px;
            }

            .admin-role {
                font-size: 9px;
            }

            .dashboard {
                padding: 24px 16px 32px;
            }

            .welcome-row {
                flex-direction: column;
                gap: 14px;
                margin-bottom: 22px;
            }

            .date-label {
                font-size: 10px;
            }

            .stats-grid {
                gap: 12px;
                margin-bottom: 18px;
            }

            .stat-card {
                padding: 16px;
            }

            .stat-icon {
                width: 31px;
                height: 31px;
                font-size: 14px;
            }

            .stat-value {
                margin-top: 15px;
            }

            .panel-header {
                padding: 17px 15px;
            }

            .inventory-list {
                padding: 4px 15px;
            }

            .inventory-footer {
                padding: 13px 15px;
            }

            .demo-notice {
                margin-top: 17px;
            }
        }

        @media (max-width: 380px) {
            .dashboard {
                padding: 20px 10px 28px;
            }

            .topbar {
                padding: 10px;
                gap: 8px;
            }

            .topbar-left {
                gap: 8px;
            }

            .menu-toggle {
                width: 34px;
                height: 34px;
            }

            .topbar-title {
                font-size: 14px;
            }

            .breadcrumb {
                font-size: 9px;
            }

            .admin-profile {
                gap: 0;
            }

            .admin-profile > div:last-child {
                display: none;
            }

            .stats-grid {
                gap: 9px;
            }

            .stat-card {
                padding: 12px;
                border-radius: 10px;
            }

            .stat-label {
                font-size: 10px;
                line-height: 1.5;
            }

            .stat-icon {
                width: 27px;
                height: 27px;
                font-size: 12px;
            }

            .stat-value {
                font-size: 22px;
            }

            .stat-note {
                font-size: 9px;
            }

            .welcome-title {
                font-size: 23px;
            }

            .panel-header {
                gap: 8px;
            }

            .panel-title {
                font-size: 13px;
            }
        }
    </style>
</head>

<body>
<div class="admin-layout">

    <aside class="sidebar" id="adminSidebar">
        <a href="#" class="brand">
            <div class="brand-mark">P</div>
            <div>
                <div class="brand-name">PACELET</div>
                <div class="brand-subtitle">Admin Studio</div>
            </div>
        </a>

        <div class="nav-label">Workspace</div>

        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="nav-link active">
                <span class="nav-icon">▦</span> Dashboard
            </a>

            <a href="${pageContext.request.contextPath}/admin/products"
               class="nav-link">
                <span class="nav-icon">□</span> Products
            </a>

            <a href="${pageContext.request.contextPath}/admin/orders"
               class="nav-link">
                <span class="nav-icon">▤</span> Orders
            </a>

            <a href="${pageContext.request.contextPath}/admin/customers"
               class="nav-link">
                <span class="nav-icon">♙</span> Customers
            </a>

            <a href="${pageContext.request.contextPath}/admin/inventory"
               class="nav-link">
                <span class="nav-icon">▧</span> Inventory
            </a>

            <a href="${pageContext.request.contextPath}/admin/reports"
               class="nav-link">
                <span class="nav-icon">▥</span> Reports
            </a>
        </nav>

        <div class="nav-label">Store</div>

        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/"
               class="nav-link">
                <span class="nav-icon">↗</span> View Store
            </a>
        </nav>

        <div class="sidebar-bottom">
            <div class="store-status">
                <span class="status-dot"></span>
                Store dashboard
            </div>
        </div>
    </aside>

    <div class="sidebar-overlay" id="sidebarOverlay"></div>

    <main class="main-content">
        <header class="topbar">
            <div class="topbar-left">
                <button class="menu-toggle" id="menuToggle"
                        type="button" aria-label="Toggle navigation"
                        aria-expanded="false">☰</button>

                <div>
                    <div class="topbar-title">Dashboard</div>
                    <div class="breadcrumb">Admin / Overview</div>
                </div>
            </div>

            <div class="admin-profile">
                <div class="admin-avatar">AD</div>
                <div>
                    <div class="admin-name">Store Admin</div>
                    <div class="admin-role">Administrator</div>
                </div>
            </div>
        </header>

        <section class="dashboard">
            <div class="welcome-row">
                <div>
                    <h1 class="welcome-title">Store Overview</h1>
                    <p class="welcome-text">
                        Here's what's happening with your store.
                    </p>
                </div>

                <div class="date-label">Dashboard Preview</div>
            </div>

            <!-- Preview metrics: connect to database later -->
            <div class="stats-grid">
                <article class="stat-card">
                    <div class="stat-top">
                        <span class="stat-label">Total Products</span>
                        <span class="stat-icon">♢</span>
                    </div>
                    <div class="stat-value">—</div>
                    <div class="stat-note">Products in your catalog</div>
                </article>

                <article class="stat-card">
                    <div class="stat-top">
                        <span class="stat-label">Total Orders</span>
                        <span class="stat-icon">▤</span>
                    </div>
                    <div class="stat-value">—</div>
                    <div class="stat-note">Orders placed by customers</div>
                </article>

                <article class="stat-card">
                    <div class="stat-top">
                        <span class="stat-label">Total Revenue</span>
                        <span class="stat-icon">₹</span>
                    </div>
                    <div class="stat-value">—</div>
                    <div class="stat-note">Revenue from recorded orders</div>
                </article>

                <article class="stat-card">
                    <div class="stat-top">
                        <span class="stat-label">Customers</span>
                        <span class="stat-icon">♙</span>
                    </div>
                    <div class="stat-value">—</div>
                    <div class="stat-note">Registered store customers</div>
                </article>
            </div>

            <div class="content-grid">
                <section class="panel">
                    <div class="panel-header">
                        <div>
                            <h2 class="panel-title">Recent Orders</h2>
                            <p class="panel-subtitle">
                                Latest activity from your store
                            </p>
                        </div>

                        <a class="text-link"
                           href="${pageContext.request.contextPath}/admin/orders">
                            View all →
                        </a>
                    </div>

                    <div class="table-scroll">
                        <table class="orders-table">
                            <thead>
                            <tr>
                                <th>Order</th>
                                <th>Customer</th>
                                <th>Amount</th>
                                <th>Status</th>
                            </tr>
                            </thead>

                            <tbody>
                            <tr>
                                <td colspan="4"
                                    style="text-align:center;padding:28px 18px;color:#777;font-size:11px;white-space:normal;">
                                    Order data will appear here after the dashboard is connected to MySQL.
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </section>

                <section class="panel">
                    <div class="panel-header">
                        <div>
                            <h2 class="panel-title">Low Stock Alert</h2>
                            <p class="panel-subtitle">
                                Products that need restocking
                            </p>
                        </div>
                    </div>

                    <div class="inventory-list">
                        <div style="padding:25px 0;text-align:center;color:#777;font-size:11px;line-height:1.7;">
                            Inventory alerts will appear here after connecting to MySQL.
                        </div>
                    </div>

                    <div class="inventory-footer">
                        <a href="${pageContext.request.contextPath}/admin/inventory">
                            Manage Inventory →
                        </a>
                    </div>
                </section>
            </div>

            <p class="demo-notice">
                Dashboard UI preview — figures and records are not connected
                to live database data yet.
            </p>
        </section>
    </main>
</div>

<script>
    const sidebar = document.getElementById("adminSidebar");
    const menuToggle = document.getElementById("menuToggle");
    const overlay = document.getElementById("sidebarOverlay");

    function closeSidebar() {
        sidebar.classList.remove("open");
        overlay.classList.remove("visible");
        menuToggle.setAttribute("aria-expanded", "false");
    }

    menuToggle.addEventListener("click", function () {
        const isOpen = sidebar.classList.toggle("open");
        overlay.classList.toggle("visible", isOpen);
        menuToggle.setAttribute("aria-expanded", String(isOpen));
    });

    overlay.addEventListener("click", closeSidebar);

    window.addEventListener("resize", function () {
        if (window.innerWidth > 760) {
            closeSidebar();
        }
    });
</script>
</body>
</html>
