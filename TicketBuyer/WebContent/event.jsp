<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="model.Event,model.Ticket,model.*, java.util.*" %>
<%
    int eventId = Integer.parseInt(request.getParameter("eventId"));
    EventDAO eventDAO = new EventDAO();
    Event event = eventDAO.getEventById(eventId);
    TicketDAO ticketDAO = new TicketDAO();
    List<Ticket> tickets = ticketDAO.getTicketsByEventId(eventId);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title><%= event.getNome() %></title>
    <link href="${pageContext.request.contextPath}/styles/style.css" rel="stylesheet" type="text/css">
</head>
<body>

    <jsp:include page="header.jsp" />

    <div id="main" class="clear">
        <section class="event-details">
            <h2><%= event.getNome() %></h2>
            <p><strong>Luogo:</strong> <%= event.getLuogo() %></p>
            <p><strong>Data:</strong> <%= event.getDataEvento() %></p>
            <p><strong>Orario:</strong> <%= event.getOrario() %></p>
            <p><strong>Tipo:</strong> <%= event.getTipo() %></p>
            <p><strong>Disponibilità:</strong> <%= event.getDisponibilita() %></p>
        </section>

        <section class="tickets">
            <h3>Biglietti Disponibili</h3>
            <ul>
                <% for (Ticket ticket : tickets) { %>
                    <li>
                        <p><strong>Tipo:</strong> <%= ticket.getTipo() %></p>
                        <p><strong>Descrizione:</strong> <%= ticket.getDescrizione() %></p>
                        <p><strong>Prezzo:</strong> &euro;<%= ticket.getPrezzoUnitario() %></p>
                        <form action="cart" method="post">
                            <input type="hidden" name="ticketId" value="<%= ticket.getCodiceBiglietto() %>">
                            <button type="submit" name="action" value="add">Aggiungi al Carrello</button>
                        </form>
                    </li>
                <% } %>
            </ul>
        </section>
    </div>

    <jsp:include page="footer.jsp" />

</body>
</html>
