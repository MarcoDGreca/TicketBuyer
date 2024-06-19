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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <jsp:include page="/header.jsp" />
    <div class="table-container">
        <h1>Gestisci Utenti</h1>
        <table>
            <tr>
                <th>Email</th>
                <th>Nome</th>
                <th>Cognome</th>
                <th>Ruolo</th>
                <th>Azioni</th>
            </tr>
            <% for (Utente user : users) { %>
                <tr>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getNome() %></td>
                    <td><%= user.getCognome() %></td>
                    <td><%= user.getRuolo() %></td>
                    <td>
                        <form action="manageUsers" method="post" style="display:inline;">
                            <input type="hidden" name="email" value="<%= user.getEmail() %>">
                            <input type="hidden" name="action" value="delete">
                            <button type="submit" class="button">Elimina</button>
                        </form>
                        <form action="manageUsers" method="post" style="display:inline;">
                            <input type="hidden" name="email" value="<%= user.getEmail() %>">
                            <input type="hidden" name="action" value="promote">
                            <button type="submit" class="button">Promuovi a Admin</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
    </div>
    <jsp:include page="/footer.jsp" />
</body>
</html>

