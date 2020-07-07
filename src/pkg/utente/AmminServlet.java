package pkg.utente;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pkg.bean.Amministratore;
import pkg.bean.Cliente;
import pkg.bean.Bagnino;
import pkg.bean.Barista;
import pkg.bean.ClientePrenotaOmbrellone;
import pkg.bean.ClientePrenotaPiatto;
import pkg.bean.Ombrellone;
import pkg.bean.Piatto;
import pkg.db.DBQuery;

/**
 * Servlet implementation class AmminServlet
 */
@WebServlet("/AmminServlet")
public class AmminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AmminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DBQuery db= new DBQuery();
		String operazione = request.getParameter("operazione");
		
		if(("spiaggia").equals(operazione)) {
					
			String data=request.getParameter("data_scelta");			
			int slot=Integer.parseInt(request.getParameter("slot_orario"));
			ArrayList<ClientePrenotaOmbrellone> listaOmbrelloniPrenotati = db.getListaPrenotazioneOmbrellone(data,slot);
						
			if(listaOmbrelloniPrenotati.size()==0) {
				response.setContentType("text/html");				
				PrintWriter out = response.getWriter();
				String result="Nessuna Prenotazione";
				out.print(result);
			}
			
			else {
				for(int i=0; i< listaOmbrelloniPrenotati.size(); i++) {
					int id= listaOmbrelloniPrenotati.get(i).getId_ombrellone();
					HttpSession session = request.getSession();
					session.setAttribute("ombrellonePrenotato"+id , listaOmbrelloniPrenotati.get(i));
				}	
				
			}		
			

		
		}
		
		if(("dati_prenotazione_ombrellone").equals(operazione)) {
			
			String id_ombrelloneString = request.getParameter("id_ombrellone");
			String slot_orarioString= request.getParameter("slot_orario");
			String data= request.getParameter("data");
			
			int slot_orario=0;
			if((slot_orarioString).equals("Mattina")) {
				slot_orario=1;
			}
			if((slot_orarioString).equals("Pomeriggio")) {
				slot_orario=2;
			}
			
			int id = Integer.parseInt(id_ombrelloneString.substring(10));
	
			Ombrellone ombrellone = db.getOmbrelloneFromDb(id);
			
			ClientePrenotaOmbrellone prenotazione = db.getPrenotazioneOmbrellone(id,slot_orario,data);
			

			int id_cliente= prenotazione.getId_cliente();
			Cliente cliente = db.getCliente(id_cliente);
			
			
			response.setContentType("application/json");
				
			PrintWriter out = response.getWriter();

			String result= "{\"id\":\""+ombrellone.getId_ombrellone()+"\","
							+ "\"zona\":\""+ombrellone.getZona()+"\","
							
							+ "\"num_persone\":\""+prenotazione.getNum_persone()+"\","
							+ "\"num_lettini\":\""+prenotazione.getNum_lettini()+"\","
							+ "\"num_sdraio\":\""+prenotazione.getNum_sdraio()+"\","
							+ "\"pagato\":\""+prenotazione.getPagato()+"\","
						
							+ "\"nome\":\""+cliente.getNome()+"\","
							+ "\"cognome\":\""+cliente.getCognome()+"\","
							+ "\"telefono\":\""+cliente.getTelefono()+"\","
							
							+ "\"prezzo\":\""+ombrellone.getPrezzo()+"\""
							+ "}";
		    out.print(result);
		
		}
		
		if(("controllo_pagamenti").equals(operazione)) {
			
			String data=request.getParameter("data_scelta");		
			
			ArrayList<ClientePrenotaOmbrellone> listaOmbrelloniPrenotati = db.getListaPrenotazioneGiornoCorrente(data);
			ArrayList<ClientePrenotaPiatto> ordini_piatti = db.ordiniPiattiGiorno(data);
			
			int num_ordini_ombrelloni= listaOmbrelloniPrenotati.size(); 
			int num_ordini_bar= ordini_piatti.size();
			
			int ordini_totali=num_ordini_ombrelloni+num_ordini_bar;
					
			HttpSession session = request.getSession();
			
			if(ordini_totali==0) {
				response.setContentType("text/html");				
				PrintWriter out = response.getWriter();
				String result="Nessuna Prenotazione";
				out.print(result);
			}
			
			else {
				ArrayList<Integer> id_clienti = new ArrayList<Integer>();

				// id_clienti che hanno prenotato un ombrellone
				for (int i=0; i<num_ordini_ombrelloni; i++) {
					int id_cliente=listaOmbrelloniPrenotati.get(i).getId_cliente();
					
					int id_ombrellone= listaOmbrelloniPrenotati.get(i).getId_ombrellone();
					
					Ombrellone ombrellone =(Ombrellone) db.getOmbrelloneFromDb(id_ombrellone);		
					
					session.setAttribute("Ombrellone"+i , ombrellone);						
					session.setAttribute("OmbrPrenotazione"+i , listaOmbrelloniPrenotati.get(i));
					
					if(!id_clienti.contains(id_cliente)) {	
						id_clienti.add(id_cliente);
					}
				}
				// id_clienti che hanno prenotato un piatto
				for (int i=0; i<num_ordini_bar; i++) {
					int id_cliente=ordini_piatti.get(i).getId_cliente();
					int id_piatto= ordini_piatti.get(i).getId_piatto();
					
					Piatto piatto = (Piatto) db.getPiatto(id_piatto);

					session.setAttribute("Piatto"+i , piatto);
					session.setAttribute("PiattoPrenotazione"+i , ordini_piatti.get(i));
	
					if(!id_clienti.contains(id_cliente)) {	
						id_clienti.add(id_cliente);
					}
				}
			
				for(int i=0; i< id_clienti.size(); i++) {
					int id= id_clienti.get(i);
					Cliente cliente= db.getCliente(id);				
					session.setAttribute("cliente"+id , cliente);
				}				
			}	
		
		}
		
		if(("elimina_ordine").equals(operazione)) {
		
				String id_String= request.getParameter("id");
				System.out.print(id_String);

				if(id_String.length()>18) {
					// elimina ordine piatto
					int id= Integer.parseInt(id_String.substring(19));
					System.out.print("Prenotazione piatto"+id);	
					
					response.setContentType("text/html");				
					PrintWriter out = response.getWriter();
					boolean result = db.eliminaOrdine(id);
					System.out.println(result);
					out.println(result);
					
				}else {
					// elimina ordine ombrellone
					int id= Integer.parseInt(id_String.substring(17));
					System.out.print("Prenotazione ombrellone"+id);

					response.setContentType("text/html");				
					PrintWriter out = response.getWriter();
					boolean result = db.eliminaPrenotazioneOmbrellone(id);
					System.out.println(result);
					out.println(result);
				}
		}
		
		
		if(("registrazione_personale").equals(operazione)) {
					
			String mansione =request.getParameter("mansione");
			String nome = request.getParameter("nome");
			String cognome = request.getParameter("cognome");
			String telefono = request.getParameter("telefono");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String nascita = request.getParameter("data_nascita");
			int sesso = Integer.parseInt(request.getParameter("genere"));			
			
			if((mansione).equals("amministratore")) {
				
				
				Amministratore amministratore = new Amministratore();
				
				amministratore.setNome(nome);
				amministratore.setCognome(cognome);
				amministratore.setTelefono(telefono);
				amministratore.setEmail(email);
				amministratore.setPw(password);
				amministratore.setData(nascita);
				amministratore.setSesso(sesso);
				
				if(db.isAmminRegistrated(amministratore)) {
										
					response.setContentType("application/json");				
					PrintWriter out = response.getWriter();		
					String result= "{\"id\":\""+"registrato"+"\"}";
					out.println(result);
					
				}else {
					response.setContentType("application/json");				
					PrintWriter out = response.getWriter();	
					
					boolean x = db.insertAmmin(amministratore);	
					
					String result= "{\"id\":\""+x+"\"}";
					out.println(result);
				}	

				
			}
			if((mansione).equals("bagnino")) {
				
				Bagnino bagnino = new Bagnino();
				
				bagnino.setNome(nome);
				bagnino.setCognome(cognome);
				bagnino.setTelefono(telefono);
				bagnino.setEmail(email);
				bagnino.setPw(password);
				bagnino.setData(nascita);
				bagnino.setSesso(sesso);
				
				if(db.isBagninoRegistrated(bagnino)) {
					
					response.setContentType("application/json");				
					PrintWriter out = response.getWriter();		
					String result= "{\"id\":\""+"registrato"+"\"}";
					out.println(result);
					
				}else {
					response.setContentType("application/json");				
					PrintWriter out = response.getWriter();
					
					boolean x = db.insertBagnino(bagnino);
					
					String result= "{\"id\":\""+x+"\"}";
					out.println(result);
				}
				
			}
			if((mansione).equals("barista")) {
				
				Barista barista = new Barista();
				
				barista.setNome(nome);
				barista.setCognome(cognome);
				barista.setTelefono(telefono);
				barista.setEmail(email);
				barista.setPw(password);
				barista.setData(nascita);
				barista.setSesso(sesso);
				
				if(db.isBaristaRegistrated(barista)) {
					
					response.setContentType("application/json");				
					PrintWriter out = response.getWriter();		
					String result= "{\"id\":\""+"registrato"+"\"}";
					out.println(result);
					
				}else {
					response.setContentType("application/json");				
					PrintWriter out = response.getWriter();
					
					boolean x = db.insertBarista(barista);
					
					String result= "{\"id\":\""+x+"\"}";
					out.println(result);
				}
				
			}
			
		}
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
