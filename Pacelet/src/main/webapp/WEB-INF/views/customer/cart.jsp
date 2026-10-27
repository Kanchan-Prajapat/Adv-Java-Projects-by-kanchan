<%@ page contentType="text/html;charset=UTF-8" %>



<%@ page import="java.util.List" %>

<%@ page import="com.pacelet.model.CartItem" %>



<%

    List<CartItem> cart =

            (List<CartItem>) request.getAttribute("cart");



    Double bagTotalObj =

            (Double) request.getAttribute("bagTotal");



    double bagTotal =

            bagTotalObj != null ? bagTotalObj : 0;


    Double appliedDiscountObj =
            (Double) request.getAttribute("appliedDiscount");

    double appliedDiscount =
            appliedDiscountObj != null ? appliedDiscountObj : 0;

    double totalPayable =
            Math.max(0, bagTotal - appliedDiscount);

    String couponCode =
            (String) request.getAttribute("couponCode");

    String couponError =
            (String) request.getAttribute("couponError");
%>



<!DOCTYPE html>



<html>



<head>



    <meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>Shopping Bag — Pacelet</title>



    <link rel="stylesheet"

          href="<%= request.getContextPath() %>/assets/css/navbar.css">



    <style>



        * {

            box-sizing: border-box;

        }



        body {

            margin: 0;

            background: #f7f9fd;

            color: #191c1f;

            font-family: Inter, Arial, sans-serif;

        }



        .cart-page {

            width: min(1000px, calc(100% - 32px));

            margin: 110px auto 60px;

        }



        .cart-title {

            margin-bottom: 30px;

        }



        .cart-title h1 {

            font-family: "Plus Jakarta Sans", Arial, sans-serif;

            font-size: 34px;

            margin: 0 0 8px;

        }



        .cart-title p {

            color: #505f76;

            margin: 0;

            font-size: 14px;

        }



     .cart-layout {
    display: grid;
    grid-template-columns: minmax(0, 1.6fr) minmax(300px, 1fr);
    gap: 24px;
    align-items: start;
}

        .cart-items {

            display: flex;

            flex-direction: column;

            gap: 14px;

        }



        .cart-item {

            background: white;

            border: 1px solid #eceef2;

            border-radius: 12px;

            padding: 16px;



            display: flex;

            gap: 18px;

        }



        .product-image {

            width: 150px;

            height: 175px;



            background: #f2f4f8;

            border-radius: 8px;



            display: flex;

            align-items: center;

            justify-content: center;



            overflow: hidden;

            flex-shrink: 0;

        }



        .product-image img {

            width: 100%;

            height: 100%;

            object-fit: contain;

            mix-blend-mode: multiply;

        }



        .item-details {

            flex: 1;

            display: flex;

            flex-direction: column;

        }



        .item-top {

            display: flex;

            justify-content: space-between;

            gap: 10px;

        }



        .item-name {

            font-size: 18px;

            font-weight: 700;

            margin: 0;

        }



        .item-price {

            font-weight: 700;

            white-space: nowrap;

        }



        .item-subtitle {

            margin: 5px 0 12px;

            color: #505f76;

            font-size: 13px;

        }



        .size-badge {

            display: inline-block;

            width: fit-content;



            padding: 6px 10px;



            background: #eceef2;

            border-radius: 5px;



            font-size: 11px;

            font-weight: 600;

        }



        .quantity-control {

            margin-top: 14px;



            display: flex;

            align-items: center;



            width: fit-content;



            background: #eceef2;

            border-radius: 6px;

            overflow: hidden;

        }



        .quantity-control form {

            margin: 0;

        }



        .quantity-control button {

            width: 38px;

            height: 36px;



            border: none;

            background: transparent;



            cursor: pointer;

            font-size: 18px;

        }



        .quantity-control span {

            min-width: 34px;

            text-align: center;



            font-size: 13px;

            font-weight: 700;

        }



        .remove-form {

            margin-top: auto;

        }



        .remove-button {

            border: none;

            background: transparent;



            color: #ba1a1a;



            font-size: 11px;

            font-weight: 700;



            text-transform: uppercase;

            letter-spacing: .08em;



            cursor: pointer;

        }



        .summary {

            background: white;

            border: 1px solid #eceef2;

            border-radius: 12px;



            padding: 22px;



            height: fit-content;

        }



        .summary h2 {

            margin: 0 0 22px;



            font-family: "Plus Jakarta Sans", Arial, sans-serif;



            font-size: 18px;

        }



        .summary-row {

            display: flex;

            justify-content: space-between;



            margin-bottom: 14px;



            font-size: 14px;

            color: #444748;

        }



        .summary-row strong {

            color: #191c1f;

        }



        .summary-divider {

            height: 1px;

            background: #eceef2;

            margin: 18px 0;

        }



        .total-row {

            display: flex;

            justify-content: space-between;

            align-items: baseline;

        }



        .total-label {

            font-size: 12px;

            text-transform: uppercase;

            letter-spacing: .08em;

            color: #505f76;

        }



        .total-price {

            font-size: 25px;

            font-weight: 800;

        }



        .checkout-button {

            width: 100%;

            height: 50px;



            margin-top: 22px;



            border: none;

            border-radius: 6px;



            background: #060607;

            color: white;



            font-size: 12px;

            font-weight: 800;



            text-transform: uppercase;

            letter-spacing: .1em;



            cursor: pointer;

        }



        .free-delivery {

            margin-top: 18px;



            padding: 14px;



            background: #f2f4f8;

            border-radius: 8px;



            font-size: 12px;

            color: #444748;

        }



        .empty-cart {

            background: white;

            border: 1px solid #eceef2;

            border-radius: 12px;



            padding: 60px 20px;



            text-align: center;

        }



        .empty-cart h2 {

            margin-bottom: 8px;

        }



        .shop-button {

            display: inline-flex;



            margin-top: 18px;



            padding: 12px 22px;



            background: #060607;

            color: white;



            text-decoration: none;



            font-size: 11px;

            font-weight: 700;



            text-transform: uppercase;

            letter-spacing: .08em;



            border-radius: 5px;

        }



        /* =========================

   PROMOTION CODE

\========================= */



