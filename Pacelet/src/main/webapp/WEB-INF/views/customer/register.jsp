
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account | Pacelet</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
            background: #f7f9fd;
            color: #191c1f;
            font-family: Arial, sans-serif;
        }

        .register-card {
            width: 100%;
            max-width: 440px;
            padding: 36px;
            background: white;
            border: 1px solid #eceef2;
            box-shadow: 0 8px 35px rgba(0,0,0,.06);
        }

        .brand {
            font-size: 26px;
            font-weight: 800;
            letter-spacing: 4px;
        }

        .tagline {
            margin-top: 5px;
            color: #747878;
            font-size: 11px;
            letter-spacing: 2px;
        }

        h1 {
            margin: 32px 0 8px;
            font-size: 27px;
        }

        .subtitle {
            margin: 0 0 24px;
            color: #666;
            font-size: 14px;
        }

        label {
            display: block;
            margin: 16px 0 7px;
            font-size: 13px;
            font-weight: 600;
        }

        input {
            width: 100%;
            height: 44px;
            padding: 0 12px;
            border: 1px solid #dfe2e7;
            background: #fafbfc;
            font-size: 14px;
        }

        input:focus {
            outline: 2px solid #c4b5fd;
            border-color: #6d28d9;
        }

        .submit-button {
            width: 100%;
            height: 46px;
            margin-top: 24px;
            border: none;
            background: #060607;
            color: white;
            font-weight: 700;
            letter-spacing: 1px;
            cursor: pointer;
        }

        .submit-button:hover {
            background: #333;
        }

        .error {
            padding: 12px;
            margin: 16px 0;
            background: #fff1f2;
            color: #be123c;
            font-size: 13px;
        }

        .footer {
            margin-top: 22px;
            text-align: center;
            color: #666;
            font-size: 13px;
        }

        .footer a {
            color: #060607;
            font-weight: 700;
        }

        @media (max-width: 480px) {
            .register-card {
                padding: 24px;
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
