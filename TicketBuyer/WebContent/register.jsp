<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrazione</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
    <script src="${pageContext.request.contextPath}/scripts/validation.js" defer></script>
</head>
<body>
    <div id="page">
        <jsp:include page="header.jsp" />
        <section>
            <h2>Registrazione</h2>
            <form id="registrationForm" action="register" method="post">
                <div>
                    <label for="nome">Nome:</label>
                    <input type="text" id="nome" name="nome" required>
                    <span class="error" id="errNome"></span>
                </div>
                <div>
                    <label for="cognome">Cognome:</label>
                    <input type="text" id="cognome" name="cognome" required>
                    <span class="error" id="errCognome"></span>
                </div>
                <div>
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>
                    <span class="error" id="errEmail"></span>
                </div>
                <div>
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                    <span class="error" id="errPassword"></span>
                </div>
                <div>
                    <button type="submit">Registrati</button>
                </div>
            </form>
        </section>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>
