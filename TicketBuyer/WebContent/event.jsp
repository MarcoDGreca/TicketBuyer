<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.Event" %>
<%@ page import="model.Ticket" %>
<%@ page import="java.util.List" %>
<%
    Event event = (Event) request.getAttribute("event");
    List<Ticket> tickets = (List<Ticket>) request.getAttribute("tickets");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= event.getNome() %></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <div id="page">
        <jsp:include page="header.jsp" />
        <section class="event-section">
            <h1><%= event.getNome() %></h1>
            <p><strong>Luogo:</strong> <%= event.getLuogo() %></p>
            <p><strong>Data:</strong> <%= event.getDataEvento() %></p>
            <p><strong>Orario:</strong> <%= event.getOrario() %></p>
            <p><strong>Tipo:</strong> <%= event.getTipo() %></p>
            <p><strong>Disponibilità:</strong> <%= event.getDisponibilita() %></p>
            <h2>Biglietti Disponibili</h2>
            <% for (Ticket ticket : tickets) { %>
                <div class="ticket">
                    <p><strong>Tipo:</strong> <%= ticket.getTipo() %></p>
                    <p><strong>Prezzo:</strong> <%= ticket.getPrezzoUnitario() %> €</p>
                    <form action="cart" method="get">
                        <input type="hidden" name="actionC" value="add">
                        <input type="hidden" name="ticketId" value="<%= ticket.getCodiceBiglietto() %>">
                        <button type="submit" class="button">Aggiungi al Carrello</button>
                    </form>
                </div>
            <% } %>
        </section>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>
