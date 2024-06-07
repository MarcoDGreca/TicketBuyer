package model;

public enum Stato {
    IN_LAVORAZIONE("In lavorazione"),
    COMPLETATO("Completato");

    private final String stato;

    Stato(String stato) {
        this.stato = stato;
    }

    public String getStato() {
        return stato;
    }

    public static Stato fromString(String stato) {
        for (Stato s : Stato.values()) {
            if (s.getStato().equalsIgnoreCase(stato)) {
                return s;
            }
        }
        throw new IllegalArgumentException("Stato non valido: " + stato);
    }
}

