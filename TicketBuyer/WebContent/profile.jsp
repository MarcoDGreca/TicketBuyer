<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="model.Utente" %>
<%
    Utente user = (Utente) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profilo</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <div id="page">
        <jsp:include page="header.jsp" />
        <section>
            <h2>Profilo Utente</h2>
            <div class="profile">
                <div>
                    <label for="email">Email:</label>
                    <input type="text" id="email" value="<%= user.getEmail() %>" readonly>
                </div>
                <div>
                    <label for="nome">Nome:</label>
                    <input type="text" id="nome" value="<%= user.getNome() %>" readonly>
                </div>
                <div>
                    <label for="cognome">Cognome:</label>
                    <input type="text" id="cognome" value="<%= user.getCognome() %>" readonly>
                </div>
                <div>
                    <label for="indirizzo">Indirizzo:</label>
                    <input type="text" id="indirizzo" value="<%= user.getIndirizzo() %>" readonly>
                </div>
                <div>
                    <label for="telefono">Telefono:</label>
                    <input type="text" id="telefono" value="<%= user.getTelefono() %>" readonly>
                </div>
            </div>
        </section>
        <aside>

        </aside>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>


