<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Conferma Richiesta di Rimborso</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <div id="page">
        <jsp:include page="header.jsp" />
        <section class="confirmation-section">
            <h2>Richiesta di Rimborso Ricevuta</h2>
            <p>La tua richiesta di rimborso è stata ricevuta e sarà elaborata a breve. Ti contatteremo via email per ulteriori dettagli.</p>
            <a href="home.jsp" class="button">Torna alla Home</a>
        </section>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>
