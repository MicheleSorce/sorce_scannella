package pkg.db;

import pkg.bean.*;
import java.sql.*;
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
	
	/*
	 * public String whoUserType(String email, String pw) { String[] user = {
	 * "amministratore", "bagnino", "barista", "cliente"};
	 * 
	 * String user_win="";
	 * 
	 * try { Connection connection3 = ds.getConnection();
	 * 
	 * String search = "SELECT * FROM  amministratore WHERE email=? AND pw=?";
	 * PreparedStatement statement = connection3.prepareStatement(search);
	 * statement.setString(1, email); statement.setString(2, pw);
	 * 
	 * ResultSet rs = statement.executeQuery();
	 * 
	 * if (rs.next()) { //true-> matcha qualcosa user_win="amministratore";
	 * rs.close(); statement.close(); connection3.close(); }else {
	 * 
	 * String search2 = "SELECT * FROM  bagnino WHERE email=? AND pw=?";
	 * PreparedStatement statement2 = connection3.prepareStatement(search2);
	 * statement2.setString(1, email); statement2.setString(2, pw);
	 * 
	 * ResultSet rs2 = statement2.executeQuery();
	 * 
	 * if (rs2.next()) { //true-> matcha qualcosa user_win="bagnino"; rs2.close();
	 * statement2.close(); connection3.close(); } } }catch(SQLException e) {
	 * e.printStackTrace(); } return user_win; }
	 */
	
	public String whoUserType2(String email, String pw) {
		
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
}	
	
	
	
	
	
	
	
		