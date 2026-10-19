<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.pacelet.model.Product" %>

<%
    Product product =
        (Product) request.getAttribute("product");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0"
    >

    <title>
        <%= product.getName() %> — Pacelet
    </title>

    <!-- Google Fonts -->
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap"
        rel="stylesheet"
    >

    <!-- Material Symbols -->
    <link
        rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
    >

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/assets/css/navbar.css"
    >

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;

            background: #f7f9fd;

            color: #191c1f;

            font-family: "Inter", sans-serif;
        }


        /* =========================
           PRODUCT PAGE
        ========================= */

        .product-page {

            width: 100%;

            max-width: 600px;

            margin: 76px auto 0;

            background: #f7f9fd;

            min-height: 100vh;

            padding-bottom: 100px;
        }


        /* =========================
           GALLERY
        ========================= */

        .product-gallery {

            background: white;

            border-bottom: 1px solid #eceef2;
        }


        .main-image-container {

            position: relative;

            width: 100%;

            aspect-ratio: 1 / 1;

            background: #f2f4f8;

            display: flex;

            align-items: center;

            justify-content: center;

            overflow: hidden;
        }


        .main-product-image {

            width: 100%;

            height: 100%;

            object-fit: contain;

            mix-blend-mode: multiply;

            padding: 16px;
        }


        /* Product badge */

        .product-badge {

            position: absolute;

            top: 16px;
            left: 16px;

            z-index: 5;

            padding: 5px 10px;

            border-radius: 999px;

            background: #e8ddff;

            color: #21005e;

            font-size: 10px;

            font-weight: 800;

            text-transform: uppercase;

            letter-spacing: .08em;
        }


        /* Wishlist */

        .wishlist-button {

            position: absolute;

            top: 16px;
            right: 16px;

            width: 42px;
            height: 42px;

            border: none;

            border-radius: 50%;

            background: rgba(255,255,255,.92);

            display: flex;

            align-items: center;
            justify-content: center;

            cursor: pointer;

            box-shadow: 0 2px 8px rgba(0,0,0,.08);
        }


        .material-symbols-outlined {

            font-family:
                "Material Symbols Outlined";

            font-size: 21px;

            line-height: 1;
        }


        /* Gallery indicator */

        .gallery-indicator {

            position: absolute;

            right: 16px;
            bottom: 16px;

            padding: 6px 11px;

            border-radius: 999px;

            background: rgba(6,6,7,.75);

            color: white;

            font-size: 10px;

            font-weight: 700;

            letter-spacing: .12em;
        }


        /* Thumbnails */

        .thumbnail-strip {

            display: flex;

            gap: 12px;

            padding: 12px 20px;

            overflow-x: auto;

            background: white;
        }


        .thumbnail {

            flex-shrink: 0;

            width: 64px;
            height: 64px;

            padding: 4px;

            border: 1px solid #e0e2e6;

            border-radius: 8px;

            background: #f2f4f8;

            cursor: pointer;
        }


        .thumbnail.active {

            border: 2px solid #060607;

            opacity: 1;
        }


        .thumbnail img {

            width: 100%;
            height: 100%;

            object-fit: contain;

            mix-blend-mode: multiply;
        }


        /* =========================
           PRODUCT INFORMATION
        ========================= */

        .product-info {

            padding: 20px;

            display: flex;

            flex-direction: column;

            gap: 12px;
        }


        .product-kicker {

            display: flex;

            justify-content: space-between;

            align-items: center;
        }


        .product-category {

            color: #505f76;

            font-size: 10px;

            font-weight: 700;

            letter-spacing: .14em;

            text-transform: uppercase;
        }


        .dispatch-badge {

            padding: 4px 8px;

            background: #eceef2;

            border-radius: 999px;

            color: #444748;

            font-size: 9px;

            font-weight: 600;
        }


        .product-title {

            margin: 0;

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 30px;

            line-height: 1.05;

            letter-spacing: -.04em;
        }


        .rating-row {

            display: flex;

            align-items: center;

            gap: 7px;

            font-size: 12px;
        }


        .stars {

            display: flex;

            color: #060607;
        }


        .stars .material-symbols-outlined {

            font-size: 16px;
        }


        .rating {

            font-weight: 700;
        }


        .reviews {

            text-decoration: underline;

            color: #444748;
        }


        /* Price */

        .price-row {

            display: flex;

            align-items: baseline;

            flex-wrap: wrap;

            gap: 8px;
        }


        .current-price {

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 24px;

            font-weight: 800;
        }


        .original-price {

            color: #747878;

            font-size: 13px;

            text-decoration: line-through;
        }


        .discount-badge {

            padding: 4px 7px;

            background: #e8ddff;

            color: #21005e;

            font-size: 9px;

            font-weight: 800;

            border-radius: 4px;

            text-transform: uppercase;
        }


        .tax-note {

            margin: 0;

            color: #444748;

            font-size: 12px;

            line-height: 1.5;
        }

        /* =========================
   COLORWAY
========================= */

