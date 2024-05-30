package model;

import java.util.Date;

public class Event {
    private int codiceEvento;
    private String nome;
    private String luogo;
    private Date dataEvento;
    private String orario;
    private int disponibilita;

    public Event() {}

    public Event(int codiceEvento, String nome, String luogo, Date dataEvento, String orario, int disponibilita) {
        this.codiceEvento = codiceEvento;
        this.nome = nome;
        this.luogo = luogo;
        this.dataEvento = dataEvento;
        this.orario = orario;
        this.disponibilita = disponibilita;
    }

    public int getCodiceEvento() {
        return codiceEvento;
    }

    public void setCodiceEvento(int codiceEvento) {
        this.codiceEvento = codiceEvento;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getLuogo() {
        return luogo;
    }

    public void setLuogo(String luogo) {
        this.luogo = luogo;
    }

    public Date getDataEvento() {
        return dataEvento;
    }

    public void setDataEvento(Date dataEvento) {
        this.dataEvento = dataEvento;
    }

    public String getOrario() {
        return orario;
    }

    public void setPrezzo(String orario) {
        this.orario = orario;
    }

    public int getDisponibilita() {
        return disponibilita;
    }

    public void setDisponibilita(int disponibilita) {
        this.disponibilita = disponibilita;
    }
}
