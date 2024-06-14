<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/register.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/footer.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    <main>
        <h2>Register</h2>
        <form action="register" method="post">
            <div>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div>
                <label for="name">Nome:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div>
                <label for="surname">Cognome:</label>
                <input type="text" id="surname" name="surname" required>
            </div>
            <div>
                <label for="address">Indirizzo:</label>
                <input type="text" id="address" name="address" required>
            </div>
            <div>
                <label for="phone">Telefono:</label>
                <input type="text" id="phone" name="phone" required>
            </div>
            <div>
                <label for="cardNumber">Numero:</label>
                <input type="text" id="number" name="number" required>
            </div>
                <button type="submit">Registrati</button>
                <button type="reset">Cancella</button>
            <div>
                <%
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null && !errorMessage.isEmpty()) {
                        out.print("<p style='color:red;'>" + errorMessage + "</p>");
                    }
                %>
            </div>
        </form>
    </main>
    <jsp:include page="footer.jsp" />
</body>
</html>