.option-section {
    margin-top: 8px;
    padding-top: 18px;
    border-top: 1px solid #e6e8ec;
}

.option-header {
    display: flex;
    align-items: center;
    justify-content: space-between;

    margin-bottom: 12px;
}

.option-label {
    font-size: 11px;
    font-weight: 800;
    letter-spacing: .12em;
    text-transform: uppercase;
}

.option-value {
    color: #505f76;
    font-size: 12px;
}

.colorway-list {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}

.colorway-button {
    min-width: 52px;
    height: 38px;

    padding: 0 12px;

    border: 1px solid #d9dce2;
    border-radius: 6px;

    background: white;

    color: #191c1f;

    font-size: 11px;
    font-weight: 600;

    cursor: pointer;

    transition:
        border-color .2s ease,
        background .2s ease,
        transform .2s ease;
}

.colorway-button:hover {
    border-color: #060607;
}

.colorway-button.active {
    border: 2px solid #060607;
    background: #f2f4f8;
}


/* =========================
   SIZE
========================= */

.size-guide-button {
    border: none;
    background: transparent;

    color: #444748;

    font-size: 11px;
    font-weight: 600;

    text-decoration: underline;

    cursor: pointer;
}

.size-list {
    display: grid;

    grid-template-columns:
        repeat(6, 1fr);

    gap: 8px;
}

.size-button {
    height: 44px;

    border: 1px solid #d9dce2;

    background: white;

    border-radius: 5px;

    font-size: 12px;
    font-weight: 600;

    cursor: pointer;

    transition:
        border-color .2s ease,
        background .2s ease,
        color .2s ease;
}

.size-button:hover {
    border-color: #060607;
}

.size-button.active {
    background: #060607;
    color: white;
    border-color: #060607;
}


/* =========================
   SIZE GUIDE MODAL
========================= */

.size-guide-overlay {
    position: fixed;

    inset: 0;

    z-index: 2000;

    display: none;

    align-items: flex-end;
    justify-content: center;

    background: rgba(0, 0, 0, .45);
}

.size-guide-overlay.open {
    display: flex;
}

.size-guide-modal {
    width: min(600px, 100%);

    max-height: 85vh;

    overflow-y: auto;

    background: white;

    border-radius: 18px 18px 0 0;

    padding: 24px;
}

.size-guide-header {
    display: flex;

    align-items: center;
    justify-content: space-between;

    margin-bottom: 20px;
}

.size-guide-title {
    margin: 0;

    font-family:
        "Plus Jakarta Sans",
        sans-serif;

    font-size: 20px;
}

.close-size-guide {
    width: 38px;
    height: 38px;

    border: none;

    border-radius: 50%;

    background: #f2f4f8;

    cursor: pointer;

    display: flex;

    align-items: center;
    justify-content: center;
}

.size-table {
    width: 100%;

    border-collapse: collapse;

    font-size: 12px;
}

.size-table th,
.size-table td {
    padding: 12px 8px;

    text-align: center;

    border-bottom: 1px solid #eceef2;
}

.size-table th {
    font-weight: 700;

    background: #f7f9fd;
}


/* =========================
   PURCHASE ACTIONS
========================= */

.purchase-section {
    margin-top: 8px;
    padding-top: 20px;
    border-top: 1px solid #e6e8ec;
}

