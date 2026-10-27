<%@ page contentType="text/html;charset=UTF-8" %>

    <% String fullName=(String) request.getAttribute("fullName"); String phone=(String) request.getAttribute("phone");
        String address=(String) request.getAttribute("address"); String city=(String) request.getAttribute("city");
        String state=(String) request.getAttribute("state"); String pincode=(String) request.getAttribute("pincode");
        String orderId=(String) request.getAttribute("orderId"); Double totalObj=(Double) request.getAttribute("total");
        double total=totalObj !=null ? totalObj : 0; String paymentMethod=(String)
        request.getAttribute("paymentMethod"); %>


        <!DOCTYPE html>

        <html lang="en">

        <head>

            <meta charset="UTF-8">

            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <title>Profile — Pacelet</title>


            <!-- Existing Navbar CSS -->

            <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/navbar.css">


            <!-- Fonts -->

            <link rel="preconnect" href="https://fonts.googleapis.com">

            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

            <link
                href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap"
                rel="stylesheet">


            <!-- Material Symbols -->

            <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">


            <style>
                * {
                    box-sizing: border-box;
                }


                body {

                    margin: 0;

                    background: #f6f8fc;

                    color: #191c1f;

                    font-family: "Inter", sans-serif;
                }


                .profile-page {

                    max-width: 1000px;

                    margin: auto;

                    padding: 135px 24px 70px;
                }


                /* =========================================
           PAGE HEADER
           ========================================= */

                .profile-header {

                    margin-bottom: 32px;
                }


                .profile-header h1 {

                    margin: 0 0 8px;

                    font-family:
                        "Plus Jakarta Sans",
                        sans-serif;

                    font-size: 34px;

                    font-weight: 800;

                    letter-spacing: -0.03em;
                }


                .profile-header p {

                    margin: 0;

                    color: #52627a;

                    font-size: 14px;
                }


                /* =========================================
           PROFILE HERO
           ========================================= */

                .profile-hero {

                    display: flex;

                    align-items: center;

                    gap: 20px;

                    margin-bottom: 24px;

                    padding: 26px;

                    background: #ffffff;

                    border: 1px solid #e3e7ed;

                    border-radius: 14px;
                }


                .profile-avatar {

                    width: 68px;

                    height: 68px;

                    flex-shrink: 0;

                    display: flex;

                    align-items: center;

                    justify-content: center;

                    border-radius: 50%;

                    background: #f0f1f5;

                    color: #191c1f;
                }


                .edit-profile-button {
                    padding: 9px 14px;
                    border: 1px solid #d7dce3;
                    border-radius: 7px;
                    background: #ffffff;
                    color: #191c1f;
                    text-decoration: none;
                    font-size: 10px;
                    font-weight: 800;
                    letter-spacing: 0.06em;
                    text-transform: uppercase;
                }

                .edit-profile-button:hover {
                    background: #f8fafc;
                }


                .profile-avatar span {

                    font-size: 34px;
                }


                .profile-user-name {

                    margin: 0 0 5px;

                    font-family:
                        "Plus Jakarta Sans",
                        sans-serif;

                    font-size: 20px;

                    font-weight: 800;
                }


                .profile-user-phone {

                    color: #64748b;

                    font-size: 13px;
                }


                .membership-badge {

                    margin-left: auto;

                    padding: 8px 12px;

                    border-radius: 7px;

                    background: #f3eef7;

                    color: #735d78;

                    font-size: 10px;

                    font-weight: 800;

                    letter-spacing: 0.08em;
                }

                .membership-badge {
                    display: none;
                }

                .edit-profile-button {
                    margin-left: auto;
                }

                /* =========================================
           GRID
           ========================================= */

                .profile-grid {

                    display: grid;

                    grid-template-columns:
                        minmax(0, 1.2fr) minmax(300px, 0.8fr);

                    gap: 24px;
                }


                .card {

                    background: #ffffff;

                    border: 1px solid #e3e7ed;

                    border-radius: 14px;

                    padding: 26px;
                }


                .card h2 {

                    margin: 0 0 22px;

                    font-family:
                        "Plus Jakarta Sans",
                        sans-serif;

                    font-size: 19px;

                    font-weight: 700;
                }


                /* =========================================
           INFORMATION ROWS
           ========================================= */

                .info-row {

                    padding: 15px 0;

                    border-bottom: 1px solid #edf0f3;
                }


                .info-row:first-child {

                    padding-top: 0;
                }


                .info-row:last-child {

                    border-bottom: none;

                    padding-bottom: 0;
                }


                .info-label {

                    display: block;

                    margin-bottom: 6px;

                    color: #64748b;

                    font-size: 10px;

                    font-weight: 700;

                    letter-spacing: 0.09em;

                    text-transform: uppercase;
                }


                .info-value {

                    color: #1f2937;

                    font-size: 14px;

                    line-height: 1.55;
                }


                /* =========================================
           ORDER CARD
           ========================================= */

                .order-card {

                    padding: 18px;

                    border: 1px solid #e5e7eb;

                    border-radius: 10px;

                    background: #f8fafc;
                }


                .order-top {

                    display: flex;

                    align-items: center;

                    justify-content: space-between;

                    gap: 15px;

                    margin-bottom: 16px;
                }


                .all-orders-btn {
                    display: inline-flex;

                    align-items: center;
                    justify-content: center;

                    gap: 7px;

                    padding: 10px 15px;

                    border: 1px solid #d7dce3;
                    border-radius: 7px;

                    background: #ffffff;
                    color: #191c1f;

                    text-decoration: none;

                    font-size: 11px;
                    font-weight: 800;

                    letter-spacing: 0.05em;
                    text-transform: uppercase;

                    transition: 0.2s ease;
                }

                .all-orders-btn:hover {
                    background: #191c1f;
                    color: #ffffff;

                    border-color: #191c1f;
                }

                .all-orders-btn .material-symbols-outlined {
                    font-size: 17px;
                }


                .order-label {

                    color: #64748b;

                    font-size: 10px;

                    font-weight: 700;

                    letter-spacing: 0.08em;

                    text-transform: uppercase;
                }


                .order-id {

                    margin-top: 5px;

                    font-family:
                        "Plus Jakarta Sans",
                        sans-serif;

                    font-size: 15px;

                    font-weight: 800;

                    letter-spacing: 0.04em;
                }


                .order-status {

                    padding: 6px 9px;

                    border-radius: 6px;

                    background: #ecfdf5;

                    color: #047857;

                    font-size: 10px;

                    font-weight: 800;
                }


                .order-details {

                    display: flex;

                    align-items: center;

                    justify-content: space-between;

                    gap: 15px;

                    padding-top: 15px;

                    border-top: 1px solid #e5e7eb;
                }


                .order-payment {

                    color: #64748b;

                    font-size: 12px;
                }


                .order-payment strong {

                    display: block;

                    margin-top: 4px;

                    color: #1f2937;

                    font-size: 13px;
                }


                .order-total {

                    text-align: right;
                }


                .order-total span {

                    display: block;

                    margin-bottom: 4px;

                    color: #64748b;

                    font-size: 10px;

                    text-transform: uppercase;

                    letter-spacing: 0.07em;
                }


                .order-total strong {

                    font-family:
                        "Plus Jakarta Sans",
                        sans-serif;

                    font-size: 19px;
                }


                /* =========================================
           ATELIER CARD
           ========================================= */

                .atelier-card {

                    margin-top: 24px;

                    background: #111113;

                    color: #ffffff;

                    border-radius: 14px;

                    padding: 26px;
                }


                .atelier-kicker {

                    margin-bottom: 8px;

                    color: #c8b9cc;

                    font-size: 10px;

                    font-weight: 700;

                    letter-spacing: 0.15em;

                    text-transform: uppercase;
                }


                .atelier-card h2 {

                    margin: 0 0 8px;

                    font-family:
                        "Plus Jakarta Sans",
                        sans-serif;

                    font-size: 21px;
                }


                .atelier-card p {

                    margin: 0;

                    color: #c7c7cc;

                    font-size: 13px;

                    line-height: 1.6;
                }


                /* =========================================
           EMPTY ORDER
           ========================================= */

                .empty-order {

                    padding: 30px 10px;

                    text-align: center;

                    color: #64748b;

                    font-size: 13px;
                }


                .empty-order span {

                    display: block;

                    margin-bottom: 10px;

                    font-size: 32px;
                }


                /* =========================================
           RESPONSIVE
           ========================================= */

                @media (max-width: 760px) {

                    .profile-page {

                        padding: 115px 16px 60px;
                    }

                    .membership-badge {
                        display: none;
                    }


                    .profile-header h1 {

                        font-size: 28px;
                    }


                    .profile-hero {

                        padding: 20px;
                    }





                    .profile-grid {

                        grid-template-columns: 1fr;
                    }


                    .card {

                        padding: 21px;
                    }
                }


                
