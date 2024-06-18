<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Order"%>
<%@ page import="model.Ticket"%>
<%@ page import="model.Event"%>
<%@ page import="java.util.List"%>
<%
List<Order> orders = (List<Order>) request.getAttribute("orders");
List<Ticket> tickets = (List<Ticket>) request.getAttribute("tickets");
List<Event> events = (List<Event>) request.getAttribute("events");
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
					<p>
						<strong>Codice Ordine:</strong>
						<%=order.getCodiceOrdine()%></p>
					<p>
						<strong>Data:</strong>
						<%=order.getDataAcquisto()%></p>
					<p>
						<strong>Totale:</strong> €<%=order.getPrezzoTotale()%></p>
					<p>
						<strong>Stato:</strong>
						<%=order.getStato().getStato()%></p>
				</div>
				<%
				}
				%>

				<form action="refundRequest" method="get">
					<button type="submit" class="refund-button">Richiedi un rimborso</button>
				</form>
				
				<form action="addReview" method="get">
					<button type="submit" class="refund-button">Scrivi una Recensione</button>
				</form>

			</div>
		</section>
		<%
		}
		%>
		<jsp:include page="footer.jsp" />
	</div>
</body>
</html>
