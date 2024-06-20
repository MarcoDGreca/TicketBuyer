package model;

import java.util.Date;

public class Event {
    private int codiceEvento;
    private String nome;
    private String luogo;
    private Date dataEvento;
    private String orario;
    private TipoEvento tipo;

    private String image;

    public Event() {}

    public Event(int codiceEvento, String nome, String luogo, Date dataEvento, String orario,TipoEvento tipo) {
        this.codiceEvento = codiceEvento;
        this.nome = nome;
        this.luogo = luogo;
        this.dataEvento = dataEvento;
        this.orario = orario;
        this.tipo = tipo;
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
    
    public void setOrario(String orario) {
		this.orario = orario;	
	}
    
    public String getTipo() {
        return tipo.getTipo();
    }
    
    public void setTipo(TipoEvento tipo) {
		this.tipo = tipo;	
	}

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

}
