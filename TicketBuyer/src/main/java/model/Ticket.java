package model;

public class Ticket {
    private int codiceBiglietto;
    private int codiceEvento;
    private String tipo;
    private String descrizione;
    private double prezzoUnitario;
    private boolean deleted;

    public Ticket() {}

    public Ticket(int codiceBiglietto, int codiceEvento, String tipo, String descrizione, double prezzoUnitario) {
        this.codiceBiglietto = codiceBiglietto;
        this.codiceEvento = codiceEvento;
        this.tipo = tipo;
        this.descrizione = descrizione;
        this.prezzoUnitario = prezzoUnitario;
        this.deleted = false;
    }

    public int getCodiceBiglietto() {
        return codiceBiglietto;
    }

    public void setCodiceBiglietto(int codiceBiglietto) {
        this.codiceBiglietto = codiceBiglietto;
    }

    public int getCodiceEvento() {
        return codiceEvento;
    }

    public void setCodiceEvento(int codiceEvento) {
        this.codiceEvento = codiceEvento;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public double getPrezzoUnitario() {
        return prezzoUnitario;
    }

    public void setPrezzoUnitario(double prezzoUnitario) {
        this.prezzoUnitario = prezzoUnitario;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }
}