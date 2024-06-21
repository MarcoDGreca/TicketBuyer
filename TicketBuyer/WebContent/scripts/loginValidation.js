function validateEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function validatePassword(password) {
    return password.length >= 6;
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
    if (input.name === "email") {
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
    var form = document.getElementById("loginForm");

    form.addEventListener("submit", function(event) {
        if (!validateForm(form)) {
            event.preventDefault();
        }
    });

    var inputs = form.getElementsByTagName("input");
    for (var i = 0; i < inputs.length; i++) {
        inputs[i].addEventListener("blur", function(event) {
            validateInput(event.target);
        });
    }
});
