<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*"%>
<%@ page import="java.util.List"%>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
	OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dettagli Ordine</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <div id="page">
        <jsp:include page="header.jsp" />
        <%
        if (orders != null && !orders.isEmpty()) {
        %>
        <section class="orders-section">
            <h2>I Tuoi Ordini</h2>
            <div class="main-content">
                <%
                for (Order order : orders) {
                %>
                <div class="order">
                    <h3>Ordine <%=order.getCodiceOrdine()%></h3>
                    <table class="order-table">
                        <tr>
                            <th>Codice Ordine</th>
                            <td><%=order.getCodiceOrdine()%></td>
                        </tr>
                        <tr>
                            <th>Data</th>
                            <td><%=order.getDataAcquisto()%></td>
                        </tr>
                        <tr>
                            <th>Totale</th>
                            <td>€<%=order.getPrezzoTotale()%></td>
                        </tr>
                        <tr>
                            <th>Stato</th>
                            <td><%=order.getStato().getStato()%></td>
                        </tr>
                    </table>
                    <h4>Dettagli Ordine</h4>
                    <table class="order-table">
                        <tr>
                            <th>Evento</th>
                            <th>Biglietto</th>
                            <th>Quantità</th>
                            <th>Prezzo</th>
                        </tr>
                        <%
                        List<OrderDetail> orderDetails = orderDetailDAO.getOrderDetailsByOrderId(order.getCodiceOrdine());
                        for (OrderDetail detail : orderDetails) {
                            Ticket ticket = (Ticket) request.getAttribute("ticket_" + detail.getCodiceBiglietto());
                            Event event = (Event) request.getAttribute("event_" + ticket.getCodiceEvento());
                        %>
                        <tr>
                            <td><%= event.getNome() %></td>
                            <td><%= ticket.getDescrizione() %></td>
                            <td><%= detail.getQuantita() %></td>
                            <td>€<%= ticket.getPrezzoUnitario() %></td>
                        </tr>
                        <%
                        }
                        %>
                    </table>
                    <div class="order-actions">
                        <form action="refundRequest" method="get">
                            <input type="hidden" name="orderId" value="<%= order.getCodiceOrdine() %>">
                            <button type="submit" class="refund-button">Richiedi un rimborso</button>
                        </form>
                        <form action="addReview" method="get">
                            <input type="hidden" name="orderId" value="<%= order.getCodiceOrdine() %>">
                            <button type="submit" class="review-button">Scrivi una Recensione</button>
                        </form>
                    </div>
                </div>
                <%
                }
                %>
            </div>
        </section>
        <%
        } else {
        %>
        <p>Non ci sono ordini disponibili.</p>
        <%
        }
        %>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>
