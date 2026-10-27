
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Pacelet</title>
    
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">


    <style>
       
* {
    box-sizing: border-box;
}

:root {
    --pacelet-black: #060607;
    --pacelet-text: #191c1f;
    --pacelet-muted: #747878;
    --pacelet-border: #e5e7eb;
    --pacelet-background: #f7f9fd;
}

html {
    min-height: 100%;
}

body {
    margin: 0;
    min-height: 100vh;
    min-height: 100dvh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 32px 20px;
    background: var(--pacelet-background);
    color: var(--pacelet-text);
    font-family: 'Inter', Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
}

.login-card {
    width: 100%;
    max-width: 440px;
    padding: 42px;
    background: #fff;
    border: 1px solid #eceef2;
    border-radius: 8px;
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.055);
}

.brand {
    text-align: center;
    font-family: 'Plus Jakarta Sans', Arial, sans-serif;
    font-size: 28px;
    font-weight: 800;
    letter-spacing: 0.16em;
    color: var(--pacelet-black);
}

.brand::after {
    content: "STEP INTO YOUR PACE";
    display: block;
    margin-top: 7px;
    color: #8f7c91;
    font-family: 'Inter', Arial, sans-serif;
    font-size: 9px;
    font-weight: 700;
    letter-spacing: 0.19em;
}

h2 {
    margin: 34px 0 8px;
    text-align: center;
    font-family: 'Plus Jakarta Sans', Arial, sans-serif;
    font-size: clamp(24px, 5vw, 30px);
    line-height: 1.2;
    font-weight: 800;
    letter-spacing: -0.04em;
}

.subtitle {
    margin: 0 0 28px;
    text-align: center;
    color: var(--pacelet-muted);
    font-size: 14px;
    line-height: 1.6;
}

label {
    display: block;
    margin: 18px 0 8px;
    font-size: 13px;
    font-weight: 600;
}

input {
    display: block;
    width: 100%;
    min-width: 0;
    height: 48px;
    padding: 0 14px;
    border: 1px solid #dfe2e7;
    border-radius: 4px;
    background: #fafbfc;
    color: var(--pacelet-text);
    font: inherit;
    font-size: 14px;
    transition: border-color 0.2s ease, background 0.2s ease;
}

input::placeholder {
    color: #92969d;
}

input:focus {
    outline: 2px solid rgba(6, 6, 7, 0.12);
    outline-offset: 1px;
    border-color: var(--pacelet-black);
    background: #fff;
}

button {
    width: 100%;
    min-height: 48px;
    margin-top: 26px;
    padding: 12px 16px;
    border: 1px solid var(--pacelet-black);
    border-radius: 4px;
    background: var(--pacelet-black);
    color: #fff;
    font-family: inherit;
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    cursor: pointer;
    transition: background 0.2s ease, transform 0.2s ease;
}

button:hover {
    background: #333;
}

button:active {
    transform: scale(0.99);
}

.message {
    padding: 12px 14px;
    margin-bottom: 18px;
    border-radius: 4px;
    font-size: 13px;
    line-height: 1.5;
    text-align: center;
}

.error {
    border: 1px solid #fecaca;
    background: #fff1f2;
    color: #b42318;
}

.success {
    border: 1px solid #bbf7d0;
    background: #edf9f0;
    color: #18713a;
}

.links {
    margin-top: 24px;
    text-align: center;
    color: #666;
    font-size: 13px;
    line-height: 1.8;
}

a {
    color: var(--pacelet-black);
    font-weight: 700;
    text-underline-offset: 3px;
}

.links a {
    display: inline-block;
    margin-left: 3px;
}

.back-home {
    display: block;
    margin-top: 24px;
    padding-top: 18px;
    border-top: 1px solid #eceef2;
    color: var(--pacelet-muted);
    font-size: 12px;
    font-weight: 500;
    text-align: center;
    text-decoration: none;
}

.back-home:hover {
    color: var(--pacelet-black);
}

/* Tablet */
@media (max-width: 600px) {
    body {
        padding: 24px 16px;
    }

    .login-card {
        max-width: 440px;
        padding: 32px;
    }
}

/* Small mobile */
@media (max-width: 380px) {
    body {
        padding: 16px 12px;
        align-items: flex-start;
    }

    .login-card {
        padding: 24px 20px;
        margin: auto 0;
    }

    .brand {
        font-size: 24px;
    }

    h2 {
        margin-top: 28px;
    }

    .subtitle {
        margin-bottom: 22px;
    }
}

/* Accessibility */
@media (prefers-reduced-motion: reduce) {
    *,
    *::before,
    *::after {
        transition: none !important;
        scroll-behavior: auto !important;
    }
}

    </style>
</head>

<body>
    <div class="login-card">
        <div class="brand">PACELET</div>

        <h2>Welcome Back</h2>
        <p class="subtitle">Sign in to continue shopping.</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="message error">
                Invalid email or password, or missing required details.
            </div>
        <% } %>

        <% if ("1".equals(request.getParameter("registered"))) { %>
            <div class="message success">
                Registration successful! Please log in.
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login"
              method="post">

            <label for="email">Email Address</label>
            <input type="email"
                   id="email"
                   name="email"
                   placeholder="Enter your email"
                   autocomplete="email"
                   required>

            <label for="password">Password</label>
            <input type="password"
                   id="password"
                   name="password"
                   placeholder="Enter your password"
                   autocomplete="current-password"
                   required>

            <button type="submit">Sign In</button>
        </form>

        <div class="links">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register">
                Create Account
            </a>
        </div>

        <a class="back-home"
           href="${pageContext.request.contextPath}/">
            ← Back to Home
        </a>
    </div>
</body>
</html>
