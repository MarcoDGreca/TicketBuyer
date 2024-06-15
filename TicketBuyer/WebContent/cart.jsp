<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="model.Cart" %>
<%@ page import="model.Ticket" %>
<%
    Cart cart = (Cart) session.getAttribute("cart");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carrello</title>
    <meta name="viewport" content="initial-scale=1, width=device-width">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    <main>
        <h1>Il tuo carrello</h1>
        <%
            if (cart != null && !cart.getTickets().isEmpty()) {
        %>
            <ul>
                <% for (Ticket ticket : cart.getTickets()) { %>
                    <li>
                        <p>Tipo: <%= ticket.getTipo() %></p>
                        <p>Descrizione: <%= ticket.getDescrizione() %></p>
                        <p>Prezzo: <%= ticket.getPrezzoUnitario() %> EUR</p>
                        <a href="cart?action=remove&ticketId=<%= ticket.getCodiceBiglietto() %>">Rimuovi</a>
                    </li>
                <% } %>
            </ul>
            <p>Prezzo totale: <%= cart.getTotalPrice() %> EUR</p>
            <form action="checkout" method="post">
                <button type="submit">Procedi al pagamento</button>
            </form>
        <%
            } else {
                out.println("<p>Il carrello è vuoto.</p>");
            }
        %>
    </main>
    <jsp:include page="footer.jsp" />
</body>
</html>
