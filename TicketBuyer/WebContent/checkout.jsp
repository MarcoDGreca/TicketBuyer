<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="model.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Checkout</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${pageContext.request.contextPath}/styles/style.css" rel="stylesheet" type="text/css">
</head>
<body>
    <jsp:include page="header.jsp" />

    <div id="main" class="clear">
        <section class="checkout-section">
            <h2>Riepilogo Ordine</h2>
            <table class="checkout-table">
                <tr>
                    <th>Immagine</th>
                    <th>Descrizione</th>
                    <th>Quantit&agrave;</th>
                    <th>Prezzo totale</th>
                </tr>
                <% Cart cart = (Cart) session.getAttribute("cart");
                   if (cart != null && !cart.isEmpty()) {
                       for (CartItem item : cart.getItems()) {
                           Ticket ticket = item.getTicket();
                %>
                <tr>
                    <td><img src="img/<%=item.getCodiceEventoBiglietto()%>.jpeg" alt="<%=ticket.getDescrizione()%>"></td>
                    <td><%=ticket.getDescrizione()%></td>
                    <td><%=item.getQuantity()%></td>
                    <td>&euro;<%=String.format("%.2f", item.getTotalPrice())%></td>
                </tr>
                <%     }
                   } %>
            </table>
            <div class="checkout-total">
                Totale ordine: &euro;<%=String.format("%.2f", cart.getTotalPrice())%>
            </div>
            <form action="checkout" method="post">
                <button type="submit" class="button">Conferma Acquisto</button>
            </form>
            <form action="cart.jsp" method="get">
                <button type="submit" class="button">Modifica Carrello</button>
            </form>
        </section>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>
