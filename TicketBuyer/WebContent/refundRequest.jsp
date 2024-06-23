<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Richiesta di Rimborso</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <div>
        <jsp:include page="header.jsp" />
        <section class="refund-section">
            <h2>Richiesta di Rimborso</h2>
            <% if (orders != null && !orders.isEmpty()) { %>
                <table class="order-table">
                    <tr>
                        <th>Codice Ordine</th>
                        <th>Data</th>
                        <th>Totale</th>
                        <th>Stato</th>
                        <th>Azione</th>
                    </tr>
                    <% for (Order order : orders) { %>
                        <tr>
                            <td><%= order.getCodiceOrdine() %></td>
                            <td><%= order.getDataAcquisto() %></td>
                            <td>&euro;<%= order.getPrezzoTotale() %></td>
                            <td><%= order.getStato().getStato() %></td>
                            <td>
                                <% if (order.getStato().getStato().equals("Completato")) { %>
                                    <form action="refund" method="post">
                                        <input type="hidden" name="orderId" value="<%= order.getCodiceOrdine() %>">
                                        <button type="submit" class="refund-button">Richiedi Rimborso</button>
                                    </form>
                                <% } else { %>
                                    <span>Non rimborsabile</span>
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                </table>
            <% } else { %>
                <p>Non hai ordini da mostrare.</p>
            <% } %>
        </section>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>

