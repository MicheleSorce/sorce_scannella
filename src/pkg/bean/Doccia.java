package pkg.bean;

public class Doccia {
	
	private  int id_doccia;
	private boolean accesso_disabili; //1 si_Accesso_disabili, 0 no 

	private  boolean pulito; //1 non pulito, 0 pulito
	
	
	public int getId_doccia() {
		return id_doccia;
	}
	public void setId_doccia(int id_doccia) {
		this.id_doccia = id_doccia;
	}
	public boolean getAccesso_disabili() {
		return accesso_disabili;
	}
	public void setAccesso_disabili(boolean accesso_disabili) {
		this.accesso_disabili = accesso_disabili;
	}
	
	
	public boolean getPulito() {
		return pulito;
	}
	public void setPulito(boolean pulito) {
		this.pulito = pulito;
	}


}