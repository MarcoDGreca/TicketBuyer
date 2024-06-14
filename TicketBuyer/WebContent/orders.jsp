<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%@ page import="model.OrderDAO" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="model.Order" %>
<%@ page import="model.Utente" %>
<%@ page import="java.util.List" %>
<%
    Utente user = (Utente) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }

    OrderDAO orderDAO = new OrderDAO();
    List<Order> orders = orderDAO.getOrdersByEmail(user.getEmail());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>I tuoi ordini</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/orders.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    <main>
        <h1>I tuoi ordini</h1>
        <%
            if (orders != null && !orders.isEmpty()) {
        %>
            <ul>
                <% for (Order order : orders) { %>
                    <li>
                        <p>Ordine: <%= order.getCodiceOrdine() %></p>
                        <p>Data: <%= order.getDataAcquisto() %></p>
                        <p>Prezzo totale: <%= order.getPrezzoTotale() %></p>
                    </li>
                <% } %>
            </ul>
        <%
            } else {
                out.println("<p>Non hai effettuato ordini.</p>");
            }
        %>
    </main>
    <jsp:include page="footer.jsp" />
</body>
</html>

