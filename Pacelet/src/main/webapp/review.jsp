<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.pacelet.model.CartItem" %>

<%
    // =========================================
    // CART
    // =========================================

    @SuppressWarnings("unchecked")
    List<CartItem> cart =
            (List<CartItem>) request.getAttribute("cart");


    // =========================================
    // TOTALS
    // =========================================

    Double bagTotalObj =
            (Double) request.getAttribute("bagTotal");

    double bagTotal =
            bagTotalObj != null
                    ? bagTotalObj
                    : 0;


    Double discountObj =
            (Double) request.getAttribute("appliedDiscount");

    double appliedDiscount =
            discountObj != null
                    ? discountObj
                    : 0;


    Double totalObj =
            (Double) request.getAttribute("totalPayable");

    double totalPayable =
            totalObj != null
                    ? totalObj
                    : Math.max(
                        0,
                        bagTotal - appliedDiscount
                    );


    String couponCode =
            (String) request.getAttribute("couponCode");


    // =========================================
    // ADDRESS
    // =========================================

    String fullName =
            (String) request.getAttribute("fullName");

    String phone =
            (String) request.getAttribute("phone");

    String pincode =
            (String) request.getAttribute("pincode");

    String addressLine =
            (String) request.getAttribute("addressLine");

    String city =
            (String) request.getAttribute("city");

    String state =
            (String) request.getAttribute("state");


    // =========================================
    // PAYMENT
    // =========================================

    String paymentMethod =
            (String) request.getAttribute(
                    "paymentMethod"
            );

    String upiId =
            (String) request.getAttribute(
                    "upiId"
            );


    if (paymentMethod == null) {
        paymentMethod = "Not selected";
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

    <title>Review Order — Pacelet</title>

        <!-- Pacelet Navbar CSS -->
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

            background: #f7f9fd;

            color: #191c1f;

            font-family:
                "Inter",
                Arial,
                sans-serif;
        }


        /* =========================================
           PAGE
           ========================================= */

        .review-page {

            width: min(
                1000px,
                calc(100% - 32px)
            );

            margin: 110px auto 60px;
        }


        /* =========================================
           HEADER
           ========================================= */

        .page-header {

            margin-bottom: 26px;
        }


        .page-header h1 {

            margin: 0 0 8px;

            font-family:
                "Plus Jakarta Sans",
                Arial,
                sans-serif;

            font-size: 34px;

            font-weight: 700;
        }


        .page-header p {

            margin: 0;

            color: #505f76;

            font-size: 14px;
        }


        /* =========================================
           CHECKOUT PROGRESS
           ========================================= */

        .checkout-progress {

            display: flex;

            align-items: center;

            gap: 10px;

            margin-bottom: 28px;

            font-size: 11px;

            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: .08em;
        }


        .step {

            padding: 8px 12px;

            border-radius: 20px;

            background: #e6e8ec;

            color: #747878;
        }


        .step.active {

            background: #060607;

            color: white;
        }


        /* =========================================
           LAYOUT
           ========================================= */

        .review-layout {

            display: grid;

            grid-template-columns:
                1.5fr 1fr;

            gap: 24px;

            align-items: start;
        }


        .left-column {

            display: flex;

            flex-direction: column;

            gap: 18px;
        }


        .review-card,
        .summary-card {

            background: white;

            border: 1px solid #eceef2;

            border-radius: 12px;

            padding: 24px;
        }


        .review-card h2,
        .summary-card h2 {

            margin: 0 0 18px;

            font-family:
                "Plus Jakarta Sans",
                Arial,
                sans-serif;

            font-size: 19px;
        }


        /* =========================================
           ADDRESS
           ========================================= */

        .address-header {

            display: flex;

            align-items: center;

            justify-content: space-between;

            margin-bottom: 16px;
        }


        .address-header h2 {

            margin: 0;
        }


        .verified {

            padding: 5px 8px;

            border-radius: 5px;

            background: #ecfdf5;

            color: #047857;

            font-size: 9px;

            font-weight: 700;

            text-transform: uppercase;
        }


        .address-name {

            margin-bottom: 8px;

            font-size: 14px;

            font-weight: 700;
        }


        .address-text {

            color: #505f76;

            font-size: 13px;

            line-height: 1.7;
        }


        .address-phone {

            margin-top: 8px;

            color: #444748;

            font-size: 12px;
        }


        /* =========================================
           PAYMENT
           ========================================= */

        .payment-method-box {

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 15px;

            padding: 15px;

            border-radius: 8px;

            background: #f7f9fd;

            border: 1px solid #e6e8ec;
        }


        .payment-method-name {

            font-family:
                "Plus Jakarta Sans",
                Arial,
                sans-serif;

            font-size: 14px;

            font-weight: 700;
        }


        .payment-method-detail {

            margin-top: 5px;

            color: #505f76;

            font-size: 11px;
        }


        .payment-status {

            padding: 6px 9px;

            border-radius: 5px;

            background: #ecfdf5;

            color: #047857;

            font-size: 9px;

            font-weight: 700;
        }


        /* =========================================
           CART ITEMS
           ========================================= */

        .cart-item {

            display: flex;

            gap: 14px;

            padding: 14px 0;

            border-bottom: 1px solid #eceef2;
        }


        .cart-item:first-of-type {

            padding-top: 0;
        }


        .cart-item:last-child {

            border-bottom: none;

            padding-bottom: 0;
        }


        .product-image {

            width: 75px;

            height: 75px;

            flex-shrink: 0;

            border-radius: 7px;

            background: #f2f4f8;

            object-fit: cover;
        }


        .product-info {

            flex: 1;
        }


        .product-name {

            margin-bottom: 5px;

            font-family:
                "Plus Jakarta Sans",
                Arial,
                sans-serif;

            font-size: 14px;

            font-weight: 700;
        }


        .product-subtitle {

            color: #505f76;

            font-size: 11px;

            margin-bottom: 7px;
        }


        .product-meta {

            display: flex;

            gap: 12px;

            color: #505f76;

            font-size: 10px;
        }


        .product-price {

            font-size: 13px;

            font-weight: 700;

            white-space: nowrap;
        }


        /* =========================================
           SUMMARY
           ========================================= */

        .summary-card {

            position: sticky;

            top: 100px;
        }


        .summary-row {

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 15px;

            padding: 9px 0;

            color: #444748;

            font-size: 13px;
        }


        .summary-row strong {

            color: #191c1f;
        }


        .discount {

            color: #047857 !important;
        }


        .summary-divider {

            height: 1px;

            margin: 14px 0;

            background: #eceef2;
        }


        .total-row {

            display: flex;

            align-items: center;

            justify-content: space-between;
        }


        .total-label {

            color: #505f76;

            font-size: 11px;

            font-weight: 600;

            text-transform: uppercase;

            letter-spacing: .08em;
        }


        .total-price {

            font-family:
                "Plus Jakarta Sans",
                Arial,
                sans-serif;

            font-size: 25px;

            font-weight: 800;
        }


        /* =========================================
           PLACE ORDER
           ========================================= */

        .place-order-button {

            width: 100%;

            height: 52px;

            margin-top: 22px;

            border: none;

            border-radius: 8px;

            background: #060607;

            color: white;

            font-size: 11px;

            font-weight: 800;

            text-transform: uppercase;

            letter-spacing: .1em;

            cursor: pointer;
        }


        .place-order-button:hover {

            opacity: .92;
        }


        .secure-note {

            margin-top: 14px;

            padding: 12px;

            border-radius: 8px;

            background: #f2f4f8;

            color: #505f76;

            font-size: 10px;

            line-height: 1.5;
        }


        /* =========================================
           RESPONSIVE
           ========================================= */

        @media (max-width: 750px) {

            .review-page {

                width: calc(100% - 24px);

                margin-top: 100px;
            }


            .review-layout {

                grid-template-columns: 1fr;
            }


            .summary-card {

                position: static;
            }


            .review-card,
            .summary-card {

                padding: 18px;
            }


            .page-header h1 {

                font-size: 28px;
            }


            .checkout-progress {

                overflow-x: auto;

                white-space: nowrap;

                padding-bottom: 5px;
            }

        }


        
