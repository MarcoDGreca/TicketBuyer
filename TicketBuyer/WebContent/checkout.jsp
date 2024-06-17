<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.Cart, model.Ticket" %>
<%@ page import="java.util.Map" %>
<%
    Cart cart = (Cart) session.getAttribute("cart");
    boolean isAuthenticated = (session.getAttribute("user") != null);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <div id="page">
        <jsp:include page="header.jsp" />
        <section class="checkout-section">
            <h2>Riepilogo Ordine</h2>
            <% if (cart != null && !cart.getItems().isEmpty()) { %>
                <div class="cart-summary">
                    <ul class="cart-list">
                        <% for (Map.Entry<Ticket, Integer> entry : cart.getItems().entrySet()) { %>
                            <li class="cart-item">
                                <div>
                                    <p><strong>Nome Evento:</strong> <%= entry.getKey().getDescrizione() %></p>
                                    <p><strong>Prezzo Unitario:</strong> €<%= entry.getKey().getPrezzoUnitario() %></p>
                                    <p><strong>Quantit&agrave;:</strong> <%= entry.getValue() %></p>
                                    <p><strong>Totale:</strong> €<%= entry.getKey().getPrezzoUnitario() * entry.getValue() %></p>
                                </div>
                            </li>
                        <% } %>
                    </ul>
                    <div class="cart-total">
                        <p><strong>Totale Ordine:</strong> &euro;<%= cart.getTotalPrice() %></p>
                    </div>
                    <% if (isAuthenticated) { %>
                        <form action="checkout" method="post">
                            <button type="submit">Conferma Ordine</button>
                        </form>
                    <% } else { %>
                        <p>Per procedere al pagamento, <a href="login.jsp">effettua il login</a> o <a href="register.jsp">registrati</a>.</p>
                    <% } %>
                </div>
            <% } else { %>
                <p>Il carrello è vuoto.</p>
            <% } %>
        </section>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>

