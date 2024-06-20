function validateEmail(email) {
    var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailPattern.test(email);
}

function validatePassword(password) {
    var passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$/;
    return passwordPattern.test(password);
}

function validateName(name) {
    var namePattern = /^[A-Za-z]+$/;
    return namePattern.test(name);
}

function showErrorMessage(input, message) {
    var errorElement = document.getElementById("err" + input.name.charAt(0).toUpperCase() + input.name.slice(1));
    errorElement.textContent = message;
    errorElement.style.color = "red";
}

function clearErrorMessage(input) {
    var errorElement = document.getElementById("err" + input.name.charAt(0).toUpperCase() + input.name.slice(1));
    errorElement.textContent = "";
}

function validateInput(input) {
    var isValid = true;
    if (input.name === "email") {
        if (!validateEmail(input.value)) {
            showErrorMessage(input, "Email non valida");
            isValid = false;
        } else {
            clearErrorMessage(input);
        }
    } else if (input.name === "password") {
        if (!validatePassword(input.value)) {
            showErrorMessage(input, "Password non valida");
            isValid = false;
        } else {
            clearErrorMessage(input);
        }
    } else if (input.name === "nome" || input.name === "cognome") {
        if (!validateName(input.value)) {
            showErrorMessage(input, input.name.charAt(0).toUpperCase() + input.name.slice(1) + " non valido");
            isValid = false;
        } else {
            clearErrorMessage(input);
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
            inputs[j].addEventListener("focus", function(event) {
                event.target.style.background = "yellow";
            });
        }
    }
});

