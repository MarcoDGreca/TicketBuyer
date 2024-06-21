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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            <h2>Biglietti Disponibili</h2>
            <% for (Ticket ticket : tickets) { %>
                <div class="ticket">
                    <p><strong>Tipo:</strong> <%= ticket.getTipo() %></p>
                    <p><strong>Prezzo:</strong> <%= ticket.getPrezzoUnitario() %> &euro;</p>
                    <form action="cart" method="post">
                       <input type="hidden" name="action" value="add">
                       <input type="hidden" name="ticketId" value="<%= ticket.getCodiceBiglietto() %>">
                       <input type="hidden" name="qnt" value="1">
                       <button type="submit">Aggiungi al Carrello (Tipo: <%= ticket.getTipo() %> Prezzo: <%= ticket.getPrezzoUnitario() %>)</button>
                    </form>
                </div>
            <% } %>
        </section>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>
