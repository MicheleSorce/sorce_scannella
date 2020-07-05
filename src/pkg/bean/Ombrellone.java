package pkg.bean;

public class Ombrellone {
	
	private  int id_ombrellone ;
	private  String zona; //vip superior standard
	private  Float prezzo;
	private  boolean pulito; //false sporco, true pulito
	
	
	public int getId_ombrellone() {
		return id_ombrellone;
	}
	public void setId_ombrellone(int id_ombrellone) {
		this.id_ombrellone = id_ombrellone;
	}
	
	public Float getPrezzo() {
		return prezzo;
	}
	public void setPrezzo(Float prezzo) {
		this.prezzo = prezzo;
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