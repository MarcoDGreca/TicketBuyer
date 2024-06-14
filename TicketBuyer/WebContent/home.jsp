<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.util.List" %>
<%@ page import="model.Event" %>
<%@ page import="model.EventDAO" %>

<%@ page import="model.Event" %>
<%@ page import="model.Ticket" %>
<%@ page import="model.TicketDAO" %>
<%@ page import="java.util.List" %>
<%
    List<Event> events = (List<Event>) request.getAttribute("events");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/footer.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    <main>
        <h1>Eventi Disponibili</h1>
        <div class="event-list">
            <% if (events != null && !events.isEmpty()) { %>
                <% for (Event event : events) { %>
                    <div class="event">
                        <h2><%= event.getNome() %></h2>
                        <p><strong>Luogo:</strong> <%= event.getLuogo() %></p>
                        <p><strong>Data:</strong> <%= event.getDataEvento() %></p>
                        <p><strong>Orario:</strong> <%= event.getOrario() %></p>
                        <p><strong>Tipo:</strong> <%= event.getTipo() %></p>
                        <p><strong>Disponibilità:</strong> <%= event.getDisponibilita() %></p>
                        <%
                            List<Ticket> tickets = new TicketDAO().getTicketsByEventId(event.getCodiceEvento());
                            if (tickets != null && !tickets.isEmpty()) {
                        %>
                            <h3>Biglietti Disponibili</h3>
                            <ul>
                                <% for (Ticket ticket : tickets) { %>
                                    <li>
                                        <p>Tipo: <%= ticket.getTipo() %></p>
                                        <p>Descrizione: <%= ticket.getDescrizione() %></p>
                                        <p>Prezzo: <%= ticket.getPrezzoUnitario() %> EUR</p>
                                        <a href="cart?action=add&ticketId=<%= ticket.getCodiceBiglietto() %>">Aggiungi al Carrello</a>
                                    </li>
                                <% } %>
                            </ul>
                        <%
                            } else {
                                out.println("<p>Non ci sono biglietti disponibili per questo evento.</p>");
                            }
                        %>
                    </div>
                <% } %>
            <% } else { %>
                <p>Non ci sono eventi disponibili.</p>
            <% } %>
        </div>
    </main>
    <jsp:include page="footer.jsp" />
</body>
</html>

