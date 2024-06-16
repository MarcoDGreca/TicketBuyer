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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
                    <a href="${pageContext.request.contextPath}/profile.jsp" class="button">Profilo</a>
                    <a href="${pageContext.request.contextPath}/orders.jsp" class="button">Ordini</a>
                </div>
            <% } else { %>
                <p>Benvenuto nel nostro sito. Effettua il <a href="${pageContext.request.contextPath}/login.jsp">login</a> o <a href="${pageContext.request.contextPath}/register.jsp">registrati</a>.</p>
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
                            <form action="cart" method="get">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="ticketId" value="<%= event.getCodiceEvento() %>">
                                <button type="submit" class="button">Aggiungi al Carrello</button>
                            </form>
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
                            <p><strong>Nome Evento:</strong> <%= events.stream().filter(e -> e.getCodiceEvento() == review.getCodiceEvento()).findFirst().orElse(new Event()).getNome() %></p>
                            <p><strong>Voto:</strong> <%= review.getVotazione() %>/10</p>
                            <p><%= review.getTesto() %></p>
                            <p><small><%= review.getdataRecensione() %></small></p>
                        </div>
                    <% } %>
                    <a href="${pageContext.request.contextPath}/addReview.jsp" class="button">Aggiungi Recensione</a>
                <% } else { %>
                    <p>Non ci sono recensioni recenti.</p>
                    <a href="${pageContext.request.contextPath}/addReview.jsp" class="button">Aggiungi Recensione</a>
                <% } %>
            </div>
        </section>
        
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>
