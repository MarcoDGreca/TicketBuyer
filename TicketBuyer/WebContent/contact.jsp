<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contatti</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <div>
        <jsp:include page="header.jsp" />
        <section>
            <h2>Contattaci</h2>
            <div class="contact">
                <div>
                    <label>Email:</label>
                    <p>support@ticketbuyer.com</p>
                </div>
                <div>
                    <label>Telefono:</label>
                    <p>+39 123 456 7890</p>
                </div>
                <div>
                    <label>Indirizzo:</label>
                    <p>Via Roma, 1, 80100 Napoli NA, Italia</p>
                </div>
                <div>
                    <label>Orari di apertura:</label>
                    <p>Lunedì - Venerdì: 9:00 - 18:00</p>
                </div>
            </div>
        </section>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>



