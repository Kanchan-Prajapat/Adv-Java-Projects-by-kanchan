<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
</head>
<body>

<%
    String username = (String) session.getAttribute("username");
%>

<h1>Welcome, <%= username %>!</h1>

<p>You are successfully logged in.</p>

</body>
</html>