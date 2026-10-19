<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String fullName = request.getParameter("fullName");
    String phone = request.getParameter("phone");
    String pincode = request.getParameter("pincode");
    String addressLine = request.getParameter("addressLine");
    String city = request.getParameter("city");
    String state = request.getParameter("state");

    if (fullName == null) fullName = "";
    if (phone == null) phone = "";
    if (pincode == null) pincode = "";
    if (addressLine == null) addressLine = "";
    if (city == null) city = "";
    if (state == null) state = "";
%>

<%
    Double bagTotalObj =
            (Double) request.getAttribute("bagTotal");

    double bagTotal =
            bagTotalObj != null
                    ? bagTotalObj
                    : 0;

    Double appliedDiscountObj =
            (Double) request.getAttribute("appliedDiscount");

    double appliedDiscount =
            appliedDiscountObj != null
                    ? appliedDiscountObj
                    : 0;

    String couponCode =
            (String) request.getAttribute("couponCode");

    Double totalPayableObj =
            (Double) request.getAttribute("totalPayable");

    double totalPayable =
            totalPayableObj != null
                    ? totalPayableObj
                    : Math.max(
                        0,
                        bagTotal - appliedDiscount
                    );
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Shipping Address — Pacelet</title>

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

        .address-page {

            width: min(1000px, calc(100% - 32px));

            margin: 110px auto 60px;
        }

        .page-header {

            margin-bottom: 30px;
        }

        .page-header h1 {

            margin: 0 0 8px;

            font-family: "Plus Jakarta Sans", Arial, sans-serif;

            font-size: 34px;

            font-weight: 700;
        }

        .page-header p {

            margin: 0;

            color: #505f76;

            font-size: 14px;
        }

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

        .address-layout {

            display: grid;

            grid-template-columns: 1.5fr 1fr;

            gap: 24px;

            align-items: start;
        }

        .address-card,
        .summary-card {

            background: white;

            border: 1px solid #eceef2;

            border-radius: 12px;

            padding: 24px;
        }

        .address-card h2,
        .summary-card h2 {

            margin: 0 0 20px;

            font-family: "Plus Jakarta Sans", Arial, sans-serif;

            font-size: 20px;
        }

        .form-grid {

            display: grid;

            grid-template-columns: 1fr 1fr;

            gap: 16px;
        }

        .form-group {

            display: flex;

            flex-direction: column;

            gap: 6px;
        }

        .form-group.full {

            grid-column: 1 / -1;
        }

        .form-group label {

            color: #505f76;

            font-size: 11px;

            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: .06em;
        }

        .form-group input,
        .form-group textarea {

            width: 100%;

            border: 1px solid #e0e2e6;

            border-radius: 8px;

            background: #f2f4f8;

            color: #191c1f;

            font-family: "Inter", Arial, sans-serif;

            font-size: 14px;

            outline: none;
        }

        .form-group input {

            height: 46px;

            padding: 0 13px;
        }

        .form-group textarea {

            min-height: 90px;

            padding: 12px;

            resize: vertical;
        }

        .form-group input:focus,
        .form-group textarea:focus {

            background: white;

            border-color: #747878;
        }

        .continue-button {

            width: 100%;

            height: 50px;

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

        .continue-button:hover {

            opacity: .92;
        }

        .summary-row {

            display: flex;

            align-items: center;

            justify-content: space-between;

            padding: 9px 0;

            color: #444748;

            font-size: 13px;
        }

        .summary-row strong {

            color: #191c1f;
        }

        .summary-divider {

            height: 1px;

            background: #eceef2;

            margin: 14px 0;
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

            font-family: "Plus Jakarta Sans", Arial, sans-serif;

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

        @media (max-width: 750px) {

            .address-page {

                width: calc(100% - 24px);

                margin-top: 100px;
            }

            .address-layout {

                grid-template-columns: 1fr;
            }

            .form-grid {

                grid-template-columns: 1fr;
            }

            .form-group.full {

                grid-column: auto;
            }

            .address-card,
            .summary-card {

                padding: 18px;
            }

            .page-header h1 {

                font-size: 28px;
            }
        }

    </style>

</head>

<body>

    <%@ include file="/WEB-INF/views/common/navbar.jsp" %>


    <main class="address-page">

        <div class="page-header">

            <h1>
                Shipping Address
            </h1>

            <p>
                Where should we deliver your Pacelet pairs?
            </p>

        </div>


        <!-- CHECKOUT PROGRESS -->

        <div class="checkout-progress">

            <span class="step">
                01 Bag
            </span>

            <span>→</span>

            <span class="step active">
                02 Address
            </span>

            <span>→</span>

            <span class="step">
                03 Payment
            </span>

            <span>→</span>

            <span class="step">
                04 Review
            </span>

        </div>


        <div class="address-layout">


            <!-- ADDRESS FORM -->

            <section class="address-card">

                <h2>
                    Delivery Details
                </h2>

                <%
    String error =
            (String) request.getAttribute("error");
%>

<% if (error != null) { %>

    <div style="
        margin-bottom:16px;
        padding:12px;
        border-radius:8px;
        background:#fff1f2;
        color:#ba1a1a;
        font-size:13px;
    ">
        <%= error %>
    </div>

<% } %>


             <form
    method="post"
    action="<%= request.getContextPath() %>/checkout/address"
>

                    <div class="form-grid">


                        <!-- FULL NAME -->

                        <div class="form-group full">

                            <label>
                                Full Name *
                            </label>

                            <input
                                type="text"
                                name="fullName"
                                value="<%= fullName %>"
                                placeholder="Enter your full name"
                                required
                            >

                        </div>


                        <!-- PHONE -->

                        <div class="form-group">

                            <label>
                                Phone *
                            </label>

                            <input
                                type="tel"
                                name="phone"
                                value="<%= phone %>"
                                placeholder="10-digit mobile number"
                                pattern="[0-9]{10}"
                                maxlength="10"
                                required
                            >

                        </div>


                        <!-- PINCODE -->

                        <div class="form-group">

                            <label>
                                Pincode *
                            </label>

                            <input
                                type="text"
                                name="pincode"
                                value="<%= pincode %>"
                                placeholder="400050"
                                pattern="[0-9]{6}"
                                maxlength="6"
                                required
                            >

                        </div>


                        <!-- CITY -->

                        <div class="form-group">

                            <label>
                                City *
                            </label>

                            <input
                                type="text"
                                name="city"
                                value="<%= city %>"
                                placeholder="Mumbai"
                                required
                            >

                        </div>


                        <!-- STATE -->

                        <div class="form-group">

                            <label>
                                State *
                            </label>

                            <input
                                type="text"
                                name="state"
                                value="<%= state %>"
                                placeholder="Maharashtra"
                                required
                            >

                        </div>


                        <!-- ADDRESS -->

                        <div class="form-group full">

                            <label>
                                Street & Building Address *
                            </label>

                            <textarea
                                name="addressLine"
                                placeholder="Flat / House No., Apartment, Street"
                                required
                            ><%= addressLine %></textarea>

                        </div>


                    </div>


                    <button
                        type="submit"
                        class="continue-button"
                    >
                        Continue to Payment →
                    </button>

                </form>

            </section>


            <!-- ORDER SUMMARY -->

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


    <!-- COUPON DISCOUNT -->

    <% if (appliedDiscount > 0 && couponCode != null) { %>

        <div class="summary-row">

            <span>
                Promotion (<%= couponCode %>)
            </span>

            <strong style="color:#047857;">

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


    <!-- SECURITY NOTE -->

    <div class="secure-note">

        ✓ Your address is used only for delivery
        and order processing.

    </div>

</aside>


        </div>

    </main>

</body>

</html>