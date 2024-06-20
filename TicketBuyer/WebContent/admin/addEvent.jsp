<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Aggiungi Evento</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>
    <jsp:include page="/header.jsp" />
    <div class="form-container">
        <h1>Aggiungi Evento</h1>
        <form action="${pageContext.request.contextPath}/admin/addEvent" method="post" enctype="multipart/form-data">
            <div>
                <label for="nome">Nome</label>
                <input type="text" id="nome" name="nome" required>
            </div>
            <div>
                <label for="luogo">Luogo</label>
                <input type="text" id="luogo" name="luogo" required>
            </div>
            <div>
                <label for="dataEvento">Data</label>
                <input type="date" id="dataEvento" name="dataEvento" required>
            </div>
            <div>
                <label for="orario">Orario</label>
                <input type="time" id="orario" name="orario" required>
            </div>
            <div>
                <label for="tipo">Tipo</label>
                <select id="tipo" name="tipo" required>
                    <option value="Sport">Sport</option>
                    <option value="Concerto">Concerto</option>
                    <option value="Fiera">Fiera</option>
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
                <input type="file" id="image" name="image" accept="image/*">
            </div>
            <button type="submit" class="button">Aggiungi</button>
        </form>
    </div>
    <jsp:include page="/footer.jsp" />
</body>
</html>

