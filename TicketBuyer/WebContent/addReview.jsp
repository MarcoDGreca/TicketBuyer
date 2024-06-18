<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Event" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Utente" %>
<%
    Utente user = (Utente) session.getAttribute("user");
    List<Event> purchasedEvents = (List<Event>) request.getAttribute("purchasedEvents");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inserisci Recensione</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <div id="page">
        <jsp:include page="header.jsp" />
        <section class="review-section">
            <h2>Inserisci una Recensione</h2>
            <% if (purchasedEvents != null && !purchasedEvents.isEmpty()) { %>
                <form action="addReview" method="post">
                    <div>
                        <label for="event">Seleziona Evento:</label>
                        <select name="eventId" id="event" required>
                            <% for (Event event : purchasedEvents) { %>
                                <option value="<%= event.getCodiceEvento() %>"><%= event.getNome() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div>
                        <label for="rating">Votazione:</label>
                        <input type="number" id="rating" name="rating" min="1" max="10" required>
                    </div>
                    <div>
                        <label for="comment">Commento:</label>
                        <textarea id="comment" name="comment" rows="5" required></textarea>
                    </div>
                    <button type="submit">Invia Recensione</button>
                </form>
            <% } else { %>
                <p>Non hai acquistato biglietti per nessun evento.</p>
            <% } %>
        </section>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>
