package model;

import java.util.Date;
import java.util.List;

public class Order {
    private int codiceOrdine;
    private String emailCliente;
    private double prezzoTotale;
    private Date dataAcquisto;
    private Stato state;
    private List<OrderDetail> dettagliOrdine;

    public Order() {}

    public Order(int codiceOrdine, String emailCliente, double prezzoTotale, Date dataAcquisto, List<OrderDetail> dettagliOrdine, Stato state) {
        this.codiceOrdine = codiceOrdine;
        this.emailCliente = emailCliente;
        this.prezzoTotale = prezzoTotale;
        this.dataAcquisto = dataAcquisto;
        this.dettagliOrdine = dettagliOrdine;
        this.state = state;
    }

    public int getCodiceOrdine() {
        return codiceOrdine;
    }

    public void setCodiceOrdine(int codiceOrdine) {
        this.codiceOrdine = codiceOrdine;
    }

    public String getEmailCliente() {
        return emailCliente;
    }

    public void setEmailCliente(String emailCliente) {
        this.emailCliente = emailCliente;
    }

    public double getPrezzoTotale() {
        return prezzoTotale;
    }

    public void setPrezzoTotale(double prezzoTotale) {
        this.prezzoTotale = prezzoTotale;
    }

    public Date getDataAcquisto() {
        return dataAcquisto;
    }

    public void setDataAcquisto(Date dataAcquisto) {
        this.dataAcquisto = dataAcquisto;
    }
    
    public Stato getState() {
        return state;
    }

    public void setState(Stato state) {
        this.state = state;
    }


    public List<OrderDetail> getDettagliOrdine() {
        return dettagliOrdine;
    }

    public void setDettagliOrdine(List<OrderDetail> dettagliOrdine) {
        this.dettagliOrdine = dettagliOrdine;
    }
}
