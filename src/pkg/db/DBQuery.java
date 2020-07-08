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

	public boolean isClienteRegistrated(String email) {
		boolean res = false;
		try {
			
			Connection connection = ds.getConnection();
			PreparedStatement statement = connection.prepareStatement("SELECT email FROM cliente WHERE email=?");
			statement.setString(1, email);
			
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

	public boolean isAmminRegistrated(String email) {
		boolean res = false;
		try {
			
			Connection connection = ds.getConnection();
			PreparedStatement statement = connection.prepareStatement("SELECT email FROM amministratore WHERE email=?");
			statement.setString(1, email);
			
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
	
	public boolean isBagninoRegistrated(String email) {
		boolean res = false;
		try {
			
			Connection connection = ds.getConnection();
			PreparedStatement statement = connection.prepareStatement("SELECT email FROM bagnino WHERE email=?");
			statement.setString(1, email);
			
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
	
	public boolean isBaristaRegistrated(String email) {
		boolean res = false;
		try {
			
			Connection connection = ds.getConnection();
			PreparedStatement statement = connection.prepareStatement("SELECT email FROM barista WHERE email=?");
			statement.setString(1, email);
			
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
	
	public boolean insertAmmin(Amministratore ammin){
		boolean res = false;
		try {
			Connection connection1 = ds.getConnection();
			String insert = "insert into amministratore(id_amministratore, nome, cognome, telefono, email, pw, data_nascita,sesso) values (?,?,?,?,?,?,?,?)";
			PreparedStatement statement = connection1.prepareStatement(insert);
			
			statement.setInt(1, this.firstIdAmminAvailable());
			statement.setString(2, ammin.getNome());
			statement.setString(3, ammin.getCognome());
			statement.setString(4, ammin.getTelefono());
			statement.setString(5, ammin.getEmail());
			statement.setString(6, ammin.getPw());
			statement.setString(7, ammin.getData());
			statement.setInt(8, ammin.getSesso());

		
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
	
	public boolean insertBarista(Barista barista){
		boolean res = false;
		try {
			Connection connection1 = ds.getConnection();
			String insert = "insert into barista(id_barista, nome, cognome, telefono, email, pw, data_nascita,sesso) values (?,?,?,?,?,?,?,?)";
			PreparedStatement statement = connection1.prepareStatement(insert);
			
			statement.setInt(1, this.firstIdBaristaAvailable());
			statement.setString(2, barista.getNome());
			statement.setString(3, barista.getCognome());
			statement.setString(4, barista.getTelefono());
			statement.setString(5, barista.getEmail());
			statement.setString(6, barista.getPw());
			statement.setString(7, barista.getData());
			statement.setInt(8, barista.getSesso());

		
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
	
	
	public boolean insertBagnino(Bagnino bagnino){
		boolean res = false;
		try {
			Connection connection1 = ds.getConnection();
			String insert = "insert into bagnino( id_bagnino, nome, cognome, telefono, email, pw, data_nascita,sesso) values (?,?,?,?,?,?,?,?)";
			PreparedStatement statement = connection1.prepareStatement(insert);
			

			statement.setInt(1, this.firstIdBagninoAvailable());
			statement.setString(2, bagnino.getNome());
			statement.setString(3, bagnino.getCognome());
			statement.setString(4, bagnino.getTelefono());
			statement.setString(5, bagnino.getEmail());
			statement.setString(6, bagnino.getPw());
			statement.setString(7, bagnino.getData());
			statement.setInt(8, bagnino.getSesso());

		
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
	
	public int firstIdBagninoAvailable() {
		int res = 0;
		try {
			
			Connection connection2 = ds.getConnection();
			
			Statement statement = connection2.createStatement();
			ResultSet rs = statement.executeQuery("SELECT id_bagnino FROM bagnino ORDER BY id_bagnino DESC	LIMIT 1");
		
			if (rs.next()) { //true-> matcha qualcosa
				res= rs.getInt("id_bagnino");
			}
			rs.close();
			statement.close();
			connection2.close();
		}catch(SQLException e){
				e.printStackTrace();
		}
		return res+1;
	}
	public int firstIdAmminAvailable() {
		int res = 0;
		try {
			
			Connection connection2 = ds.getConnection();
			
			Statement statement = connection2.createStatement();
			ResultSet rs = statement.executeQuery("SELECT id_amministratore FROM amministratore ORDER BY id_amministratore DESC	LIMIT 1");
		
			if (rs.next()) { //true-> matcha qualcosa
				res= rs.getInt("id_amministratore");
			}
			rs.close();
			statement.close();
			connection2.close();
		}catch(SQLException e){
				e.printStackTrace();
		}
		return res+1;
	}
	public int firstIdBaristaAvailable() {
		int res = 0;
		try {
			
			Connection connection2 = ds.getConnection();
			
			Statement statement = connection2.createStatement();
			ResultSet rs = statement.executeQuery("SELECT id_barista FROM barista ORDER BY id_barista DESC	LIMIT 1");
		
			if (rs.next()) { //true-> matcha qualcosa
				res= rs.getInt("id_barista");
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

	public Ombrellone getOmbrelloneFromDb(int id) { 			
		
		Ombrellone ombrellone= new Ombrellone();
		
		try {
			Connection connection = ds.getConnection();
			PreparedStatement statement = connection.prepareStatement("SELECT * FROM ombrellone WHERE id_ombrellone=?");
			statement.setInt(1, id);
			
			ResultSet rs = statement.executeQuery();
		
				
			if (rs.next()) { //true-> matcha qualcosa
				
				ombrellone.setId_ombrellone(rs.getInt("id_ombrellone"));
				ombrellone.setZona(rs.getString("zona"));
				ombrellone.setPrezzo(rs.getFloat("prezzo"));
				ombrellone.setPulito(rs.getBoolean("stato_pulizia"));
			}
			rs.close();
			statement.close();
			connection.close();
		}catch(SQLException e){
				e.printStackTrace();
		}
		

		return ombrellone;
	}
	
	public ArrayList<ClientePrenotaOmbrellone> getListaPrenotazioneOmbrellone(String data_scelta, int slot_orario){
		 ArrayList<ClientePrenotaOmbrellone> lista= new ArrayList<ClientePrenotaOmbrellone>();
		 Object[] result= new Object[9];
		
			
		 try {
				Connection connection = ds.getConnection();
				PreparedStatement statement = connection.prepareStatement("SELECT * FROM cliente_prenota_ombrellone WHERE data_prenotazione=? and slot_orario=?");
				statement.setString(1, data_scelta);
				statement.setInt(2, slot_orario);

				ResultSet rs = statement.executeQuery();
			
				while (rs.next()) { //true-> matcha qualcosa
					
					ClientePrenotaOmbrellone prenotazione= new ClientePrenotaOmbrellone();
					
					result[0]=rs.getInt("id_prenotazione");
					result[1]=rs.getInt("cliente_id_cliente");
					result[2]=rs.getInt("ombrellone_id_ombrellone");
					result[3]=rs.getBoolean("stato_pagamento");
					result[4]=rs.getDate("data_prenotazione");
					result[5]=rs.getInt("slot_orario");
					result[6]=rs.getInt("num_lettini");
					result[7]=rs.getInt("num_persone");
					result[8]=rs.getInt("num_sdraio");
					
					prenotazione.setId_prenotazione((Integer)(result[0]));
					prenotazione.setId_cliente((Integer)result[1]);
					prenotazione.setId_ombrellone((Integer)result[2]);
					prenotazione.setPagato((boolean)result[3]);
					prenotazione.setData_prenotazione(data_scelta);
					prenotazione.setSlot_orario(slot_orario);				
					prenotazione.setNum_lettini((Integer)result[6]);
					prenotazione.setNum_persone((Integer)result[7]);
					prenotazione.setNum_sdraio((Integer)result[8]);
					
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
		
	public ArrayList<Piatto> menuFromDb() { 	// menu		
		 ArrayList<Piatto> menu= new ArrayList<Piatto>();
		
		 try {
				Connection connection = ds.getConnection();
				PreparedStatement statement = connection.prepareStatement("SELECT * FROM piatto");

				ResultSet rs = statement.executeQuery();
			
				while (rs.next()) { //true-> matcha qualcosa
					Piatto piatto= new Piatto();
					
					piatto.setId_piatto(rs.getInt("id_piatto"));
					piatto.setTipo(rs.getString("tipo")); 
					piatto.setNome(rs.getString("nome"));
					piatto.setPrezzo(rs.getFloat("prezzo"));
					piatto.setDisponibilita(rs.getInt("disponibilita"));
					piatto.setMenu_giorno(rs.getBoolean("menu_giorno"));
					
					menu.add(piatto);
					piatto= null;
					
				}	
				rs.close();
				statement.close();
				connection.close();
		 	}catch(SQLException e){
					e.printStackTrace();
			}

		return menu;
	}
		
	public boolean updateDisponibilita( int id, int disponibilita) {
		boolean isModified = false;
		try {
			Connection connection = ds.getConnection();
			String update = "UPDATE piatto SET disponibilita=? WHERE id_piatto=?";
			
			PreparedStatement statement = connection.prepareStatement(update);
			
			statement.setInt(1, disponibilita); 
			statement.setInt(2, id);	  		 
			
			if(statement.executeUpdate()==0) {	//num righe che ha modificato
				isModified= false;
			}else {
				isModified = true;
			}

			statement.close();
			connection.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return isModified;
	}
		
	public ArrayList<ClientePrenotaPiatto> ordiniPiattiFromDb() { 	// menu		
		 ArrayList<ClientePrenotaPiatto> ordini_piatti= new ArrayList<ClientePrenotaPiatto>();
		
		 try {
				Connection connection = ds.getConnection();
				PreparedStatement statement = connection.prepareStatement("SELECT * FROM cliente_prenota_piatto");

				ResultSet rs = statement.executeQuery();
			
				while (rs.next()) { //true-> matcha qualcosa
					ClientePrenotaPiatto ordine= new ClientePrenotaPiatto();
					
					ordine.setId_ordine(rs.getInt("id_ordine"));
					ordine.setId_cliente(rs.getInt("cliente_id_cliente"));
					ordine.setId_piatto(rs.getInt("piatto_id_piatto"));
					ordine.setQuantita(rs.getInt("quantita"));
					ordine.setStato_pagamento(rs.getBoolean("stato_pagamento"));
					ordine.setStato_completamento(rs.getString("stato_completamento"));
					ordine.setData_ordine(rs.getString("data_prenotazione"));
					
					ordini_piatti.add(ordine);
					ordine= null;
					
				}	
				rs.close();
				statement.close();
				connection.close();
		 	}catch(SQLException e){
					e.printStackTrace();
			}

		return ordini_piatti;
	}
		
	public boolean updateStatoOrdine( int id, String stato_ordine) {
		boolean isModified = false;
		try {
			Connection connection = ds.getConnection();
			String update = "UPDATE cliente_prenota_piatto SET stato_completamento=? WHERE id_ordine=?";
			
			PreparedStatement statement = connection.prepareStatement(update);
			
			statement.setString(1, stato_ordine); 
			statement.setInt(2, id);	  		 
			
			if(statement.executeUpdate()==0) {	//num righe che ha modificato
				isModified= false;
			}else {
				isModified = true;
			}

			statement.close();
			connection.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return isModified;
	}
		
	public boolean eliminaOrdine(int id) {
		boolean isModified = false;
		try {
			Connection connection = ds.getConnection();
			String update = "DELETE FROM cliente_prenota_piatto WHERE id_ordine=?";
			
			PreparedStatement statement = connection.prepareStatement(update);
			
			statement.setInt(1, id); 
			
			if(statement.executeUpdate()==0) {	//num righe che ha modificato
				isModified= false;
			}else {
				isModified = true;
			}
			statement.close();
			connection.close();	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return isModified;
	}
	
	public boolean updateQuantitaPiatto( int id, int quantita_usata) {
		boolean isModified = false;
		try {
			
			int disponibilita=0;
			
			Connection connection1 = ds.getConnection();		
			PreparedStatement statement1 = connection1.prepareStatement("SELECT disponibilita FROM piatto WHERE id_piatto=?");
			statement1.setInt(1, id);
			
			ResultSet rs1 = statement1.executeQuery();

			while (rs1.next()) { //true-> matcha qualcosa
				disponibilita = rs1.getInt("disponibilita");	
			}	
			rs1.close();
			statement1.close();
			connection1.close();

			
			
			Connection connection = ds.getConnection();
			String update = "UPDATE piatto SET disponibilita=? WHERE id_piatto=?";
			
			PreparedStatement statement = connection.prepareStatement(update);
			
			int nuova_quantita = disponibilita - quantita_usata;
			
			statement.setInt(1, nuova_quantita); 
			statement.setInt(2, id);	  		 
			
			if(statement.executeUpdate()==0) {	//num righe che ha modificato
				isModified= false;
			}else {
				isModified = true;
			}

			statement.close();
			connection.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return isModified;
	}
	
	public boolean updateMenuGiorno( int id, int valore) {
		boolean isModified = false;
		try {
			Connection connection = ds.getConnection();
			String update = "UPDATE piatto SET menu_giorno=? WHERE id_piatto=?";
			
			PreparedStatement statement = connection.prepareStatement(update);
			
			statement.setInt(1, valore); 
			statement.setInt(2, id);	  		 
			
			if(statement.executeUpdate()==0) {	//num righe che ha modificato
				isModified= false;
			}else {
				isModified = true;
			}

			statement.close();
			connection.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return isModified;
	}
	
	public ClientePrenotaOmbrellone getPrenotazioneOmbrellone(int id, int slot_orario, String data) {
		 ClientePrenotaOmbrellone prenotazione= new ClientePrenotaOmbrellone();
		 try {
				Connection connection = ds.getConnection();
				PreparedStatement statement = connection.prepareStatement("SELECT * FROM cliente_prenota_ombrellone WHERE ombrellone_id_ombrellone=? and slot_orario=? and data_prenotazione=? ");
				
				statement.setInt(1, id); 
				statement.setInt(2, slot_orario);
				statement.setString(3, data);
				
				
				ResultSet rs = statement.executeQuery();
			
				while (rs.next()) { //true-> matcha qualcosa
					
					
					prenotazione.setId_prenotazione(rs.getInt("id_prenotazione"));
					prenotazione.setId_cliente(rs.getInt("cliente_id_cliente"));
					prenotazione.setId_ombrellone(rs.getInt("ombrellone_id_ombrellone"));
					prenotazione.setNum_lettini(rs.getInt("num_lettini"));
					prenotazione.setNum_persone(rs.getInt("num_persone"));
					prenotazione.setNum_sdraio(rs.getInt("num_sdraio"));
					prenotazione.setSlot_orario(rs.getInt("slot_orario"));
					prenotazione.setPagato(rs.getBoolean("stato_pagamento"));
					
				}	
				rs.close();
				statement.close();
				connection.close();
		 	}catch(SQLException e){
					e.printStackTrace();
			}

		return prenotazione;
		
	}
	
	public Cliente getCliente(int id_cliente) { 	
		 Cliente cliente= new Cliente();
		
		 try {
				Connection connection = ds.getConnection();
				PreparedStatement statement = connection.prepareStatement("SELECT * FROM cliente WHERE id_cliente=? ");
				
				statement.setInt(1, id_cliente); 

				ResultSet rs = statement.executeQuery();
			
				while (rs.next()) { //true-> matcha qualcosa
					
					cliente.setNome(rs.getString("nome"));
					cliente.setCognome(rs.getString("cognome"));
					cliente.setTelefono(rs.getString("telefono"));
					cliente.setEmail(rs.getString("email"));
					cliente.setPw(rs.getString("pw"));
					cliente.setData(rs.getString("data_nascita"));
					cliente.setSesso(rs.getInt("sesso"));
					cliente.setTot_pagamento(rs.getFloat("tot_pagamento"));

					
				}	
				rs.close();
				statement.close();
				connection.close();
		 	}catch(SQLException e){
					e.printStackTrace();
			}

		return cliente;
	}
	
	public ArrayList<ClientePrenotaOmbrellone> getListaPrenotazioneGiornoCorrente(String data_scelta){
		 ArrayList<ClientePrenotaOmbrellone> lista= new ArrayList<ClientePrenotaOmbrellone>();

		 try {
				Connection connection = ds.getConnection();
				PreparedStatement statement = connection.prepareStatement("SELECT * FROM cliente_prenota_ombrellone WHERE data_prenotazione=?");
				statement.setString(1, data_scelta);


				ResultSet rs = statement.executeQuery();
			
				while (rs.next()) { //true-> matcha qualcosa
					
					ClientePrenotaOmbrellone prenotazione= new ClientePrenotaOmbrellone();

					prenotazione.setId_prenotazione((Integer)rs.getInt("id_prenotazione"));
					prenotazione.setId_cliente((Integer)rs.getInt("cliente_id_cliente"));
					prenotazione.setId_ombrellone((Integer)rs.getInt("ombrellone_id_ombrellone"));
					prenotazione.setPagato((boolean)rs.getBoolean("stato_pagamento"));
					prenotazione.setData_prenotazione(data_scelta);
					prenotazione.setSlot_orario((Integer)rs.getInt("slot_orario"));				
					prenotazione.setNum_lettini((Integer)rs.getInt("num_lettini"));
					prenotazione.setNum_persone((Integer)rs.getInt("num_persone"));
					prenotazione.setNum_sdraio((Integer)rs.getInt("num_sdraio"));
					
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
	
	public ArrayList<ClientePrenotaPiatto> ordiniPiattiGiorno(String data) { 	
		 ArrayList<ClientePrenotaPiatto> ordini_piatti= new ArrayList<ClientePrenotaPiatto>();
		
		 try {
				Connection connection = ds.getConnection();
				PreparedStatement statement = connection.prepareStatement("SELECT * FROM cliente_prenota_piatto WHERE data_prenotazione=?");
				statement.setString(1, data);
				
				ResultSet rs = statement.executeQuery();
			
				while (rs.next()) { //true-> matcha qualcosa
					ClientePrenotaPiatto ordine= new ClientePrenotaPiatto();
					
					ordine.setId_ordine(rs.getInt("id_ordine"));
					ordine.setId_cliente(rs.getInt("cliente_id_cliente"));
					ordine.setId_piatto(rs.getInt("piatto_id_piatto"));
					ordine.setQuantita(rs.getInt("quantita"));
					ordine.setStato_pagamento(rs.getBoolean("stato_pagamento"));
					ordine.setStato_completamento(rs.getString("stato_completamento"));
					ordine.setData_ordine(rs.getString("data_prenotazione"));
					
					ordini_piatti.add(ordine);
					ordine= null;
					
				}	
				rs.close();
				statement.close();
				connection.close();
		 	}catch(SQLException e){
					e.printStackTrace();
			}

		return ordini_piatti;
	}
	
	public Piatto getPiatto(int id_piatto) { 	
		 Piatto piatto= new Piatto();
		
		 try {
				Connection connection = ds.getConnection();
				PreparedStatement statement = connection.prepareStatement("SELECT * FROM piatto WHERE id_piatto=? ");
				
				statement.setInt(1, id_piatto); 

				ResultSet rs = statement.executeQuery();
			
				while (rs.next()) { //true-> matcha qualcosa
					
					piatto.setId_piatto(rs.getInt("id_piatto"));
					piatto.setTipo(rs.getString("tipo"));
					piatto.setNome(rs.getString("nome"));
					piatto.setPrezzo(rs.getFloat("prezzo"));
					piatto.setMenu_giorno(rs.getBoolean("menu_giorno"));
					piatto.setDisponibilita(rs.getInt("disponibilita"));

				}	
				rs.close();
				statement.close();
				connection.close();
		 	}catch(SQLException e){
					e.printStackTrace();
			}

		return piatto;
	}

	public boolean eliminaPrenotazioneOmbrellone(int id) {
		boolean isModified = false;
		try {
			Connection connection = ds.getConnection();
			String update = "DELETE FROM cliente_prenota_ombrellone WHERE id_prenotazione=?";

			PreparedStatement statement = connection.prepareStatement(update);	
			statement.setInt(1, id); 
			
			if(statement.executeUpdate()!=0) {	//num righe che ha modificato
				isModified= true;
			}else {
				isModified = false;
			}
			statement.close();
			connection.close();	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return isModified;
	}
	
	public Doccia getDocciaFromDb(int id) { 			
		
		Doccia doccia= new Doccia();
		
		try {
			Connection connection = ds.getConnection();
			PreparedStatement statement = connection.prepareStatement("SELECT * FROM doccia WHERE id_doccia=?");
			statement.setInt(1, id);
			
			ResultSet rs = statement.executeQuery();
		
				
			if (rs.next()) { //true-> matcha qualcosa
				
				doccia.setId_doccia(rs.getInt("id_doccia"));
				doccia.setAccesso_disabili(rs.getBoolean("accesso_disabili"));
		
				doccia.setPulito(rs.getBoolean("stato_pulizia"));
			}
			rs.close();
			statement.close();
			connection.close();
		}catch(SQLException e){
				e.printStackTrace();
		}
		return doccia;
	}
	
	public ClientePrenotaDoccia getPrenotazioneDoccia(int id, int slot_orario, String data) {
		ClientePrenotaDoccia prenotazione= new ClientePrenotaDoccia();
		 try {
				Connection connection = ds.getConnection();
				PreparedStatement statement = connection.prepareStatement("SELECT * FROM cliente_prenota_doccia WHERE doccia_id_doccia=? and slot_orario=? and data_prenotazione=? ");
				
				statement.setInt(1, id); 
				statement.setInt(2, slot_orario);
				statement.setString(3, data);
				
				
				ResultSet rs = statement.executeQuery();
			
				while (rs.next()) { //true-> matcha qualcosa
					
					
					prenotazione.setId_prenota_doccia(rs.getInt("id_prenota_doccia"));
					prenotazione.setId_cliente(rs.getInt("cliente_id_cliente"));
					prenotazione.setId_doccia(rs.getInt("doccia_id_doccia"));
					prenotazione.setSlot_orario(rs.getInt("slot_orario"));
					prenotazione.setData_prenotazione(rs.getString("data_prenotazione"));
					
				}	
				rs.close();
				statement.close();
				connection.close();
		 	}catch(SQLException e){
					e.printStackTrace();
			}

		return prenotazione;
		
	}
	
	public boolean setStatoPulito(int idOmbr, int isPulito){
		boolean isModified = false;
		try {
			Connection connection = ds.getConnection();
			String update = "UPDATE ombrellone SET stato_pulizia=? WHERE id_ombrellone=?";
			
			PreparedStatement statement = connection.prepareStatement(update);
			
			statement.setInt(1, isPulito); 
			statement.setInt(2, idOmbr);	  		 
			
			if(statement.executeUpdate()==0) {	//num righe che ha modificato
				isModified= false;
			}else {
				isModified = true;
			}

			statement.close();
			connection.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return isModified;

	}
	
	public int firstIdPrenotazioneOmbrAvailable() {  
		int res = 0;
		try {
			
			Connection connection = ds.getConnection();
			
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("SELECT id_prenotazione FROM cliente_prenota_ombrellone ORDER BY id_prenotazione DESC	LIMIT 1");
		
			if (rs.next()) { //true-> matcha qualcosa
				res= rs.getInt("id_prenotazione");
			}
			rs.close();
			statement.close();
			connection.close();
		}catch(SQLException e){
				e.printStackTrace();
		}
		return res+1;
	}
	
	
	public boolean insertPrenotazioneOmbrellone( int id_prenot_disp, int id_cliente,int id_ombrellone, String data, int slot_orario,int num_persone,int num_lettini,int num_sdraio) {
		boolean res = false;
		try {
			Connection connection = ds.getConnection();
			String insert = "insert into cliente_prenota_ombrellone(id_prenotazione, cliente_id_cliente,ombrellone_id_ombrellone, stato_pagamento, data_prenotazione,slot_orario, num_persone, num_lettini, num_sdraio) values (?,?,?,?,?,?,?,?,?)";
			PreparedStatement statement = connection.prepareStatement(insert);
			
			
			statement.setInt(1, id_prenot_disp);
			statement.setInt(2, id_cliente);
			statement.setInt(3, id_ombrellone);
			statement.setInt(4, 0 ); //stato_pagamento
			statement.setString(5, data);
			statement.setInt(6, slot_orario);
			statement.setInt(7, num_persone);
			statement.setInt(8, num_lettini);
			statement.setInt(9, num_sdraio);
		
			//statement.executeUpdate(); //0 (non ritorna niente) o 1

			if(statement.executeUpdate() == 0) {
				res= false;
			}else {
				res=true;
			}
			
			statement.close();
			connection.close();
			
		}catch(SQLException e){
				e.printStackTrace();
		}
		return res;
		
		
	}

	public ArrayList<ClientePrenotaDoccia> getListaPrenotazioneDocce(String data_scelta, int slot_orario){
		 ArrayList<ClientePrenotaDoccia> lista= new ArrayList<ClientePrenotaDoccia>();
		 Object[] result= new Object[5];
		
			
		 try {
				Connection connection = ds.getConnection();
				PreparedStatement statement = connection.prepareStatement("SELECT * FROM cliente_prenota_doccia WHERE data_prenotazione=? and slot_orario=?");
				statement.setString(1, data_scelta);
				statement.setInt(2, slot_orario);

				ResultSet rs = statement.executeQuery();
			
				while (rs.next()) { //true-> matcha qualcosa
					ClientePrenotaDoccia prenotazione= new ClientePrenotaDoccia();
					
					result[0]=rs.getInt("id_prenota_doccia");
					result[1]=rs.getInt("cliente_id_cliente");
					result[2]=rs.getInt("doccia_id_doccia");
					result[3]=rs.getInt("slot_orario");
					result[4]=rs.getString("data_prenotazione");
					
					
					prenotazione.setId_prenota_doccia((Integer)(result[0]));
					prenotazione.setId_cliente((Integer)result[1]);
					prenotazione.setId_doccia((Integer)result[2]);
					prenotazione.setSlot_orario(slot_orario);	
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
	
	
	public int firstIdPrenotazioneDocciaAvailable() {  
		int res = 0;
		try {
			
			Connection connection = ds.getConnection();
			
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("SELECT id_prenota_doccia FROM cliente_prenota_doccia ORDER BY id_prenota_doccia DESC	LIMIT 1");
		
			if (rs.next()) { //true-> matcha qualcosa
				res= rs.getInt("id_prenota_doccia");
			}
			rs.close();
			statement.close();
			connection.close();
		}catch(SQLException e){
				e.printStackTrace();
		}
		return res+1;
	}
	
	public boolean insertPrenotazioneDoccia(int id_prenot_disp,int id_cliente, int id_doccia, int slot_orario, String data) {
		boolean res = false;
		try {
			Connection connection = ds.getConnection();
			String insert = "insert into cliente_prenota_doccia(id_prenota_doccia, cliente_id_cliente,doccia_id_doccia, slot_orario,data_prenotazione) values (?,?,?,?,?)";
			PreparedStatement statement = connection.prepareStatement(insert);
			
			statement.setInt(1, id_prenot_disp);
			statement.setInt(2, id_cliente);
			statement.setInt(3, id_doccia);
			statement.setInt(4, slot_orario);
			statement.setString(5, data);
			

			if(statement.executeUpdate() == 0) {
				res= false;
			}else {
				res=true;
			}
			
			statement.close();
			connection.close();
			
		}catch(SQLException e){
				e.printStackTrace();
		}
		return res;
		
		
	}
	
	public int firstIdPrenotazionePiattoAvailable() {
		int res = 0;
		try {
			
			Connection connection = ds.getConnection();
			
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery("SELECT id_ordine FROM cliente_prenota_piatto ORDER BY id_ordine DESC	LIMIT 1");
		
			if (rs.next()) { //true-> matcha qualcosa
				res= rs.getInt("id_ordine");
			}
			rs.close();
			statement.close();
			connection.close();
		}catch(SQLException e){
				e.printStackTrace();
		}
		return res+1;
	}
	
	public int getOrdinePiatto(String nome_piatto) {
		int res = 0;
		try {
			
			Connection connection = ds.getConnection();
			PreparedStatement statement = connection.prepareStatement("SELECT id_piatto FROM piatto WHERE nome=?");
			statement.setString(1, nome_piatto);
			
			ResultSet rs = statement.executeQuery();
		
			if (rs.next()) { //true-> matcha qualcosa
				res= rs.getInt("id_piatto");
				
			}	
			rs.close();
			statement.close();
			connection.close();
			
		}catch(SQLException e){
				e.printStackTrace();
		}
		return res;
	}
	
	public boolean insertPrenotazionePiatto(int idOrdineAvailable, int id_piatto, int id_cliente, int quantita , int stato_pagamento, String stato_completamento,String data_prenotazione ){
		boolean res = false;
		try {
			Connection connection = ds.getConnection();
			String insert = "insert into cliente_prenota_piatto(id_ordine, piatto_id_piatto,cliente_id_cliente, quantita,stato_pagamento, stato_completamento, data_prenotazione) values (?,?,?,?,?,?,?)";
			PreparedStatement statement = connection.prepareStatement(insert);
			
			statement.setInt(1, idOrdineAvailable);
			statement.setInt(2, id_piatto);
			statement.setInt(3, id_cliente);
			statement.setInt(4, quantita);
			statement.setInt(5, stato_pagamento);
			statement.setString(6, stato_completamento);
			statement.setString(7, data_prenotazione);
			if(statement.executeUpdate() == 0) {
				res= false;
			}else {
				res=true;
			}
			
			statement.close();
			connection.close();
			
		}catch(SQLException e){
				e.printStackTrace();
		}
		return res;
		
	}
	
	public ArrayList<ClientePrenotaOmbrellone> getListaPrenotazioneOmbrellonibyIdCliente(int id_cliente){
		 ArrayList<ClientePrenotaOmbrellone> lista= new ArrayList<ClientePrenotaOmbrellone>();

		 try {
				Connection connection = ds.getConnection();
				PreparedStatement statement = connection.prepareStatement("SELECT * FROM cliente_prenota_ombrellone WHERE cliente_id_cliente=?");
				statement.setInt(1, id_cliente);

				ResultSet rs = statement.executeQuery();
			
				while (rs.next()) { //true-> matcha qualcosa
					
					ClientePrenotaOmbrellone prenotazione= new ClientePrenotaOmbrellone();

					prenotazione.setId_prenotazione((Integer)rs.getInt("id_prenotazione"));
					prenotazione.setId_cliente((Integer)rs.getInt("cliente_id_cliente"));
					prenotazione.setId_ombrellone((Integer)rs.getInt("ombrellone_id_ombrellone"));
					prenotazione.setPagato((boolean)rs.getBoolean("stato_pagamento"));
					prenotazione.setData_prenotazione(rs.getString("data_prenotazione"));
					prenotazione.setSlot_orario((Integer)rs.getInt("slot_orario"));				
					prenotazione.setNum_lettini((Integer)rs.getInt("num_lettini"));
					prenotazione.setNum_persone((Integer)rs.getInt("num_persone"));
					prenotazione.setNum_sdraio((Integer)rs.getInt("num_sdraio"));
					
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
		
	public boolean modificaPrenotazioneOmbrellone(int id,int persone,int lettini,int sdraio) {
		boolean isModified = false;
		try {
			Connection connection = ds.getConnection();
			String update = "UPDATE cliente_prenota_ombrellone SET num_persone=?, num_lettini=?, num_sdraio=?  WHERE id_prenotazione=?";
			
			PreparedStatement statement = connection.prepareStatement(update);
			
			statement.setInt(1, persone); 
			statement.setInt(2, lettini);	  
			statement.setInt(3, sdraio);
			statement.setInt(4, id);
			
			if(statement.executeUpdate()==0) {	//num righe che ha modificato
				isModified= false;
			}else {
				isModified = true;
			}

			statement.close();
			connection.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return isModified;
	}

	public ArrayList<ClientePrenotaDoccia> getPrenotazioneDocciaById(int id_cliente) {
		 ArrayList<ClientePrenotaDoccia> lista= new ArrayList<ClientePrenotaDoccia>();
		 Object[] result= new Object[5];
		
			
		 try {
				Connection connection = ds.getConnection();
				PreparedStatement statement = connection.prepareStatement("SELECT * FROM cliente_prenota_doccia WHERE cliente_id_cliente=?");

				statement.setInt(1, id_cliente);

				ResultSet rs = statement.executeQuery();
			
				while (rs.next()) { //true-> matcha qualcosa
					ClientePrenotaDoccia prenotazione= new ClientePrenotaDoccia();
					
					result[0]=rs.getInt("id_prenota_doccia");
					result[1]=rs.getInt("cliente_id_cliente");
					result[2]=rs.getInt("doccia_id_doccia");
					result[3]=rs.getInt("slot_orario");
					result[4]=rs.getString("data_prenotazione");
					
					
					prenotazione.setId_prenota_doccia((Integer)(result[0]));
					prenotazione.setId_cliente((Integer)result[1]);
					prenotazione.setId_doccia((Integer)result[2]);
					prenotazione.setSlot_orario((Integer) result[3]);	
					prenotazione.setData_prenotazione((String) result[4]);
								
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

	public boolean eliminaPrenotazioneDoccia(int id_prenotazione) {
		boolean isModified = false;
		try {
			Connection connection = ds.getConnection();
			String update = "DELETE FROM cliente_prenota_doccia WHERE id_prenota_doccia=?";

			PreparedStatement statement = connection.prepareStatement(update);	
			statement.setInt(1, id_prenotazione); 
			
			if(statement.executeUpdate()!=0) {	//num righe che ha modificato
				isModified= true;
			}else {
				isModified = false;
			}
			statement.close();
			connection.close();	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return isModified;
	}
	
	public ArrayList<ClientePrenotaPiatto> getListaOrdinibyId(int id){
		 ArrayList<ClientePrenotaPiatto> lista= new ArrayList<ClientePrenotaPiatto>();

		 try {
				Connection connection = ds.getConnection();
				PreparedStatement statement = connection.prepareStatement("SELECT * FROM cliente_prenota_piatto WHERE cliente_id_cliente=?");
				statement.setInt(1, id);


				ResultSet rs = statement.executeQuery();
			
				while (rs.next()) { //true-> matcha qualcosa
					
					ClientePrenotaPiatto prenotazione= new ClientePrenotaPiatto();

					prenotazione.setId_ordine((Integer)rs.getInt("id_ordine"));
					prenotazione.setId_cliente((Integer)rs.getInt("cliente_id_cliente"));
					prenotazione.setId_piatto((Integer)rs.getInt("piatto_id_piatto"));	
					prenotazione.setQuantita((Integer)rs.getInt("quantita"));
					prenotazione.setStato_pagamento((Boolean)rs.getBoolean("stato_pagamento"));
					prenotazione.setStato_completamento((String)rs.getString("stato_completamento"));
					prenotazione.setData_ordine((String)rs.getString("data_prenotazione"));
					
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
	
	
	
	public boolean  updateQuantitaOrdine(int id_ordine, int quantita) {
		boolean isModified = false;
		try {
			Connection connection = ds.getConnection();
			String update = "UPDATE cliente_prenota_piatto SET quantita=? WHERE id_ordine=?";
			
			PreparedStatement statement = connection.prepareStatement(update);
			
			statement.setInt(1, quantita); 
			statement.setInt(2, id_ordine);	  		 
			
			if(statement.executeUpdate()==0) {	//num righe che ha modificato
				isModified= false;
			}else {
				isModified = true;
			}

			statement.close();
			connection.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return isModified;
	}

	
	public boolean modificaStatoPagamentoPiatto(int id, Boolean statoPagamento) {
		boolean isModified = false;
		try {
			Connection connection = ds.getConnection();
			String update = "UPDATE cliente_prenota_piatto SET stato_pagamento=? WHERE id_ordine=?";
			
			PreparedStatement statement = connection.prepareStatement(update);
			
			statement.setBoolean(1, statoPagamento); 
			statement.setInt(2, id);	  		 
			
			if(statement.executeUpdate()==0) {	//num righe che ha modificato
				isModified= false;
			}else {
				isModified = true;
			}

			statement.close();
			connection.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return isModified;
	}

	public boolean modificaStatoPagamentoOmbr(int id, Boolean statoPagamento) {
		boolean isModified = false;
		try {
			Connection connection = ds.getConnection();
			String update = "UPDATE cliente_prenota_ombrellone SET stato_pagamento=? WHERE id_prenotazione=?";
			
			PreparedStatement statement = connection.prepareStatement(update);
			
			statement.setBoolean(1, statoPagamento); 
			statement.setInt(2, id);	  		 
			
			if(statement.executeUpdate()==0) {	//num righe che ha modificato
				isModified= false;
			}else {
				isModified = true;
			}

			statement.close();
			connection.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return isModified;
	}
	
}	
	
	



	
	
		