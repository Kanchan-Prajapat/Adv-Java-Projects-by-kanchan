<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>
    <title>JSP Loop</title>
</head>

<body>

<h1>Student Marks</h1>

<%
    String[] subjects = {"Java", "DBMS", "OS", "Computer Networks"};
    int[] marks = {85, 78, 92, 88};
%>

<ul>

<%
    for (int i = 0; i < subjects.length; i++) {
%>

    <li>
        <%= subjects[i] %> : <%= marks[i] %>
    </li>

<%
    }
%>

</ul>

</body>

</html>