/* ===== PACELET REVIEW ORDER RESPONSIVE ===== */

.review-page {
    width: min(1100px, calc(100% - 40px));
    margin: 105px auto 56px;
    min-width: 0;
}

.review-layout {
    grid-template-columns: minmax(0, 1.45fr) minmax(280px, 0.85fr);
    gap: 22px;
}

.left-column,
.review-card,
.summary-card,
.cart-item,
.product-info {
    min-width: 0;
}

.address-text,
.address-name,
.payment-method-detail,
.product-name,
.product-subtitle {
    overflow-wrap: anywhere;
}

.summary-card {
    position: sticky;
    top: 100px;
}

.payment-method-box {
    min-width: 0;
    flex-wrap: wrap;
}

.payment-method-box > div {
    min-width: 0;
    flex: 1;
}

.payment-status {
    flex-shrink: 0;
}

.product-meta {
    flex-wrap: wrap;
    row-gap: 6px;
}

.summary-row {
    min-width: 0;
}

.summary-row > * {
    min-width: 0;
    overflow-wrap: anywhere;
}

.total-price {
    white-space: nowrap;
}

.place-order-button {
    min-height: 50px;
}

/* ===== TABLET ===== */
@media (max-width: 900px) {
    .review-page {
        width: calc(100% - 32px);
        margin-top: 100px;
    }

    .review-layout {
        grid-template-columns: minmax(0, 1fr);
    }

    .summary-card {
        position: static;
    }

    .left-column {
        gap: 16px;
    }
}

