document.addEventListener("DOMContentLoaded", function() {
    const searchForm = document.getElementById("searchForm");

    searchForm.addEventListener("submit", function(event) {
        event.preventDefault();
        const formData = new FormData(searchForm);
        const params = new URLSearchParams(formData).toString();

        const xhr = new XMLHttpRequest();
        xhr.open("GET", `search?${params}`, true);

        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                const events = JSON.parse(xhr.responseText);
                displayResults(events);
            } else if (xhr.readyState === 4) {
                console.error('Errore:', xhr.statusText);
            }
        };

        xhr.send();
    });

    function displayResults(events) {
    const results = document.getElementById("results");
    results.innerHTML = "";

    if (events.length > 0) {
        events.forEach(event => {
            const eventDiv = document.createElement("div");
            eventDiv.className = "event";
            eventDiv.innerHTML = `
                <h3>${event.nome}</h3>
                <p>Luogo: ${event.luogo}</p>
                <p>Data: ${event.dataEvento}</p>
                <p>Orario: ${event.orario}</p>
                <p>Tipo: ${event.tipo}</p>
                <form action="cart" method="post">
                    <input type="hidden" name="eventId" value="${event.codiceEvento}">
                    <button type="submit" name="action" value="add">Aggiungi al Carrello</button>
                </form>
            `;
            results.appendChild(eventDiv);
        });
    } else {
        results.innerHTML = "<p>Nessun evento trovato.</p>";
    }
}

});
