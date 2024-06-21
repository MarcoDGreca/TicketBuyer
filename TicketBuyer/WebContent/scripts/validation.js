function validateNome(nome) {
    return /^[A-Za-z]+$/.test(nome);
}

function validateCognome(cognome) {
    return /^[A-Za-z\s]+$/.test(cognome);
}

function validateEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function validatePassword(password) {
    return /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$/.test(password);
}

function validateIndirizzo(indirizzo) {
    return indirizzo.length > 0;
}

function validateCAP(cap) {
    return /^\d{5}$/.test(cap);
}

function validateNumero(numero) {
    return numero.length > 0;
}

function validateTelefono(telefono) {
    return /^\d{10,15}$/.test(telefono);
}

function validateNumeroT(numeroT) {
    return /^\d{16}$/.test(numeroT);
}

function showError(input, message) {
    var errorElement = document.getElementById("err" + input.id.charAt(0).toUpperCase() + input.id.slice(1));
    errorElement.textContent = message;
    errorElement.style.color = "red";
}

function clearError(input) {
    var errorElement = document.getElementById("err" + input.id.charAt(0).toUpperCase() + input.id.slice(1));
    errorElement.textContent = "";
}

function validateInput(input) {
    var isValid = true;
    if (input.name === "nome") {
        if (!validateNome(input.value)) {
            showError(input, "Nome non valido");
            isValid = false;
        } else {
            clearError(input);
        }
    } else if (input.name === "cognome") {
        if (!validateCognome(input.value)) {
            showError(input, "Cognome non valido");
            isValid = false;
        } else {
            clearError(input);
        }
    } else if (input.name === "email") {
        if (!validateEmail(input.value)) {
            showError(input, "Email non valida");
            isValid = false;
        } else {
            clearError(input);
        }
    } else if (input.name === "password") {
        if (!validatePassword(input.value)) {
            showError(input, "Password non valida");
            isValid = false;
        } else {
            clearError(input);
        }
    } else if (input.name === "via" || input.name === "numero") {
        if (!validateIndirizzo(input.value)) {
            showError(input, "Indirizzo non valido");
            isValid = false;
        } else {
            clearError(input);
        }
    } else if (input.name === "cap") {
        if (!validateCAP(input.value)) {
            showError(input, "CAP non valido");
            isValid = false;
        } else {
            clearError(input);
        }
    } else if (input.name === "provincia" || input.name === "citta") {
        if (input.value === "") {
            showError(input, input.name.charAt(0).toUpperCase() + input.name.slice(1) + " non valida");
            isValid = false;
        } else {
            clearError(input);
        }
    } else if (input.name === "telefono") {
        if (!validateTelefono(input.value)) {
            showError(input, "Telefono non valido");
            isValid = false;
        } else {
            clearError(input);
        }
    } else if (input.name === "numeroT") {
        if (!validateNumeroT(input.value)) {
            showError(input, "Numero di carta non valido");
            isValid = false;
        } else {
            clearError(input);
        }
    }
    return isValid;
}

function validateForm(form) {
    var inputs = form.getElementsByTagName("input");
    var isValid = true;
    for (var i = 0; i < inputs.length; i++) {
        if (!validateInput(inputs[i])) {
            isValid = false;
        }
    }
    var selects = form.getElementsByTagName("select");
    for (var i = 0; i < selects.length; i++) {
        if (!validateInput(selects[i])) {
            isValid = false;
        }
    }
    return isValid;
}

document.addEventListener("DOMContentLoaded", function() {
    var forms = document.getElementsByTagName("form");
    for (var i = 0; i < forms.length; i++) {
        forms[i].addEventListener("submit", function(event) {
            if (!validateForm(event.target)) {
                event.preventDefault();
            }
        });

        var inputs = forms[i].getElementsByTagName("input");
        for (var j = 0; j < inputs.length; j++) {
            inputs[j].addEventListener("blur", function(event) {
                validateInput(event.target);
            });
        }

        var selects = forms[i].getElementsByTagName("select");
        for (var j = 0; j < selects.length; j++) {
            selects[j].addEventListener("blur", function(event) {
                validateInput(event.target);
            });
        }
    }
});