/* ===== RESPONSIVE PACELET PROFILE ===== */

.profile-page {
    width: 100%;
    max-width: 1100px;
    margin: 0 auto;
    padding: 120px 24px 60px;
    min-width: 0;
}

.profile-grid {
    grid-template-columns: minmax(0, 1.2fr) minmax(0, 0.8fr);
    gap: 24px;
}

.profile-grid > *,
.profile-hero > *,
.card,
.order-card {
    min-width: 0;
}

.profile-user-name,
.info-value,
.order-id {
    overflow-wrap: anywhere;
}

.profile-hero {
    flex-wrap: wrap;
}

.edit-profile-button {
    flex-shrink: 0;
}

.order-top,
.order-details {
    min-width: 0;
}

.order-status {
    max-width: 100%;
    overflow-wrap: anywhere;
}

.order-payment,
.order-total {
    min-width: 0;
}

.order-total strong {
    white-space: nowrap;
}

.view-order-btn,
.all-orders-btn {
    max-width: 100%;
    text-align: center;
}

/* Tablet */
@media (max-width: 760px) {
    .profile-page {
        padding: 105px 20px 48px;
    }

    .profile-grid {
        grid-template-columns: minmax(0, 1fr);
        gap: 18px;
    }

    .profile-hero {
        gap: 16px;
        padding: 20px;
    }

    .membership-badge {
        display: none;
    }

    .card {
        padding: 21px;
    }
}

