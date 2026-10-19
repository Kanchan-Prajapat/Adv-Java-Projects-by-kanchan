<%@ page contentType="text/html;charset=UTF-8" %>

    <%@ page import="java.util.List" %>
        <%@ page import="com.pacelet.model.Product" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>

                <meta charset="UTF-8">

                <meta name="viewport" content="width=device-width, initial-scale=1.0">

                <title>Pacelet — Shop Footwear</title>

                <link rel="preconnect" href="https://fonts.googleapis.com">

                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

                <link
                    href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap"
                    rel="stylesheet">

                <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">

                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/navbar.css">


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

                    a {
                        text-decoration: none;
                        color: inherit;
                    }

                    .shop-page {

                        width: 100%;
                        max-width: 520px;

                        margin: 0 auto;

                        min-height: 100vh;

                        padding-top: 76px;
                        padding-bottom: 40px;
                    }


                    /* =========================
           PAGE HEADER
        ========================= */

                    .shop-header {

                        padding: 18px 20px 10px;
                    }

                    .breadcrumb {

                        display: flex;
                        gap: 7px;

                        color: #505f76;

                        font-size: 10px;
                        font-weight: 600;

                        text-transform: uppercase;
                        letter-spacing: .12em;
                    }

                    .breadcrumb .active {
                        color: #060607;
                        font-weight: 800;
                    }

                    .title-row {

                        display: flex;
                        align-items: baseline;
                        justify-content: space-between;

                        margin-top: 6px;
                    }

                    .shop-title {

                        margin: 0;

                        font-family: "Plus Jakarta Sans", sans-serif;

                        font-size: 28px;
                        font-weight: 800;

                        letter-spacing: -.04em;
                    }

                    .product-count {

                        color: #505f76;

                        font-size: 10px;
                        font-weight: 700;

                        letter-spacing: .08em;
                        text-transform: uppercase;
                    }


                    /* =========================
           FILTER BAR
        ========================= */

                    .filter-bar {

                        position: sticky;

                        top: 76px;

                        z-index: 20;

                        padding: 8px 20px;

                        background: rgba(247, 249, 253, .95);

                        backdrop-filter: blur(12px);

                        border-bottom: 1px solid #eceef2;
                    }

                    .filter-row {

                        display: flex;
                        gap: 8px;
                    }

                    .filter-button,
                    .sort-select {

                        height: 40px;

                        border: none;
                        border-radius: 3px;

                        background: #e6e8ec;

                        color: #191c1f;

                        font-size: 11px;
                        font-weight: 700;

                        text-transform: uppercase;
                        letter-spacing: .08em;
                    }

                    .filter-button {

                        padding: 0 14px;

                        display: flex;
                        align-items: center;
                        gap: 7px;
                    }

                    .sort-wrapper {

                        flex: 1;
                    }

                    .sort-select {

                        width: 100%;

                        padding: 0 10px;

                        outline: none;
                    }


                    /* =========================
           CATEGORY PILLS
        ========================= */

                    .category-pills {

                        display: flex;

                        gap: 6px;

                        overflow-x: auto;

                        padding: 8px 20px;

                        scrollbar-width: none;
                    }

                    .category-pills::-webkit-scrollbar {
                        display: none;
                    }

                    .category-pill {

                        flex-shrink: 0;

                        padding: 7px 13px;

                        border: none;
                        border-radius: 50px;

                        background: #e6e8ec;

                        color: #191c1f;

                        font-size: 10px;
                        font-weight: 700;

                        text-transform: uppercase;
                    }

                    .category-pill.active {

                        background: #060607;
                        color: white;
                    }


                    /* =========================
           PRODUCT GRID
        ========================= */

                    .catalog {

                        padding: 10px 20px;
                    }

                    .product-grid {

                        display: grid;

                        grid-template-columns: repeat(2, 1fr);

                        gap: 20px 10px;
                    }

                    .product-card {
                        min-width: 0;
                    }

                    .product-image-box {

                        position: relative;

                        width: 100%;
                        aspect-ratio: 4 / 5;

                        overflow: hidden;

                        background: white;

                        border: 1px solid #eceef2;
                        border-radius: 7px;
                    }

                    .product-image {

                        width: 100%;
                        height: 100%;

                        object-fit: cover;

                        display: block;
                    }

                    .product-badge {

                        position: absolute;

                        top: 8px;
                        left: 8px;

                        padding: 4px 7px;

                        background: #060607;
                        color: white;

                        border-radius: 3px;

                        font-size: 9px;
                        font-weight: 700;

                        letter-spacing: .08em;
                        text-transform: uppercase;
                    }

                    .product-info {

                        padding-top: 9px;
                    }

                    .rating {

                        color: #444748;

                        font-size: 10px;
                        font-weight: 700;
                    }

                    .product-name {

                        margin: 3px 0 2px;

                        font-family: "Plus Jakarta Sans", sans-serif;

                        font-size: 14px;
                        font-weight: 700;

                        line-height: 1.2;
                    }

                    .product-subtitle {

                        color: #505f76;

                        font-size: 10px;

                        white-space: nowrap;
                        overflow: hidden;
                        text-overflow: ellipsis;
                    }

                    .price-row {

                        display: flex;
                        align-items: baseline;
                        gap: 6px;

                        margin-top: 7px;
                    }

                    .price {

                        font-family: "Plus Jakarta Sans", sans-serif;

                        font-size: 14px;
                        font-weight: 800;
                    }

                    .original-price {

                        color: #747878;

                        font-size: 10px;

                        text-decoration: line-through;
                    }

                    .discount {

                        color: #505f76;

                        font-size: 9px;
                        font-weight: 700;
                    }


                    /* =========================
           EMPTY STATE
        ========================= */

                    .empty {

                        padding: 80px 20px;

                        text-align: center;
                    }

                    .empty-icon {

                        font-size: 42px;
                        color: #747878;
                    }

                    .empty h2 {

                        font-family: "Plus Jakarta Sans", sans-serif;

                        font-size: 17px;
                    }

                    .empty p {

                        color: #444748;

                        font-size: 12px;
                    }

                    /* =========================
   FILTER DRAWER
========================= */

                    .filter-overlay {
                        position: fixed;
                        inset: 0;

                        z-index: 2000;

                        background: rgba(0, 0, 0, 0.35);

                        opacity: 0;
                        visibility: hidden;

                        transition:
                            opacity .25s ease,
                            visibility .25s ease;
                    }

                    .filter-overlay.open {
                        opacity: 1;
                        visibility: visible;
                    }

                    .filter-drawer {

                        position: absolute;

                        top: 0;
                        right: 0;

                        width: min(340px, 90vw);
                        height: 100%;

                        background: white;

                        transform: translateX(100%);

                        transition: transform .3s ease;

                        display: flex;
                        flex-direction: column;
                    }

                    .filter-overlay.open .filter-drawer {
                        transform: translateX(0);
                    }

                    .filter-header {

                        height: 64px;

                        padding: 0 16px;

                        display: flex;
                        align-items: center;
                        justify-content: space-between;

                        background: #f2f4f8;

                        border-bottom: 1px solid #e0e2e6;
                    }

                    .filter-title {

                        display: flex;
                        align-items: center;
                        gap: 8px;

                        font-family: "Plus Jakarta Sans", sans-serif;

                        font-size: 15px;
                        font-weight: 800;

                        text-transform: uppercase;
                        letter-spacing: .06em;
                    }

                    .close-filter {

                        width: 36px;
                        height: 36px;

                        border: none;
                        border-radius: 50%;

                        background: transparent;

                        cursor: pointer;
                    }

                    .filter-form {

                        flex: 1;

                        overflow-y: auto;

                        padding: 22px 18px;

                        display: flex;
                        flex-direction: column;
                        gap: 28px;
                    }

                    .filter-form fieldset {

                        border: none;
                        padding: 0;
                        margin: 0;
                    }

                    .filter-form legend {

                        margin-bottom: 12px;

                        font-size: 10px;
                        font-weight: 800;

                        text-transform: uppercase;
                        letter-spacing: .13em;
                    }

                    .filter-form fieldset label {

                        display: flex;
                        align-items: center;

                        gap: 9px;

                        padding: 7px 0;

                        font-size: 13px;
                    }

                    .filter-form fieldset label span {

                        margin-left: auto;

                        color: #505f76;

                        font-size: 10px;
                    }

                    .filter-section-title {

                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    .size-guide-button {

                        border: none;

                        background: none;

                        color: #505f76;

                        font-size: 10px;

                        text-decoration: underline;

                        cursor: pointer;
                    }

                    .size-grid {

                        display: grid;

                        grid-template-columns: repeat(4, 1fr);

                        gap: 8px;
                    }

                    .size-option {

                        position: relative;

                        padding: 0 !important;
                    }

                    .size-option input {

                        position: absolute;

                        opacity: 0;
                    }

                    .size-option span {

                        width: 100%;
                        height: 40px;

                        display: flex;
                        align-items: center;
                        justify-content: center;

                        background: #e6e8ec;

                        color: #191c1f;

                        border-radius: 4px;

                        font-size: 13px !important;

                        margin: 0 !important;
                    }

                    .size-option input:checked+span {

                        background: #060607;

                        color: white;
                    }

                    .price-value {

                        margin-bottom: 10px;

                        font-family: "Plus Jakarta Sans", sans-serif;

                        font-size: 20px;
                        font-weight: 800;
                    }

                    #priceRange {

                        width: 100%;
                    }

                    .price-range-labels {

                        display: flex;
                        justify-content: space-between;

                        margin-top: 5px;

                        color: #747878;

                        font-size: 9px;
                    }

                    .filter-actions {

                        display: grid;

                        grid-template-columns: 1fr 2fr;

                        gap: 8px;

                        margin-top: auto;

                        padding-top: 15px;
                    }

                    .reset-button,
                    .apply-button {

                        height: 46px;

                        display: flex;
                        align-items: center;
                        justify-content: center;

                        border-radius: 3px;

                        font-size: 11px;
                        font-weight: 800;

                        text-transform: uppercase;
                        letter-spacing: .08em;

                        cursor: pointer;
                    }

                    .reset-button {

                        background: #e6e8ec;
                    }

                    .apply-button {

                        border: none;

                        background: #060607;
                        color: white;
                    }


                    @media (min-width: 700px) {

                        .shop-page {

                            box-shadow:
                                0 0 40px rgba(0, 0, 0, .08);
                        }

                    }
                </style>

            </head>

            <body>


                <jsp:include page="/WEB-INF/views/common/navbar.jsp" />


                <div class="shop-page">


                    <!-- PAGE HEADER -->

                    <section class="shop-header">

                        <div class="breadcrumb">

                            <a href="${pageContext.request.contextPath}/home">
                                Home
                            </a>

                            <span>/</span>

                            <span>
                                Footwear
                            </span>

                            <span>/</span>

                            <span class="active">
                                All Shoes
                            </span>

                        </div>


                        <div class="title-row">

                            <h1 class="shop-title">
                                Shop Footwear
                            </h1>

                            <span class="product-count">
                                84 Products
                            </span>

                        </div>

                    </section>


                    <!-- FILTER + SORT -->

                    <div class="filter-bar">

                        <div class="filter-row">

                           <button type="button"
        class="filter-button"
        onclick="openFilters()">

                                <span class="material-symbols-outlined">
                                    tune
                                </span>

                                Filters

                            </button>


                            <div class="sort-wrapper">

                                <form method="get" action="${pageContext.request.contextPath}/shop">

                                    <input
    type="hidden"
    name="category"
    value="${selectedCategory}"
