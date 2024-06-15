<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="model.Utente" %>
<%@ page import="model.Ruolo" %>
<%@ page import="model.Event" %>
<%@ page import="model.EventDAO" %>
<%@ page import="java.util.List" %>
<%
    Utente user = (Utente) session.getAttribute("user");
    if (user == null || !user.getRuolo().equals(Ruolo.ADMIN)) {
        response.sendRedirect("login");
        return;
    }

    EventDAO eventDAO = new EventDAO();
    List<Event> events = eventDAO.getAllEvents();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Gestisci Eventi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/footer.css">
</head>
<body>
    <jsp:include page="/header.jsp" />
    <main>
        <h1>Gestisci Eventi</h1>
        <form action="addEvent" method="post">
            <input type="text" name="nome" placeholder="Nome Evento" required>
            <input type="text" name="luogo" placeholder="Luogo" required>
            <input type="date" name="dataEvento" required>
            <input type="text" name="orario" placeholder="Orario" required>
            <input type="text" name="tipo" placeholder="Tipo Evento" required>
            <input type="number" name="disponibilita" placeholder="Disponibilità" required>
            <button type="submit">Aggiungi Evento</button>
        </form>
        <ul>
            <% for (Event event : events) { %>
                <li>
                    <p>Nome: <%= event.getNome() %></p>
                    <p>Luogo: <%= event.getLuogo() %></p>
                    <p>Data: <%= event.getDataEvento() %></p>
                    <p>Orario: <%= event.getOrario() %></p>
                    <p>Tipo: <%= event.getTipo() %></p>
                    <p>Disponibilità: <%= event.getDisponibilita() %></p>
                    <a href="editEvent?eventId=<%= event.getCodiceEvento() %>">Modifica</a>
                    <a href="deleteEvent?eventId=<%= event.getCodiceEvento() %>">Elimina</a>
                </li>
            <% } %>
        </ul>
    </main>
    <jsp:include page="/footer.jsp" />
</body>
</html>