/* Mobile */
@media (max-width: 600px) {
    .profile-page {
        padding: 88px 12px 36px;
    }

    .profile-header {
        margin-bottom: 22px;
    }

    .profile-header h1 {
        font-size: clamp(25px, 7vw, 30px);
        line-height: 1.2;
    }

    .profile-header p {
        font-size: 12px;
        line-height: 1.6;
    }

    .profile-hero {
        display: grid;
        grid-template-columns: 54px minmax(0, 1fr);
        gap: 12px;
        padding: 16px;
        margin-bottom: 16px;
        border-radius: 11px;
    }

    .profile-avatar {
        width: 54px;
        height: 54px;
        grid-row: 1;
    }

    .profile-avatar span {
        font-size: 28px;
    }

    .profile-user-name {
        font-size: 16px;
        line-height: 1.4;
    }

    .profile-user-phone {
        font-size: 11px;
        overflow-wrap: anywhere;
    }

    .edit-profile-button {
        grid-column: 1 / -1;
        width: 100%;
        min-height: 42px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0;
        font-size: 10px;
    }

    .profile-grid {
        gap: 16px;
    }

    .card {
        padding: 16px;
        border-radius: 11px;
    }

    .card h2 {
        font-size: 17px;
        line-height: 1.4;
        margin-bottom: 18px;
    }

    .info-row {
        padding: 13px 0;
    }

    .info-label {
        font-size: 9px;
    }

    .info-value {
        font-size: 12px;
        line-height: 1.65;
    }

    .section-heading-row {
        flex-wrap: wrap;
        gap: 12px;
    }

    .order-card {
        padding: 12px;
    }

    .order-top {
        align-items: flex-start;
        gap: 10px;
    }

    .order-label {
        font-size: 9px;
    }

    .order-id {
        font-size: 13px;
        line-height: 1.5;
    }

    .order-status {
        padding: 5px 7px;
        font-size: 8px;
    }

    .order-details {
        flex-wrap: wrap;
        gap: 14px;
    }

    .order-payment {
        font-size: 11px;
    }

    .order-payment strong {
        font-size: 12px;
        overflow-wrap: anywhere;
    }

    .order-total {
        text-align: left;
    }

    .order-total strong {
        font-size: 17px;
    }

    .view-order-btn,
    .all-orders-btn {
        width: 100%;
        min-height: 42px;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 10px;
        font-size: 10px;
    }

    .atelier-card {
        padding: 20px;
        margin-top: 16px;
        border-radius: 11px;
    }

    .atelier-card h2 {
        font-size: 19px;
        line-height: 1.4;
    }

    .atelier-card p {
        font-size: 12px;
        line-height: 1.7;
    }
}

