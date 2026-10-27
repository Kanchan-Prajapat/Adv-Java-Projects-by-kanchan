<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.pacelet.model.Order" %>
<%@ page import="com.pacelet.model.CartItem" %>

<%
    Order order = (Order) request.getAttribute("order");

    if (order == null) {
        response.sendRedirect(request.getContextPath() + "/profile");
        return;
    }

    List<CartItem> items = order.getItems();

    String paymentMethod = order.getPaymentMethod();
    String couponCode = order.getCouponCode();

    double bagTotal = order.getBagTotal();
    double discount = order.getDiscount();
    double total = order.getTotal();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0"
    >

    <title>Order Details — Pacelet</title>


    <!-- Navbar -->

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

            font-family:
                "Inter",
                Arial,
                sans-serif;
        }


        /* =========================================
           PAGE
        ========================================= */

        .order-page {

            max-width: 1000px;

            margin: auto;

            padding: 135px 24px 70px;
        }


        /* =========================================
           HEADER
        ========================================= */

        .page-header {
            margin-bottom: 30px;
        }


        .page-header h1 {

            margin: 0 0 8px;

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 32px;

            font-weight: 800;

            letter-spacing: -0.03em;
        }


        .page-header p {

            margin: 0;

            color: #64748b;

            font-size: 14px;
        }


        /* =========================================
           STATUS
        ========================================= */

        .status-card {

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 20px;

            padding: 22px 24px;

            margin-bottom: 24px;

            background: #ffffff;

            border: 1px solid #e3e7ed;

            border-radius: 14px;
        }


        .status-label {

            color: #64748b;

            font-size: 10px;

            font-weight: 700;

            letter-spacing: 0.09em;

            text-transform: uppercase;
        }


        .status-order-id {

            margin-top: 6px;

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 19px;

            font-weight: 800;
        }


        .status-badge {

            padding: 8px 12px;

            border-radius: 7px;

            background: #ecfdf5;

            color: #047857;

            font-size: 10px;

            font-weight: 800;

            letter-spacing: 0.06em;
        }


        /* =========================================
           PRODUCT CARD
        ========================================= */

        .card {

            background: #ffffff;

            border: 1px solid #e3e7ed;

            border-radius: 14px;

            padding: 26px;

            margin-bottom: 24px;
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
           PRODUCTS
        ========================================= */

        .product-item {

            display: flex;

            align-items: center;

            gap: 18px;

            padding: 16px 0;

            border-bottom: 1px solid #edf0f3;
        }


        .product-item:first-child {
            padding-top: 0;
        }


        .product-item:last-child {

            padding-bottom: 0;

            border-bottom: none;
        }


        .product-image {

            width: 100px;

            height: 110px;

            flex-shrink: 0;

            overflow: hidden;

            border-radius: 10px;

            background: #f2f4f8;
        }


        .product-image img {

            width: 100%;

            height: 100%;

            object-fit: contain;

            mix-blend-mode: multiply;
        }


        .product-info {

            flex: 1;
        }


        .product-name {

            margin-bottom: 6px;

            color: #191c1f;

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 15px;

            font-weight: 700;
        }


        .product-subtitle {

            margin-bottom: 9px;

            color: #64748b;

            font-size: 12px;
        }


        .product-meta {

            display: flex;

            gap: 18px;

            color: #64748b;

            font-size: 12px;
        }


        .product-meta strong {

            color: #191c1f;
        }


        .product-price {

            color: #191c1f;

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 15px;

            font-weight: 700;

            white-space: nowrap;
        }


        /* =========================================
           TWO COLUMN SECTION
        ========================================= */

        .two-column {

            display: grid;

            grid-template-columns:
                minmax(0, 1fr)
                minmax(300px, 0.8fr);

            gap: 24px;
        }


        /* =========================================
           SHIPPING
        ========================================= */

        .address-name {

            margin-bottom: 8px;

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 15px;

            font-weight: 700;
        }


        .address-line {

            color: #52627a;

            font-size: 13px;

            line-height: 1.7;
        }


        .phone {

            margin-top: 12px;

            color: #191c1f;

            font-size: 13px;

            font-weight: 600;
        }


        /* =========================================
           PAYMENT
        ========================================= */

        .payment-box {

            display: flex;

            align-items: center;

            gap: 12px;

            padding: 14px;

            background: #f8fafc;

            border: 1px solid #edf0f3;

            border-radius: 10px;
        }


        .payment-icon {

            display: flex;

            align-items: center;

            justify-content: center;

            width: 38px;

            height: 38px;

            border-radius: 9px;

            background: #191c1f;

            color: white;
        }


        .payment-label {

            color: #64748b;

            font-size: 10px;

            font-weight: 700;

            letter-spacing: 0.08em;

            text-transform: uppercase;
        }


        .payment-value {

            margin-top: 4px;

            color: #191c1f;

            font-size: 14px;

            font-weight: 600;
        }

        /* =========================================
   ORDER TRACKING
   ========================================= */

.tracking-card {
    background: #ffffff;

    border: 1px solid #e3e7ed;
    border-radius: 14px;

    padding: 28px;

    margin-bottom: 24px;
}

.tracking-header {
    display: flex;

    align-items: center;
    justify-content: space-between;

    gap: 20px;

    margin-bottom: 30px;
}

.tracking-kicker {
    display: block;

    margin-bottom: 6px;

    color: #64748b;

    font-size: 10px;
    font-weight: 800;

    letter-spacing: 0.1em;

    text-transform: uppercase;
}

.tracking-header h2 {
    margin: 0;

    font-family:
        "Plus Jakarta Sans",
        sans-serif;

    font-size: 22px;
    font-weight: 800;
}

.tracking-current {
    padding: 7px 12px;

    border-radius: 7px;

    background: #ecfdf5;
    color: #047857;

    font-size: 10px;
    font-weight: 800;

    text-transform: uppercase;
}

/* =========================================
   TIMELINE
   ========================================= */

.tracking-timeline {
    display: flex;

    flex-direction: column;
}

.tracking-step {
    display: flex;

    align-items: center;

    gap: 15px;
}

.tracking-icon {
    width: 34px;
    height: 34px;

    flex-shrink: 0;

    display: flex;

    align-items: center;
    justify-content: center;

    border-radius: 50%;

    background: #eef1f5;
    color: #64748b;

    font-size: 13px;
    font-weight: 800;
}

.tracking-step.active .tracking-icon {
    background: #191c1f;
    color: #ffffff;
}

.tracking-content {
    display: flex;

    flex-direction: column;

    gap: 3px;
}

.tracking-content strong {
    font-size: 14px;
    font-weight: 700;
}

.tracking-content span {
    color: #64748b;

    font-size: 12px;
}

.tracking-line {
    width: 2px;
    height: 28px;

    margin-left: 16px;

    background: #e3e7ed;
}

/* =========================================
   MOBILE
   ========================================= */

@media (max-width: 600px) {

    .tracking-card {
        padding: 20px;
    }

    .tracking-header {
        align-items: flex-start;

        flex-direction: column;
    }

}


        /* =========================================
           SUMMARY
        ========================================= */

        .summary-row {

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 15px;

            padding: 13px 0;

            color: #52627a;

            font-size: 13px;
        }


        .summary-row.discount {

            color: #047857;
        }


        .summary-row.total {

            margin-top: 10px;

            padding-top: 18px;

            border-top: 1px solid #e5e7eb;

            color: #191c1f;
        }


        .summary-row.total span {

            font-weight: 700;
        }


        .summary-row.total strong {

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 22px;
        }


        /* =========================================
           BACK BUTTON
        ========================================= */

        .back-button {

            display: inline-flex;

            align-items: center;

            gap: 7px;

            margin-top: 2px;

            padding: 11px 16px;

            border: 1px solid #d7dce3;

            border-radius: 8px;

            background: #ffffff;

            color: #191c1f;

            text-decoration: none;

            font-size: 12px;

            font-weight: 700;
        }


        .back-button:hover {

            background: #f8fafc;
        }


        /* =========================================
           MOBILE
        ========================================= */

        @media (max-width: 760px) {

            .order-page {

                padding:
                    115px
                    16px
                    60px;
            }


            .two-column {

                grid-template-columns: 1fr;
            }


            .status-card {

                align-items: flex-start;

                flex-direction: column;
            }


            .product-item {

                align-items: flex-start;
            }


            .product-image {

                width: 82px;

                height: 95px;
            }


            .product-price {

                font-size: 13px;
            }

        }

        
/* ===== RESPONSIVE ORDER DETAILS ===== */

.order-page {
    width: 100%;
    max-width: 1100px;
    margin: 0 auto;
    padding: 120px 24px 60px;
    min-width: 0;
    overflow-wrap: anywhere;
}

.order-page > *,
.two-column > *,
.card,
.tracking-card {
    min-width: 0;
}

.two-column {
    grid-template-columns: minmax(0, 1fr) minmax(280px, 0.8fr);
    gap: 24px;
}

.product-item {
    min-width: 0;
}

.product-info {
    min-width: 0;
    overflow-wrap: anywhere;
}

.product-meta {
    flex-wrap: wrap;
    gap: 8px 18px;
}

.product-price {
    flex-shrink: 0;
}

.status-order-id {
    overflow-wrap: anywhere;
}

.status-badge,
.tracking-current {
    max-width: 100%;
    overflow-wrap: anywhere;
}

.address-line,
.payment-value {
    overflow-wrap: anywhere;
}

.summary-row {
    gap: 12px;
}

.summary-row > span,
.summary-row > strong {
    min-width: 0;
    overflow-wrap: anywhere;
}

.summary-row.total strong {
    white-space: nowrap;
}

/* Tablet */
@media (max-width: 760px) {
    .order-page {
        padding: 105px 20px 48px;
    }

    .two-column {
        grid-template-columns: minmax(0, 1fr);
        gap: 0;
    }

    .status-card {
        flex-direction: row;
        align-items: center;
    }
}

/* Mobile */
@media (max-width: 600px) {
    .order-page {
        padding: 88px 12px 36px;
    }

    .page-header {
        margin-bottom: 22px;
    }

    .page-header h1 {
        font-size: clamp(25px, 7vw, 30px);
        line-height: 1.2;
    }

    .page-header p {
        font-size: 12px;
        line-height: 1.6;
    }

    .status-card {
        padding: 16px;
        gap: 12px;
        border-radius: 11px;
    }

    .status-order-id {
        font-size: 15px;
    }

    .status-badge {
        padding: 7px 9px;
        font-size: 9px;
        text-align: center;
    }

    .card,
    .tracking-card {
        padding: 16px;
        border-radius: 11px;
        margin-bottom: 16px;
    }

    .card h2,
    .tracking-header h2 {
        font-size: 18px;
        line-height: 1.35;
    }

    .product-item {
        align-items: flex-start;
        gap: 11px;
        padding: 14px 0;
    }

    .product-image {
        width: 76px;
        height: 88px;
        border-radius: 7px;
    }

    .product-name {
        font-size: 13px;
        line-height: 1.4;
        overflow-wrap: anywhere;
    }

    .product-subtitle {
        font-size: 11px;
        line-height: 1.5;
    }

    .product-meta {
        gap: 6px 12px;
        font-size: 11px;
    }

    .product-price {
        font-size: 12px;
    }

    .two-column {
        display: grid;
        grid-template-columns: minmax(0, 1fr);
        gap: 0;
    }

    .address-name {
        font-size: 14px;
        overflow-wrap: anywhere;
    }

    .address-line {
        font-size: 12px;
        line-height: 1.7;
    }

    .phone {
        font-size: 12px;
        overflow-wrap: anywhere;
    }

    .payment-box {
        padding: 12px;
        gap: 10px;
    }

    .payment-icon {
        width: 34px;
        height: 34px;
        flex-shrink: 0;
    }

    .payment-value {
        font-size: 12px;
        line-height: 1.5;
    }

    .tracking-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 12px;
        margin-bottom: 22px;
    }

    .tracking-current {
        font-size: 9px;
    }

    .tracking-step {
        align-items: flex-start;
        gap: 12px;
    }

    .tracking-icon {
        width: 32px;
        height: 32px;
    }

    .tracking-content strong {
        font-size: 13px;
        line-height: 1.5;
    }

    .tracking-content span {
        font-size: 11px;
        line-height: 1.5;
    }

    .tracking-line {
        height: 24px;
        margin-left: 15px;
    }

    .summary-row {
        padding: 11px 0;
        font-size: 12px;
    }

    .summary-row.total strong {
        font-size: 19px;
    }

    .back-button {
        min-height: 44px;
        padding: 11px 13px;
        font-size: 11px;
    }
}

