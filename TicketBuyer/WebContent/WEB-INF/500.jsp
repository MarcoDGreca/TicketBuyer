<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Errore del Server</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <jsp:include page="/header.jsp" />
    <main>
        <h1>500 - Errore del Server</h1>
        <p>Si è verificato un errore interno del server. Riprova più tardi.</p>
    </main>
    <footer>
        <jsp:include page="/footer.jsp" />
    </footer>
</body>
</html>