/* ===== MOBILE ===== */
@media (max-width: 600px) {
    .review-page {
        width: calc(100% - 24px);
        margin: 88px auto 32px;
    }

    .page-header {
        margin-bottom: 20px;
    }

    .page-header h1 {
        font-size: clamp(25px, 7vw, 30px);
        line-height: 1.25;
    }

    .page-header p {
        font-size: 12px;
        line-height: 1.6;
    }

    .checkout-progress {
        gap: 7px;
        margin-bottom: 20px;
        overflow-x: auto;
        white-space: nowrap;
        padding-bottom: 8px;
        scrollbar-width: thin;
    }

    .step {
        padding: 7px 10px;
        font-size: 9px;
        flex-shrink: 0;
    }

    .review-layout {
        gap: 16px;
    }

    .left-column {
        gap: 14px;
    }

    .review-card,
    .summary-card {
        padding: 16px;
        border-radius: 11px;
    }

    .review-card h2,
    .summary-card h2 {
        font-size: 17px;
        line-height: 1.4;
        margin-bottom: 15px;
    }

    .address-header {
        gap: 10px;
        align-items: flex-start;
        flex-wrap: wrap;
    }

    .address-header h2 {
        font-size: 17px;
    }

    .verified {
        font-size: 8px;
    }

    .address-name {
        font-size: 13px;
    }

    .address-text {
        font-size: 12px;
        line-height: 1.7;
    }

    .payment-method-box {
        padding: 12px;
        gap: 10px;
    }

    .payment-method-name {
        font-size: 13px;
        overflow-wrap: anywhere;
    }

    .payment-method-detail {
        font-size: 10px;
    }

    .payment-status {
        font-size: 8px;
        padding: 5px 7px;
    }

    .cart-item {
        gap: 10px;
        padding: 12px 0;
        align-items: flex-start;
    }

    .product-image {
        width: 66px;
        height: 72px;
    }

    .product-info {
        flex: 1;
    }

    .product-name {
        font-size: 12px;
        line-height: 1.5;
    }

    .product-subtitle {
        font-size: 10px;
        line-height: 1.5;
    }

    .product-meta {
        gap: 7px;
        font-size: 9px;
    }

    .product-price {
        font-size: 11px;
    }

    .summary-row {
        gap: 10px;
        font-size: 12px;
    }

    .total-label {
        font-size: 10px;
    }

    .total-price {
        font-size: 22px;
    }

    .place-order-button {
        margin-top: 18px;
        min-height: 48px;
        height: auto;
        padding: 12px 8px;
        font-size: 10px;
        line-height: 1.5;
    }

    .secure-note {
        font-size: 10px;
        line-height: 1.7;
    }
}

/* ===== NARROW PHONES: 320px ===== */
@media (max-width: 360px) {
    .review-page {
        width: calc(100% - 16px);
        margin-top: 82px;
    }

    .review-card,
    .summary-card {
        padding: 12px;
    }

    .checkout-progress {
        gap: 5px;
        font-size: 9px;
    }

    .step {
        padding: 7px 8px;
    }

    .address-header {
        flex-direction: column;
    }

    .cart-item {
        gap: 8px;
    }

    .product-image {
        width: 55px;
        height: 62px;
    }

    .product-price {
        font-size: 10px;
    }

    .summary-row {
        font-size: 11px;
    }

    .total-price {
        font-size: 19px;
    }
}


    </style>

</head>


