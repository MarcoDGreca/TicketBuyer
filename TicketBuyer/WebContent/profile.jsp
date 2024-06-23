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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <div>
        <jsp:include page="header.jsp" />
        <section>
            <h2>Profilo Utente</h2>
            <form id="profileForm" action="profile" method="post">
                <div class="profile">
                    <div>
                        <label for="email">Email:</label>
                        <input type="text" id="email" name="email" value="<%= user.getEmail() %>" readonly>
                    </div>
                    <div>
                        <label for="nome">Nome:</label>
                        <input type="text" id="nome" name="nome" value="<%= user.getNome() %>" required>
                        <span class="error" id="errNome"></span>
                    </div>
                    <div>
                        <label for="cognome">Cognome:</label>
                        <input type="text" id="cognome" name="cognome" value="<%= user.getCognome() %>" required>
                        <span class="error" id="errCognome"></span>
                    </div>
                    <div>
                        <label for="indirizzo">Indirizzo:</label>
                        <input type="text" id="indirizzo" name="indirizzo" value="<%= user.getIndirizzo() %>" required>
                        <span class="error" id="errIndirizzo"></span>
                    </div>
                    <div>
                        <label for="telefono">Telefono:</label>
                        <input type="text" id="telefono" name="telefono" value="<%= user.getTelefono() %>" required>
                        <span class="error" id="errTelefono"></span>
                    </div>
                    <div>
                        <button type="submit">Salva Modifiche</button>
                    </div>
                </div>
            </form>
        </section>
        <aside>

        </aside>
        <jsp:include page="footer.jsp" />
    </div>
    <script src="${pageContext.request.contextPath}/scripts/validation.js" defer></script>
</body>
</html>
