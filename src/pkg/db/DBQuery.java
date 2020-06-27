package pkg.db;

import pkg.bean.*;


import java.sql.*;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBQuery {
	// public Context ctx ;
	public DataSource ds;


	//public PreparedStatement statement ;
	// public ResultSet rs ;
	


	public DBQuery() {
			
			try {
				Context ctx = new InitialContext();
				ds = (DataSource) ctx.lookup("java:comp/env/jdbc/sorcescannella"); //l'unica che mi connette al db
			} catch (Exception e) {
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
		
		String user_win="";
		try {
			Connection connection3 = ds.getConnection();
			String search = "SELECT * FROM  amministratore WHERE email=? AND pw=?";
			boolean flag= checkTable(search ,connection3, email, pw);
			if (flag==true) {
				return "amministratore";
			}else {
				String search2 = "SELECT * FROM  bagnino WHERE email=? AND pw=?";
				boolean flag2= checkTable(search2 ,connection3, email, pw);
				if(flag2== true) {
					return "bagnino";
				}else {
					String search3 = "SELECT * FROM  barista WHERE email=? AND pw=?";
					boolean flag3= checkTable(search3 ,connection3, email, pw);
					if(flag3== true) {
						return "barista";
					}else {
						String search4 = "SELECT * FROM  cliente WHERE email=? AND pw=?";
						boolean flag4= checkTable(search4 ,connection3, email, pw);
						if(flag4== true) {
							return "cliente";
						}
					}
				}
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}		
		return user_win;
	}
	
	
	
	public boolean checkTable(String search, Connection conn, String email,String pw) {
		PreparedStatement statement;
		try {
			statement = conn.prepareStatement(search);
			statement.setString(1, email);
			statement.setString(2, pw);
			
			ResultSet rs = statement.executeQuery();
			
			if (rs.next()) { //true-> matcha qualcosa
				rs.close();
				statement.close();
				conn.close();
				return true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
		
	}
	
	
	public Object searchAmm_Bar_Bag(String email, String type_utente, String id) {
	
		Object[] array_fields= new Object[8];
		try {
			Connection connection4 = ds.getConnection();
			PreparedStatement statement = connection4.prepareStatement("SELECT * FROM " + type_utente + " WHERE email=?");
			statement.setString(1, email);
			
			ResultSet rs = statement.executeQuery();
		
			if (rs.next()) { //true-> matcha qualcosa
				array_fields[0]=rs.getInt(id);
				array_fields[1]=rs.getString("nome");
				array_fields[2]=rs.getString("cognome");
				array_fields[3]=rs.getString("telefono");
				array_fields[4]=rs.getString("email");
				array_fields[5]=rs.getString("pw");
				array_fields[6]=rs.getString("data_nascita");
				array_fields[7]=rs.getInt("sesso");
			}
			rs.close();
			statement.close();
			connection4.close();
		}catch(SQLException e){
				e.printStackTrace();
		}
		return array_fields;
	}
	
	public Object searchCliente(String email, String id){
		Object[] array_fields= new Object[9];

		try {
			Connection connection4 = ds.getConnection();
			PreparedStatement statement = connection4.prepareStatement("SELECT * FROM cliente WHERE email=?");
			statement.setString(1, email);
			
			ResultSet rs = statement.executeQuery();
		
			if (rs.next()) { //true-> matcha qualcosa
				array_fields[0]=rs.getInt(id);
				array_fields[1]=rs.getString("nome");
				array_fields[2]=rs.getString("cognome");
				array_fields[3]=rs.getString("telefono");
				array_fields[4]=rs.getString("email");
				array_fields[5]=rs.getString("pw");
				array_fields[6]=rs.getString("data_nascita");
				array_fields[7]=rs.getInt("sesso");
				array_fields[8]=rs.getFloat("tot_pagamento");
			}
			rs.close();
			statement.close();
			connection4.close();
		}catch(SQLException e){
				e.printStackTrace();
		}
		return array_fields;
		
	}
	
	public boolean modifyPw(String email, String new_pw){
		//String user="";
		boolean isModified = false;
		try {
			Connection connection5 = ds.getConnection();
			Connection connection6 = ds.getConnection();
			Connection connection7 = ds.getConnection();
			Connection connection8 = ds.getConnection();
			Connection connection9 = ds.getConnection();
			
			String search = "SELECT * FROM amministratore WHERE email=?";
			boolean isEmail= checkEmail(search ,connection5, email);
			if (isEmail==true) {
				isModified=updatePw("amministratore", connection6, email, new_pw);	
			}else {
				String search2 = "SELECT * FROM  bagnino WHERE email=?"; 
				boolean isEmail2=checkEmail(search2 ,connection5, email); 
				if(isEmail2== true) {
					isModified=updatePw("bagnino", connection7, email, new_pw);
				 } else { 
					 String search3 = "SELECT * FROM  barista WHERE email=?"; 
					 boolean isEmail3= checkEmail(search3,connection5, email);
					 if(isEmail3== true) { 
						isModified= updatePw( "barista", connection8, email, new_pw);
						}else { 
							String search4 = "SELECT * FROM  cliente WHERE email=?"; 
							boolean isEmail4= checkEmail(search4 ,connection5, email); 
							if(isEmail4== true) { 
								isModified=updatePw( "cliente", connection9, email, new_pw); 
							}
						} 
					}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return isModified;
	}	
	
	public boolean checkEmail(String search, Connection conn, String email) {
			PreparedStatement statement;
			try {
				statement = conn.prepareStatement(search);
				statement.setString(1, email);
		
				ResultSet rs = statement.executeQuery();
				
				if (rs.next()) { //true-> matcha qualcosa
					rs.close();
					statement.close();
					conn.close();
					return true;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return false;

	}
	
	public boolean updatePw( String user,Connection conn, String email, String new_pw) {
		boolean isModified = false;
		try {
			String update = "UPDATE " + user + " SET pw=? WHERE email=?";
			PreparedStatement statement = conn.prepareStatement(update);
			
			statement.setString(1, new_pw); 
			statement.setString(2, email);	  		 
			
			if(statement.executeUpdate()==0) {	//num righe che ha modificato
				isModified= false;
			}else {
				isModified = true;
			}

			statement.close();
			conn.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return isModified;
	}

	public Object[] getOmbrelloneFromDb(int id) { 			//non ci serve per ora
		//Ombrellone ombrellone=new Ombrellone();
		Object[] result= new Object[10];
		
		try {
			Connection connection = ds.getConnection();
			PreparedStatement statement = connection.prepareStatement("SELECT * FROM ombrellone WHERE id_ombrellone=?");
			statement.setInt(1, id);
			
			ResultSet rs = statement.executeQuery();
		
			if (rs.next()) { //true-> matcha qualcosa
				
				result[0]=rs.getInt("id_ombrellone");
				result[1]=rs.getInt("num_persone");
				result[2]=rs.getInt("num_lettini");
				result[3]=rs.getInt("num_sdraio");
				result[4]=rs.getInt("slot_orario");
				result[5]=rs.getString("data_prenotazione");
				result[6]=rs.getString("zona");
				result[7]=rs.getFloat("prezzo");
				result[8]=rs.getBoolean("stato_occupazione");
				result[9]=rs.getBoolean("stato_pulizia");
			}
			rs.close();
			statement.close();
			connection.close();
		}catch(SQLException e){
				e.printStackTrace();
		}
		return result;
	}
	
	public ArrayList<ClientePrenotaOmbrellone> getListaPrenotazioneOmbrellone(String data_scelta){
		 ArrayList<ClientePrenotaOmbrellone> lista= new ArrayList<ClientePrenotaOmbrellone>();
		 Object[] result= new Object[5];
		
			
		 try {
				Connection connection = ds.getConnection();
				PreparedStatement statement = connection.prepareStatement("SELECT * FROM cliente_prenota_ombrellone WHERE data_prenotazione=?");
				statement.setString(1, data_scelta);
				
				ResultSet rs = statement.executeQuery();
			
				while (rs.next()) { //true-> matcha qualcosa
					ClientePrenotaOmbrellone prenotazione= new ClientePrenotaOmbrellone();
					
					result[0]=rs.getInt("cliente_id_cliente");
					result[1]=rs.getInt("ombrellone_id_ombrellone");
					result[2]=rs.getInt("quantita");
					result[3]=rs.getBoolean("stato_pagamento");
					result[4]=rs.getDate("data_prenotazione");
					
					prenotazione.setId_cliente((Integer)result[0]);
					prenotazione.setId_ombrellone((Integer)result[1]);
					prenotazione.setQuantita((Integer)result[2]);
					prenotazione.setPagato((boolean)result[3]);
					prenotazione.setData_prenotazione(data_scelta);
					
					lista.add(prenotazione);
					prenotazione= null;
					
				}	
				rs.close();
				statement.close();
				connection.close();
		 	}catch(SQLException e){
					e.printStackTrace();
			}
		return lista;
	}
	
	public int getNumRighePerData(String data) {
		int num=0;
		
		return num;
	}
	
	
	
	
}	
	
	
	
	
	
	
	
		