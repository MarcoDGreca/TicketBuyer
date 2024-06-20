<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.Event" %>
<%@ page import="java.util.List" %>
<%
    List<Event> events = (List<Event>) request.getAttribute("events");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestione Eventi</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <jsp:include page="/header.jsp" />
    <div class="main-content">
        <h1>Gestione Eventi</h1>
        <a href="${pageContext.request.contextPath}/admin/addEvent.jsp" class="button">Aggiungi Nuovo Evento</a>
        <table class="styled-table">
            <thead>
                <tr>
                    <th>Nome</th>
                    <th>Luogo</th>
                    <th>Data</th>
                    <th>Orario</th>
                    <th>Tipo</th>
                    <th>Disponibilità</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <% if (events != null && !events.isEmpty()) { %>
                    <% for (Event event : events) { %>
                        <tr>
                            <td><%= event.getNome() %></td>
                            <td><%= event.getLuogo() %></td>
                            <td><%= event.getDataEvento() %></td>
                            <td><%= event.getOrario() %></td>
                            <td><%= event.getTipo() %></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/updateEvent?id=<%= event.getCodiceEvento() %>" class="button">Modifica</a>
                                <form action="${pageContext.request.contextPath}/manageEvents?action=delete" method="post" style="display:inline;">
                                    <input type="hidden" name="eventID" value="<%= event.getCodiceEvento() %>">
                                    <button type="submit" class="button">Elimina</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                <% } else { %>
                    <tr>
                        <td colspan="7">Nessun evento disponibile.</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <jsp:include page="/footer.jsp" />
</body>
</html>



