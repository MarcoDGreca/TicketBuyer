<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Eventi</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/styles.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    <h1>Eventi Disponibili</h1>
    <table>
        <thead>
            <tr>
                <th>Codice Evento</th>
                <th>Nome</th>
                <th>Luogo</th>
                <th>Data Evento</th>
                <th>Orario</th>
                <th>Disponibilità</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="event" items="${events}">
                <tr>
                    <td>${event.codiceEvento}</td>
                    <td>${event.nome}</td>
                    <td>${event.luogo}</td>
                    <td>${event.dataEvento}</td>
                    <td>${event.orario}</td>
                    <td>${event.disponibilita}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <jsp:include page="footer.jsp" />
</body>
</html>