.quantity-row {
    display: flex;
    align-items: center;
    justify-content: space-between;

    margin-bottom: 14px;
}

.quantity-label {
    font-size: 11px;
    font-weight: 800;
    letter-spacing: .12em;
    text-transform: uppercase;
}

.quantity-control {
    display: flex;
    align-items: center;

    height: 42px;

    background: #eceef2;

    border-radius: 6px;

    overflow: hidden;
}

.quantity-control button {
    width: 42px;
    height: 42px;

    border: none;
    background: transparent;

    font-size: 18px;
    font-weight: 600;

    cursor: pointer;
}

.quantity-control span {
    min-width: 36px;

    text-align: center;

    font-size: 13px;
    font-weight: 700;
}

.purchase-actions {
    display: flex;
    flex-direction: column;

    gap: 8px;
}

.add-to-bag-button,
.upi-button {
    width: 100%;
    height: 52px;

    border: none;
    border-radius: 6px;

    font-size: 12px;
    font-weight: 800;

    letter-spacing: .12em;
    text-transform: uppercase;

    cursor: pointer;

    transition:
        transform .15s ease,
        opacity .15s ease;
}

.add-to-bag-button {
    background: #060607;
    color: white;
}

.upi-button {
    background: white;
    color: #060607;

    border: 1px solid #060607;
}

.add-to-bag-button:active,
.upi-button:active {
    transform: scale(.98);
}


@media (max-width: 420px) {

    .size-list {
        grid-template-columns:
            repeat(3, 1fr);
    }

}


        /* =========================
           RESPONSIVE
        ========================= */

        @media (min-width: 901px) {

            .product-page {

                max-width: 900px;

            }

            .main-image-container {

                aspect-ratio: 1 / .85;

            }

        }

    </style>

</head>


<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp" />


<main class="product-page">


    <!-- =========================
         GALLERY
    ========================== -->

    <section class="product-gallery">

        <div class="main-image-container">


            <span class="product-badge">

                <%= product.getBadge() != null
                    ? product.getBadge()
                    : "New Release" %>

            </span>


            <button
                type="button"
                class="wishlist-button"
                aria-label="Save to wishlist"
            >

                <span class="material-symbols-outlined">
                    favorite_border
                </span>

            </button>


            <img
                id="mainProductImage"
                class="main-product-image"
                src="<%= product.getImages().get(0) %>"
                alt="<%= product.getName() %>"
            >


            <span
                id="galleryIndicator"
                class="gallery-indicator"
            >
                1 / <%= product.getImages().size() %>
            </span>

        </div>


        <!-- Thumbnail strip -->

        <div class="thumbnail-strip">

            <%
                for (
                    int i = 0;
                    i < product.getImages().size();
                    i++
                ) {
            %>

                <button
                    type="button"
                    class="thumbnail <%= i == 0 ? "active" : "" %>"
                    onclick="changeImage(<%= i %>)"
                >

                    <img
                        src="<%= product.getImages().get(i) %>"
                        alt="Product image <%= i + 1 %>"
                    >

                </button>

            <%
                }
            %>

        </div>

    </section>


    <!-- =========================
         PRODUCT INFORMATION
    ========================== -->

    <section class="product-info">


        <div class="product-kicker">

            <span class="product-category">

                <%= product.getCategory() %> LAB

            </span>


            <span class="dispatch-badge">

                ● Fast Dispatch

            </span>

        </div>


        <h1 class="product-title">

            <%= product.getName() %>

        </h1>


        <p style="
            margin:0;
            color:#505f76;
            font-size:13px;
        ">

            <%= product.getSubtitle() %>

        </p>


        <!-- Rating -->

        <div class="rating-row">

            <div class="stars">

                <span class="material-symbols-outlined">
                    star
                </span>

                <span class="material-symbols-outlined">
                    star
                </span>

                <span class="material-symbols-outlined">
                    star
                </span>

                <span class="material-symbols-outlined">
                    star
                </span>

                <span class="material-symbols-outlined">
                    star_half
                </span>

            </div>


            <span class="rating">

                <%= product.getRating() %>

            </span>


            <span>•</span>


            <span class="reviews">

                <%= product.getReviewsCount() %>
                verified reviews

            </span>

        </div>


        <!-- Price -->

        <div class="price-row">

            <span class="current-price">

                ₹<%= String.format(
                    "%,.0f",
                    product.getPrice()
                ) %>

            </span>


            <% if (product.getOriginalPrice() > product.getPrice()) { %>

                <span class="original-price">

                    ₹<%= String.format(
                        "%,.0f",
                        product.getOriginalPrice()
                    ) %>

                </span>

            <% } %>


            <% if (product.getDiscountBadge() != null) { %>

                <span class="discount-badge">

                    <%= product.getDiscountBadge() %>

                </span>

            <% } %>

        </div>


        <p class="tax-note">

            Inclusive of all taxes.
            Free express shipping across India
            on prepaid orders.

        </p>


    </section>


    <!-- =========================
     COLORWAY
