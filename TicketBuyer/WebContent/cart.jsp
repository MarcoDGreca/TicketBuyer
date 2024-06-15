<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Ticket" %>
<%@ page import="java.util.List" %>
<%
    List<Ticket> cart = (List<Ticket>) session.getAttribute("cart");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Carrello</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    <main>
        <h2>Il tuo carrello</h2>
        <div class="cart-items">
            <% if (cart != null && !cart.isEmpty()) { 
                double total = 0.0;
                for (Ticket ticket : cart) {
                    total += ticket.getPrezzoUnitario();
            %>
            <div class="cart-item">
                <div>
                    <h3><%= ticket.getDescrizione() %></h3>
                    <p>Prezzo: €<%= ticket.getPrezzoUnitario() %></p>
                </div>
                <form action="cart" method="post">
                    <input type="hidden" name="ticketId" value="<%= ticket.getCodiceBiglietto() %>">
                    <button class="remove-button" type="submit" name="action" value="remove">Rimuovi</button>
                </form>
            </div>
            <% } %>
            <div class="cart-total">
                Totale: €<%= total %>
            </div>
            <div class="cart-checkout">
                <form action="checkout" method="post">
                    <button type="submit">Procedi al pagamento</button>
                </form>
            </div>
            <% } else { %>
            <p>Il carrello è vuoto.</p>
            <% } %>
        </div>
    </main>
    <footer>
        <jsp:include page="footer.jsp" />
    </footer>
</body>
</html>