.promotion-section {

    background: white;

    border: 1px solid #eceef2;

    border-radius: 12px;



    padding: 18px;

    margin-bottom: 16px;

}



.promotion-header {

    display: flex;

    align-items: center;

    justify-content: space-between;



    margin-bottom: 10px;



    font-size: 11px;

    font-weight: 800;



    text-transform: uppercase;

    letter-spacing: .08em;

}



.promotion-header small {

    color: #505f76;

    font-size: 10px;

}



.coupon-form {

    display: flex;

    gap: 8px;

}



.coupon-form input {

    flex: 1;



    height: 44px;



    padding: 0 12px;



    border: 1px solid #e0e2e6;

    border-radius: 7px;



    background: #f2f4f8;



    font-size: 13px;



    text-transform: uppercase;

}



.coupon-form input:focus {

    outline: none;

    background: white;

    border-color: #747878;

}



.coupon-form button {

    height: 44px;



    padding: 0 18px;



    border: none;

    border-radius: 7px;



    background: #060607;

    color: white;



    font-size: 11px;

    font-weight: 800;



    text-transform: uppercase;

    letter-spacing: .08em;



    cursor: pointer;

}



.coupon-error {

    margin: 8px 0 0;



    color: #ba1a1a;



    font-size: 12px;

}



.applied-coupon {

    margin-top: 10px;



    padding: 9px 12px;



    display: flex;

    align-items: center;

    justify-content: space-between;



    background: #eceef2;



    border-radius: 7px;



    font-size: 12px;



    color: #047857;

}



.applied-coupon strong {

    color: #191c1f;

    margin-left: 5px;

}



.remove-coupon {

    border: none;

    background: transparent;



    font-size: 18px;



    cursor: pointer;



    color: #444748;

}





        @media (max-width: 750px) {



            .cart-page {

                width: calc(100% - 24px);

                margin-top: 100px;

            }



            .cart-layout {

                grid-template-columns: 1fr;

            }



            .cart-item {

                padding: 12px;

            }



            .product-image {

                width: 105px;

                height: 125px;

            }



            .item-name {

                font-size: 15px;

            }



            .item-price {

                font-size: 14px;

            }



        }

/* ===== RESPONSIVE CART PAGE ===== */

.cart-page {
    width: min(1200px, calc(100% - 40px));
    margin: 110px auto 60px;
}

.cart-items,
.cart-layout,
.item-details {
    min-width: 0;
}

.cart-item {
    min-width: 0;
}

.item-top {
    flex-wrap: wrap;
}

.item-name {
    overflow-wrap: anywhere;
}

.summary {
    position: sticky;
    top: 100px;
}

@media (max-width: 900px) {
    .cart-layout {
        grid-template-columns: minmax(0, 1fr);
        gap: 20px;
    }

    .summary {
        position: static;
    }
}

