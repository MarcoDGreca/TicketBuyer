<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="model.Event" %>
<%
    Event event = (Event) request.getAttribute("event");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifica Evento</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <jsp:include page="/header.jsp" />
    <div class="form-container">
        <h1>Modifica Evento</h1>
        <form action="${pageContext.request.contextPath}/admin/updateEvent" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= event.getCodiceEvento() %>">
            <div>
                <label for="nome">Nome</label>
                <input type="text" id="nome" name="nome" value="<%= event.getNome() %>" required>
            </div>
            <div>
                <label for="luogo">Luogo</label>
                <input type="text" id="luogo" name="luogo" value="<%= event.getLuogo() %>" required>
            </div>
            <div>
                <label for="dataEvento">Data</label>
                <input type="date" id="dataEvento" name="dataEvento" value="<%= event.getDataEvento().toString() %>" required>
            </div>
            <div>
                <label for="orario">Orario</label>
                <input type="time" id="orario" name="orario" value="<%= event.getOrario() %>" required>
            </div>
            <div>
                <label for="tipo">Tipo</label>
                <select id="tipo" name="tipo" required>
                    <option value="Sport" <%= "Sport".equals(event.getTipo()) ? "selected" : "" %>>Sport</option>
                    <option value="Concerto" <%= "Concerto".equals(event.getTipo()) ? "selected" : "" %>>Concerto</option>
                    <option value="Fiera" <%= "Fiera".equals(event.getTipo()) ? "selected" : "" %>>Fiera</option>
                </select>
            </div>
            <div>
                <label for="Prezzo Standard">Prezzo Standard</label>
                <input type="number" id="prezzoStandard" name="prezzoStandard" required>
            </div>
            <div>
                <label for="Prezzo VIP">Prezzo VIP</label>
                <input type="number" id="prezzoVIP" name="prezzoVIP" required>
            </div>
            <div>
                <label for="image">Immagine</label>
                <input type="file" id="image" name="image" accept="image/*"">
            </div>
            <button type="submit" class="button">Modifica</button>
        </form>
    </div>
    <jsp:include page="/footer.jsp" />
</body>
</html>
