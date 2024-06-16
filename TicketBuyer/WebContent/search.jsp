<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ricerca Eventi</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
    <script src="${pageContext.request.contextPath}/scripts/search.js"></script>
</head>
<body>
    <header>
        <jsp:include page="header.jsp" />
    </header>
    <main>
        <div class="search">
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
                    <input type="number" id="disponibilita" name="disponibilita" min="0">
                </div>
                <div>
                    <label for="prezzoMax">Prezzo Max:</label>
                    <input type="number" id="prezzoMax" name="prezzoMax" step="0.01" min="0">
                </div>
                <div>
                    <button type="submit">Cerca</button>
                </div>
            </form>
        </div>
        <div class="main-content" id="results">
            
        </div>
    </main>
    <footer>
        <jsp:include page="footer.jsp" />
    </footer>
</body>
</html>
