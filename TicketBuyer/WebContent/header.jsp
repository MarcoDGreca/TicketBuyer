<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>   
<%@ page import="model.Utente" %>
<%@ page import="model.Ruolo" %>
<%
    Utente user = (Utente) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TicketBuyer</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <header>
        <div class="auth-links">
            <% if (user != null) { %>
                <a href="${pageContext.request.contextPath}/profile.jsp">Profilo</a>
                <a href="${pageContext.request.contextPath}/orderDetails">Ordini</a>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/login.jsp">Login</a>
                <a href="${pageContext.request.contextPath}/register.jsp">Registrati</a>
            <% } %>
        </div>
        <div class="logo">
            <img src="${pageContext.request.contextPath}/img/logo.png" alt="TicketBuyer Logo">
        </div>
    </header>
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/contact.jsp">Contatti</a></li>
            <li><a href="${pageContext.request.contextPath}/search.jsp">Cerca</a></li>
            <li><a href="${pageContext.request.contextPath}/cart.jsp">Carrello</a></li>
            <% if (user != null && user.getRuolo().equals(Ruolo.ADMIN)) { %>
                <li><a href="${pageContext.request.contextPath}/manageEvents">Gestisci Eventi</a></li>
                <li><a href="${pageContext.request.contextPath}/manageUsers">Gestisci Utenti</a></li>
                <li><a href="${pageContext.request.contextPath}/manageOrders">Gestisci Ordini</a></li>
            <% } %>
        </ul>
    </nav>
</body>
</html>
