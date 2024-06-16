<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Conferma Ordine</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <div id="page">
        <jsp:include page="header.jsp" />
        <section class="order-confirmation-section">
            <h2>Ordine Confermato</h2>
            <p>Il tuo ordine è stato confermato con successo!</p>
            <p>Grazie per aver acquistato con noi.</p>
            <a href="home" class="button">Torna alla Home</a>
        </section>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>