/* Narrow mobile screens */
@media (max-width: 360px) {
    .order-page {
        padding-right: 8px;
        padding-left: 8px;
    }

    .card,
    .tracking-card {
        padding: 12px;
    }

    .status-card {
        align-items: flex-start;
        flex-direction: column;
    }

    .product-item {
        flex-wrap: wrap;
        gap: 10px;
    }

    .product-image {
        width: 68px;
        height: 78px;
    }

    .product-price {
        width: 100%;
        padding-left: 78px;
    }

    .summary-row.total strong {
        font-size: 17px;
    }
}


    </style>

</head>


<body>


    <!-- =========================================
         NAVBAR
    ========================================== -->

    <%@ include file="/WEB-INF/views/common/navbar.jsp" %>


    <main class="order-page">


        <!-- =========================================
             HEADER
        ========================================== -->

        <section class="page-header">

            <h1>
                Order Details
            </h1>

            <p>
                Review your Pacelet order information,
                products and delivery details.
            </p>

        </section>


        <!-- =========================================
             ORDER STATUS
        ========================================== -->

        <section class="status-card">

            <div>

                <div class="status-label">
                    Order ID
                </div>

                <div class="status-order-id">

                    <%= order.getOrderId() %>

                </div>

            </div>


            <div class="status-badge">

                <%= order.getStatus() != null
                        ? order.getStatus().toUpperCase()
                        : "CONFIRMED" %>

            </div>

        </section>


        <!-- =========================================
             PRODUCTS
        ========================================== -->

        <section class="card">

            <h2>
                Ordered Items
            </h2>


            <%
                if (items != null && !items.isEmpty()) {

                    for (CartItem item : items) {
            %>


                        <article class="product-item">


                            <!-- Product Image -->

                            <div class="product-image">

                                <img
                                    src="<%= item.getImage() %>"
                                    alt="<%= item.getName() %>"
                                >

                            </div>


                            <!-- Product Information -->

                            <div class="product-info">

                                <div class="product-name">

                                    <%= item.getName() %>

                                </div>


                                <%
                                    if (item.getSubtitle() != null) {
                                %>

                                    <div class="product-subtitle">

                                        <%= item.getSubtitle() %>

                                    </div>

                                <%
                                    }
                                %>


                                <div class="product-meta">

                                    <span>
                                        Size:
                                        <strong>
                                            <%= item.getSize() %>
                                        </strong>
                                    </span>


                                    <span>
                                        Qty:
                                        <strong>
                                            <%= item.getQuantity() %>
                                        </strong>
                                    </span>

                                </div>

                            </div>


                            <!-- Price -->

                            <div class="product-price">

                                ₹<%= String.format(
                                    "%,.0f",
                                    item.getPrice()
                                ) %>

                            </div>


                        </article>


            <%
                    }

                } else {
            %>


                <p style="color:#64748b; font-size:13px;">
                    No product information available for this order.
                </p>


            <%
                }
            %>

        </section>


        <!-- =========================================
             SHIPPING + PAYMENT
        ========================================== -->

        <div class="two-column">


            <!-- SHIPPING ADDRESS -->

            <section class="card">

                <h2>
                    Shipping Address
                </h2>


                <div class="address-name">

                    <%= order.getFullName() != null
                            ? order.getFullName()
                            : "Not available" %>

                </div>


                <div class="address-line">

                    <%
                        if (order.getAddressLine() != null) {
                    %>

                        <%= order.getAddressLine() %>

                        <br>

                        <%= order.getCity() != null
                                ? order.getCity()
                                : "" %>,

                        <%= order.getState() != null
                                ? order.getState()
                                : "" %>

                        -

                        <%= order.getPincode() != null
                                ? order.getPincode()
                                : "" %>

                    <%
                        } else {
                    %>

                        No shipping address available.

                    <%
                        }
                    %>

                </div>


                <%
                    if (order.getPhone() != null) {
                %>

                    <div class="phone">

                        <span
                            class="material-symbols-outlined"
                            style="
                                font-size:15px;
                                vertical-align:middle;
                            "
                        >
                            call
                        </span>

                        <%= order.getPhone() %>

                    </div>

                <%
                    }
                %>

            </section>


            <!-- PAYMENT -->

            <section class="card">

                <h2>
                    Payment
                </h2>


                <div class="payment-box">

                    <div class="payment-icon">

                        <span class="material-symbols-outlined">
                            payments
                        </span>

                    </div>


                    <div>

                        <div class="payment-label">
                            Payment Method
                        </div>


                        <div class="payment-value">

                            <%= paymentMethod != null
                                    ? paymentMethod
                                    : "Not available" %>

                        </div>

                    </div>

                </div>

            </section>

        </div>

        <%
    String currentStatus = order.getStatus();

    boolean isConfirmed =
            "Confirmed".equalsIgnoreCase(currentStatus)
            || "Processing".equalsIgnoreCase(currentStatus)
            || "Shipped".equalsIgnoreCase(currentStatus)
            || "Delivered".equalsIgnoreCase(currentStatus);

    boolean isProcessing =
            "Processing".equalsIgnoreCase(currentStatus)
            || "Shipped".equalsIgnoreCase(currentStatus)
            || "Delivered".equalsIgnoreCase(currentStatus);

    boolean isShipped =
            "Shipped".equalsIgnoreCase(currentStatus)
            || "Delivered".equalsIgnoreCase(currentStatus);

    boolean isDelivered =
            "Delivered".equalsIgnoreCase(currentStatus);
