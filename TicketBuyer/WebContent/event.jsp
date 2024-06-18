<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Event" %>
<%@ page import="model.Review" %>
<%@ page import="model.Utente" %>
<%@ page import="java.util.List" %>
<%
    Event event = (Event) request.getAttribute("event");
    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
    Utente user = (Utente) request.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= event != null ? event.getNome() : "Evento non trovato" %></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <div id="page">
        <jsp:include page="header.jsp" />
        <section class="event-details-section">
            <% if (event != null) { %>
                <h2><%= event.getNome() %></h2>
                <img src="${pageContext.request.contextPath}/img/<%= event.getCodiceEvento() %>.jpeg" alt="<%= event.getNome() %>">
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
            <% } else { %>
                <h2>Evento non trovato</h2>
                <p>Ci dispiace, ma l'evento che stai cercando non esiste.</p>
            <% } %>
        </section>
        
        <% if (event != null) { %>
            <section class="reviews-section">
                <h2>Recensioni</h2>
                <div class="main-content">
                    <% if (reviews != null && !reviews.isEmpty()) { %>
                        <% for (Review review : reviews) { %>
                            <div class="review">
                                <p><strong>Email:</strong> <%= review.getEmailCliente() %></p>
                                <p><strong>Nome Evento:</strong> <%= event.getNome() %></p>
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
                        <a href="${pageContext.request.contextPath}/addReview?eventId=<%= event.getCodiceEvento() %>" class="button">Aggiungi Recensione</a>
                    <% } else { %>
                        <p>Non ci sono recensioni per questo evento.</p>
                        <a href="${pageContext.request.contextPath}/addReview?eventId=<%= event.getCodiceEvento() %>" class="button">Aggiungi Recensione</a>
                    <% } %>
                </div>
            </section>
        <% } %>

        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>



