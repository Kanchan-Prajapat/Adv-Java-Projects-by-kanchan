
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pacelet.model.Product" %>

<%
    List<Product> wishlist =
            (List<Product>) request.getAttribute("wishlist");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Wishlist — Pacelet</title>

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

        .wishlist-page {
            width: min(1100px, calc(100% - 32px));
            margin: 110px auto 60px;
        }

        .wishlist-header {
            margin-bottom: 30px;
        }

        .wishlist-header h1 {
            font-family: "Plus Jakarta Sans", Arial, sans-serif;
            font-size: 34px;
            margin: 0 0 8px;
        }

        .wishlist-header p {
            color: #505f76;
            margin: 0;
            font-size: 14px;
        }

        .wishlist-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 22px;
        }

        .wishlist-card {
            background: white;
            border: 1px solid #eceef2;
            border-radius: 12px;
            overflow: hidden;
            transition: transform .2s ease, box-shadow .2s ease;
        }

        .wishlist-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, .06);
        }

        .product-image {
            position: relative;
            height: 250px;
            background: #f2f4f8;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            mix-blend-mode: multiply;
            padding: 12px;
        }

        .product-badge {
            position: absolute;
            top: 14px;
            left: 14px;
            padding: 6px 9px;
            background: white;
            border-radius: 4px;
            font-size: 10px;
            font-weight: 800;
            text-transform: uppercase;
        }

        .card-content {
            padding: 18px;
        }

        .product-category {
            color: #697386;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: .08em;
            margin: 0 0 8px;
        }

        .product-name {
            font-size: 18px;
            font-weight: 700;
            margin: 0 0 5px;
        }

        .product-subtitle {
            font-size: 13px;
            color: #505f76;
            margin: 0 0 14px;
        }

        .price-row {
            display: flex;
            align-items: center;
            gap: 9px;
            margin-bottom: 18px;
        }

        .product-price {
            font-size: 17px;
            font-weight: 800;
        }

        .original-price {
            font-size: 13px;
            color: #818897;
            text-decoration: line-through;
        }

        .discount-badge {
            font-size: 11px;
            font-weight: 700;
            color: #047857;
        }

        .card-actions {
            display: grid;
            grid-template-columns: 1fr auto;
            gap: 10px;
        }

        .view-button,
        .remove-button {
            min-height: 43px;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            border-radius: 5px;
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: .06em;
            cursor: pointer;
            text-decoration: none;
        }

        .view-button {
            padding: 0 12px;
            background: #060607;
            color: white;
            border: 1px solid #060607;
        }

        .view-button:hover {
            background: #303034;
        }

        .remove-form {
            margin: 0;
        }

        .remove-button {
            width: 44px;
            background: white;
            border: 1px solid #e0e2e6;
            color: #ba1a1a;
            font-size: 18px;
        }

        .remove-button:hover {
            background: #fff1f1;
        }

        .empty-wishlist {
            background: white;
            border: 1px solid #eceef2;
            border-radius: 12px;
            padding: 65px 20px;
            text-align: center;
        }

        .empty-icon {
            font-size: 42px;
            margin-bottom: 15px;
        }

        .empty-wishlist h2 {
            margin: 0 0 10px;
            font-size: 23px;
        }

        .empty-wishlist p {
            color: #505f76;
            font-size: 14px;
            margin: 0;
        }

        .shop-button {
            display: inline-flex;
            margin-top: 22px;
            padding: 13px 22px;
            background: #060607;
            color: white;
            text-decoration: none;
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: .08em;
            border-radius: 5px;
        }

        @media (max-width: 850px) {
            .wishlist-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 16px;
            }

            .product-image {
                height: 220px;
            }
        }

        @media (max-width: 520px) {
            .wishlist-page {
                width: calc(100% - 24px);
                margin-top: 100px;
            }

            .wishlist-header h1 {
                font-size: 28px;
            }

            .wishlist-grid {
                grid-template-columns: 1fr;
            }

            .product-image {
                height: 260px;
            }
        }
    </style>
</head>

<body>

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<main class="wishlist-page">

    <header class="wishlist-header">
        <h1>My Wishlist <span style="font-size:20px;">♡</span></h1>
        <p>Your favourite Pacelet pairs, saved for later.</p>
    </header>

    <% if (wishlist == null || wishlist.isEmpty()) { %>

        <section class="empty-wishlist">
            <div class="empty-icon">♡</div>
            <h2>Your wishlist is waiting</h2>
            <p>Save the pairs you love and find them here whenever you're ready.</p>

            <a class="shop-button"
               href="<%= request.getContextPath() %>/shop">
                Explore Footwear
            </a>
        </section>

    <% } else { %>

        <section class="wishlist-grid">

            <% for (Product product : wishlist) {
                String imageUrl = (product.getImages() != null
                        && !product.getImages().isEmpty())
                        ? product.getImages().get(0) : "";

                String contextPath = request.getContextPath();
            %>

                <article class="wishlist-card">

                    <div class="product-image">

                        <% if (!imageUrl.isBlank()) { %>
                            <img src="<%= imageUrl %>"
                                 alt="<%= product.getName() %>">
                        <% } %>

                        <% if (product.getBadge() != null
                                && !product.getBadge().isBlank()) { %>
                            <span class="product-badge">
                                <%= product.getBadge() %>
                            </span>
                        <% } %>

                    </div>

                    <div class="card-content">

                        <p class="product-category">
                            <%= product.getCategory() != null
                                    ? product.getCategory() : "Pacelet Footwear" %>
                        </p>

                        <h2 class="product-name">
                            <%= product.getName() %>
                        </h2>

                        <p class="product-subtitle">
                            <%= product.getSubtitle() != null
                                    ? product.getSubtitle() : "" %>
                        </p>

                        <div class="price-row">
                            <span class="product-price">
                                ₹<%= String.format("%,.0f", product.getPrice()) %>
                            </span>

                            <% if (product.getOriginalPrice() > product.getPrice()) { %>
                                <span class="original-price">
                                    ₹<%= String.format("%,.0f",
                                            product.getOriginalPrice()) %>
                                </span>
                            <% } %>

                            <% if (product.getDiscountBadge() != null
                                    && !product.getDiscountBadge().isBlank()) { %>
                                <span class="discount-badge">
                                    <%= product.getDiscountBadge() %>
                                </span>
                            <% } %>
                        </div>

                        <div class="card-actions">

                            <a class="view-button"
                               href="<%= contextPath %>/product-detail?id=<%= product.getId() %>">
                                View Product
                            </a>

                            <form class="remove-form"
                                  method="post"
                                  action="<%= contextPath %>/wishlist">

                                <input type="hidden"
                                       name="action"
                                       value="remove">

                                <input type="hidden"
                                       name="productId"
                                       value="<%= product.getId() %>">

                                <button class="remove-button"
                                        type="submit"
                                        title="Remove from wishlist"
                                        aria-label="Remove <%= product.getName() %> from wishlist">
                                    ×
                                </button>

                            </form>

                        </div>

                    </div>

                </article>

            <% } %>

        </section>

    <% } %>

</main>

</body>
</html>
