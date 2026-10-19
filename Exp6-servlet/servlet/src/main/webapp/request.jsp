<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>
    <title>Request Object</title>
</head>

<body>

<h1>Student Registration</h1>

<form action="request.jsp" method="post">

    Name:
    <input type="text" name="name">

    <br><br>

    Email:
    <input type="email" name="email">

    <br><br>

    Age:
    <input type="number" name="age">

    <br><br>

    <input type="submit" value="Register">

</form>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String age = request.getParameter("age");

    if (name != null && email != null && age != null) {
%>

    <hr>

    <h2>Student Information</h2>

    <p>Name: <%= name %></p>
    <p>Email: <%= email %></p>
    <p>Age: <%= age %></p>

<%
    }
%>

</body>

</html>