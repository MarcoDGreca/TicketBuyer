document.addEventListener("DOMContentLoaded", function() {
    const provinceSelect = document.getElementById("province");
    const citySelect = document.getElementById("city");
    const registrationForm = document.getElementById("registrationForm");

    provinceSelect.addEventListener("change", function() {
        const selectedProvince = provinceSelect.value;

        // Clear current options
        citySelect.innerHTML = '<option value="">Seleziona Città</option>';

        if (selectedProvince === "Napoli") {
            const option = document.createElement("option");
            option.value = "Napoli";
            option.text = "Napoli";
            citySelect.appendChild(option);
        } else if (selectedProvince === "Salerno") {
            const option1 = document.createElement("option");
            option1.value = "Salerno";
            option1.text = "Salerno";
            citySelect.appendChild(option1);

            const option2 = document.createElement("option");
            option2.value = "Fisciano";
            option2.text = "Fisciano";
            citySelect.appendChild(option2);
        }
    });

    registrationForm.addEventListener("submit", function(event) {
        const email = document.getElementById("email");
        const password = document.getElementById("password");
        const name = document.getElementById("name");
        const surname = document.getElementById("surname");
        const address = document.getElementById("address");
        const number = document.getElementById("number");
        const phone = document.getElementById("phone");

        let valid = true;

        if (!validateEmail(email.value)) {
            showError(email, "Email non valida");
            valid = false;
        } else {
            clearError(email);
        }

        if (password.value.length < 6) {
            showError(password, "La password deve contenere almeno 6 caratteri");
            valid = false;
        } else {
            clearError(password);
        }

        if (name.value.trim() === "") {
            showError(name, "Nome obbligatorio");
            valid = false;
        } else {
            clearError(name);
        }

        if (surname.value.trim() === "") {
            showError(surname, "Cognome obbligatorio");
            valid = false;
        } else {
            clearError(surname);
        }

        if (address.value.trim() === "") {
            showError(address, "Via obbligatoria");
            valid = false;
        } else {
            clearError(address);
        }

        if (number.value.trim() === "") {
            showError(number, "Numero obbligatorio");
            valid = false;
        } else {
            clearError(number);
        }

        if (!validatePhone(phone.value)) {
            showError(phone, "Numero di telefono non valido");
            valid = false;
        } else {
            clearError(phone);
        }

        if (!valid) {
            event.preventDefault();
        }
    });

    function validateEmail(email) {
        const re = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
        return re.test(email);
    }

    function validatePhone(phone) {
        const re = /^[0-9]{10}$/;
        return re.test(phone);
    }

    function showError(element, message) {
        element.classList.add("error");
        const errorElement = document.createElement("span");
        errorElement.classList.add("error-message");
        errorElement.textContent = message;
        if (element.nextSibling) {
            element.parentNode.removeChild(element.nextSibling);
        }
        element.parentNode.appendChild(errorElement);
    }

    function clearError(element) {
        element.classList.remove("error");
        if (element.nextSibling) {
            element.parentNode.removeChild(element.nextSibling);
        }
    }
});