/* Very narrow phones */
@media (max-width: 360px) {
    .profile-page {
        padding-right: 8px;
        padding-left: 8px;
    }

    .profile-hero,
    .card,
    .atelier-card {
        padding: 12px;
    }

    .profile-hero {
        grid-template-columns: 46px minmax(0, 1fr);
    }

    .profile-avatar {
        width: 46px;
        height: 46px;
    }

    .profile-avatar span {
        font-size: 24px;
    }

    .order-top {
        flex-direction: column;
    }

    .order-details {
        align-items: flex-start;
        flex-direction: column;
    }

    .order-total {
        text-align: left;
    }
}

            </style>

        </head>


        <body>


            <!-- =========================================
         NAVBAR
         ========================================= -->

            <%@ include file="/WEB-INF/views/common/navbar.jsp" %>


                <!-- =========================================
         PROFILE
         ========================================= -->

                <main class="profile-page">


                    <!-- HEADER -->

                    <section class="profile-header">

                        <h1>
                            My Profile
                        </h1>

                        <p>
                            Manage your Pacelet account and orders.
                        </p>

                    </section>


                    <!-- PROFILE HERO -->

                    <section class="profile-hero">

                        <div class="profile-avatar">

                            <span class="material-symbols-outlined">
                                person
                            </span>

                        </div>


                        <div>

                            <h2 class="profile-user-name">

                                <%= fullName !=null ? fullName : "Pacelet Customer" %>

                            </h2>


                            <div class="profile-user-phone">

                                <%= phone !=null ? phone : "Phone not available" %>

                            </div>

                        </div>


                        <div class="membership-badge">

                            PACELET ATELIER

                        </div>

                        <a href="<%= request.getContextPath() %>/profile/edit" class="edit-profile-button">
                            Edit Profile
                        </a>


                    </section>



                    <!-- MAIN GRID -->

                    <div class="profile-grid">


                        <!-- =====================================
                 ACCOUNT INFORMATION
                 ====================================== -->

                        <section class="card">

                            <h2>
                                Account Information
                            </h2>


                            <div class="info-row">

                                <span class="info-label">
                                    Full Name
                                </span>

                                <div class="info-value">

                                    <%= fullName !=null ? fullName : "Not available" %>

                                </div>

                            </div>


                            <div class="info-row">

                                <span class="info-label">
                                    Phone
                                </span>

                                <div class="info-value">

                                    <%= phone !=null ? phone : "Not available" %>

                                </div>

                            </div>


                            <div class="info-row">

                                <span class="info-label">
                                    Delivery Address
                                </span>

                                <div class="info-value">

                                    <% if (address !=null) { %>

                                        <%= address %><br>

                                            <%= city !=null ? city : "" %>,
                                                <%= state !=null ? state : "" %>
                                                    -
                                                    <%= pincode !=null ? pincode : "" %>

                                                        <% } else { %>

                                                            No saved address yet.

                                                            <% } %>

                                </div>

                            </div>

                        </section>


                        <!-- =====================================
                 ORDERS
                 ====================================== -->

                        <section class="card">

                            <div class="section-heading-row">

                                <div>
                                    <h2>Recent Orders</h2>





                                    <% if (orderId !=null) { %>


                                        <div class="order-card">


                                            <div class="order-top">

                                                <div>

                                                    <div class="order-label">
                                                        Order ID
                                                    </div>

                                                    <div class="order-id">
                                                        <%= orderId %>
                                                    </div>

                                                </div>


                                                <div class="order-status">
                                                    CONFIRMED
                                                </div>

                                            </div>


                                            <div class="order-details">


                                                <div class="order-payment">

                                                    Payment

                                                    <strong>

                                                        <%= paymentMethod !=null ? paymentMethod : "Not available" %>

                                                    </strong>

                                                </div>


                                                <div class="order-total">

                                                    <span>
                                                        Total
                                                    </span>

                                                    <strong>

                                                        ₹<%= String.format( "%,.0f" , total ) %>

                                                    </strong>

                                                </div>

                                                <a href="<%= request.getContextPath() %>/profile/order?orderId=<%= orderId %>"
                                                    class="view-order-btn">
                                                    View Order
                                                </a>

                                                <p>
                                                    Your latest Pacelet purchases.
                                                </p>
                                            </div>

                                            <a href="<%= request.getContextPath() %>/orders" class="all-orders-btn">
                                                <span class="material-symbols-outlined">
                                                    receipt_long
                                                </span>

                                                View All Orders
                                            </a>
                                        </div>

                                </div>

                            </div>


                            <% } else { %>


                                <div class="empty-order">

                                    <span class="material-symbols-outlined">
                                        shopping_bag
                                    </span>

                                    No orders yet.

                                </div>


                                <% } %>


                        </section>

                    </div>


                    <!-- =========================================
             ATELIER MEMBERSHIP
             ========================================== -->

                    <section class="atelier-card">

                        <div class="atelier-kicker">
                            Pacelet Membership
                        </div>


                        <h2>
                            Welcome to the Atelier.
                        </h2>


                        <p>
                            Your curated Pacelet experience —
                            designed around movement, comfort
                            and everyday pace.
                        </p>

                    </section>


                </main>


        </body>

        </html>