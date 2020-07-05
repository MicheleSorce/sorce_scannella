package pkg.bean;

public class Cliente extends Utente {
	private float tot_pagamento;	
	private int idCliente;

	public void setIdCliente(int id) {
		this.idCliente=id;
	}
	public int getIdCliente() {
		return idCliente;
	}

	
	public void setTot_pagamento(float tot_pagamento) {
		this.tot_pagamento = tot_pagamento;
	}
	
	public float getTot_pagamento() {
		return tot_pagamento;
	}
	

	
}
