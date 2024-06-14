<%@ page import="model.Utente" %>
<%@ page import="model.Ruolo" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    
<%@ page import="model.Utente" %>
<%@ page import="model.Ruolo" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styles/header.css">
</head>
<body>
    <header>
        <div class="logo">
            <img src="images/logo.png" alt="Logo">
        </div>
        <div class="auth-links">
            <% 
                Utente user = (Utente) session.getAttribute("user");
                if (user != null) {
            %>
                <a href="logout">Logout</a>
            <% 
                } else { 
            %>
                <a href="login.jsp">Login</a>
                <a href="register.jsp">Registrati</a>
            <% 
                } 
            %>
        </div>
    </header>
    <nav>
        <ul>
            <li><a href="home.jsp">Home</a></li>
            <li><a href="events.jsp">Eventi</a></li>
            <% 
                if (user != null) {
            %>
                <li><a href="profile.jsp">Profilo</a></li>
                <li><a href="orders.jsp">Ordini</a></li>
                <li><a href="cart.jsp">Carrello</a></li>
            <% 
                    if (user.getRuolo().equals(Ruolo.ADMIN)) {
            %>
                <li><a href="admin/manageUsers.jsp">Gestisci Utenti</a></li>
                <li><a href="admin/manageOrders.jsp">Gestisci Ordini</a></li>
                <li><a href="admin/manageEvents.jsp">Gestisci Eventi</a></li>
            <% 
                    } 
                } else { 
            %>
                <li><a href="contact.jsp">Contatti</a></li>
            <% 
                } 
            %>
        </ul>
    </nav>
</body>
</html>

