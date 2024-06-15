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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <header>
        <div class="auth-links">
            <% if (user != null) { %>
                <a href="profile.jsp">Profilo</a>
                <a href="orders.jsp">Ordini</a>
                <a href="logout">Logout</a>
            <% } else { %>
                <a href="login.jsp">Login</a>
                <a href="register.jsp">Registrati</a>
            <% } %>
            <a href="cart">Carrello</a>
        </div>
        <div class="logo">
            <img src="${pageContext.request.contextPath}/img/logo.png" alt="TicketBuyer Logo">
        </div>
    </header>
    <nav>
        <ul>
            <li><a href="home.jsp">Home</a></li>
            <li><a href="contact.jsp">Contatti</a></li>
            <li><a href="search.jsp">Cerca</a></li>
            <% if (user != null && user.getRuolo().equals(Ruolo.ADMIN)) { %>
                <li><a href="admin/manageEvents.jsp">Gestisci Eventi</a></li>
                <li><a href="admin/manageUsers.jsp">Gestisci Utenti</a></li>
            <% } %>
        </ul>
    </nav>
</body>
</html>

