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
            <tr>
                <th>Codice Ordine</th>
                <th>Email Cliente</th>
                <th>Data Acquisto</th>
                <th>Totale</th>
                <th>Stato</th>
                <th>Azioni</th>
            </tr>
            <% for (Order order : orders) { %>
                <tr>
                    <td><%= order.getCodiceOrdine() %></td>
                    <td><%= order.getEmailCliente() %></td>
                    <td><%= order.getDataAcquisto() %></td>
                    <td>€<%= order.getPrezzoTotale() %></td>
                    <td><%= order.getStato().getStato() %></td>
                    <td>
                        <form action="manageOrders" method="post">
                            <input type="hidden" name="orderId" value="<%= order.getCodiceOrdine() %>">
                            <select name="stato" required>
                                <option value="In lavorazione" <%= "In lavorazione".equals(order.getStato().getStato()) ? "selected" : "" %>>In lavorazione</option>
                                <option value="Completato" <%= "Completato".equals(order.getStato().getStato()) ? "selected" : "" %>>Completato</option>
                                <option value="Richiesto Rimborso" <%= "Richiesto Rimborso".equals(order.getStato().getStato()) ? "selected" : "" %>>Richiesto Rimborso</option>
                            </select>
                            <button type="submit" class="button">Aggiorna</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
    </div>
    <jsp:include page="/footer.jsp" />
</body>
</html>
