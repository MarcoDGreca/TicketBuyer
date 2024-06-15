<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <div id="page">
        <jsp:include page="header.jsp" />
        <section>
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
                    <% if (request.getAttribute("errorMessage") != null) { %>
                        <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
                    <% } %>
                </div>
            </form>
        </section>
        <aside>

        </aside>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>



