<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ricerca Eventi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
    <script src="${pageContext.request.contextPath}/scripts/search.js"></script>
</head>
<body>
    <jsp:include page="header.jsp" />
    <section class="search-section">
        <h2>Ricerca Eventi</h2>
        <form id="searchForm" class="horizontal-form">
            <div>
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome">
            </div>
            <div>
                <label for="tipo">Tipo:</label>
                <select id="tipo" name="tipo">
                    <option value="">Tutti</option>
                    <option value="Sport">Sport</option>
                    <option value="Concerto">Concerto</option>
                    <option value="Fiera">Fiera</option>
                </select>
            </div>
            <div>
                <label for="dataInizio">Data Inizio:</label>
                <input type="date" id="dataInizio" name="dataInizio">
            </div>
            <div>
                <label for="dataFine">Data Fine:</label>
                <input type="date" id="dataFine" name="dataFine">
            </div>
            <div>
                <label for="disponibilita">Disponibilità:</label>
                <input type="number" id="disponibilita" name="disponibilita" min="1">
            </div>
            <div>
                <label for="prezzoMax">Prezzo Massimo:</label>
                <input type="number" id="prezzoMax" name="prezzoMax" step="0.01">
            </div>
            <button type="submit">Cerca</button>
        </form>
        <div id="results" class="grid"></div>
    </section>
    <jsp:include page="footer.jsp" />
</body>
</html>
