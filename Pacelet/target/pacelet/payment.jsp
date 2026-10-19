<%@ page contentType="text/html;charset=UTF-8" %>

<%
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


    String selectedPaymentMethod =
            (String) request.getAttribute("paymentMethod");


    String upiId =
            (String) request.getAttribute("upiId");


    String paymentError =
            (String) request.getAttribute("paymentError");


    if (selectedPaymentMethod == null) {
        selectedPaymentMethod = "UPI";
    }

    if (upiId == null) {
        upiId = "";
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

    <title>Payment — Pacelet</title>


    <link
        rel="stylesheet"
        href="<%= request.getContextPath() %>/assets/css/navbar.css"
    >


    <style>

        * {
            box-sizing: border-box;
        }


        body {

            margin: 0;

            background: #f7f9fd;

            color: #191c1f;

            font-family: "Inter", Arial, sans-serif;
        }


        .payment-page {

            width: min(
                1000px,
                calc(100% - 32px)
            );

            margin: 110px auto 60px;
        }


        /* =========================
           HEADER
           ========================= */

        .page-header {

            margin-bottom: 28px;
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


        /* =========================
           CHECKOUT PROGRESS
           ========================= */

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


        /* =========================
           LAYOUT
           ========================= */

        .payment-layout {

            display: grid;

            grid-template-columns:
                1.5fr 1fr;

            gap: 24px;

            align-items: start;
        }


        .payment-card,
        .summary-card {

            background: white;

            border: 1px solid #eceef2;

            border-radius: 12px;

            padding: 24px;
        }


        .payment-card h2,
        .summary-card h2 {

            margin: 0 0 8px;

            font-family:
                "Plus Jakarta Sans",
                Arial,
                sans-serif;

            font-size: 20px;
        }


        .payment-description {

            margin: 0 0 20px;

            color: #505f76;

            font-size: 13px;
        }


        /* =========================
           PAYMENT OPTIONS
           ========================= */

        .payment-options {

            display: flex;

            flex-direction: column;

            gap: 12px;
        }


        .payment-option {

            display: flex;

            flex-direction: column;

            gap: 10px;

            padding: 15px;

            border: 1px solid #e0e2e6;

            border-radius: 9px;

            cursor: pointer;

            transition:
                background .2s ease,
                border-color .2s ease;
        }


        .payment-option:hover {

            background: #f7f9fd;
        }


        .payment-option.selected {

            border-color: #060607;

            background: #f7f9fd;
        }


        .payment-option-header {

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 12px;
        }


        .payment-option-title {

            display: flex;

            align-items: center;

            gap: 10px;
        }


        .payment-option-title input {

            width: 16px;

            height: 16px;

            accent-color: #060607;

            cursor: pointer;
        }


        .payment-option-title strong {

            font-family:
                "Plus Jakarta Sans",
                Arial,
                sans-serif;

            font-size: 14px;
        }


        .payment-meta {

            color: #505f76;

            font-size: 11px;

            font-weight: 600;

            white-space: nowrap;
        }


        .payment-badges {

            display: flex;

            gap: 5px;
        }


        .payment-badge {

            padding: 4px 7px;

            border-radius: 4px;

            background: #e0e2e6;

            color: #191c1f;

            font-size: 9px;

            font-weight: 700;
        }


        /* =========================
           UPI INPUT
           ========================= */

        .upi-section {

            display: none;

            flex-direction: column;

            gap: 7px;

            padding-top: 4px;
        }


        .upi-section.active {

            display: flex;
        }


        .upi-input {

            width: 100%;

            height: 42px;

            padding: 0 12px;

            border: 1px solid #c4c7c7;

            border-radius: 6px;

            background: white;

            color: #191c1f;

            font-family: monospace;

            font-size: 12px;

            outline: none;
        }


        .upi-input:focus {

            border-color: #060607;
        }


        .payment-note {

            color: #505f76;

            font-size: 11px;
        }


        /* =========================
           ERROR
           ========================= */

        .payment-error {

            margin-bottom: 16px;

            padding: 12px;

            border-radius: 8px;

            background: #fff1f2;

            color: #ba1a1a;

            font-size: 13px;
        }


        /* =========================
           PAYABLE
           ========================= */

        .payable-box {

            display: flex;

            align-items: baseline;

            justify-content: space-between;

            margin-top: 20px;

            padding-top: 18px;

            border-top: 1px solid #eceef2;
        }


        .payable-label {

            color: #505f76;

            font-size: 11px;

            font-weight: 600;

            text-transform: uppercase;

            letter-spacing: .08em;
        }


        .payable-amount {

            font-family:
                "Plus Jakarta Sans",
                Arial,
                sans-serif;

            font-size: 25px;

            font-weight: 800;
        }


        .continue-button {

            width: 100%;

            height: 50px;

            margin-top: 20px;

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


        .continue-button:hover {

            opacity: .92;
        }


        /* =========================
           SUMMARY
           ========================= */

        .summary-card h2 {

            margin-bottom: 18px;
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


        .secure-note {

            margin-top: 20px;

            padding: 13px;

            border-radius: 8px;

            background: #f2f4f8;

            color: #505f76;

            font-size: 11px;

            line-height: 1.5;
        }


        /* =========================
           RESPONSIVE
           ========================= */

        @media (max-width: 750px) {

            .payment-page {

                width: calc(100% - 24px);

                margin-top: 100px;
            }


            .payment-layout {

                grid-template-columns: 1fr;
            }


            .payment-card,
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

    </style>

</head>


<body>


    <%@ include file="/WEB-INF/views/common/navbar.jsp" %>


    <main class="payment-page">


        <!-- =========================
             HEADER
             ========================= -->

        <div class="page-header">

            <h1>
                Payment Method
            </h1>

            <p>
                Choose your preferred payment option.
            </p>

        </div>


        <!-- =========================
             CHECKOUT PROGRESS
             ========================= -->

        <div class="checkout-progress">

            <span class="step">
                01 Bag
            </span>

            <span>→</span>

            <span class="step">
                02 Address
            </span>

            <span>→</span>

            <span class="step active">
                03 Payment
            </span>

            <span>→</span>

            <span class="step">
                04 Review
            </span>

        </div>


        <div class="payment-layout">


            <!-- =========================
                 PAYMENT OPTIONS
                 ========================= -->

            <section class="payment-card">

                <h2>
                    Select Payment Method
                </h2>

                <p class="payment-description">
                    Choose a secure way to complete your order.
                </p>


                <% if (paymentError != null) { %>

                    <div class="payment-error">
                        <%= paymentError %>
                    </div>

                <% } %>


                <form
                    method="post"
                    action="<%= request.getContextPath() %>/checkout/payment"
                >


                    <div class="payment-options">


                        <!-- UPI -->

                        <label
                            class="payment-option
                            <%= "UPI".equals(selectedPaymentMethod)
                                ? "selected"
                                : "" %>"
                        >

                            <div class="payment-option-header">

                                <div class="payment-option-title">

                                    <input
                                        type="radio"
                                        name="paymentMethod"
                                        value="UPI"
                                        <%= "UPI".equals(selectedPaymentMethod)
                                            ? "checked"
                                            : "" %>
                                        onchange="selectPayment('UPI')"
                                    >

                                    <strong>
                                        Instant UPI Pay
                                    </strong>

                                </div>


                                <div class="payment-badges">

                                    <span class="payment-badge">
                                        GPay
                                    </span>

                                    <span class="payment-badge">
                                        PhonePe
                                    </span>

                                    <span class="payment-badge">
                                        Paytm
                                    </span>

                                </div>

                            </div>


                            <div
                                id="upiSection"
                                class="upi-section
                                <%= "UPI".equals(selectedPaymentMethod)
                                    ? "active"
                                    : "" %>"
                            >

                                <input
                                    type="text"
                                    name="upiId"
                                    class="upi-input"
                                    value="<%= upiId %>"
                                    placeholder="Enter UPI ID (e.g. mobile@okhdfcbank)"
                                >

                                <span class="payment-note">
                                    Zero gateway convenience fee.
                                    Instant refund eligible.
                                </span>

                            </div>

                        </label>


                        <!-- CARDS -->

                        <label
                            class="payment-option
                            <%= "Cards".equals(selectedPaymentMethod)
                                ? "selected"
                                : "" %>"
                        >

                            <div class="payment-option-header">

                                <div class="payment-option-title">

                                    <input
                                        type="radio"
                                        name="paymentMethod"
                                        value="Cards"
                                        <%= "Cards".equals(selectedPaymentMethod)
                                            ? "checked"
                                            : "" %>
                                        onchange="selectPayment('Cards')"
                                    >

                                    <strong>
                                        Credit / Debit Cards
                                    </strong>

                                </div>


                                <span class="payment-meta">
                                    Visa / MC / Amex
                                </span>

                            </div>

                        </label>


                        <!-- NET BANKING -->

                        <label
                            class="payment-option
                            <%= "Netbanking".equals(selectedPaymentMethod)
                                ? "selected"
                                : "" %>"
                        >

                            <div class="payment-option-header">

                                <div class="payment-option-title">

                                    <input
                                        type="radio"
                                        name="paymentMethod"
                                        value="Netbanking"
                                        <%= "Netbanking".equals(selectedPaymentMethod)
                                            ? "checked"
                                            : "" %>
                                        onchange="selectPayment('Netbanking')"
                                    >

                                    <strong>
                                        Net Banking
                                    </strong>

                                </div>


                                <span class="payment-meta">
                                    50+ Indian Banks
                                </span>

                            </div>

                        </label>


                        <!-- COD -->

                        <label
                            class="payment-option
                            <%= "COD".equals(selectedPaymentMethod)
                                ? "selected"
                                : "" %>"
                        >

                            <div class="payment-option-header">

                                <div class="payment-option-title">

                                    <input
                                        type="radio"
                                        name="paymentMethod"
                                        value="COD"
                                        <%= "COD".equals(selectedPaymentMethod)
                                            ? "checked"
                                            : "" %>
                                        onchange="selectPayment('COD')"
                                    >

                                    <strong>
                                        Cash on Delivery (COD)
                                    </strong>

                                </div>


                                <span
                                    class="payment-badge"
                                    style="
                                        background:#ECFDF5;
                                        color:#047857;
                                    "
                                >
                                    Doorstep Inspection
                                </span>

                            </div>

                        </label>


                    </div>


                    <!-- PAYABLE -->

                    <div class="payable-box">

                        <span class="payable-label">
                            Payable Amount
                        </span>

                        <span class="payable-amount">

                            ₹<%= String.format(
                                "%,.0f",
                                totalPayable
                            ) %>

                        </span>

                    </div>


                    <button
                        type="submit"
                        class="continue-button"
                    >
                        Continue to Review →
                    </button>


                </form>

            </section>


            <!-- =========================
                 ORDER SUMMARY
                 ========================= -->

            <aside class="summary-card">

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

                    <span>
                        Included
                    </span>

                </div>


                <div class="summary-divider"></div>


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


                <div class="secure-note">

                    🔒 Your payment information is
                    processed securely.

                </div>

            </aside>


        </div>

    </main>


    <script>

        function selectPayment(method) {

            const options =
                document.querySelectorAll(
                    ".payment-option"
                );

            options.forEach(function(option) {

                const radio =
                    option.querySelector(
                        'input[type="radio"]'
                    );

                if (radio && radio.checked) {

                    option.classList.add("selected");

                } else {

                    option.classList.remove("selected");

                }

            });


            const upiSection =
                document.getElementById(
                    "upiSection"
                );


            if (method === "UPI") {

                upiSection.classList.add("active");

            } else {

                upiSection.classList.remove("active");

            }

        }

    </script>


</body>

</html>