<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.Utente" %>
<%@ page import="java.util.List" %>
<%
    List<Utente> users = (List<Utente>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestisci Utenti</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <jsp:include page="/header.jsp" />
    <div class="user-management-container">
        <h1>Gestisci Utenti</h1>
        <table class="user-table">
            <thead>
                <tr>
                    <th>Email</th>
                    <th>Nome</th>
                    <th>Cognome</th>
                    <th>Ruolo</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <% if (users != null && !users.isEmpty()) { %>
                    <% for (Utente user : users) { %>
                        <tr>
                            <td><%= user.getEmail() %></td>
                            <td><%= user.getNome() %></td>
                            <td><%= user.getCognome() %></td>
                            <td><%= user.getRuolo() %></td>
                            <td class="user-actions">
                                <form action="manageUsers" method="post" style="display:inline;">
                                    <input type="hidden" name="email" value="<%= user.getEmail() %>">
                                    <input type="hidden" name="action" value="delete">
                                    <button type="submit" class="user-action-button">Elimina</button>
                                </form>
                                <form action="manageUsers" method="post" style="display:inline;">
                                    <input type="hidden" name="email" value="<%= user.getEmail() %>">
                                    <input type="hidden" name="action" value="promote">
                                    <button type="submit" class="user-action-button">Promuovi ad Admin</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                <% } else { %>
                    <tr>
                        <td colspan="5">Nessun utente disponibile.</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <jsp:include page="/footer.jsp" />
</body>
</html>
