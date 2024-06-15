<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="model.Utente" %>
<%@ page import="model.Event" %>
<%@ page import="model.Review" %>
<%@ page import="java.util.List" %>
<%
    Utente user = (Utente) session.getAttribute("user");
    List<Event> events = (List<Event>) request.getAttribute("events");
    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <div id="page">
        <jsp:include page="header.jsp" />
        <section class="welcome-section">
            <h1>Benvenuto</h1>
            <% if (user != null) { %>
                <p>Ciao, <%= user.getNome() %> <%= user.getCognome() %>! Bentornato!</p>
                <div class="welcome-buttons">
                    <a href="profile" class="button">Profilo</a>
                    <a href="orders" class="button">Ordini</a>
                </div>
            <% } else { %>
                <p>Benvenuto nel nostro sito. Effettua il <a href="login.jsp">login</a> o <a href="register.jsp">registrati</a>.</p>
            <% } %>
        </section>
        
        <section class="events-section">
            <h2>Eventi Disponibili</h2>
            <div class="main-content">
                <% if (events != null && !events.isEmpty()) { %>
                    <% for (Event event : events) { %>
                        <div class="event">
                            <img src="${pageContext.request.contextPath}/img/event<%= event.getCodiceEvento() %>.jpg" alt="<%= event.getNome() %>">
                            <h3><%= event.getNome() %></h3>
                            <p><strong>Luogo:</strong> <%= event.getLuogo() %></p>
                            <p><strong>Data:</strong> <%= event.getDataEvento() %></p>
                            <p><strong>Orario:</strong> <%= event.getOrario() %></p>
                            <p><strong>Tipo:</strong> <%= event.getTipo() %></p>
                            <p><strong>Disponibilità:</strong> <%= event.getDisponibilita() %></p>
                            <a href="addToCart?eventId=<%= event.getCodiceEvento() %>" class="button">Aggiungi al Carrello</a>
                        </div>
                    <% } %>
                <% } else { %>
                    <p>Non ci sono eventi disponibili.</p>
                <% } %>
            </div>
        </section>
        
        <section class="reviews-section">
            <h2>Recensioni Recenti</h2>
            <div class="main-content">
                <% if (reviews != null && !reviews.isEmpty()) { %>
                    <% for (Review review : reviews) { %>
                        <div class="review">
                            <p><strong>Email:</strong> <%= review.getEmailCliente() %></p>
                            <p><strong>Nome Evento:</strong> <%= events.stream().filter(e -> e.getCodiceEvento() == review.getCodiceEvento()).findFirst().get().getNome() %></p>
                            <p><strong>Voto:</strong> <%= review.getVotazione() %>/10</p>
                            <p><%= review.getTesto() %></p>
                            <p><small><%= review.getdataRecensione() %></small></p>
                        </div>
                    <% } %>
                    <a href="addReview" class="button">Aggiungi Recensione</a>
                <% } else { %>
                    <p>Non ci sono recensioni recenti.</p>
                    <a href="addReview" class="button">Aggiungi Recensione</a>
                <% } %>
            </div>
        </section>
        
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>





