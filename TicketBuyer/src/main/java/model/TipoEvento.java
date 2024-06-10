package model;

public enum TipoEvento {
	SPORT("Sport"),
    CONCERTO("Concerto"),
    FIERA("Fiera");

    private final String tipo;

    TipoEvento (String tipo) {
        this.tipo = tipo;
    }

    public String getTipo() {
        return tipo;
    }

    public static TipoEvento fromString(String tipo) {
        for (TipoEvento r : TipoEvento.values()) {
            if (r.getTipo().equalsIgnoreCase(tipo)) {
                return r;
            }
        }
        throw new IllegalArgumentException("Tipo non valido: " + tipo);
    }
}
