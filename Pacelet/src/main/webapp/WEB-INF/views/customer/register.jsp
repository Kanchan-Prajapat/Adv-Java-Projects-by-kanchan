
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account | Pacelet</title>

    
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

.register-card {
    width: 100%;
    max-width: 460px;
    padding: 40px;
    background: #fff;
    border: 1px solid #eceef2;
    border-radius: 8px;
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.055);
}

.brand {
    font-family: 'Plus Jakarta Sans', Arial, sans-serif;
    font-size: 28px;
    font-weight: 800;
    letter-spacing: 0.16em;
    color: var(--pacelet-black);
}

.tagline {
    margin-top: 7px;
    color: #8f7c91;
    font-size: 9px;
    font-weight: 700;
    letter-spacing: 0.19em;
}

h1 {
    margin: 30px 0 8px;
    font-family: 'Plus Jakarta Sans', Arial, sans-serif;
    font-size: clamp(25px, 5vw, 30px);
    line-height: 1.2;
    font-weight: 800;
    letter-spacing: -0.04em;
}

.subtitle {
    margin: 0 0 24px;
    color: var(--pacelet-muted);
    font-size: 14px;
    line-height: 1.6;
}

label {
    display: block;
    margin: 17px 0 8px;
    font-size: 13px;
    font-weight: 600;
}

input {
    display: block;
    width: 100%;
    min-width: 0;
    height: 46px;
    padding: 0 13px;
    border: 1px solid #dfe2e7;
    border-radius: 4px;
    background: #fafbfc;
    color: var(--pacelet-text);
    font: inherit;
    font-size: 14px;
    transition: border-color 0.2s ease, background 0.2s ease;
}

input:focus {
    outline: 2px solid rgba(6, 6, 7, 0.12);
    outline-offset: 1px;
    border-color: var(--pacelet-black);
    background: #fff;
}

.submit-button {
    width: 100%;
    min-height: 48px;
    margin-top: 25px;
    padding: 12px 16px;
    border: 1px solid var(--pacelet-black);
    border-radius: 4px;
    background: var(--pacelet-black);
    color: #fff;
    font-family: inherit;
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.1em;
    cursor: pointer;
    transition: background 0.2s ease, transform 0.2s ease;
}

.submit-button:hover {
    background: #333;
}

.submit-button:active {
    transform: scale(0.99);
}

.error {
    padding: 12px 14px;
    margin: 16px 0;
    border: 1px solid #fecaca;
    border-radius: 4px;
    background: #fff1f2;
    color: #be123c;
    font-size: 13px;
    line-height: 1.5;
}

.footer {
    margin-top: 24px;
    color: #666;
    font-size: 13px;
    line-height: 1.8;
    text-align: center;
}

.footer a {
    color: var(--pacelet-black);
    font-weight: 700;
    text-underline-offset: 3px;
}

@media (max-width: 600px) {
    body {
        padding: 24px 16px;
    }

    .register-card {
        max-width: 460px;
        padding: 30px;
    }
}

@media (max-width: 380px) {
    body {
        padding: 14px 12px;
        align-items: flex-start;
    }

    .register-card {
        padding: 24px 20px;
        margin: auto 0;
    }

    .brand {
        font-size: 24px;
    }

    h1 {
        margin-top: 24px;
    }

    .subtitle {
        margin-bottom: 20px;
    }
}

@media (prefers-reduced-motion: reduce) {
    *,
    *::before,
    *::after {
        transition: none !important;
    }
}

    </style>
</head>

<body>
    <main class="register-card">

        <div class="brand">PACELET</div>
        <div class="tagline">STEP INTO YOUR PACE</div>

        <h1>Create your account</h1>
        <p class="subtitle">
            Join Pacelet and find your perfect pace.
        </p>

      
<% if (request.getAttribute("error") != null) { %>
    <div class="error">
        Please check your details and try again.
    </div>
<% } %>

        <form action="${pageContext.request.contextPath}/register"
              method="post">

            <label for="fullName">Full name</label>
            <input type="text"
                   id="fullName"
                   name="fullName"
                   autocomplete="name"
                   maxlength="100"
                   required>

            <label for="email">Email address</label>
            <input type="email"
                   id="email"
                   name="email"
                   autocomplete="email"
                   maxlength="150"
                   required>

            <label for="phone">Mobile number</label>
            <input type="tel"
                   id="phone"
                   name="phone"
                   autocomplete="tel"
                   maxlength="20"
                   required>

            <label for="password">Password</label>
            <input type="password"
                   id="password"
                   name="password"
                   autocomplete="new-password"
                   minlength="8"
                   required>

            <label for="confirmPassword">Confirm password</label>
            <input type="password"
                   id="confirmPassword"
                   name="confirmPassword"
                   autocomplete="new-password"
                   minlength="8"
                   required>

            <button class="submit-button" type="submit">
                CREATE ACCOUNT
            </button>
        </form>

        <div class="footer">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">Sign in</a>
        </div>

    </main>
</body>
</html>