@media (max-width: 600px) {
    .cart-page {
        width: calc(100% - 24px);
        margin: 92px auto 36px;
    }

    .cart-title {
        margin-bottom: 20px;
    }

    .cart-title h1 {
        font-size: clamp(26px, 7vw, 32px);
    }

    .cart-title p {
        font-size: 12px;
    }

    .cart-item {
        gap: 12px;
        padding: 10px;
        border-radius: 9px;
    }

    .product-image {
        width: 96px;
        height: 116px;
        border-radius: 6px;
    }

    .item-name {
        font-size: 14px;
        line-height: 1.4;
    }

    .item-price {
        font-size: 13px;
    }

    .item-subtitle {
        margin: 4px 0 9px;
        font-size: 11px;
    }

    .size-badge {
        padding: 5px 7px;
        font-size: 10px;
    }

    .quantity-control {
        margin-top: 10px;
    }

    .quantity-control button {
        width: 32px;
        height: 34px;
    }

    .quantity-control span {
        min-width: 28px;
    }

    .summary {
        padding: 16px;
    }

    .promotion-section {
        padding: 14px;
    }

    .coupon-form {
        gap: 6px;
    }

    .coupon-form input {
        min-width: 0;
        width: 100%;
    }

    .coupon-form button {
        padding: 0 14px;
    }

    .total-price {
        font-size: 22px;
    }

    .checkout-button {
        font-size: 11px;
        letter-spacing: .06em;
    }

    .empty-cart {
        padding: 40px 16px;
    }
}

@media (max-width: 360px) {
    .cart-page {
        width: calc(100% - 16px);
    }

    .cart-item {
        gap: 9px;
        padding: 8px;
    }

    .product-image {
        width: 80px;
        height: 100px;
    }

    .item-name {
        font-size: 13px;
    }

    .summary {
        padding: 12px;
    }
}

/* Cart: mobile layout fix */
@media screen and (max-width: 600px) {
    .cart-page {
        width: calc(100% - 24px);
        margin: 88px auto 32px;
    }

    .cart-layout {
        display: flex;
        flex-direction: column;
        width: 100%;
        gap: 18px;
    }

    .cart-items,
    .summary {
        width: 100%;
        min-width: 0;
    }

    .summary {
        position: static;
    }

    .cart-item {
        width: 100%;
        gap: 10px;
        padding: 10px;
    }

    .product-image {
        width: 88px;
        height: 105px;
        flex-shrink: 0;
    }

    .item-details {
        min-width: 0;
    }

    .item-top {
        flex-wrap: wrap;
        gap: 5px;
    }

    .item-name {
        font-size: 13px;
    }

    .item-price {
        font-size: 12px;
    }

    .checkout-button {
        height: auto;
        min-height: 48px;
        padding: 12px 8px;
        line-height: 1.5;
    }
}

    </style>



</head>





