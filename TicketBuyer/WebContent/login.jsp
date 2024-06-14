<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/footer.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    <main>
        <h2>Login</h2>
        <form action="login" method="post">
            <div>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div>
                <button type="submit">Login</button>
            </div>
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

