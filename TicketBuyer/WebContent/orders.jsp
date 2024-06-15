<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Utente" %>
<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%
    Utente user = (Utente) session.getAttribute("user");
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ordini</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <div id="page">
        <jsp:include page="header.jsp" />
        <section>
            <h2>I miei ordini</h2>
            <div class="order-list">
                <% if (orders != null && !orders.isEmpty()) { %>
                    <% for (Order order : orders) { %>
                        <div class="order">
                            <h3>Ordine <%= order.getCodiceOrdine() %></h3>
                            <p><strong>Data:</strong> <%= order.getDataAcquisto() %></p>
                            <p><strong>Stato:</strong> <%= order.getStato() %></p>
                            <p><strong>Totale:</strong> €<%= order.getPrezzoTotale() %></p>
                        </div>
                    <% } %>
                <% } else { %>
                    <p>Non ci sono ordini.</p>
                <% } %>
            </div>
        </section>
        <aside>
 
        </aside>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>


