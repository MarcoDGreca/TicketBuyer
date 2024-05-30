package model;
import java.sql.Date;

public class Review {

    private int codiceRecensione;
    private int codiceProdotto;
    private String emailCliente;
    private int votazione;
    private String testo;
    private Date dataRecensione;

    public Review(int codiceRecensione, int codiceProdotto, String emailCliente, int votazione, String testo, Date dataRecensione) {
        this.codiceRecensione = codiceRecensione;
        this.codiceProdotto = codiceProdotto;
        this.emailCliente = emailCliente;
        this.votazione = votazione;
        this.testo = testo;
        this.dataRecensione = dataRecensione;
    }

    public int getCodiceRecensione() {
        return codiceRecensione;
    }

    public void setCodiceRecensione(int codiceRecensione) {
        this.codiceRecensione = codiceRecensione;
    }
    
    public int getCodiceProdotto() {
        return codiceProdotto;
    }

    public void setCodiceProdotto(int codiceProdotto) {
        this.codiceProdotto = codiceProdotto;
    }
    
    public String getemailCliente() {
        return emailCliente;
    }

    public void setemailCliente(String emailCliente) {
        this.emailCliente = emailCliente;
    }
    
    public int getVotazione() {
        return votazione;
    }

    public void setVotazione(int votazione) {
    	if(votazione >=0 && votazione <=5)
        this.votazione = votazione;
    }
    
    public String gettesto() {
        return testo;
    }

    public void settesto(String testo) {
        this.testo = testo;
    }
    
    public Date getdataRecensione() {
        return dataRecensione;
    }

    public void setdataRecensione(Date dataRecensione) {
        this.dataRecensione = dataRecensione;
    }
}