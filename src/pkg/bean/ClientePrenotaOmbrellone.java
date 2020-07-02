package pkg.bean;

public class ClientePrenotaOmbrellone {
	
	private int id_prenotazione;
	private int id_cliente;
	private int id_ombrellone ;
	private boolean pagato;
	private  String data_prenotazione;
	private int slot_orario; // 1 mattina 2=pm
	private int num_persone;
	private int num_lettini;
	private int num_sdraio;
	
	public int getId_prenotazione() {
		return id_prenotazione;
	}
	public void setId_prenotazione(int id_prenotazione) {
		this.id_prenotazione = id_prenotazione;
	}
	public int getSlot_orario() {
		return slot_orario;
	}
	public void setSlot_orario(int slot_orario) {
		this.slot_orario = slot_orario;
	}
	
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
	public boolean getPagato() {
		return pagato;
	}
	public void setPagato(boolean pagato) {
		this.pagato = pagato;
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

	

}