<body>


    <!-- =========================================
         NAVBAR
         ========================================= -->

    <%@ include file="/WEB-INF/views/common/navbar.jsp" %>


    <main class="review-page">


        <!-- =========================================
             HEADER
             ========================================= -->

        <div class="page-header">

            <h1>
                Review Your Order
            </h1>

            <p>
                Check your details before placing your order.
            </p>

        </div>


        <!-- =========================================
             CHECKOUT PROGRESS
             ========================================= -->

        <div class="checkout-progress">

            <span class="step">
                01 Bag
            </span>

            <span>→</span>

            <span class="step">
                02 Address
            </span>

            <span>→</span>

            <span class="step">
                03 Payment
            </span>

            <span>→</span>

            <span class="step active">
                04 Review
            </span>

        </div>


        <div class="review-layout">


            <!-- =====================================
                 LEFT COLUMN
                 ===================================== -->

            <div class="left-column">


                <!-- ADDRESS -->

                <section class="review-card">

                    <div class="address-header">

                        <h2>
                            Delivery Address
                        </h2>

                        <span class="verified">
                            ✓ Confirmed
                        </span>

                    </div>


                    <% if (fullName != null) { %>

                        <div class="address-name">

                            <%= fullName %>

                        </div>


                        <div class="address-text">

                            <%= addressLine != null
                                ? addressLine
                                : "" %>

                            <br>

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


                        <div class="address-phone">

                            Phone:
                            <%= phone != null
                                ? phone
                                : "" %>

                        </div>

                    <% } else { %>

                        <div class="address-text">

                            Shipping address not available.

                        </div>

                    <% } %>

                </section>


                <!-- PAYMENT -->

                <section class="review-card">

                    <h2>
                        Payment Method
                    </h2>


                    <div class="payment-method-box">

                        <div>

                            <div class="payment-method-name">

                                <%= paymentMethod %>

                            </div>


                            <% if ("UPI".equals(paymentMethod)
                                    && upiId != null
                                    && !upiId.isBlank()) { %>

                                <div class="payment-method-detail">

                                    UPI ID:
                                    <%= upiId %>

                                </div>

                            <% } else if ("Cards".equals(paymentMethod)) { %>

                                <div class="payment-method-detail">

                                    Credit / Debit Card

                                </div>

                            <% } else if ("Netbanking".equals(paymentMethod)) { %>

                                <div class="payment-method-detail">

                                    Internet Banking

                                </div>

                            <% } else if ("COD".equals(paymentMethod)) { %>

                                <div class="payment-method-detail">

                                    Pay at the time of delivery

                                </div>

                            <% } %>

                        </div>


                        <span class="payment-status">

                            SELECTED

                        </span>

                    </div>

                </section>


                <!-- ITEMS -->

                <section class="review-card">

                    <h2>
                        Your Items
                    </h2>


                    <% if (cart != null && !cart.isEmpty()) { %>

                        <% for (CartItem item : cart) { %>

                            <div class="cart-item">


                             <img
    src="<%= item.getImage() %>"
    alt="<%= item.getName() %>"
    class="product-image"
>


                                <div class="product-info">

                                   <div class="product-name">

    <%= item.getName() %>

</div>

                                    <div class="product-subtitle">

                                        <%= item.getSubtitle() %>

                                    </div>


                                    <div class="product-meta">

                                        <span>
                                            Size UK <%= item.getSize() %>
                                        </span>

                                        <span>
                                            Qty <%= item.getQuantity() %>
                                        </span>

                                    </div>

                                </div>


                                <div class="product-price">

                                    ₹<%= String.format(
                                        "%,.0f",
                                        item.getPrice()
                                        * item.getQuantity()
                                    ) %>

                                </div>

                            </div>

                        <% } %>

                    <% } else { %>

                        <div class="address-text">

                            No items in your cart.

                        </div>

                    <% } %>

                </section>

            </div>


            <!-- =====================================
                 RIGHT COLUMN
                 ===================================== -->

            <aside class="summary-card">

                <h2>
                    Order Summary
                </h2>


                <!-- BAG TOTAL -->

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


                <!-- COUPON -->

                <% if (appliedDiscount > 0
                        && couponCode != null) { %>

                    <div class="summary-row">

                        <span>
                            Promotion (<%= couponCode %>)
                        </span>

                        <strong class="discount">

                            - ₹<%= String.format(
                                "%,.0f",
                                appliedDiscount
                            ) %>

                        </strong>

                    </div>

                <% } %>


                <!-- DELIVERY -->

                <div class="summary-row">

                    <span>
                        Delivery
                    </span>

                    <strong>
                        Free Express
                    </strong>

                </div>


                <!-- GST -->

                <div class="summary-row">

                    <span>
                        GST
                    </span>

                    <span>
                        Included
                    </span>

                </div>


                <div class="summary-divider"></div>


                <!-- TOTAL -->

                <div class="total-row">

                    <span class="total-label">
                        Total Payable
                    </span>

                    <span class="total-price">

                        ₹<%= String.format(
                            "%,.0f",
                            totalPayable
                        ) %>

                    </span>

                </div>


                <!-- PLACE ORDER -->

              <form
    method="post"
    action="<%= request.getContextPath() %>/checkout/place-order"
>
    <button type="submit">
        Place Order
    </button>
</form>


                <div class="secure-note">

                    🔒 By placing this order, you confirm
                    that your delivery and payment details
                    are correct.

                </div>

            </aside>


        </div>

    </main>

</body>

</html>