========================= -->

<% if (product.getColorways() != null
        && !product.getColorways().isEmpty()) { %>

<section class="option-section">

    <div class="option-header">

        <span class="option-label">
            Colorway
        </span>

        <span
            id="selectedColorway"
            class="option-value"
        >
            <%= product.getColorways().get(0) %>
        </span>

    </div>


    <div class="colorway-list">

        <%
            for (
                int i = 0;
                i < product.getColorways().size();
                i++
            ) {

                String colorway =
                    product.getColorways().get(i);
        %>

            <button
                type="button"
                class="colorway-button <%= i == 0 ? "active" : "" %>"
                onclick="selectColorway(this)"
                data-colorway="<%= colorway %>"
            >

                <%= colorway %>

            </button>

        <%
            }
        %>

    </div>

</section>

<% } %>


<!-- =========================
     SIZE
========================= -->

<section class="option-section">

    <div class="option-header">

        <span class="option-label">
            Select Size (UK)
        </span>


        <button
            type="button"
            class="size-guide-button"
            onclick="openSizeGuide()"
        >
            Size Guide
        </button>

    </div>


    <div class="size-list">

        <%
            if (
                product.getSizes() != null
                && !product.getSizes().isEmpty()
            ) {

                for (
                    Integer size :
                    product.getSizes()
                ) {
        %>

            <button
                type="button"
                class="size-button"
                onclick="selectSize(this)"
                data-size="<%= size %>"
            >

                <%= size %>

            </button>

        <%
                }

            }
        %>

    </div>

</section>


<!-- =========================
     PURCHASE
========================= -->

<section class="purchase-section">

    <div class="quantity-row">

        <span class="quantity-label">
            Quantity
        </span>


        <div class="quantity-control">

            <button
                type="button"
                onclick="decreaseQuantity()"
            >
                −
            </button>


            <span id="quantityValue">
                1
            </span>


            <button
                type="button"
                onclick="increaseQuantity()"
            >
                +
            </button>

        </div>

    </div>


    <form
        method="post"
        action="${pageContext.request.contextPath}/cart/add"
        class="purchase-actions"
    >

        <input
            type="hidden"
            name="productId"
            value="<%= product.getId() %>"
        >


        <input
            type="hidden"
            name="size"
            id="selectedSizeInput"
            value=""
        >


        <input
            type="hidden"
            name="quantity"
            id="quantityInput"
            value="1"
        >


        <button
            type="submit"
            class="add-to-bag-button"
            onclick="return validateProductSelection()"
        >

            Add to Bag

        </button>


        <button
            type="button"
            class="upi-button"
            onclick="buyWithUPI()"
        >

            Buy with UPI

        </button>

    </form>

</section>


</main>

<!-- =========================
     SIZE GUIDE
========================= -->

<div
    id="sizeGuideOverlay"
    class="size-guide-overlay"
    onclick="closeSizeGuide(event)"
