<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.Ticket" %>
<%@ page import="java.util.List" %>
<%
    List<Ticket> cart = (List<Ticket>) request.getAttribute("cart");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carrello</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <div id="page">
        <jsp:include page="header.jsp" />
        <section class="cart-section">
            <h2>Il tuo Carrello</h2>
            <% if (cart != null && !cart.isEmpty()) { %>
                <ul class="cart-list">
                    <% for (Ticket ticket : cart) { %>
                        <li class="cart-item">
                            <div>
                                <img src="${pageContext.request.contextPath}/img/ticket<%= ticket.getCodiceBiglietto() %>.jpg" alt="<%= ticket.getDescrizione() %>">
                            </div>
                            <div>
                                <p><strong>Nome Evento:</strong> <%= ticket.getDescrizione() %></p>
                                <p><strong>Prezzo:</strong> €<%= ticket.getPrezzoUnitario() %></p>
                                <form action="cart" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="ticketId" value="<%= ticket.getCodiceBiglietto() %>">
                                    <label for="quantity">Quantità:</label>
                                    <input type="number" name="quantity" value="1" min="1">
                                    <button type="submit">Aggiorna</button>
                                </form>
                                <a href="cart?action=remove&ticketId=<%= ticket.getCodiceBiglietto() %>" class="remove-button">Rimuovi</a>
                            </div>
                        </li>
                    <% } %>
                </ul>
                <div class="cart-total">
                    <p><strong>Totale:</strong> €<%= cart.stream().mapToDouble(Ticket::getPrezzoUnitario).sum() %></p>
                </div>
                <div class="cart-checkout">
                    <button onclick="location.href='checkout.jsp'">Procedi al Pagamento</button>
                </div>
            <% } else { %>
                <p>Il carrello è vuoto.</p>
            <% } %>
        </section>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>



