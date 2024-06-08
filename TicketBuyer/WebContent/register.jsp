<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>
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
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div>
                <label for="surname">Surname:</label>
                <input type="text" id="surname" name="surname" required>
            </div>
            <div>
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" required>
            </div>
            <div>
                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" required>
            </div>
            <div>
                <label for="cardNumber">Card Number:</label>
                <input type="text" id="cardNumber" name="cardNumber" required>
            </div>
            <div>
                <label for="cardHolder">Card Holder:</label>
                <input type="text" id="cardHolder" name="cardHolder" required>
            </div>
            <div>
                <label for="cvv">CVV:</label>
                <input type="text" id="cvv" name="cvv" required>
            </div>
            <div>
                <button type="submit">Register</button>
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

