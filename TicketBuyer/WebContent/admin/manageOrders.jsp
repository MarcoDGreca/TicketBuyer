<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Gestisci Ordini</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <jsp:include page="/header.jsp" />
    <div class="order-management-container">
        <h1>Gestisci Ordini</h1>
        <form action="${pageContext.request.contextPath}/manageOrders" method="get" class="filter-form">
            <input type="hidden" name="action" value="filter">
            <div>
                <label for="emailCliente">Email Cliente</label>
                <input type="email" id="emailCliente" name="emailCliente">
            </div>
            <div>
                <label for="dataInizio">Data Inizio</label>
                <input type="date" id="dataInizio" name="dataInizio">
            </div>
            <div>
                <label for="dataFine">Data Fine</label>
                <input type="date" id="dataFine" name="dataFine">
            </div>
            <button type="submit" class="filter-button">Filtra</button>
        </form>
        <table class="order-table">
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
                            <td><%= order.getStato().getStato() %></td>
                            <td class="order-actions">
                                <form action="manageOrders" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="orderId" value="<%= order.getCodiceOrdine() %>">
                                    <select name="stato" required>
                                        <option value="IN_LAVORAZIONE" <%= "IN_LAVORAZIONE".equals(order.getStato().name()) ? "selected" : "" %>>In lavorazione</option>
                                        <option value="COMPLETATO" <%= "COMPLETATO".equals(order.getStato().name()) ? "selected" : "" %>>Completato</option>
                                        <option value="RICHIESTO_RIMBORSO" <%= "RICHIESTO_RIMBORSO".equals(order.getStato().name()) ? "selected" : "" %>>Richiesto Rimborso</option>
                                    </select>
                                    <button type="submit" class="order-action-button">Aggiorna</button>
                                </form>
                                <form action="manageOrders" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="orderId" value="<%= order.getCodiceOrdine() %>">
                                    <button type="submit" class="order-action-button">Elimina</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                <% } else { %>
                    <tr>
                        <td colspan="6">Nessun ordine trovato.</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <jsp:include page="/footer.jsp" />
</body>
</html>
