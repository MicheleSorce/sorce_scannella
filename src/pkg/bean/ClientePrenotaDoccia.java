package pkg.bean;

public class ClientePrenotaDoccia {
	
	private int id_prenota_doccia;
	private int id_cliente;
	private int id_doccia ;
	private  String data_prenotazione;
	private int slot_orario; 
	//ref amministratore non messo, in caso togliere da db
	
	public int getId_prenota_doccia() {
		return id_prenota_doccia;
	}
	public void setId_prenota_doccia(int id_prenotazione) {
		this.id_prenota_doccia = id_prenotazione;
	}
	public int getSlot_orario() {
		return slot_orario;
	}
	public void setSlot_orario(int slot_orario) {
		this.slot_orario = slot_orario;
	}
	
	public int getId_doccia() {
		return id_doccia;
	}
	public void setId_doccia(int id_doccia) {
		this.id_doccia = id_doccia;
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
}