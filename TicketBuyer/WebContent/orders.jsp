<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%@ page import="model.OrderDAO" %>
<jsp:include page="header.jsp" />

<main>
    <h2>I tuoi ordini</h2>
    <%
        String emailCliente = (String) session.getAttribute("user");
        if (emailCliente != null) {
            OrderDAO orderDAO = new OrderDAO();
            List<Order> orders = orderDAO.getOrdersByEmail(emailCliente);

            if (orders != null && !orders.isEmpty()) {
    %>
                <table>
                    <thead>
                        <tr>
                            <th>Codice Ordine</th>
                            <th>Data Ordine</th>
                            <th>Totale</th>
                            <th>Stato</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Order order : orders) {
                        %>
                            <tr>
                                <td><%= order.getCodiceOrdine() %></td>
                                <td><%= order.getDataAcquisto() %></td>
                                <td><%= order.getPrezzoTotale() %></td>
                                <td><%= order.getStato() %></td>
                            </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
    <%
            } else {
    %>
                <p>Non hai ordini.</p>
    <%
            }
        } else {
    %>
            <p>Devi essere loggato per vedere i tuoi ordini.</p>
    <%
        }
    %>
</main>

<jsp:include page="footer.jsp" />
