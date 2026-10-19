<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Pacelet — Step Into Your Pace</title>

    <!-- Google Fonts -->
    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap"
          rel="stylesheet">

<!-- Material Symbols -->
<link
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
    rel="stylesheet">

<!-- Pacelet Navbar CSS -->
<link
    rel="stylesheet"
    href="${pageContext.request.contextPath}/assets/css/navbar.css">


    <style>

        * {
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            margin: 0;
            background: #f7f9fd;
            color: #191c1f;
            font-family: 'Inter', sans-serif;
        }

        a {
            color: inherit;
            text-decoration: none;
        }

        button,
        input {
            font-family: inherit;
        }

        button {
            cursor: pointer;
        }

        .pacelet-page {
            width: 100%;
            max-width: 520px;
            margin: 0 auto;
            background: #f7f9fd;
            min-height: 100vh;
             padding-top: 76px;
        }

        /* =========================================
           HERO
        ========================================= */

        .hero {
            position: relative;
            width: 100%;
            overflow: hidden;
            background: #f2f4f8;
        }

        .hero-image-wrapper {
            position: relative;
            width: 100%;
            aspect-ratio: 4 / 5;
            max-height: 520px;
        }

        .hero-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
            display: block;
        }

        .hero-overlay {
            position: absolute;
            inset: 0;
            background:
                linear-gradient(
                    to top,
                    rgba(0,0,0,.85),
                    rgba(0,0,0,.25),
                    transparent
                );
        }

        .capsule-badge {
            position: absolute;
            top: 16px;
            left: 20px;

            display: inline-flex;
            align-items: center;
            gap: 7px;

            padding: 6px 10px;

            background: rgba(255,255,255,.95);
            color: #060607;

            font-size: 10px;
            font-weight: 700;
            letter-spacing: .12em;
            text-transform: uppercase;

            border-radius: 3px;
        }

        .capsule-dot {
            width: 6px;
            height: 6px;
            background: #060607;
            border-radius: 50%;
        }

        .hero-content {
            position: absolute;
            left: 0;
            right: 0;
            bottom: 0;

            padding: 20px;

            color: white;
        }

        .hero-kicker {
            font-size: 10px;
            font-weight: 700;
            letter-spacing: .2em;
            color: #c4c7c7;
            text-transform: uppercase;
        }

        .hero-title {
            margin: 4px 0 7px;

            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: clamp(42px, 12vw, 62px);
            line-height: .92;
            font-weight: 800;
            letter-spacing: -.05em;
            text-transform: uppercase;
        }

        .hero-description {
            max-width: 280px;
            margin: 0;

            color: #e0e2e6;
            font-size: 13px;
            line-height: 1.45;
        }

        .hero-actions {
            display: flex;
            gap: 8px;
            margin-top: 16px;
        }

        .btn-primary {
            flex: 1;
            min-height: 44px;

            border: none;
            border-radius: 3px;

            background: #060607;
            color: white;

            font-size: 11px;
            font-weight: 700;
            letter-spacing: .08em;
            text-transform: uppercase;
        }

        .hero .btn-primary {
            background: white;
            color: #060607;
        }

        .btn-secondary {
            min-height: 44px;
            padding: 0 16px;

            border: 1px solid rgba(255,255,255,.2);
            border-radius: 3px;

            background: rgba(255,255,255,.2);
            color: white;

            font-size: 11px;
            font-weight: 700;
            letter-spacing: .08em;
            text-transform: uppercase;
        }

        /* =========================================
           BRAND TICKER
        ========================================= */

        .ticker {
            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 10px 20px;

            background: #060607;
            color: #c4c7c7;

            border-top: 1px solid #000;
            border-bottom: 1px solid #000;

            font-size: 9px;
            font-weight: 700;
            letter-spacing: .12em;
            text-transform: uppercase;
        }

        .ticker-star {
            color: #cebdff;
        }

        /* =========================================
           COMMON SECTION
        ========================================= */

        .section {
            padding: 26px 20px 10px;
        }

        .section-header {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            gap: 15px;
            margin-bottom: 14px;
        }

        .section-kicker {
            margin: 0 0 4px;

            color: #505f76;

            font-size: 10px;
            font-weight: 700;
            letter-spacing: .15em;
            text-transform: uppercase;
        }

        .section-title {
            margin: 0;

            font-family: 'Plus Jakarta Sans', sans-serif;

            font-size: 25px;
            line-height: 1.05;
            font-weight: 800;

            letter-spacing: -.03em;
            text-transform: uppercase;
        }

        .section-description {
            margin: 5px 0 0;

            color: #444748;
            font-size: 13px;
            line-height: 1.5;
        }

        .view-all {
            flex-shrink: 0;

            padding: 0 0 3px;

            border: none;
            border-bottom: 1px solid #060607;

            background: transparent;

            font-size: 11px;
            font-weight: 700;
            letter-spacing: .08em;
            text-transform: uppercase;
        }

        /* =========================================
           CATEGORIES
        ========================================= */

        .category-list {
            display: flex;
            gap: 8px;

            overflow-x: auto;
            padding: 4px 0 8px;

            scrollbar-width: none;
        }

        .category-list::-webkit-scrollbar {
            display: none;
        }

        .category {
            flex-shrink: 0;

            padding: 9px 16px;

            border: none;
            border-radius: 3px;

            background: #eceef2;
            color: #444748;

            font-size: 11px;
            font-weight: 700;
            letter-spacing: .06em;
            text-transform: uppercase;
        }

        .category.active {
            background: #060607;
            color: white;
        }

        /* =========================================
           PRODUCT GRID
        ========================================= */

        .product-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
        }

        .product-card {
            overflow: hidden;

            background: white;

            border: 1px solid #eceef2;
            border-radius: 3px;

            box-shadow: 0 1px 4px rgba(0,0,0,.04);
        }

        .product-image-wrapper {
            position: relative;

            width: 100%;
            aspect-ratio: 1;

            overflow: hidden;
            background: #f2f4f8;
        }

        .product-image {
            width: 100%;
            height: 100%;

            display: block;

            object-fit: cover;

            transition: transform .4s ease;
        }

        .product-card:hover .product-image {
            transform: scale(1.04);
        }

        .product-badge {
            position: absolute;
            top: 8px;
            left: 8px;

            padding: 4px 7px;

            background: #f5f3ff;
            color: #6d28d9;

            border-radius: 3px;

            font-size: 9px;
            font-weight: 700;
            letter-spacing: .08em;
            text-transform: uppercase;
        }

        .product-info {
            padding: 12px;
        }

        .rating {
            color: #c2410c;

            font-size: 11px;
            font-weight: 700;
        }

        .product-name {
            margin: 4px 0 2px;

            font-family: 'Plus Jakarta Sans', sans-serif;

            font-size: 15px;
            line-height: 1.2;
            font-weight: 700;
        }

        .product-subtitle {
            color: #505f76;

            font-size: 11px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .price-row {
            display: flex;
            align-items: baseline;
            gap: 7px;

            margin-top: 9px;
        }

        .price {
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 16px;
            font-weight: 800;
        }

        .original-price {
            color: #747878;
            font-size: 11px;
            text-decoration: line-through;
        }

        .quick-add {
            width: 100%;
            min-height: 36px;

            margin-top: 9px;

            border: none;
            border-radius: 3px;

            background: #060607;
            color: white;

            font-size: 10px;
            font-weight: 700;
            letter-spacing: .08em;
            text-transform: uppercase;
        }

        /* =========================================
           BUILT FOR EVERYDAY
        ========================================= */

        .everyday-section {
            padding: 12px 20px;
        }

        .everyday-card {
            padding: 24px;

            background: #e6e8ec;

            border-radius: 3px;

            box-shadow: 0 1px 4px rgba(0,0,0,.04);
        }

        .everyday-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .material-badge {
            padding: 4px 8px;

            background: #fff7ed;
            color: #c2410c;

            border-radius: 3px;

            font-size: 9px;
            font-weight: 700;
            letter-spacing: .08em;
            text-transform: uppercase;
        }

        .series {
            color: #505f76;

            font-size: 9px;
            font-weight: 700;
            letter-spacing: .15em;
            text-transform: uppercase;
        }

        .everyday-title {
            margin: 18px 0 5px;

            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 25px;
            font-weight: 800;
            letter-spacing: -.03em;
        }

        .everyday-description {
            margin: 0;

            color: #444748;
            font-size: 13px;
            line-height: 1.55;
        }

        .everyday-features {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;

            margin-top: 16px;

            color: #060607;

            font-size: 10px;
            font-weight: 700;
            letter-spacing: .06em;
            text-transform: uppercase;
        }

        /* =========================================
           BEST SELLER
        ========================================= */

        .spotlight-card {
            overflow: hidden;

            background: white;

            border: 1px solid #eceef2;
            border-radius: 3px;

            box-shadow: 0 1px 4px rgba(0,0,0,.04);
        }

        .spotlight-image {
            width: 100%;
            aspect-ratio: 4 / 3;

            object-fit: cover;
            display: block;
        }

        .spotlight-info {
            padding: 16px;
        }

        .limited-badge {
            display: inline-block;

            padding: 4px 8px;

            background: #eff6ff;
            color: #1d4ed8;

            border-radius: 3px;

            font-size: 9px;
            font-weight: 700;
            letter-spacing: .08em;
            text-transform: uppercase;
        }

        .spotlight-title {
            margin: 10px 0 3px;

            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 20px;
            font-weight: 800;
        }

        .spotlight-subtitle {
            color: #505f76;
            font-size: 12px;
        }

        .spotlight-description {
            margin: 10px 0;

            color: #444748;
            font-size: 13px;
            line-height: 1.5;
        }

        .size-label {
            display: block;

            margin-bottom: 7px;

            color: #505f76;

            font-size: 10px;
            font-weight: 700;
            letter-spacing: .08em;
            text-transform: uppercase;
        }

        .size-list {
            display: flex;
            gap: 7px;
        }

        .size {
            min-width: 38px;
            height: 36px;

            border: 1px solid #e0e2e6;
            border-radius: 3px;

            background: white;

            font-size: 11px;
            font-weight: 600;
        }

        .size.selected {
            border-color: #060607;
            background: #060607;
            color: white;
        }

        .spotlight-price {
            margin-top: 13px;

            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 18px;
            font-weight: 800;
        }

        .spotlight-button {
            width: 100%;
            height: 44px;

            margin-top: 10px;

            border: none;
            border-radius: 3px;

            background: #060607;
            color: white;

            font-size: 11px;
            font-weight: 700;
            letter-spacing: .08em;
            text-transform: uppercase;
        }

        /* =========================================
           PROMOTION
        ========================================= */

        .promotion {
            margin: 8px 20px;

            padding: 20px;

            background: #f5f3ff;

            border: 1px solid #e8ddff;
            border-radius: 3px;

            text-align: center;
        }

        .promotion-kicker {
            color: #6d28d9;

            font-size: 10px;
            font-weight: 700;
            letter-spacing: .18em;
            text-transform: uppercase;
        }

        .promotion-title {
            margin: 7px 0;

            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 23px;
            font-weight: 800;
            text-transform: uppercase;
        }

        .promotion-text {
            max-width: 280px;
            margin: 0 auto;

            color: #4f319c;

            font-size: 13px;
            line-height: 1.5;
        }

        .promotion-button {
            width: 100%;
            max-width: 220px;
            height: 40px;

            margin-top: 14px;

            border: none;
            border-radius: 3px;

            background: #060607;
            color: white;

            font-size: 11px;
            font-weight: 700;
            letter-spacing: .08em;
            text-transform: uppercase;
        }

        .promotion-note {
            display: block;

            margin-top: 9px;

            color: #747878;

            font-size: 9px;
            letter-spacing: .08em;
            text-transform: uppercase;
        }

        /* =========================================
           PROMISE
        ========================================= */

        .promise-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 8px;
        }

        .promise-card {
            padding: 14px;

            background: white;

            border: 1px solid #eceef2;
            border-radius: 3px;

            box-shadow: 0 1px 4px rgba(0,0,0,.03);
        }

        .promise-icon {
            font-size: 22px;
        }

        .promise-title {
            margin: 7px 0 3px;

            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px;
            font-weight: 700;
        }

        .promise-text {
            margin: 0;

            color: #444748;

            font-size: 11px;
            line-height: 1.45;
        }

        /* =========================================
           NEWSLETTER
        ========================================= */

        .newsletter {
            padding: 40px 20px;

            background: white;

            text-align: center;
        }

        .mail-icon {
            width: 36px;
            height: 36px;

            margin: 0 auto 8px;

            display: flex;
            align-items: center;
            justify-content: center;

            background: #e6e8ec;
            border-radius: 50%;
        }

        .newsletter-text {
            max-width: 300px;
            margin: 7px auto 0;

            color: #444748;

            font-size: 13px;
            line-height: 1.5;
        }

        .newsletter-form {
            display: flex;
            flex-direction: column;
            gap: 8px;

            max-width: 380px;

            margin: 15px auto 0;
        }

        .newsletter-input {
            width: 100%;
            height: 44px;

            padding: 0 14px;

            border: 1px solid #e0e2e6;
            border-radius: 3px;

            background: #eceef2;

            outline: none;
        }

        .newsletter-button {
            width: 100%;
            height: 44px;

            border: none;
            border-radius: 3px;

            background: #060607;
            color: white;

            font-size: 11px;
            font-weight: 700;
            letter-spacing: .08em;
            text-transform: uppercase;
        }

        /* =========================================
           FOOTER
        ========================================= */

        .footer {
            padding: 40px 20px 32px;

            background: #f2f4f8;

            border-top: 1px solid #e0e2e6;
        }

        .footer-brand {
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 19px;
            font-weight: 800;
            letter-spacing: .08em;
        }

        .footer-tagline {
            margin-top: 3px;

            color: #444748;

            font-size: 10px;
            font-weight: 700;
            letter-spacing: .15em;
            text-transform: uppercase;
        }

        .footer-links {
            display: flex;
            flex-wrap: wrap;
            gap: 10px 20px;

            margin-top: 22px;

            color: #444748;

            font-size: 12px;
        }

        .footer-links a:hover {
            color: #060607;
        }

        .copyright {
            margin-top: 25px;

            color: #747878;

            font-size: 10px;
        }

        @media (min-width: 700px) {

            .pacelet-page {
                box-shadow:
                    0 0 40px rgba(0,0,0,.08);
            }

        }

    </style>

