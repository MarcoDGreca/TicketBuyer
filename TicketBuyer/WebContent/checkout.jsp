<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Ticket" %>
<%
    List<Ticket> cart = (List<Ticket>) session.getAttribute("cart");
    Double totalPrice = (Double) request.getAttribute("totalPrice");
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
            <h2>Checkout</h2>
            <p>Controlla i tuoi articoli e procedi al pagamento.</p>
            <ul class="cart-list">
                <% for (Ticket ticket : cart) { %>
                    <li class="cart-item">
                        <div>
                            <img src="${pageContext.request.contextPath}/img/ticket<%= ticket.getCodiceBiglietto() %>.jpg" alt="<%= ticket.getDescrizione() %>">
                        </div>
                        <div>
                            <p><strong>Nome Evento:</strong> <%= ticket.getDescrizione() %></p>
                            <p><strong>Prezzo:</strong> €<%= ticket.getPrezzoUnitario() %></p>
                        </div>
                    </li>
                <% } %>
            </ul>
            <div class="cart-total">
                <p><strong>Totale:</strong> €<%= totalPrice %></p>
            </div>
            <form action="checkout" method="post">
                <button type="submit">Conferma Ordine</button>
            </form>
        </section>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>
