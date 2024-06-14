<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="model.Utente" %>
<%@ page import="model.UtenteDAO" %>

<%
    Utente user = (Utente) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profilo</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/profile.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/footer.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    <main>
        <h1>Il tuo Profilo</h1>
        <form action="profile" method="post">
            <div>
                <label for="name">Nome:</label>
                <input type="text" id="name" name="name" value="<%= user.getNome() %>" required>
            </div>
            <div>
                <label for="surname">Cognome:</label>
                <input type="text" id="surname" name="surname" value="<%= user.getCognome() %>" required>
            </div>
            <div>
                <label for="address">Indirizzo:</label>
                <input type="text" id="address" name="address" value="<%= user.getIndirizzo() %>" required>
            </div>
            <div>
                <label for="phone">Telefono:</label>
                <input type="text" id="phone" name="phone" value="<%= user.getTelefono() %>" required>
            </div>
            <div>
                <button type="submit">Aggiorna Profilo</button>
            </div>
        </form>
    </main>
    <jsp:include page="footer.jsp" />
</body>
</html>
