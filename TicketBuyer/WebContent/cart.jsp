<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*, model.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Carrello</title>
    <link href="${pageContext.request.contextPath}/styles/style.css" rel="stylesheet" type="text/css">
</head>
<body>

    <jsp:include page="header.jsp" />

    <div id="main" class="clear">

    <%  Cart cart = (Cart) request.getSession().getAttribute("cart");
        if(cart != null && !cart.isEmpty()) { %>

        <section class="cart-section">
            <h2>Il tuo Carrello</h2>
            <table class="cart-table">
                <tr>
                    <th>Immagine</th>
                    <th>Descrizione</th>
                    <th>Quantità</th>
                    <th>Prezzo totale</th>
                    <th>Rimuovi</th>
                </tr>
                <% 
                    Map<Ticket, Integer> items = cart.getItems();    
                    for(Map.Entry<Ticket, Integer> entry: items.entrySet()){
                        Ticket ticket = entry.getKey();
                        int quantity = entry.getValue();
                %>
                <tr>
                    <td><img src="img/ticket<%=ticket.getCodiceBiglietto()%>.jpg" alt="<%=ticket.getDescrizione()%>"></td>
                    <td><%=ticket.getDescrizione()%></td>
                    <td> 
                        <form action="cart" method="get">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="ticketId" value="<%=ticket.getCodiceBiglietto()%>">
                            <input type="number" name="quantity" value="<%=quantity%>" min="1">
                            <button type="submit">Aggiorna</button>
                        </form>
                    </td>
                    <td>&euro;<%=String.format("%.2f", ticket.getPrezzoUnitario() * quantity)%></td>
                    <td>
                        <form action="cart" method="get">
                            <input type="hidden" name="action" value="remove">
                            <input type="hidden" name="ticketId" value="<%=ticket.getCodiceBiglietto()%>">
                            <button type="submit" class="remove-button">Rimuovi</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </table>
            <div class="cart-total">
                Totale provvisorio: &euro;<%=String.format("%.2f", cart.getTotalPrice())%>
            </div>

            <div class="cart-checkout">
                <a <%if(request.getSession().getAttribute("user") != null) { %>
                        href="checkout" <%} else { %>href="login.jsp?action=checkout" <%} %>>
                    <button>Acquista</button>
                </a>
            </div>
        </section>

    <% } else { %> 
        <h2>Carrello vuoto</h2>
    <% } %>
    <br><br>

    </div>

    <jsp:include page="footer.jsp" />

</body>
</html>

