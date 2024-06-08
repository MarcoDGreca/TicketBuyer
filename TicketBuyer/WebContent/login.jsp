<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="styles/style.css">
    <% String errorMessage = request.getAttribute("errorMessage").toString(); %>
</head>
<body>
    <header>
        <div class="logo">
            <img src="images/logo.png" alt="Logo">
        </div>
        <div class="auth-links">
            <% if (session.getAttribute("user") != null) { %>
                <a href="logout">Logout</a>
            <% } else { %>
                <a href="login">Login</a>
                <a href="register">Register</a>
            <% } %>
        </div>
    </header>
    <nav>
        <ul>
            <li><a href="home">Home</a></li>
            <li><a href="events">Events</a></li>
            <% if (session.getAttribute("user") != null) { %>
                <li><a href="orders">My Orders</a></li>
            <% } %>
            <li><a href="cart">Cart</a></li>
        </ul>
    </nav>
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
                <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
                    <p style="color:red;"><%= errorMessage %></p>
                <% } %>
            </div>
        </form>
    </main>
    <footer>
        <p>&copy; 2024 TicketBuyer</p>
    </footer>
</body>
</html>

