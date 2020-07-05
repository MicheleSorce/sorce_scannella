package pkg.bean;

public class ClientePrenotaPiatto extends Utente {
	
	private int id_ordine;
	private int id_piatto;	 //piatto_id_piatto nel DB
	private int id_cliente;	 //cliente_id_cliente nel DB
	private int quantita;
	private boolean stato_pagamento;
	private String stato_completamento;
	private String data_ordine;
	
	
	public int getId_ordine() {
		return id_ordine;
	}
	public void setId_ordine(int id_ordine) {
		this.id_ordine = id_ordine;
	}
	
	
	public int getId_piatto() {
		return id_piatto;
	}
	public void setId_piatto(int id_piatto) {
		this.id_piatto = id_piatto;
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
	
	
	public boolean getStato_pagamento() {
		return stato_pagamento;
	}
	public void setStato_pagamento(boolean stato_pagamento) {
		this.stato_pagamento = stato_pagamento;
	}
	
	
	public String getStato_completamento() {
		return stato_completamento;
	}
	public void setStato_completamento(String stato_completamento) {
		this.stato_completamento = stato_completamento;
	}
	public String getData_ordine() {
		return data_ordine;
	}
	public void setData_ordine(String data_ordine) {
		this.data_ordine = data_ordine;
	}
	
	
	

	

	

	
}