>
                               <input
        type="hidden"
        name="size"
        value="${selectedSize}"
    >

                                    <select class="sort-select" name="sort" onchange="this.form.submit()"
                                        aria-label="Sort Footwear Collection">

                                        <option value="Recommended" <%="Recommended"
                                            .equals(request.getAttribute("selectedSort")) ? "selected" : "" %>
                                            >
                                            Sort: Recommended
                                        </option>

                                        <option value="Newest" <%="Newest" .equals(request.getAttribute("selectedSort"))
                                            ? "selected" : "" %>
                                            >
                                            Sort: Newest
                                        </option>

                                        <option value="Price: Low to High" <%="Price: Low to High"
                                            .equals(request.getAttribute("selectedSort")) ? "selected" : "" %>
                                            >
                                            Sort: Price: Low to High
                                        </option>

                                        <option value="Price: High to Low" <%="Price: High to Low"
                                            .equals(request.getAttribute("selectedSort")) ? "selected" : "" %>
                                            >
                                            Sort: Price: High to Low
                                        </option>

                                        <option value="Top Customer Rated" <%="Top Customer Rated"
                                            .equals(request.getAttribute("selectedSort")) ? "selected" : "" %>
                                            >
                                            Sort: Top Customer Rated
                                        </option>

                                    </select>

                                </form>

                            </div>

                        </div>

                    </div>


                    <!-- CATEGORY PILLS -->

                    <div class="category-pills">
                        <% String selectedCategory=(String) request.getAttribute("selectedCategory"); Integer
                            selectedSize=(Integer) request.getAttribute("selectedSize"); %>
                            <a class="category-pill <%= " All".equalsIgnoreCase(selectedCategory) ? "active" : "" %>"
                                href="${pageContext.request.contextPath}/shop?category=All"
                                >
                                All (84)
                            </a>


                            <a class="category-pill <%= " Running".equalsIgnoreCase(selectedCategory) ? "active" : ""
                                %>"
                                href="${pageContext.request.contextPath}/shop?category=Running"
                                >
                                Running (28)
                            </a>


                            <a class="category-pill <%= " Lifestyle".equalsIgnoreCase(selectedCategory) ? "active" : ""
                                %>"
                                href="${pageContext.request.contextPath}/shop?category=Lifestyle"
                                >
                                Lifestyle (32)
                            </a>


                            <a class="category-pill <%= " Performance".equalsIgnoreCase(selectedCategory) ? "active"
                                : "" %>"
                                href="${pageContext.request.contextPath}/shop?category=Performance"
                                >
                                Performance (16)
                            </a>


                            <a class="category-pill <%= " Casual".equalsIgnoreCase(selectedCategory) ? "active" : "" %>"
                                href="${pageContext.request.contextPath}/shop?category=Casual"
                                >
                                Casual (8)
                            </a>

                    </div>


                    <!-- FILTER DRAWER -->

                    <div id="filterOverlay" class="filter-overlay">

                        <aside class="filter-drawer">

                            <div class="filter-header">

                                <div class="filter-title">

                                    <span class="material-symbols-outlined">
                                        tune
                                    </span>

                                    <span>
                                        Filter Footwear
                                    </span>

                                </div>

                                <button type="button" onclick="closeFilters()" class="close-filter">
                                    <span class="material-symbols-outlined">
                                        close
                                    </span>
                                </button>

                            </div>


                            <form method="get" action="${pageContext.request.contextPath}/shop" class="filter-form">

                                <!-- CATEGORY -->

                                <fieldset>

                                    <legend>
                                        Footwear Category
                                    </legend>

                                    <label>
                                        <input type="radio" name="category" value="Running" <%="Running"
                                            .equalsIgnoreCase(selectedCategory) ? "checked" : "" %>
                                        >
                                        Running
                                        <span>(28)</span>
                                    </label>

                                    <label>
                                        <input type="radio" name="category" value="Lifestyle" <%="Lifestyle"
                                            .equalsIgnoreCase(selectedCategory) ? "checked" : "" %>
                                        >
                                        Lifestyle
                                        <span>(32)</span>
                                    </label>

                                    <label>
                                        <input type="radio" name="category" value="Performance" <%="Performance"
                                            .equalsIgnoreCase(selectedCategory) ? "checked" : "" %>
                                        >
                                        Performance Training
                                        <span>(16)</span>
                                    </label>

                                    <label>
                                        <input type="radio" name="category" value="Casual" <%="Casual"
                                            .equalsIgnoreCase(selectedCategory) ? "checked" : "" %>
                                        >
                                        Studio & Recovery
                                        <span>(8)</span>
                                    </label>

                                    <label>
                                        <input type="radio" name="category" value="All" <%="All"
                                            .equalsIgnoreCase(selectedCategory) ? "checked" : "" %>
                                        >
                                        All
                                    </label>

                                </fieldset>


                                <!-- SIZE -->

                                <fieldset>

                                    <div class="filter-section-title">

                                        <legend>
                                            Select Size (UK)
                                        </legend>

                                        <button type="button" class="size-guide-button">
                                            Guide
                                        </button>

                                    </div>


                                    <div class="size-grid">

                                        <% int[] sizes={6, 7, 8, 9, 10, 11, 12}; for (int size : sizes) { %>

                                            <label class="size-option">

                                                <input type="radio" name="size" value="<%= size %>" <%=selectedSize
                                                    !=null && selectedSize==size ? "checked" : "" %>
                                                >

                                                <span>
                                                    <%= size %>
                                                </span>

                                            </label>

                                            <% } %>

                                    </div>

                                </fieldset>


                                <!-- PRICE -->

                                <fieldset>

                                    <legend>
                                        Maximum Price
                                    </legend>

                                    <div class="price-value">
                                        ₹<span id="priceValue">
                                         ${maxPrice}
                                        </span>
                                    </div>

                                    <input type="range" name="maxPrice" id="priceRange" min="2000" max="12000"
                                        step="500" value="${maxPrice}"
                                    >

                                    <div class="price-range-labels">

                                        <span>₹2,000</span>
                                        <span>₹12,000</span>

                                    </div>

                                </fieldset>


                                <!-- ACTIONS -->

                                <div class="filter-actions">

                                    <a href="${pageContext.request.contextPath}/shop?category=All" class="reset-button">
                                        Reset
                                    </a>

                                    <button type="submit" class="apply-button">
                                        Apply Filters
                                    </button>

                                </div>

                            </form>

                        </aside>

                    </div>

                    <!-- PRODUCT CATALOG -->

                    <section class="catalog">


                        <% List<Product> products =
                            (List<Product>)
                                request.getAttribute("products");

                                %>


                                <% if (products==null || products.isEmpty()) { %>


                                    <div class="empty">

                                        <span class="material-symbols-outlined empty-icon">
                                            search_off
                                        </span>

                                        <h2>
                                            No models match your current filter
                                        </h2>

                                        <p>
                                            Try expanding your price range
                                            or clearing the selected size.
                                        </p>

                                    </div>


                                    <% } else { %>


                                        <div class="product-grid">


                                            <% for (Product product : products) { %>


                                                <article class="product-card">


                                                    <a
                                                       href="${pageContext.request.contextPath}/product-detail?id=<%= product.getId() %>">

                                                        <div class="product-image-box">


                                                            <% if (product.getBadge() !=null) { %>

                                                                <span class="product-badge">
                                                                    <%= product.getBadge() %>
                                                                </span>

                                                                <% } %>


                                                                    <img class="product-image"
                                                                        src="<%= product.getImages().get(0) %>"
                                                                        alt="<%= product.getName() %>">

                                                        </div>


                                                        <div class="product-info">


                                                            <div class="rating">

                                                                ★ <%= product.getRating() %>

                                                                    (<%= product.getReviewsCount() %>)

                                                            </div>


                                                            <h2 class="product-name">
                                                                <%= product.getName() %>
                                                            </h2>


                                                            <div class="product-subtitle">
                                                                <%= product.getSubtitle() %>
                                                            </div>


                                                            <div class="price-row">

                                                                <span class="price">
                                                                    ₹<%= String.format( "%,.0f" , product.getPrice() )
                                                                        %>
                                                                </span>


                                                                <span class="original-price">
                                                                    ₹<%= String.format( "%,.0f" ,
                                                                        product.getOriginalPrice() ) %>
                                                                </span>


                                                                <% if (product.getDiscountBadge() !=null) { %>

                                                                    <span class="discount">
                                                                        <%= product.getDiscountBadge() %>
                                                                    </span>

                                                                    <% } %>

                                                            </div>

                                                        </div>

                                                    </a>

                                                </article>


                                                <% } %>


                                        </div>


                                        <% } %>


                    </section>


                </div>

<script>

function openFilters() {
    document
        .getElementById("filterOverlay")
        .classList.add("open");

    document.body.style.overflow = "hidden";
}

function closeFilters() {
    document
        .getElementById("filterOverlay")
        .classList.remove("open");

    document.body.style.overflow = "";
}

const priceRange = document.getElementById("priceRange");
const priceValue = document.getElementById("priceValue");

if (priceRange && priceValue) {

    priceRange.addEventListener("input", function () {

        priceValue.textContent =
            Number(this.value).toLocaleString("en-IN");

    });
}

document
    .getElementById("filterOverlay")
    ?.addEventListener("click", function(event) {

        if (event.target === this) {
            closeFilters();
        }

    });

</script>

<script src="${pageContext.request.contextPath}/assets/js/navbar.js"></script>

            </body>

            </html>