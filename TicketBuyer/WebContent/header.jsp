<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>TicketBuyer</title>
    <link rel="stylesheet" href="styles/style.css">
</head>
<body>
<header>
    <div class="logo">
        <img src="images/logo.png" alt="Logo">
    </div>
    <div class="auth-links">
        <%
            String user = (String) session.getAttribute("user");
            if (user != null) {
        %>
            <a href="logout.jsp">Logout</a>
        <%
            } else {
        %>
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Register</a>
        <%
            }
        %>
    </div>
</header>
<nav>
    <ul>
        <li><a href="home.jsp">Home</a></li>
        <li><a href="events.jsp">Eventi</a></li>
        <%
            if (user != null) {
        %>
            <li><a href="orders.jsp">Ordini</a></li>
        <%
            }
        %>
        <li><a href="shoppingCart.jsp">Carrello</a></li>
    </ul>
</nav>
