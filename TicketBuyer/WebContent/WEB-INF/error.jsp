<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Errore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
	<jsp:include page="/header.jsp" />
    <main>
        <h1>Errore</h1>
        <p>Si è verificato un errore. Riprova più tardi.</p>
    </main>
    <footer>
        <jsp:include page="/footer.jsp" />
    </footer>
</body>
</html>
