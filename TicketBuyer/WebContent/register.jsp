<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrazione</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
    <script src="${pageContext.request.contextPath}/scripts/validation.js" defer></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const provinciaSelect = document.getElementById("provincia");
            const cittaSelect = document.getElementById("citta");

            provinciaSelect.addEventListener("change", function() {
                const provincia = provinciaSelect.value;
                cittaSelect.innerHTML = '<option value="">Seleziona Città</option>';

                if (provincia === "Napoli") {
                    cittaSelect.innerHTML += '<option value="Napoli">Napoli</option>';
                } else if (provincia === "Salerno") {
                    cittaSelect.innerHTML += '<option value="Salerno">Salerno</option>';
                    cittaSelect.innerHTML += '<option value="Fisciano">Fisciano</option>';
                }
            });
        });
    </script>
</head>
<body>
    <div>
        <jsp:include page="header.jsp" />
        <section>
            <h2>Registrazione</h2>
            <form id="registrationForm" action="register" method="post">
                <div>
                    <label for="nome">Nome:</label>
                    <input type="text" id="nome" name="nome" required>
                    <span class="error" id="errNome"></span>
                </div>
                <div>
                    <label for="cognome">Cognome:</label>
                    <input type="text" id="cognome" name="cognome" required>
                    <span class="error" id="errCognome"></span>
                </div>
                <div>
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>
                    <span class="error" id="errEmail"></span>
                </div>
                <div>
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                    <span class="error" id="errPassword"></span>
                </div>
                <div>
                    <label for="via">Via:</label>
                    <input type="text" id="via" name="via" required>
                    <span class="error" id="errVia"></span>
                </div>
                <div>
                    <label for="cap">CAP:</label>
                    <input type="text" id="cap" name="cap" required>
                    <span class="error" id="errCap"></span>
                </div>
                <div>
                    <label for="numero">Numero:</label>
                    <input type="text" id="numero" name="numero" required>
                    <span class="error" id="errNumero"></span>
                </div>
                <div>
                    <label for="provincia">Provincia:</label>
                    <select id="provincia" name="provincia" required>
                        <option value="">Seleziona Provincia</option>
                        <option value="Napoli">Napoli</option>
                        <option value="Salerno">Salerno</option>
                    </select>
                    <span class="error" id="errProvincia"></span>
                </div>
                <div>
                    <label for="citta">Città:</label>
                    <select id="citta" name="citta" required>
                        <option value="">Seleziona Città</option>
                    </select>
                    <span class="error" id="errCitta"></span>
                </div>
                <div>
                    <label for="telefono">Telefono:</label>
                    <input type="text" id="telefono" name="telefono" required>
                    <span class="error" id="errTelefono"></span>
                </div>
                <div>
                    <label for="numeroT">Numero di Carta:</label>
                    <input type="text" id="numeroT" name="numeroT" required>
                    <span class="error" id="errNumeroT"></span>
                </div>
                <div>
                    <button type="submit">Registrati</button>
                </div>
            </form>
        </section>
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>
