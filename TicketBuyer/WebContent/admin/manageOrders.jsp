<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestisci Ordini</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <jsp:include page="/header.jsp" />
    <div class="table-container">
        <h1>Gestisci Ordini</h1>
        <table>
            <thead>
                <tr>
                    <th>Codice Ordine</th>
                    <th>Email Cliente</th>
                    <th>Data Acquisto</th>
                    <th>Totale</th>
                    <th>Stato</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
                <% if (orders != null && !orders.isEmpty()) { %>
                    <% for (Order order : orders) { %>
                        <tr>
                            <td><%= order.getCodiceOrdine() %></td>
                            <td><%= order.getEmailCliente() %></td>
                            <td><%= order.getDataAcquisto() %></td>
                            <td>&euro;<%= order.getPrezzoTotale() %></td>
                            <td>
                                <form action="manageOrders" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="orderId" value="<%= order.getCodiceOrdine() %>">
                                    <select name="stato" required>
                                        <option value="In lavorazione" <%= "In lavorazione".equals(order.getStato().getStato()) ? "selected" : "" %>>In lavorazione</option>
                                        <option value="Completato" <%= "Completato".equals(order.getStato().getStato()) ? "selected" : "" %>>Completato</option>
                                        <option value="Richiesto Rimborso" <%= "Richiesto Rimborso".equals(order.getStato().getStato()) ? "selected" : "" %>>Richiesto Rimborso</option>
                                    </select>
                                    <button type="submit" class="button">Aggiorna</button>
                                </form>
                            </td>
                            <td>
                                <form action="manageOrders" method="post">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="orderId" value="<%= order.getCodiceOrdine() %>">
                                    <button type="submit" class="button delete-button">Elimina</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                <% } else { %>
                    <tr>
                        <td colspan="7">Nessun ordine disponibile.</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <jsp:include page="/footer.jsp" />
</body>
</html>

