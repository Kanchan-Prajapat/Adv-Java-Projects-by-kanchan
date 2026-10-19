<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.pacelet.model.Order" %>

<%
    List<Order> orders =
            (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0"
    >

    <title>My Orders — Pacelet</title>

    <!-- Navbar CSS -->
    <link
        rel="stylesheet"
        href="<%= request.getContextPath() %>/assets/css/navbar.css"
    >

    <!-- Fonts -->
    <link
        rel="preconnect"
        href="https://fonts.googleapis.com"
    >

    <link
        rel="preconnect"
        href="https://fonts.gstatic.com"
        crossorigin
    >

    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap"
        rel="stylesheet"
    >

    <!-- Material Symbols -->
    <link
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
        rel="stylesheet"
    >

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

        /* =========================================
           PAGE
           ========================================= */

        .orders-page {
            max-width: 1000px;
            margin: auto;
            padding: 135px 24px 70px;
        }

        /* =========================================
           HEADER
           ========================================= */

        .orders-header {
            margin-bottom: 32px;
        }

        .orders-header h1 {
            margin: 0 0 8px;

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 34px;
            font-weight: 800;

            letter-spacing: -0.03em;
        }

        .orders-header p {
            margin: 0;

            color: #52627a;
            font-size: 14px;
        }

        /* =========================================
           ORDER LIST
           ========================================= */

        .orders-list {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        /* =========================================
           ORDER CARD
           ========================================= */

        .order-card {
            background: #ffffff;

            border: 1px solid #e3e7ed;
            border-radius: 14px;

            padding: 24px;
        }

        .order-top {
            display: flex;
            align-items: center;
            justify-content: space-between;

            gap: 20px;

            padding-bottom: 18px;

            border-bottom: 1px solid #edf0f3;
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

            font-size: 16px;
            font-weight: 800;

            letter-spacing: 0.04em;
        }

        .order-date {
            margin-top: 5px;

            color: #64748b;
            font-size: 12px;
        }

        /* =========================================
           STATUS
           ========================================= */

        .order-status {
            padding: 7px 11px;

            border-radius: 7px;

            background: #ecfdf5;
            color: #047857;

            font-size: 10px;
            font-weight: 800;

            letter-spacing: 0.04em;
        }

        /* =========================================
           ORDER DETAILS
           ========================================= */

        .order-details {
            display: grid;

            grid-template-columns:
                1fr
                1fr
                auto;

            align-items: center;

            gap: 20px;

            padding-top: 20px;
        }

        .detail-label {
            display: block;

            margin-bottom: 5px;

            color: #64748b;

            font-size: 10px;
            font-weight: 700;

            letter-spacing: 0.08em;
            text-transform: uppercase;
        }

        .detail-value {
            color: #1f2937;

            font-size: 14px;
            font-weight: 600;
        }

        .detail-value.total {
            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 18px;
            font-weight: 800;
        }

        /* =========================================
           VIEW ORDER
           ========================================= */

        .view-order-btn {
            display: inline-flex;

            align-items: center;
            justify-content: center;

            gap: 7px;

            padding: 11px 17px;

            border: 1px solid #d7dce3;
            border-radius: 7px;

            background: #ffffff;
            color: #191c1f;

            text-decoration: none;

            font-size: 11px;
            font-weight: 800;

            letter-spacing: 0.06em;
            text-transform: uppercase;

            transition: 0.2s ease;
        }

        .view-order-btn:hover {
            background: #191c1f;
            color: #ffffff;

            border-color: #191c1f;
        }

        /* =========================================
           EMPTY STATE
           ========================================= */

        .empty-orders {
            background: #ffffff;

            border: 1px solid #e3e7ed;
            border-radius: 14px;

            padding: 70px 30px;

            text-align: center;
        }

        .empty-orders span {
            display: block;

            margin-bottom: 14px;

            font-size: 44px;

            color: #64748b;
        }

        .empty-orders h2 {
            margin: 0 0 8px;

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 20px;
        }

        .empty-orders p {
            margin: 0;

            color: #64748b;

            font-size: 13px;
        }

        .shop-btn {
            display: inline-flex;

            margin-top: 22px;

            padding: 12px 18px;

            border-radius: 7px;

            background: #191c1f;
            color: #ffffff;

            text-decoration: none;

            font-size: 11px;
            font-weight: 800;

            letter-spacing: 0.06em;
            text-transform: uppercase;
        }

        /* =========================================
           RESPONSIVE
           ========================================= */

        @media (max-width: 700px) {

            .orders-page {
                padding:
                    115px
                    16px
                    60px;
            }

            .orders-header h1 {
                font-size: 28px;
            }

            .order-card {
                padding: 20px;
            }

            .order-top {
                align-items: flex-start;
            }

            .order-details {
                grid-template-columns: 1fr 1fr;
            }

            .view-order-btn {
                grid-column: 1 / -1;

                width: 100%;
            }
        }

        @media (max-width: 480px) {

            .order-top {
                flex-direction: column;
            }

            .order-status {
                align-self: flex-start;
            }

            .order-details {
                grid-template-columns: 1fr;
            }

            .view-order-btn {
                grid-column: auto;
            }
        }

    </style>

</head>

<body>

    <!-- NAVBAR -->

    <%@ include file="/WEB-INF/views/common/navbar.jsp" %>


    <!-- =========================================
         ORDERS PAGE
         ========================================= -->

    <main class="orders-page">

        <section class="orders-header">

            <h1>
                My Orders
            </h1>

            <p>
                View and manage your complete Pacelet order history.
            </p>

        </section>


        <% if (orders != null && !orders.isEmpty()) { %>


            <section class="orders-list">

                <% for (Order order : orders) { %>

                    <article class="order-card">


                        <!-- ORDER HEADER -->

                        <div class="order-top">

                            <div>

                                <div class="order-label">
                                    Order ID
                                </div>

                                <div class="order-id">
                                    <%= order.getOrderId() %>
                                </div>

                                <div class="order-date">

                                    Ordered on

                                    <%= order.getOrderDate() %>

                                </div>

                            </div>


                            <div class="order-status">

                                <%= order.getStatus() %>

                            </div>

                        </div>


                        <!-- ORDER DETAILS -->

                        <div class="order-details">


                            <!-- PAYMENT -->

                            <div>

                                <span class="detail-label">
                                    Payment
                                </span>

                                <div class="detail-value">

                                    <%= order.getPaymentMethod() != null
                                            ? order.getPaymentMethod()
                                            : "Not available" %>

                                </div>

                            </div>


                            <!-- TOTAL -->

                            <div>

                                <span class="detail-label">
                                    Total
                                </span>

                                <div class="detail-value total">

                                    ₹<%= String.format(
                                            "%,.0f",
                                            order.getTotal()
                                        ) %>

                                </div>

                            </div>


                            <!-- VIEW -->

                            <a
                                href="<%= request.getContextPath() %>/profile/order?orderId=<%= order.getOrderId() %>"
                                class="view-order-btn"
                            >

                                <span class="material-symbols-outlined"
                                      style="font-size:16px;">
                                    visibility
                                </span>

                                View Order

                            </a>


                        </div>

                    </article>

                <% } %>

            </section>


        <% } else { %>


            <!-- EMPTY -->

            <section class="empty-orders">

                <span class="material-symbols-outlined">
                    shopping_bag
                </span>

                <h2>
                    No Orders Yet
                </h2>

                <p>
                    Your Pacelet orders will appear here.
                </p>

                <a
                    href="<%= request.getContextPath() %>/shop"
                    class="shop-btn"
                >
                    Start Shopping
                </a>

            </section>


        <% } %>

    </main>

</body>

</html>