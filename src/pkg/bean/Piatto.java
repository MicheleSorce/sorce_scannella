package pkg.bean;

public class Piatto {
	
	private int id_piatto;
	private String tipo;
	private String nome; 
	private float prezzo;
	private int disponibilita;
	private boolean menu_giorno;
	
	
	public int getId_piatto() {
		return id_piatto;
	}
	public void setId_piatto(int id_piatto) {
		this.id_piatto = id_piatto;
	}
	
	
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	
	
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	
	
	public float getPrezzo() {
		return prezzo;
	}
	public void setPrezzo(float prezzo) {
		this.prezzo = prezzo;
	}
	
	
	public int getDisponibilita() {
		return disponibilita;
	}
	public void setDisponibilita(int disponibilita) {
		this.disponibilita = disponibilita;
	}
	
	
	public boolean getMenu_giorno() {
		return menu_giorno;
	}
	public void setMenu_giorno(boolean menu_giorno) {
		this.menu_giorno = menu_giorno;
	}
	
	
}
