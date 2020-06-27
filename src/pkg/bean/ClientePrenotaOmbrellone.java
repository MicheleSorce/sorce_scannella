package pkg.bean;

public class ClientePrenotaOmbrellone {
	private int id_cliente;
	private int id_ombrellone ;
	private int quantita;
	private boolean pagato;
	private  String data_prenotazione;
	
	
	public int getId_ombrellone() {
		return id_ombrellone;
	}
	public void setId_ombrellone(int id_ombrellone) {
		this.id_ombrellone = id_ombrellone;
	}

	public String getData_prenotazione() {
		return data_prenotazione;
	}
	public void setData_prenotazione(String data_prenotazione) {
		this.data_prenotazione = data_prenotazione;
	}
	public int getId_cliente() {
		return id_cliente;
	}
	public void setId_cliente(int id_cliente) {
		this.id_cliente = id_cliente;
	}
	public int getQuantita() {
		return quantita;
	}
	public void setQuantita(int quantita) {
		this.quantita = quantita;
	}
	public boolean getPagato() {
		return pagato;
	}
	public void setPagato(boolean pagato) {
		this.pagato = pagato;
	}
	
	

}