>

    <div
        class="size-guide-modal"
        onclick="event.stopPropagation()"
    >

        <div class="size-guide-header">

            <h2 class="size-guide-title">
                Size Guide
            </h2>

            <button
                type="button"
                class="close-size-guide"
                onclick="closeSizeGuide()"
            >

                <span class="material-symbols-outlined">
                    close
                </span>

            </button>

        </div>


        <p style="
            margin-top:0;
            color:#505f76;
            font-size:12px;
            line-height:1.6;
        ">
            Use your foot length to find the
            recommended UK size.
        </p>


        <table class="size-table">

            <thead>

                <tr>

                    <th>UK</th>
                    <th>EU</th>
                    <th>Foot Length</th>

                </tr>

            </thead>


            <tbody>

                <tr>
                    <td>6</td>
                    <td>40</td>
                    <td>25.0 cm</td>
                </tr>

                <tr>
                    <td>7</td>
                    <td>41</td>
                    <td>26.0 cm</td>
                </tr>

                <tr>
                    <td>8</td>
                    <td>42</td>
                    <td>27.0 cm</td>
                </tr>

                <tr>
                    <td>9</td>
                    <td>43</td>
                    <td>28.0 cm</td>
                </tr>

                <tr>
                    <td>10</td>
                    <td>44</td>
                    <td>29.0 cm</td>
                </tr>

                <tr>
                    <td>11</td>
                    <td>45</td>
                    <td>30.0 cm</td>
                </tr>

            </tbody>

        </table>

    </div>

</div>


<script>

    const productImages = [

        <%
            for (
                int i = 0;
                i < product.getImages().size();
                i++
            ) {

                if (i > 0) {
        %>
                    ,
        <%
                }
        %>

        "<%= product.getImages().get(i) %>"

        <%
            }
        %>

    ];


    function changeImage(index) {

        const image =
            document.getElementById(
                "mainProductImage"
            );

        const indicator =
            document.getElementById(
                "galleryIndicator"
            );


        image.src =
            productImages[index];


        indicator.textContent =
            (index + 1)
            + " / "
            + productImages.length;


        document
            .querySelectorAll(".thumbnail")
            .forEach(
                (thumbnail, i) => {

                    thumbnail.classList.toggle(
                        "active",
                        i === index
                    );

                }
            );

    }

    /* =========================
   COLORWAY
========================= */

function selectColorway(button) {

    document
        .querySelectorAll(".colorway-button")
        .forEach(function (item) {

            item.classList.remove("active");

        });


    button.classList.add("active");


    const selected =
        button.getAttribute("data-colorway");


    const selectedColorway =
        document.getElementById(
            "selectedColorway"
        );


    if (selectedColorway) {

        selectedColorway.textContent =
            selected;

    }

}


/* =========================
   SIZE
========================= */

function selectSize(button) {

    document
        .querySelectorAll(".size-button")
        .forEach(function (item) {

            item.classList.remove("active");

        });


    button.classList.add("active");


    const size =
        button.getAttribute("data-size");


    document
        .getElementById("selectedSizeInput")
        .value = size;

}

/* =========================
   SIZE GUIDE
========================= */

function openSizeGuide() {

    const overlay =
        document.getElementById(
            "sizeGuideOverlay"
        );


    if (overlay) {

        overlay.classList.add("open");

        document.body.style.overflow =
            "hidden";

    }

}

let quantity = 1;


function increaseQuantity() {

    quantity++;

    updateQuantityUI();

}


function decreaseQuantity() {

    if (quantity > 1) {

        quantity--;

    }

    updateQuantityUI();

}


function updateQuantityUI() {

    document
        .getElementById("quantityValue")
        .textContent = quantity;


    document
        .getElementById("quantityInput")
        .value = quantity;

}


function validateProductSelection() {

    const size =
        document
            .getElementById("selectedSizeInput")
            .value;


    if (!size) {

        alert("Please select a UK size.");

        return false;

    }


    return true;
}


function buyWithUPI() {

    const size =
        document
            .getElementById("selectedSizeInput")
            .value;


    if (!size) {

        alert("Please select a UK size.");

        return;

    }


    alert(
        "UPI checkout will be connected next."
    );
}


function closeSizeGuide(event) {

    if (
        event
        && event.target
        !== document.getElementById(
            "sizeGuideOverlay"
        )
    ) {

        return;

    }


    const overlay =
        document.getElementById(
            "sizeGuideOverlay"
        );


    if (overlay) {

        overlay.classList.remove("open");

        document.body.style.overflow =
            "";

    }

}

</script>

</body>

</html>