<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Order" %>
<%@ page import="model.Ticket" %>
<%@ page import="java.util.List" %>
<%
    Order order = (Order) request.getAttribute("order");
    List<Ticket> tickets = (List<Ticket>) request.getAttribute("tickets");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dettagli Ordine</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <div id="page">
        <jsp:include page="header.jsp" />
        <section class="order-details-section">
            <h2>Dettagli Ordine</h2>
            <p><strong>Codice Ordine:</strong> <%= order.getCodiceOrdine() %></p>
            <p><strong>Data:</strong> <%= order.getDataAcquisto() %></p>
            <p><strong>Totale:</strong> €<%= order.getPrezzoTotale() %></p>
            <p><strong>Stato:</strong> <%= order.getStato().getStato() %></p>
            <h3>Biglietti</h3>
            <ul class="ticket-list">
                <% for (Ticket ticket : tickets) { %>
                    <li class="ticket-item">
                        <p><strong>Nome Evento:</strong> <%= ticket.getDescrizione() %></p>
                        <p><strong>Prezzo:</strong> €<%= ticket.getPrezzoUnitario() %></p>
                    </li>
                <% } %>
            </ul>
        </section>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>
