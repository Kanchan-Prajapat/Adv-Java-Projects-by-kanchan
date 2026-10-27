<%@ page contentType="text/html;charset=UTF-8" %>

<!-- Material Symbols -->
<link
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
    rel="stylesheet"
>

<header class="pacelet-navbar">

    <div class="navbar-container">

        <!-- Mobile Menu -->
        <button
            type="button"
            class="nav-icon-button mobile-menu-button"
            aria-label="Open navigation menu"
            onclick="toggleMobileMenu()">

            <span class="material-symbols-outlined">
                menu
            </span>

        </button>


        <!-- Logo -->
        <a
            href="${pageContext.request.contextPath}/"
            class="pacelet-brand">

            <img
                src="${pageContext.request.contextPath}/assets/images/pacelet-logo.png"
                alt="Pacelet"
                class="pacelet-logo"
            />

            <div class="brand-text">

                <span class="brand-name">
                    PACELET
                </span>

                <span class="brand-tagline">
                    STEP INTO YOUR PACE
                </span>

            </div>

        </a>


        <!-- Desktop Navigation -->
        <nav class="desktop-navigation">

            <a href="${pageContext.request.contextPath}/">
                Home
            </a>

            <a href="${pageContext.request.contextPath}/shop">
                Shop
            </a>

            <a href="${pageContext.request.contextPath}/shop?category=men">
                Men
            </a>

            <a href="${pageContext.request.contextPath}/shop?category=women">
                Women
            </a>

            <a href="${pageContext.request.contextPath}/shop?category=sports">
                Sports
            </a>

            <a href="${pageContext.request.contextPath}/shop?filter=new">
                New Arrivals
            </a>

            <a href="${pageContext.request.contextPath}/offers">
                Offers
            </a>

        </nav>


        <!-- Right Actions -->
        <div class="navbar-actions">

            <!-- Search -->
            <a
                href="${pageContext.request.contextPath}/search"
                class="nav-icon-button"
                aria-label="Search">

                <span class="material-symbols-outlined">
                    search
                </span>

            </a>


            <!-- Wishlist -->
            <a
                href="${pageContext.request.contextPath}/wishlist"
                class="nav-icon-button nav-badge-wrapper"
                aria-label="Wishlist">

                <span class="material-symbols-outlined">
                    favorite
                </span>

                <span
                    id="wishlistCount"
                    class="nav-count">
                    0
                </span>

            </a>


            <!-- Cart -->
            <a
                href="${pageContext.request.contextPath}/cart"
                class="nav-icon-button nav-badge-wrapper"
                aria-label="Shopping bag">

                <span class="material-symbols-outlined">
                    shopping_bag
                </span>

                <span
                    id="cartCount"
                    class="nav-count">
                    0
                </span>

            </a>


        
            <!-- Profile / Login -->
            <%
                Object loggedInUser = session.getAttribute("userId");
                String loggedInName =
                    (String) session.getAttribute("userName");
            %>

            <% if (loggedInUser != null) { %>

                <a
                    href="${pageContext.request.contextPath}/profile"
                    class="profile-button"
                    aria-label="Profile">

                    <span class="material-symbols-outlined">
                        person
                    </span>
                </a>

                <span class="brand-name">
                    <%= loggedInName != null ? loggedInName : "My Account" %>
                </span>

                <a href="${pageContext.request.contextPath}/logout"
                   class="nav-icon-button"
                   aria-label="Logout"
                   title="Logout">

                    <span class="material-symbols-outlined">
                        logout
                    </span>
                </a>

            <% } else { %>

                <a
                    href="${pageContext.request.contextPath}/login"
                    class="profile-button"
                    aria-label="Login"
                    title="Login">

                    <span class="material-symbols-outlined">
                        person
                    </span>
                </a>

                <a
                    href="${pageContext.request.contextPath}/register"
                    class="nav-icon-button"
                    aria-label="Create account"
                    title="Create account">

                    <span class="material-symbols-outlined">
                        person_add
                    </span>
                </a>

            <% } %>

        </div>

    </div>


   
<!-- Mobile Navigation Overlay -->
<div
    id="mobileMenuOverlay"
    class="mobile-menu-overlay"
    onclick="closeMobileMenu()">
</div>

<!-- Mobile Navigation Drawer -->
<div
    id="mobileMenu"
    class="mobile-menu"
    role="dialog"
    aria-modal="true"
    aria-label="Mobile navigation"
    aria-hidden="true">

    <div class="mobile-menu-header">
        <span>MENU</span>

        <button
            type="button"
            class="nav-icon-button"
            onclick="closeMobileMenu()"
            aria-label="Close navigation menu">

            <span class="material-symbols-outlined">close</span>
        </button>
    </div>

    <nav class="mobile-navigation">
        <a href="${pageContext.request.contextPath}/">Home</a>
        <a href="${pageContext.request.contextPath}/shop">Shop</a>
        <a href="${pageContext.request.contextPath}/shop?category=men">Men</a>
        <a href="${pageContext.request.contextPath}/shop?category=women">Women</a>
        <a href="${pageContext.request.contextPath}/shop?category=sports">Sports</a>
        <a href="${pageContext.request.contextPath}/shop?filter=new">New Arrivals</a>
        <a href="${pageContext.request.contextPath}/offers">Offers</a>
    </nav>

    <div class="mobile-account-navigation">
        <a href="${pageContext.request.contextPath}/wishlist">
            <span class="material-symbols-outlined">favorite</span>
            Wishlist
        </a>

        <a href="${pageContext.request.contextPath}/cart">
            <span class="material-symbols-outlined">shopping_bag</span>
            Shopping Bag
        </a>

        <% if (loggedInUser != null) { %>
            <a href="${pageContext.request.contextPath}/profile">
                <span class="material-symbols-outlined">person</span>
                My Account
            </a>

            <a href="${pageContext.request.contextPath}/logout">
                <span class="material-symbols-outlined">logout</span>
                Logout
            </a>
        <% } else { %>
            <a href="${pageContext.request.contextPath}/login">
                <span class="material-symbols-outlined">login</span>
                Login
            </a>

            <a href="${pageContext.request.contextPath}/register">
                <span class="material-symbols-outlined">person_add</span>
                Create Account
            </a>
        <% } %>
    </div>
</div>


</header>