<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.Utente" %>
<%@ page import="model.Event" %>
<%@ page import="model.Order" %>
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
                    <a href="${pageContext.request.contextPath}/orderDetails" class="button">Ordini</a>
                </div>
            <% } else { %>
                <p>Benvenuto nel nostro sito. Effettua il <a href="${pageContext.request.contextPath}/login.jsp">login</a> o <a href="${pageContext.request.contextPath}/register.jsp">registrati</a>.</p>
            <% } %>
        </section>
        
        <section class="events-section">
            <h2>Eventi Disponibili</h2>
            <div class="main-content grid">
                <% if (events != null && !events.isEmpty()) { %>
                    <% for (Event event : events) { %>
                        <div class="event grid-item">
                            <div class="event-image-container">
                                <img src="${pageContext.request.contextPath}/img/<%= event.getCodiceEvento() %>.jpeg" alt="<%= event.getNome() %>">
                            </div>
                            <div class="event-details">
                                <h3><%= event.getNome() %></h3>
                                <p><strong>Luogo:</strong> <%= event.getLuogo() %></p>
                                <p><strong>Data:</strong> <%= event.getDataEvento() %></p>
                                <p><strong>Orario:</strong> <%= event.getOrario() %></p>
                                <p><strong>Tipo:</strong> <%= event.getTipo() %></p>
                                <p><strong>Disponibilità:</strong> <%= event.getDisponibilita() %></p>
                                <form action="event" method="get">
                                    <input type="hidden" name="eventId" value="<%= event.getCodiceEvento() %>">
                                    <button type="submit" class="button">Visualizza Evento</button>
                                </form>
                                <form action="cart" method="get">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="ticketId" value="<%= event.getCodiceEvento() %>">
                                    <button type="submit" class="button">Aggiungi al Carrello</button>
                                </form>
                            </div>
                        </div>
                    <% } %>
                <% } else { %>
                    <p>Non ci sono eventi disponibili.</p>
                <% } %>
            </div>
        </section>
        
        <section class="reviews-section">
            <h2>Recensioni Recenti</h2>
            <div class="main-content grid">
                <% if (reviews != null && !reviews.isEmpty()) { %>
                    <% for (Review review : reviews) { %>
                        <div class="review grid-item">
                            <p><strong>Email:</strong> <%= review.getEmailCliente() %></p>
                            <p><strong>Nome Evento:</strong> <%= events.stream().filter(e -> e.getCodiceEvento() == review.getCodiceEvento()).findFirst().orElse(new Event()).getNome() %></p>
                            <p><strong>Voto:</strong> <%= review.getVotazione() %>/10</p>
                            <p><%= review.getTesto() %></p>
                            <p><small><%= review.getDataRecensione() %></small></p>
                            <% if (user != null && user.getEmail().equals(review.getEmailCliente())) { %>
                                <form action="${pageContext.request.contextPath}/deleteReview" method="post" class="delete-review-form">
                                    <input type="hidden" name="reviewId" value="<%= review.getCodiceRecensione() %>">
                                    <button type="submit" class="delete-button">Elimina</button>
                                </form>
                            <% } %>
                        </div>
                    <% } %>
                    <a href="${pageContext.request.contextPath}/addReview" class="button">Aggiungi Recensione</a>
                <% } else { %>
                    <p>Non ci sono recensioni recenti.</p>
                    <a href="${pageContext.request.contextPath}/addReview" class="button">Aggiungi Recensione</a>
                <% } %>
            </div>
        </section>

        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>

