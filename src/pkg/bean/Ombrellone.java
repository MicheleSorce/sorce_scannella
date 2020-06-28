package pkg.bean;

public class Ombrellone {
	
	private  int id_ombrellone ;
	private int num_persone;
	private int num_lettini;
	private int num_sdraio;

	private  String zona; //vip superior standard

	private  Float prezzo;
	private  boolean libero; //true libero, false occupato
	private  boolean pulito; //false sporco, true pulito
	
	
	public int getId_ombrellone() {
		return id_ombrellone;
	}
	public void setId_ombrellone(int id_ombrellone) {
		this.id_ombrellone = id_ombrellone;
	}
	public int getNum_persone() {
		return num_persone;
	}
	public void setNum_persone(int num_persone) {
		this.num_persone = num_persone;
	}
	public int getNum_lettini() {
		return num_lettini;
	}
	public void setNum_lettini(int num_lettini) {
		this.num_lettini = num_lettini;
	}
	public int getNum_sdraio() {
		return num_sdraio;
	}
	public void setNum_sdraio(int num_sdraio) {
		this.num_sdraio = num_sdraio;
	}

	
	public Float getPrezzo() {
		return prezzo;
	}
	public void setPrezzo(Float prezzo) {
		this.prezzo = prezzo;
	}
	public boolean getLibero() {
		return libero;
	}
	public void setLibero(boolean libero) {
		this.libero = libero;
	}
	public boolean getPulito() {
		return pulito;
	}
	public void setPulito(boolean pulito) {
		this.pulito = pulito;
	}
	public String getZona() {
		return zona;
	}
	public void setZona(String zona) {
		this.zona = zona;
	}

}