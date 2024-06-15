<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="model.Utente" %>
<%@ page import="model.Ruolo" %>
<%@ page import="model.Order" %>
<%@ page import="model.OrderDAO" %>
<%@ page import="java.util.List" %>
<%
    Utente user = (Utente) session.getAttribute("user");
    if (user == null || !user.getRuolo().equals(Ruolo.ADMIN)) {
        response.sendRedirect("login");
        return;
    }

    OrderDAO orderDAO = new OrderDAO();
    List<Order> orders = orderDAO.getAllOrders();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Gestisci Ordini</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/footer.css">
</head>
<body>
    <jsp:include page="/header.jsp" />
    <main>
        <h1>Gestisci Ordini</h1>
        <ul>
            <% for (Order order : orders) { %>
                <li>
                    <p>Ordine: <%= order.getCodiceOrdine() %></p>
                    <p>Cliente: <%= order.getEmailCliente() %></p>
                    <p>Data: <%= order.getDataAcquisto() %></p>
                    <p>Prezzo totale: <%= order.getPrezzoTotale() %></p>
                </li>
            <% } %>
        </ul>
    </main>
    <jsp:include page="/footer.jsp" />
</body>
</html>