%>


<!-- =========================================
     ORDER TRACKING
     ========================================= -->

<section class="tracking-card">

    <div class="tracking-header">

        <div>
            <span class="tracking-kicker">
                ORDER STATUS
            </span>

            <h2>
                Track Your Order
            </h2>
        </div>

        <span class="tracking-current">
            <%= order.getStatus() %>
        </span>

    </div>


    <div class="tracking-timeline">

        <!-- CONFIRMED -->

    <div class="tracking-step <%= isConfirmed ? "active" : "" %>">

            <div class="tracking-icon">
                ✓
            </div>

            <div class="tracking-content">

                <strong>
                    Confirmed
                </strong>

                <span>
                    Your order has been confirmed.
                </span>

            </div>

        </div>


        <div class="tracking-line"></div>


        <!-- PROCESSING -->

      <div class="tracking-step <%= isProcessing ? "active" : "" %>">

            <div class="tracking-icon">
                2
            </div>

            <div class="tracking-content">

                <strong>
                    Processing
                </strong>

                <span>
                    Your order is being prepared.
                </span>

            </div>

        </div>


        <div class="tracking-line"></div>


        <!-- SHIPPED -->

      <div class="tracking-step <%= isShipped ? "active" : "" %>">

            <div class="tracking-icon">
                3
            </div>

            <div class="tracking-content">

                <strong>
                    Shipped
                </strong>

                <span>
                    Your order has been shipped.
                </span>

            </div>

        </div>


        <div class="tracking-line"></div>


        <!-- DELIVERED -->

      <div class="tracking-step <%= isDelivered ? "active" : "" %>">

            <div class="tracking-icon">
                4
            </div>

            <div class="tracking-content">

                <strong>
                    Delivered
                </strong>

                <span>
                    Your order has been delivered.
                </span>

            </div>

        </div>

    </div>

</section>


        <!-- =========================================
             ORDER SUMMARY
        ========================================== -->

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


            <%
                if (couponCode != null &&
                    !couponCode.isEmpty() &&
                    discount > 0) {
            %>


                <div class="summary-row discount">

                    <span>
                        Promotion
                        (<%= couponCode %>)
                    </span>

                    <strong>
                        -₹<%= String.format(
                            "%,.0f",
                            discount
                        ) %>
                    </strong>

                </div>


            <%
                }
            %>


            <div class="summary-row">

                <span>
                    Delivery
                </span>

                <strong>
                    FREE
                </strong>

            </div>


            <div class="summary-row total">

                <span>
                    Total Paid
                </span>

                <strong>
                    ₹<%= String.format(
                        "%,.0f",
                        total
                    ) %>
                </strong>

            </div>

        </section>


        <!-- =========================================
             BACK
        ========================================== -->

        <a
            href="<%= request.getContextPath() %>/profile"
            class="back-button"
        >

            <span class="material-symbols-outlined">
                arrow_back
            </span>

            Back to Profile

        </a>


    </main>

</body>

</html>