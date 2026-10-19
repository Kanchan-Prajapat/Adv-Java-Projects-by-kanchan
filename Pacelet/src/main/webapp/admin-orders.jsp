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

    <title>Order Management — Pacelet</title>

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
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap"
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

            background: #f5f7fb;
            color: #191c1f;

            font-family: "Inter", sans-serif;
        }

        /* =========================================
           PAGE
           ========================================= */

        .admin-page {
            max-width: 1150px;

            margin: auto;

            padding: 70px 24px;
        }

        /* =========================================
           HEADER
           ========================================= */

        .admin-header {
            display: flex;

            align-items: flex-end;
            justify-content: space-between;

            gap: 20px;

            margin-bottom: 30px;
        }

        .admin-kicker {
            display: block;

            margin-bottom: 7px;

            color: #64748b;

            font-size: 10px;
            font-weight: 800;

            letter-spacing: 0.12em;

            text-transform: uppercase;
        }

        .admin-header h1 {
            margin: 0;

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 32px;
            font-weight: 800;

            letter-spacing: -0.03em;
        }

        .admin-header p {
            margin: 8px 0 0;

            color: #64748b;

            font-size: 13px;
        }

        .order-count {
            padding: 9px 13px;

            border-radius: 8px;

            background: #ffffff;

            border: 1px solid #e1e5eb;

            color: #475569;

            font-size: 11px;
            font-weight: 700;
        }

        /* =========================================
           ORDERS
           ========================================= */

        .orders-list {
            display: flex;

            flex-direction: column;

            gap: 14px;
        }

        .order-card {
            background: #ffffff;

            border: 1px solid #e1e5eb;

            border-radius: 14px;

            padding: 22px;
        }

        .order-main {
            display: grid;

            grid-template-columns:
                1.3fr
                0.8fr
                0.8fr
                1fr;

            align-items: center;

            gap: 22px;
        }

        /* =========================================
           ORDER INFO
           ========================================= */

        .label {
            display: block;

            margin-bottom: 6px;

            color: #64748b;

            font-size: 9px;
            font-weight: 800;

            letter-spacing: 0.1em;

            text-transform: uppercase;
        }

        .order-id {
            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 16px;
            font-weight: 800;
        }

        .order-date {
            margin-top: 5px;

            color: #64748b;

            font-size: 11px;
        }

        .value {
            font-size: 14px;
            font-weight: 600;
        }

        .total {
            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 17px;
            font-weight: 800;
        }

        /* =========================================
           STATUS
           ========================================= */

        .status-badge {
            display: inline-flex;

            padding: 6px 9px;

            border-radius: 6px;

            background: #ecfdf5;

            color: #047857;

            font-size: 9px;
            font-weight: 800;

            letter-spacing: 0.05em;

            text-transform: uppercase;
        }

        /* =========================================
           UPDATE FORM
           ========================================= */

        .status-form {
            display: flex;

            align-items: center;

            gap: 8px;

            margin-top: 18px;

            padding-top: 18px;

            border-top: 1px solid #edf0f3;
        }

        .status-form select {
            min-width: 170px;

            padding: 10px 12px;

            border: 1px solid #d7dce3;

            border-radius: 7px;

            background: #ffffff;

            color: #191c1f;

            font-family: "Inter", sans-serif;

            font-size: 12px;

            outline: none;
        }

        .status-form select:focus {
            border-color: #191c1f;
        }

        .update-btn {
            display: inline-flex;

            align-items: center;
            justify-content: center;

            gap: 6px;

            padding: 10px 15px;

            border: none;

            border-radius: 7px;

            background: #191c1f;

            color: #ffffff;

            cursor: pointer;

            font-size: 10px;
            font-weight: 800;

            letter-spacing: 0.05em;

            text-transform: uppercase;
        }

        .update-btn:hover {
            background: #34383d;
        }

        /* =========================================
           EMPTY STATE
           ========================================= */

        .empty-orders {
            padding: 70px 25px;

            background: #ffffff;

            border: 1px solid #e1e5eb;

            border-radius: 14px;

            text-align: center;
        }

        .empty-orders span {
            display: block;

            margin-bottom: 12px;

            color: #64748b;

            font-size: 42px;
        }

        .empty-orders h2 {
            margin: 0 0 7px;

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

        /* =========================================
           MOBILE
           ========================================= */

        @media (max-width: 800px) {

            .admin-page {
                padding:
                    40px
                    16px
                    60px;
            }

            .admin-header {
                align-items: flex-start;

                flex-direction: column;
            }

            .order-main {
                grid-template-columns:
                    1fr
                    1fr;
            }

        }

        @media (max-width: 500px) {

            .order-main {
                grid-template-columns: 1fr;
            }

            .status-form {
                align-items: stretch;

                flex-direction: column;
            }

            .status-form select,
            .update-btn {
                width: 100%;
            }

        }

    </style>

</head>

<body>


<main class="admin-page">


    <!-- =========================================
         HEADER
         ========================================= -->

    <header class="admin-header">

        <div>

            <span class="admin-kicker">
                PACELET ADMIN
            </span>

            <h1>
                Order Management
            </h1>

            <p>
                Manage customer orders and update their delivery status.
            </p>

        </div>


        <div class="order-count">

            <%= orders != null ? orders.size() : 0 %>
            Orders

        </div>

    </header>


    <!-- =========================================
         ORDERS
         ========================================= -->

    <% if (orders != null && !orders.isEmpty()) { %>


        <section class="orders-list">


            <% for (Order order : orders) { %>


                <article class="order-card">


                    <div class="order-main">


                        <!-- ORDER ID -->

                        <div>

                            <span class="label">
                                Order
                            </span>

                            <div class="order-id">
                                <%= order.getOrderId() %>
                            </div>

                            <div class="order-date">
                                <%= order.getOrderDate() %>
                            </div>

                        </div>


                        <!-- PAYMENT -->

                        <div>

                            <span class="label">
                                Payment
                            </span>

                            <div class="value">

                                <%= order.getPaymentMethod() != null
                                        ? order.getPaymentMethod()
                                        : "Not available" %>

                            </div>

                        </div>


                        <!-- TOTAL -->

                        <div>

                            <span class="label">
                                Total
                            </span>

                            <div class="total">

                                ₹<%= String.format(
                                        "%,.0f",
                                        order.getTotal()
                                    ) %>

                            </div>

                        </div>


                        <!-- CURRENT STATUS -->

                        <div>

                            <span class="label">
                                Current Status
                            </span>

                            <span class="status-badge">

                                <%= order.getStatus() %>

                            </span>

                        </div>


                    </div>


                    <!-- STATUS UPDATE -->

                    <form
                        class="status-form"
                        method="post"
                        action="<%= request.getContextPath() %>/order/status"
                    >

                        <input
                            type="hidden"
                            name="orderId"
                            value="<%= order.getOrderId() %>"
                        >


                        <select name="status">

                            <option
                                value="Confirmed"
                                <%= "Confirmed".equals(order.getStatus())
                                        ? "selected"
                                        : "" %>
                            >
                                Confirmed
                            </option>

                            <option
                                value="Processing"
                                <%= "Processing".equals(order.getStatus())
                                        ? "selected"
                                        : "" %>
                            >
                                Processing
                            </option>

                            <option
                                value="Shipped"
                                <%= "Shipped".equals(order.getStatus())
                                        ? "selected"
                                        : "" %>
                            >
                                Shipped
                            </option>

                            <option
                                value="Delivered"
                                <%= "Delivered".equals(order.getStatus())
                                        ? "selected"
                                        : "" %>
                            >
                                Delivered
                            </option>

                        </select>


                        <button
                            type="submit"
                            class="update-btn"
                        >

                            <span
                                class="material-symbols-outlined"
                                style="font-size:16px;"
                            >
                                sync
                            </span>

                            Update Status

                        </button>

                    </form>


                </article>


            <% } %>


        </section>


    <% } else { %>


        <!-- EMPTY -->

        <section class="empty-orders">

            <span class="material-symbols-outlined">
                inventory_2
            </span>

            <h2>
                No Orders Yet
            </h2>

            <p>
                Customer orders will appear here.
            </p>

        </section>


    <% } %>


</main>

</body>

</html>