<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pagina Non Trovata</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <jsp:include page="/header.jsp" />
    <main>
        <h1>404 - Pagina Non Trovata</h1>
        <p>La pagina che stai cercando non esiste. Verifica l'URL e riprova.</p>
    </main>
    <jsp:include page="/footer.jsp" />

</body>
</html>