<body>



    <%@ include file="/WEB-INF/views/common/navbar.jsp" %>





    <main class="cart-page">





        <div class="cart-title">



            <h1>

                Shopping Bag

            </h1>



            <p>

                Your curated Pacelet pairs

            </p>



        </div>





        <% if (cart == null || cart.isEmpty()) { %>





            <div class="empty-cart">



                <h2>

                    Your shopping bag is empty

                </h2>



                <p>

                    Explore our collection to add your first pair.

                </p>



                <a

                    class="shop-button"

                    href="<%= request.getContextPath() %>/shop"

                >

                    Explore Footwear

                </a>



            </div>





        <% } else { %>





            <div class="cart-layout">





                <!-- =========================

                     CART ITEMS

                ========================== -->



                <section class="cart-items">



                    <% for (CartItem item : cart) { %>





                        <article class="cart-item">





                            <div class="product-image">



                                <img

                                    src="<%= item.getImage() %>"

                                    alt="<%= item.getName() %>"

                                >



                            </div>





                            <div class="item-details">





                                <div class="item-top">



                                    <h2 class="item-name">

                                        <%= item.getName() %>

                                    </h2>







                                    <span class="item-price">

                                        ₹<%= String.format(

                                            "%,.0f",

                                            item.getPrice()

                                        ) %>

                                    </span>



                                </div>





                                <p class="item-subtitle">

                                    <%= item.getSubtitle() %>

                                </p>





                                <span class="size-badge">



                                    Size UK

                                    <%= item.getSize() %>



                                </span>





                                <!-- Quantity -->



                                <div class="quantity-control">





                                    <form

                                        method="post"

                                        action="<%= request.getContextPath() %>/cart/update"

                                    >



                                        <input

                                            type="hidden"

                                            name="productId"

                                            value="<%= item.getProductId() %>"

                                        >



                                        <input

                                            type="hidden"

                                            name="size"

                                            value="<%= item.getSize() %>"

                                        >



                                        <input

                                            type="hidden"

                                            name="change"

                                            value="-1"

                                        >



                                        <button

                                            type="submit"

                                        >

                                            −

                                        </button>



                                    </form>





                                    <span>

                                        <%= item.getQuantity() %>

                                    </span>





                                    <form

                                        method="post"

                                        action="<%= request.getContextPath() %>/cart/update"

                                    >



                                        <input

                                            type="hidden"

                                            name="productId"

                                            value="<%= item.getProductId() %>"

                                        >



                                        <input

                                            type="hidden"

                                            name="size"

                                            value="<%= item.getSize() %>"

                                        >



                                        <input

                                            type="hidden"

                                            name="change"

                                            value="1"

                                        >



                                        <button

                                            type="submit"

                                        >

                                            +

                                        </button>



                                    </form>





                                </div>





                                <!-- Remove -->



                                <form

                                    class="remove-form"

                                    method="post"

                                    action="<%= request.getContextPath() %>/cart/remove"

                                >



                                    <input

                                        type="hidden"

                                        name="productId"

                                        value="<%= item.getProductId() %>"

                                    >



                                    <input

                                        type="hidden"

                                        name="size"

                                        value="<%= item.getSize() %>"

                                    >



                                    <button

                                        type="submit"

                                        class="remove-button"

                                    >

                                        Remove

                                    </button>



                                </form>





                            </div>



                        </article>





                    <% } %>



                </section>







                <!-- =========================

                     SUMMARY

                ========================== -->



                <aside class="summary">

<section class="promotion-section">



    <div class="promotion-header">



        <span>

            🎟 Promotion Code

        </span>



        <small>
            <%= couponCode != null ? "1 Active" : "Available Codes" %>
        </small>



    </div>





    <form

        method="post"

        action="<%= request.getContextPath() %>/cart/coupon"

        class="coupon-form"

    >



        <input

            type="text"

            name="couponCode"

            placeholder="e.g. PACE10"

            autocomplete="off"

        >



        <button type="submit">

            Apply

        </button>



    </form>

    <% if (couponError != null) { %>



        <p class="coupon-error">

            <%= couponError %>

        </p>



    <%

        }

    %>





    <%

        if (couponCode != null) {

    %>



        <div class="applied-coupon">



            <div>



                ✓



                <strong>

                    <%= couponCode %>

                </strong>



                applied



            </div>





            <form

                method="post"

                action="<%= request.getContextPath() %>/cart/coupon/remove"

            >



                <button

                    type="submit"

                    class="remove-coupon"

                >

                    ×

                </button>



            </form>



        </div>



    <%

        }

    %>



</section>



                    <h2>

                        Price Details

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





                    

                    <% if (appliedDiscount > 0) { %>
                    <div class="summary-row">
                        <span>Coupon Discount</span>
                        <strong style="color:#047857;">
                            -₹<%= String.format("%,.0f", appliedDiscount) %>
                        </strong>
                    </div>
                    <% } %>

                    <div class="summary-row">



                        <span>

                            Delivery Charges

                        </span>



                        <strong>

                            Free Express

                        </strong>



                    </div>





                    <div class="summary-row">



                        <span>

                            Estimated GST (18% included)

                        </span>



                        <span>

                            ₹<%= String.format(

                                "%,.0f",

                                (bagTotal * 0.18) / 1.18

                            ) %>

                        </span>



                    </div>





                    <div class="summary-divider"></div>





                    <div class="total-row">



                        <div>



                            <div class="total-label">

                                Total Amount Payable

                            </div>



                        </div>





                        <div class="total-price">



                            ₹<%= String.format(

                                "%,.0f",

                                totalPayable

                            ) %>



                        </div>



                    </div>





                  <form
    method="get"
    action="<%= request.getContextPath() %>/checkout/address"
>
    <button
        type="submit"
        class="checkout-button"
    >
        Proceed to Shipping Address
    </button>
</form>





                    <% if (bagTotal >= 3000) { %>



                        <div class="free-delivery">



                            ✓ Free Express Delivery Unlocked



                        </div>



                    <% } else { %>



                        <div class="free-delivery">



                            Add more for Free Express Delivery



                        </div>



                    <% } %>





                </aside>





            </div>





        <% } %>





    </main>



</body>



</html>