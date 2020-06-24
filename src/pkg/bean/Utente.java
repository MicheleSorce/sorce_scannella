package pkg.bean;

public class Utente {
	
	private  String nome ;
	private String cognome;
	private String telefono;
	private  String email;
	private  String pw;
	private  String data;
	private  int sesso;

	
	public void setNome(String nome) {
		this.nome=nome;
	}
	public String getNome() {
		return nome;
	}
	
	
	public void setCognome( String cognome) {
		this.cognome=cognome;
	}
	public String getCognome() {
		return cognome;
	}
	

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getTelefono() {
		return telefono;
	}
	
	
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmail() {
		return email;
	}
	

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getPw() {
		return pw;
	}


	public void setData(String data) {
		this.data = data;
	}
	public String getData() {
		return data;
	}

	
	
	public void setSesso(int sesso) { //1M, 2F, 3Altro 
		this.sesso = sesso;
	}
	public int getSesso() {
		return sesso;
	}
	
}
