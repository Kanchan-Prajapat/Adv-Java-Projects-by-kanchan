
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Pacelet</title>

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
            padding: 20px;
            background: #f7f5f2;
            font-family: Arial, sans-serif;
            color: #292929;
        }

        .login-card {
            width: 100%;
            max-width: 420px;
            padding: 38px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
        }

        .brand {
            text-align: center;
            font-size: 30px;
            font-weight: bold;
            letter-spacing: 2px;
            margin-bottom: 10px;
        }

        h2 {
            text-align: center;
            margin: 20px 0 8px;
        }

        .subtitle {
            text-align: center;
            color: #777;
            font-size: 14px;
            margin-bottom: 28px;
        }

        label {
            display: block;
            margin: 16px 0 7px;
            font-size: 14px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 13px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
        }

        input:focus {
            outline: none;
            border-color: #292929;
        }

        button {
            width: 100%;
            padding: 14px;
            margin-top: 24px;
            border: none;
            border-radius: 8px;
            background: #292929;
            color: white;
            font-size: 15px;
            cursor: pointer;
        }

        button:hover {
            background: #444;
        }

        .message {
            padding: 11px;
            margin-bottom: 16px;
            border-radius: 7px;
            font-size: 13px;
            text-align: center;
        }

        .error {
            background: #fff0f0;
            color: #b42318;
        }

        .success {
            background: #edf9f0;
            color: #18713a;
        }

        .links {
            text-align: center;
            margin-top: 22px;
            font-size: 14px;
        }

        a {
            color: #292929;
            font-weight: bold;
        }

        .back-home {
            display: block;
            margin-top: 18px;
            text-align: center;
            font-size: 13px;
            color: #777;
            text-decoration: none;
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
