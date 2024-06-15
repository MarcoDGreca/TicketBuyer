<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="model.Utente" %>
<%@ page import="model.Ruolo" %>
    
<%
    Utente user = (Utente) session.getAttribute("user");
    if (user == null || !user.getRuolo().equals(Ruolo.ADMIN)) {
        response.sendRedirect("login");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>