<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrazione</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    <main>
        <h2>Registrazione</h2>
        <form id="registrationForm" action="register" method="post">
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="name">Nome:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="surname">Cognome:</label>
                <input type="text" id="surname" name="surname" required>
            </div>
            <div class="form-group">
                <label for="address">Via:</label>
                <input type="text" id="address" name="address" required>
            </div>
            <div class="form-group">
                <label for="number">Numero:</label>
                <input type="text" id="number" name="number" required>
            </div>
            <div class="form-group">
                <label for="province">Provincia:</label>
                <select id="province" name="province" required>
                    <option value="">Seleziona Provincia</option>
                    <option value="Napoli">Napoli</option>
                    <option value="Salerno">Salerno</option>
                </select>
            </div>
            <div class="form-group">
                <label for="city">Città:</label>
                <select id="city" name="city" required>
                    <option value="">Seleziona Città</option>
                </select>
            </div>
            <div class="form-group">
                <label for="phone">Telefono:</label>
                <input type="text" id="phone" name="phone" required>
            </div>
            <div class="form-group">
                <label for="phone">Numero di Cellulare:</label>
                <input type="text" id="cell" name="cell" required>
            </div>
            <div>
                <button type="submit">Registrati</button>
            </div>
            <div>
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
                <% } %>
            </div>
        </form>
    </main>
    <jsp:include page="footer.jsp" />
    <script src="${pageContext.request.contextPath}/scripts/register.js"></script>
</body>
</html>


