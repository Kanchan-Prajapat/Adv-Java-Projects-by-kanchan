<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>

<h1>Login</h1>

<form action="login.jsp" method="post">

    Username:
    <input type="text" name="username">

    <br><br>

    Password:
    <input type="password" name="password">

    <br><br>

    <input type="submit" value="Login">

</form>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {

        if (username.equals("admin") && password.equals("1234")) {

            session.setAttribute("username", username);

            response.sendRedirect("welcome.jsp");

        } else {
%>

            <p>Invalid username or password!</p>

<%
        }
    }
%>

</body>
</html>