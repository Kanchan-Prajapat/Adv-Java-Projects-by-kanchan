<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String orderId =
            (String) request.getAttribute("orderId");

    Double bagTotalObj =
            (Double) request.getAttribute("bagTotal");

    Double discountObj =
            (Double) request.getAttribute("discount");

    Double totalObj =
            (Double) request.getAttribute("total");

    double bagTotal =
            bagTotalObj != null ? bagTotalObj : 0;

    double discount =
            discountObj != null ? discountObj : 0;

    double total =
            totalObj != null ? totalObj : 0;

    String couponCode =
            (String) request.getAttribute("couponCode");

    String paymentMethod =
            (String) request.getAttribute("paymentMethod");

    String fullName =
            (String) request.getAttribute("fullName");

    String phone =
            (String) request.getAttribute("phone");

    String address =
            (String) request.getAttribute("address");

    String city =
            (String) request.getAttribute("city");

    String state =
            (String) request.getAttribute("state");

    String pincode =
            (String) request.getAttribute("pincode");


    if (orderId == null) {
        orderId = "PAC-00000";
    }

    if (paymentMethod == null) {
        paymentMethod = "Cash on Delivery";
    }
%>


<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0"
    >

    <title>Order Confirmed — Pacelet</title>


    <!-- Navbar CSS -->

    <link
        rel="stylesheet"
        href="<%= request.getContextPath() %>/assets/css/navbar.css"
    >


    <!-- Google Fonts -->

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


        .confirmation-page {

            max-width: 1000px;

            margin: 0 auto;

            padding: 150px 24px 80px;
        }


        /* =========================================
           SUCCESS HEADER
           ========================================= */

        .success-header {

            text-align: center;

            margin-bottom: 42px;
        }


        .success-icon {

            width: 72px;
            height: 72px;

            margin: 0 auto 22px;

            display: flex;

            align-items: center;
            justify-content: center;

            border-radius: 50%;

            background: #ecfdf5;

            color: #059669;

            border: 1px solid #a7f3d0;
        }


        .success-icon span {

            font-size: 38px;
        }


        .success-header h1 {

            margin: 0 0 10px;

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 34px;

            font-weight: 800;

            letter-spacing: -0.03em;
        }


        .success-header p {

            margin: 0;

            color: #52627a;

            font-size: 15px;
        }


        /* =========================================
           ORDER ID
           ========================================= */

        .order-id-card {

            max-width: 520px;

            margin: 28px auto 0;

            padding: 18px 24px;

            background: #ffffff;

            border: 1px solid #e5e7eb;

            border-radius: 12px;

            text-align: center;
        }


        .order-id-label {

            display: block;

            margin-bottom: 6px;

            color: #64748b;

            font-size: 11px;

            font-weight: 700;

            letter-spacing: 0.12em;

            text-transform: uppercase;
        }


        .order-id {

            color: #111827;

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 20px;

            font-weight: 800;

            letter-spacing: 0.08em;
        }


        /* =========================================
           MAIN GRID
           ========================================= */

        .confirmation-grid {

            display: grid;

            grid-template-columns:
                minmax(0, 1.4fr)
                minmax(320px, 0.8fr);

            gap: 24px;

            margin-top: 32px;
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
           DELIVERY
           ========================================= */

        .confirmed-badge {

            display: inline-flex;

            align-items: center;

            gap: 5px;

            padding: 7px 11px;

            margin-bottom: 18px;

            border-radius: 7px;

            background: #ecfdf5;

            color: #047857;

            font-size: 11px;

            font-weight: 700;

            letter-spacing: 0.04em;
        }


        .customer-name {

            margin-bottom: 9px;

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 16px;

            font-weight: 700;
        }


        .address-line {

            margin-bottom: 6px;

            color: #4b5563;

            font-size: 14px;

            line-height: 1.6;
        }


        .phone {

            margin-top: 12px;

            color: #374151;

            font-size: 13px;
        }


        /* =========================================
           PAYMENT
           ========================================= */

        .payment-box {

            padding: 18px;

            border: 1px solid #e5e7eb;

            border-radius: 10px;

            background: #f8fafc;
        }


        .payment-label {

            margin-bottom: 6px;

            color: #64748b;

            font-size: 11px;

            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: 0.08em;
        }


        .payment-value {

            font-size: 15px;

            font-weight: 700;
        }


        /* =========================================
           SUMMARY
           ========================================= */

        .summary-row {

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 20px;

            margin-bottom: 15px;

            color: #4b5563;

            font-size: 14px;
        }


        .summary-row strong {

            color: #111827;

            font-weight: 700;
        }


        .discount {

            color: #059669 !important;
        }


        .summary-divider {

            height: 1px;

            margin: 22px 0;

            background: #e5e7eb;
        }


        .total-row {

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 20px;
        }


        .total-label {

            color: #64748b;

            font-size: 11px;

            font-weight: 700;

            letter-spacing: 0.1em;

            text-transform: uppercase;
        }


        .total-value {

            color: #111827;

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 27px;

            font-weight: 800;
        }


        /* =========================================
           DELIVERY INFO
           ========================================= */

        .delivery-note {

            margin-top: 22px;

            padding: 13px 14px;

            border-radius: 8px;

            background: #f1f5f9;

            color: #52627a;

            font-size: 12px;

            line-height: 1.5;
        }


        /* =========================================
           ACTIONS
           ========================================= */

        .actions {

            display: flex;

            justify-content: center;

            gap: 12px;

            margin-top: 34px;
        }


        .action-button {

            display: inline-flex;

            align-items: center;

            justify-content: center;

            min-width: 190px;

            height: 48px;

            padding: 0 22px;

            border-radius: 7px;

            text-decoration: none;

            font-size: 12px;

            font-weight: 800;

            letter-spacing: 0.08em;

            text-transform: uppercase;
        }


        .primary-button {

            background: #060607;

            color: #ffffff;
        }


        .primary-button:hover {

            background: #222222;
        }


        .secondary-button {

            background: #ffffff;

            color: #191c1f;

            border: 1px solid #d7dce3;
        }


        .secondary-button:hover {

            background: #f8fafc;
        }


        /* =========================================
           RESPONSIVE
           ========================================= */

        @media (max-width: 760px) {

            .confirmation-page {

                padding: 120px 16px 60px;
            }


            .success-header h1 {

                font-size: 28px;
            }


            .confirmation-grid {

                grid-template-columns: 1fr;
            }


            .card {

                padding: 21px;
            }


            .actions {

                flex-direction: column;
            }


            .action-button {

                width: 100%;
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
         PAGE
         ========================================= -->

    <main class="confirmation-page">


        <!-- SUCCESS -->

        <section class="success-header">

            <div class="success-icon">

                <span class="material-symbols-outlined">
                    check
                </span>

            </div>


            <h1>
                Order Placed Successfully!
            </h1>


            <p>
                Thank you for choosing Pacelet.
                Your order has been confirmed.
            </p>


            <div class="order-id-card">

                <span class="order-id-label">
                    Order ID
                </span>

                <span class="order-id">
                    <%= orderId %>
                </span>

            </div>

        </section>


        <!-- =========================================
             CONTENT
             ========================================= -->

        <div class="confirmation-grid">


            <!-- LEFT -->

            <div>


                <!-- DELIVERY ADDRESS -->

                <section class="card">

                    <h2>
                        Delivery Address
                    </h2>


                    <div class="confirmed-badge">

                        ✓ CONFIRMED

                    </div>


                    <div class="customer-name">

                        <%= fullName != null
                                ? fullName
                                : "Customer" %>

                    </div>


                    <div class="address-line">

                        <%= address != null
                                ? address
                                : "" %>

                    </div>


                    <div class="address-line">

                        <%= city != null
                                ? city
                                : "" %>,
                        <%= state != null
                                ? state
                                : "" %>
                        -
                        <%= pincode != null
                                ? pincode
                                : "" %>

                    </div>


                    <div class="phone">

                        Phone:
                        <%= phone != null
                                ? phone
                                : "Not provided" %>

                    </div>

                </section>


                <!-- PAYMENT -->

                <section
                    class="card"
                    style="margin-top: 24px;"
                >

                    <h2>
                        Payment Method
                    </h2>


                    <div class="payment-box">

                        <div class="payment-label">
                            Selected Method
                        </div>


                        <div class="payment-value">

                            <%= paymentMethod %>

                        </div>

                    </div>

                </section>

            </div>


            <!-- RIGHT -->

            <div>


                <!-- ORDER SUMMARY -->

                <section class="card">

                    <h2>
                        Order Summary
                    </h2>


                    <div class="summary-row">

                        <span>
                            Bag Total
                        </span>

                        <strong>
                            ₹<%= String.format(
                                "%,.0f",
                                bagTotal
                            ) %>
                        </strong>

                    </div>


                    <% if (
                        couponCode != null
                        && discount > 0
                    ) { %>

                        <div class="summary-row">

                            <span>
                                Promotion
                                (<%= couponCode %>)
                            </span>

                            <strong class="discount">

                                - ₹<%= String.format(
                                    "%,.0f",
                                    discount
                                ) %>

                            </strong>

                        </div>

                    <% } %>


                    <div class="summary-row">

                        <span>
                            Delivery
                        </span>

                        <strong>
                            Free Express
                        </strong>

                    </div>


                    <div class="summary-row">

                        <span>
                            GST
                        </span>

                        <strong>
                            Included
                        </strong>

                    </div>


                    <div class="summary-divider"></div>


                    <div class="total-row">

                        <span class="total-label">
                            Total Paid
                        </span>

                        <span class="total-value">

                            ₹<%= String.format(
                                "%,.0f",
                                total
                            ) %>

                        </span>

                    </div>


                    <div class="delivery-note">

                        🔒 Your order and payment
                        information are securely processed.

                    </div>

                </section>

            </div>

        </div>


        <!-- =========================================
             ACTIONS
             ========================================= -->

        <div class="actions">

            <a
                href="<%= request.getContextPath() %>/"
                class="action-button primary-button"
            >
                Continue Shopping →
            </a>


            <a
                href="<%= request.getContextPath() %>/profile"
                class="action-button secondary-button"
            >
                View Profile
            </a>

        </div>


    </main>


</body>

</html>