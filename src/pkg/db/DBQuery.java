package pkg.db;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import pkg.bean.Cliente;



public class DBQuery {
	// public Context ctx ;
	 public DataSource ds;

	//public PreparedStatement statement ;
	// public ResultSet rs ;
	


	public DBQuery() {
			
			try {
				Context ctx = new InitialContext();
				ds = (DataSource) ctx.lookup("java:comp/env/jdbc/sorcescannella"); //l'unica che mi connette al db
			} catch (NamingException e) {
				e.printStackTrace();
			}
			
	}

	public boolean isRegistrated(Cliente cliente) {
		 boolean res = false;
		try {
			
			Connection connection = ds.getConnection();
			PreparedStatement statement = connection.prepareStatement("SELECT email FROM cliente WHERE email=?");
			statement.setString(1, cliente.getEmail());
			
			ResultSet rs = statement.executeQuery();
		
			if (rs.next()) { //true-> matcha qualcosa
				res= true;
			}else {
				res= false;
			}
			rs.close();
			statement.close();
			connection.close();
		}catch(SQLException e){
				e.printStackTrace();
		}
		return res;
	}
	

	public boolean insertCliente(Cliente cliente){
		boolean res = false;
		try {
			Connection connection1 = ds.getConnection();
			String insert = "insert into cliente(id_cliente, nome, cognome, telefono, email, pw, data_nascita,sesso, tot_pagamento) values (?,?,?,?,?,?,?,?,?)";
			PreparedStatement statement = connection1.prepareStatement(insert);
			
			
			statement.setInt(1, this.firstIdClientAvailable());
			statement.setString(2, cliente.getNome());
			statement.setString(3, cliente.getCognome());
			statement.setString(4, cliente.getTelefono());
			statement.setString(5, cliente.getEmail());
			statement.setString(6, cliente.getPw());
			statement.setString(7, cliente.getData());
			statement.setInt(8, cliente.getSesso());
			statement.setFloat(9, cliente.getTot_pagamento());
		
			//statement.executeUpdate(); //0 (non ritorna niente) o 1

			if(statement.executeUpdate() == 0) {
				res= false;
			}else {
				res=true;
			}
			
			statement.close();
			connection1.close();
			
		}catch(SQLException e){
				e.printStackTrace();
		}
		return res;
		
	}
	

	
	public int firstIdClientAvailable() {
		int res = 0;
		try {
			
			Connection connection2 = ds.getConnection();
			
			Statement statement = connection2.createStatement();
			ResultSet rs = statement.executeQuery("SELECT id_cliente FROM cliente ORDER BY id_cliente DESC	LIMIT 1");
		
			if (rs.next()) { //true-> matcha qualcosa
				res= rs.getInt("id_cliente");
			}
			rs.close();
			statement.close();
			connection2.close();
		}catch(SQLException e){
				e.printStackTrace();
		}
		return res+1;
	}
	
	public String whoUserType(String email, String pw) {
		String[] user = { "amministratore", "bagnino", "barista", "cliente"};
		String user_win="ciao";
		
		try {
			Connection connection3 = ds.getConnection();
			
			for(int i=0; i<user.length; i++) {
				String search = "SELECT * FROM "+ user[i] +"WHERE email=? AND pw=?";
				
				PreparedStatement statement = connection3.prepareStatement(search);
				statement.setString(1, email);
				statement.setString(2, pw);
				
				ResultSet rs = statement.executeQuery();
				
				if (rs.next()) { //true-> matcha qualcosa
					user_win= user[i];
					rs.close();
					statement.close();
					connection3.close();
				}
				
			}
		
		}catch(SQLException e) {
			e.printStackTrace();
		}		
		return user_win;
	}
	
	
	
	
	
	
	
	
	
//	protected void finalize() {
//		try{
//			connection.close();
//		}
//		catch(SQLException e){
//			e.printStackTrace();
//		}			
//	}
//
//	public int validate(String nomeUtente, String passwd){
//		int result = -1;
//		
//		try{
//			Statement stat = conn.createStatement();
//			String sql = String.format("SELECT Permessi FROM users WHERE NomeUtente = \"%s\" AND Password = \"%s\"", nomeUtente, passwd);
//			ResultSet rs = stat.executeQuery(sql);
//			
//			if (rs.next())
//				result = rs.getInt("Permessi");
//			
//			rs.close();
//			stat.close();
//		}
//		catch(SQLException e){
//			e.printStackTrace();
//		}
//
//		return result;
//	}
	
		
	/*
	 * public String[] selectStudent(String id) { String[] s = new String[4]; try{
	 * PreparedStatement statement =
	 * connection.prepareStatement("SELECT * FROM student WHERE ID=?");
	 * statement.setString(1, id); ResultSet rs = statement.executeQuery();
	 * 
	 * if (rs.next()) { s[0] = rs.getString("code"); s[1] =
	 * rs.getString("firstname"); s[2] = rs.getString("lastname"); s[3] =
	 * rs.getString("birthdate"); } rs.close(); statement.close(); }
	 * catch(SQLException e){ e.printStackTrace(); }
	 * 
	 * return s; }
	 * 
	 * public int insertUtente(int code, String firstname, String lastname, Date
	 * birthdate) { int risultato = -1;
	 * 
	 * try{ PreparedStatement statement = connection.
	 * prepareStatement("INSERT INTO users (NomeUtente, Password, Permessi) VALUES (?,?,?)"
	 * ); statement.setInt(1, code); statement.setString(2, firstname);
	 * statement.setString(3, lastname); statement.setDate(4, birthdate); risultato
	 * = statement.executeUpdate();
	 * 
	 * statement.close(); } catch(SQLException e){ e.printStackTrace(); }
	 * 
	 * return risultato; }
	 * 
	 * 
	 * 
	 * // public int updateUtente(String oldNome, String newNome, String password,
	 * String permessi) { // int risultato = -1; // // try{ // PreparedStatement
	 * statement = connection.
	 * prepareStatement("UPDATE users SET NomeUtente=?, Password=?, Permessi=? WHERE NomeUtente=?"
	 * ); // statement.setString(1, newNome); // statement.setString(2, password);
	 * // statement.setString(3, permessi); // statement.setString(4, oldNome); //
	 * risultato = statement.executeUpdate(); // // statement.close(); // } //
	 * catch(SQLException e){ // e.printStackTrace(); // } // // return risultato;
	 * // }
	 * 
	 * 
	 * 
	 * public int deleteUtente(String nomeUtente) { int risultato = -1;
	 * 
	 * try{ PreparedStatement statement =
	 * connection.prepareStatement("DELETE FROM student WHERE code = ?");
	 * statement.setString(1, nomeUtente); risultato = statement.executeUpdate();
	 * 
	 * statement.close(); } catch(SQLException e){ e.printStackTrace(); }
	 * 
	 * return risultato; }
	 */
}
	
	