</head>


<body>

<div class="pacelet-page">


    <!-- =========================================
         HEADER / EXISTING NAVBAR
    ========================================== -->

    <jsp:include page="/WEB-INF/views/common/navbar.jsp" />


    <!-- =========================================
         1. EDITORIAL HERO
    ========================================== -->

    <section class="hero">

        <div class="hero-image-wrapper">

            <img
                class="hero-image"
                alt="Athletic runner pacing outdoor stairs"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuBuBp82gbeLMkTuAg6m_gdPudBlRLN8R0j6nytghnJeSonhqXJz5ANWhKlBYJ7Ok899yqM5CsAn5BnL-NEzLcP_DSFKvvur212YcSO5VHrFAlXbZwZK9AX626khYNKBmQ8bg1JMBo8TVXjtq2X181gXPYHPSK35F8CNRSX6FPJEiyGTEDDCKjc2wwWPjdV8QlRy9UdQYNvsrFaYIesiIwCElllF1HwxoPOveE3lVO3TwsYPYHOUyWLrRA"
            >

            <div class="hero-overlay"></div>


            <div class="capsule-badge">

                <span class="capsule-dot"></span>

                2025 Capsule

            </div>


            <div class="hero-content">

                <div class="hero-kicker">
                    PACELET ATELIER
                </div>

                <h1 class="hero-title">
                    STEP INTO<br>
                    YOUR PACE
                </h1>

                <p class="hero-description">
                    Engineered for intentional movement,
                    calibrated comfort, and everyday cadence.
                </p>


                <div class="hero-actions">

                    <a
                        href="${pageContext.request.contextPath}/products"
                        class="btn-primary"
                    >
                        Shop Capsule
                    </a>

                    <a
                        href="#curated-bestsellers"
                        class="btn-secondary"
                    >
                        Explore
                    </a>

                </div>

            </div>

        </div>

    </section>


    <!-- =========================================
         BRAND VALUES TICKER
    ========================================== -->

    <div class="ticker">

        <span>Architectural Fit</span>

        <span class="ticker-star">✦</span>

        <span>Featherweight Soles</span>

        <span class="ticker-star">✦</span>

        <span>Pan-India Delivery</span>

    </div>


    <!-- =========================================
         2. FIND YOUR PACE
    ========================================== -->

    <section class="section">

        <div class="section-header">

            <div>

                <p class="section-kicker">
                    CURATED SELECTION
                </p>

                <h2 class="section-title">
                    Find Your Pace
                </h2>

            </div>

            <span class="section-kicker">
                6 Categories
            </span>

        </div>


        <div class="category-list">

            <a
                href="${pageContext.request.contextPath}/products"
                class="category active"
            >
                Sneakers
            </a>

            <a
                href="${pageContext.request.contextPath}/products?category=Running"
                class="category"
            >
                Running
            </a>

            <a
                href="${pageContext.request.contextPath}/products?category=Sports"
                class="category"
            >
                Sports
            </a>

            <a
                href="${pageContext.request.contextPath}/products?category=Casual"
                class="category"
            >
                Casual
            </a>

            <a
                href="${pageContext.request.contextPath}/products?category=Formal"
                class="category"
            >
                Formal
            </a>

            <a
                href="${pageContext.request.contextPath}/products?category=Sandals"
                class="category"
            >
                Sandals
            </a>

        </div>

    </section>


    <!-- =========================================
         3. NEW ARRIVALS
    ========================================== -->

    <section class="section" id="new-arrivals">

        <div class="section-header">

            <div>

                <p class="section-kicker">
                    AUTUMN/WINTER 2025
                </p>

                <h2 class="section-title">
                    New Arrivals
                </h2>

                <p class="section-description">
                    Fresh silhouettes. Made to move effortlessly.
                </p>

            </div>

            <a
                href="${pageContext.request.contextPath}/products"
                class="view-all"
            >
                View All
            </a>

        </div>


        <div class="product-grid">

            <!-- AeroStride -->

            <article class="product-card">

                <a
                    href="${pageContext.request.contextPath}/products?id=${aeroStride.id}"
                    class="product-image-wrapper"
                >

                    <img
                        class="product-image"
                        src="${aeroStride.images[0]}"
                        alt="Pacelet AeroStride 01"
                    >

                    <span class="product-badge">
                        NEW
                    </span>

                </a>


                <div class="product-info">

                    <div class="rating">
                        ★ ${aeroStride.rating}
                    </div>

                    <h3 class="product-name">
                        ${aeroStride.name}
                    </h3>

                    <div class="product-subtitle">
                        ${aeroStride.subtitle}
                    </div>


                    <div class="price-row">

                        <span class="price">
                            ₹${aeroStride.price}
                        </span>

                        <span class="original-price">
                            ₹${aeroStride.originalPrice}
                        </span>

                    </div>


                    <a
                        href="${pageContext.request.contextPath}/products?id=${aeroStride.id}"
                        class="quick-add"
                        style="display:flex;align-items:center;justify-content:center;"
                    >
                        Quick Add
                    </a>

                </div>

            </article>


            <!-- Phantom Flow -->

            <article class="product-card">

                <a
                    href="${pageContext.request.contextPath}/products?id=${phantomFlow.id}"
                    class="product-image-wrapper"
                >

                    <img
                        class="product-image"
                        src="${phantomFlow.images[0]}"
                        alt="Pacelet Phantom Flow"
                    >

                    <span class="product-badge">
                        NEW
                    </span>

                </a>


                <div class="product-info">

                    <div class="rating">
                        ★ ${phantomFlow.rating}
                    </div>

                    <h3 class="product-name">
                        ${phantomFlow.name}
                    </h3>

                    <div class="product-subtitle">
                        ${phantomFlow.subtitle}
                    </div>


                    <div class="price-row">

                        <span class="price">
                            ₹${phantomFlow.price}
                        </span>

                        <span class="original-price">
                            ₹${phantomFlow.originalPrice}
                        </span>

                    </div>


                    <a
                        href="${pageContext.request.contextPath}/products?id=${phantomFlow.id}"
                        class="quick-add"
                        style="display:flex;align-items:center;justify-content:center;"
                    >
                        Quick Add
                    </a>

                </div>

            </article>

        </div>

    </section>


    <!-- =========================================
         4. BUILT FOR EVERYDAY
    ========================================== -->

    <section class="everyday-section">

        <div class="everyday-card">

            <div class="everyday-top">

                <span class="material-badge">
                    MATERIAL MASTERY
                </span>

                <span class="series">
                    SERIES 02
                </span>

            </div>


            <h3 class="everyday-title">
                Built For Everyday
            </h3>

            <p class="everyday-description">

                Proprietary zero-fatigue midsoles wrapped in
                breathable Japanese knit mesh. Designed to
                transition smoothly from urban commute to
                evening pace.

            </p>


            <div class="everyday-features">

                <span>
                    ✓ Shock Absorbing
                </span>

                <span>/</span>

                <span>
                    ◷ 218 Grams
                </span>

            </div>

        </div>

    </section>


    <!-- =========================================
         5. BEST SELLERS
    ========================================== -->

    <section
        class="section"
        id="curated-bestsellers"
    >

        <div class="section-header">

            <div>

                <p class="section-kicker">
                    COMMUNITY FAVORITE
                </p>

                <h2 class="section-title">
                    Best Sellers
                </h2>

            </div>

            <a
                href="${pageContext.request.contextPath}/products"
                class="view-all"
            >
                Explore
            </a>

        </div>


        <div class="spotlight-card">

            <a
                href="${pageContext.request.contextPath}/products?id=${cloudformLuxe.id}"
            >

                <img
                    class="spotlight-image"
                    src="${cloudformLuxe.images[0]}"
                    alt="Pacelet Cloudform Luxe"
                >

            </a>


            <div class="spotlight-info">

                <span class="limited-badge">
                    LIMITED EDITION
                </span>


                <h3 class="spotlight-title">
                    ${cloudformLuxe.name}
                </h3>

                <div class="spotlight-subtitle">
                    ${cloudformLuxe.subtitle}
                </div>


                <p class="spotlight-description">
                    ${cloudformLuxe.description}
                </p>


                <span class="size-label">
                    Select Size
                </span>


                <div class="size-list">

                    <button class="size">6</button>
                    <button class="size selected">7</button>
                    <button class="size">8</button>
                    <button class="size">9</button>
                    <button class="size">10</button>
                    <button class="size">11</button>

                </div>


                <div class="spotlight-price">
                    ₹${cloudformLuxe.price}
                </div>


                <button class="spotlight-button">
                    Add to Bag • ₹${cloudformLuxe.price}
                </button>

            </div>

        </div>

    </section>


    <!-- =========================================
         6. MID-SEASON SALE
    ========================================== -->

    <section class="promotion">

        <div class="promotion-kicker">
            MID-SEASON PRIVILEGE
        </div>

        <h3 class="promotion-title">
            STEP INTO THE SALE
        </h3>

        <p class="promotion-text">

            Enjoy up to
            <strong>40% OFF</strong>
            curated runner models
            and lifestyle essentials.

        </p>


        <a
            href="${pageContext.request.contextPath}/products"
            class="promotion-button"
            style="display:flex;align-items:center;justify-content:center;margin-left:auto;margin-right:auto;"
        >
            Shop Offers
        </a>


        <span class="promotion-note">
            Code auto-applies at checkout
        </span>

    </section>


    <!-- =========================================
         7. PACELET PROMISE
    ========================================== -->

    <section class="section">

        <div>

            <p class="section-kicker">
                THE PACELET PROMISE
            </p>

            <h2 class="section-title">
                Crafted With Integrity
            </h2>

        </div>


        <div
            class="promise-grid"
            style="margin-top:12px;"
        >

            <div class="promise-card">

                <div class="promise-icon">
                    ✓
                </div>

                <h4 class="promise-title">
                    100% Genuine
                </h4>

                <p class="promise-text">
                    Direct atelier certified footwear.
                </p>

            </div>


            <div class="promise-card">

                <div class="promise-icon">
                    ↗
                </div>

                <h4 class="promise-title">
                    Express Transit
                </h4>

                <p class="promise-text">
                    2-4 days across 18,000+ PIN codes.
                </p>

            </div>


            <div class="promise-card">

                <div class="promise-icon">
                    ↻
                </div>

                <h4 class="promise-title">
                    7-Day Easy Returns
                </h4>

                <p class="promise-text">
                    Doorstep try-on and instant pickups.
                </p>

            </div>


            <div class="promise-card">

                <div class="promise-icon">
                    🔒
                </div>

                <h4 class="promise-title">
                    Secure UPI &amp; COD
                </h4>

                <p class="promise-text">
                    Encrypted instant checkout options.
                </p>

            </div>

        </div>

    </section>


    <!-- =========================================
         8. NEWSLETTER
    ========================================== -->

    <section class="newsletter">

        <div class="mail-icon">
            ✉
        </div>


        <p class="section-kicker">
            PRIVATE RELEASES
        </p>


        <h2 class="section-title">
            Stay In The Pace
        </h2>


        <p class="newsletter-text">

            Receive invitation-only capsule launches,
            architectural retrospectives, and 10% off
            your debut pair.

        </p>


        <form
            class="newsletter-form"
            action="${pageContext.request.contextPath}/newsletter"
            method="post"
        >

            <input
                class="newsletter-input"
                type="email"
                name="email"
                placeholder="Enter your email address"
                required
            >

            <button
                class="newsletter-button"
                type="submit"
            >
                Subscribe to Atelier
            </button>

        </form>

    </section>


    <!-- =========================================
         FOOTER
    ========================================== -->

    <footer class="footer">

        <div class="footer-brand">
            PACELET
        </div>

        <div class="footer-tagline">
            STEP INTO YOUR PACE
        </div>


        <div class="footer-links">

            <a href="#">
                Client Concierge
            </a>

            <a href="#">
                Shipping &amp; Returns
            </a>

            <a href="#">
                Stores
            </a>

            <a href="#">
                Legal Notice
            </a>

        </div>


        <div class="copyright">
            © 2025 Pacelet Atelier. All rights reserved.
        </div>

    </footer>


</div>

<script
    src="${pageContext.request.contextPath}/assets/js/navbar.js">
</script>

</body>

</html>