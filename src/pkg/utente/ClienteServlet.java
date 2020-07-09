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


import pkg.bean.ClientePrenotaDoccia;
import pkg.bean.ClientePrenotaOmbrellone;
import pkg.bean.ClientePrenotaPiatto;
import pkg.bean.Doccia;
import pkg.bean.Ombrellone;
import pkg.bean.Piatto;
import pkg.db.DBQuery;

/**
 * Servlet implementation class BagninoServlet
 */
@WebServlet("/ClienteServlet")
public class ClienteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClienteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DBQuery db= new DBQuery();
		String operazione = request.getParameter("operazione");
		
		
		//sotto-opzione1->prenota ombrellone
		if(("visualizza_spiaggia_prenot").equals(operazione)) {
		
			String data_sess=request.getParameter("data_scelta");
			String slot_orarioString1= request.getParameter("slot_orario");
	
			
			int slot_orario_sess=0;
			if((slot_orarioString1).equals("1")) {
				slot_orario_sess=1;
			} 
			if((slot_orarioString1).equals("2")) {
				slot_orario_sess=2;
			} 
			
			ArrayList<ClientePrenotaOmbrellone> listaOmbrelloniPrenotati = db.getListaPrenotazioneOmbrellone(data_sess,slot_orario_sess);
			
			HttpSession session = request.getSession();
			for(int i=0; i< listaOmbrelloniPrenotati.size(); i++) {
				int id= listaOmbrelloniPrenotati.get(i).getId_ombrellone();
				session.setAttribute("ombrellonePrenotato"+id , listaOmbrelloniPrenotati.get(i));
			}	
			
			String data_sessione = (String)session.getAttribute("data_sess");
			if(data_sessione== null) {
				
				session.setAttribute("data_sess", data_sess);
			
				
			}
			
			String slot_orario_sessione= (String)session.getAttribute("slot_orario_sess");
			if(slot_orario_sessione==null) {
				
				session.setAttribute("slot_orario_sess", slot_orario_sess);
			
			}
		
		}
		
		
		if(("dati_prenotazione_ombrellone").equals(operazione)) {
			
			String id_ombrelloneString = request.getParameter("id_ombrellone");
			int id = Integer.parseInt(id_ombrelloneString.substring(10));
			
			Ombrellone ombrellone = db.getOmbrelloneFromDb(id);
						
			response.setContentType("application/json");
				
			PrintWriter out = response.getWriter();
			String result= "{\"id\":\""+ombrellone.getId_ombrellone()+"\","
					+ "\"zona\":\""+ombrellone.getZona()+"\","
					+ "\"prezzo\":\""+ombrellone.getPrezzo()+"\""
					+ "}";
			
		    out.print(result);
					
		}
	if(("prenota_ombrellone").equals(operazione)) {
			int id_ombrellone = Integer.parseInt(request.getParameter("id_ombrellone"));
			
			String slot_orarioString= request.getParameter("slot_orario1");
			String data= request.getParameter("data1");
			
			int slot_orario=0;
			if((slot_orarioString).equals("Mattina")) {
				slot_orario=1;
			}
			if((slot_orarioString).equals("Pomeriggio")) {
				slot_orario=2;
			}
			int id_cliente = Integer.parseInt(request.getParameter("id_cliente"));
			int num_persone = Integer.parseInt(request.getParameter("num_persone"));
			int num_lettini = Integer.parseInt(request.getParameter("num_lettini"));
			int num_sdraio = Integer.parseInt(request.getParameter("num_sdraio"));
			
			int id_prenot_disp=db.firstIdPrenotazioneOmbrAvailable();
					
			boolean flag=false;
			ClientePrenotaOmbrellone ombr_verifica=db.getPrenotazioneOmbrellone(id_ombrellone, slot_orario, data);
			
			if(ombr_verifica.getId_ombrellone()!= id_ombrellone ) {
				flag=db.insertPrenotazioneOmbrellone(id_prenot_disp,id_cliente, id_ombrellone, data, slot_orario,num_persone, num_lettini, num_sdraio);
				
			}
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			
			String result= "{\"res\":\""+flag+"\"}";
			out.print(result);
			 
			
		}
		
		//sotto-opzione2
	
	if(("lista_prenotazioni").equals(operazione)) {
		
		int id_cliente =Integer.parseInt(request.getParameter("id_cliente"));
		
		ArrayList<ClientePrenotaOmbrellone> lista_prenotazioni = db.getListaPrenotazioneOmbrellonibyIdCliente(id_cliente);
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		
		if(lista_prenotazioni.size()==0) {
			String result= "{\"result\":\""+"Nessuna Prenotazione"+"\"}";
			out.print(result);
		}else {

			for(int i=0; i<lista_prenotazioni.size(); i++) {
				
				ClientePrenotaOmbrellone prenotazione = lista_prenotazioni.get(i);
				int id_ombrellone= lista_prenotazioni.get(i).getId_ombrellone();
				
				Ombrellone ombrellone =(Ombrellone) db.getOmbrelloneFromDb(id_ombrellone);		
				
				session.setAttribute("Ombrellone"+i , ombrellone);	
				session.setAttribute("prenotazione"+i, prenotazione);
				
			}
			String result= "{\"result\":\""+"true"+"\"}";
			out.print(result);
		
		}
				
	}
	
	if(("modifica_ordine_ombr").equals(operazione)) {
	
		int id = Integer.parseInt(request.getParameter("id"));
		int lettini = Integer.parseInt(request.getParameter("lettini"));
		int persone = Integer.parseInt(request.getParameter("persone"));
		int sdraio = Integer.parseInt(request.getParameter("sdraio"));
		
		response.setContentType("application/json");				
		PrintWriter out = response.getWriter();

		boolean modificata = db.modificaPrenotazioneOmbrellone(id,persone,lettini,sdraio);
		String result= "{\"result\":\""+modificata+"\"}";
		out.println(result);
		
	}
	
	if(("elimina_ordine_ombr").equals(operazione)) {
		
		
		int id = Integer.parseInt(request.getParameter("id"));
		response.setContentType("application/json");				
		PrintWriter out = response.getWriter();

		boolean modificata = db.eliminaPrenotazioneOmbrellone(id);
		String result= "{\"result\":\""+modificata+"\"}";
		out.println(result);
		
	}
	
	
	
	
	
		
	//sotto-opzione3 ->prenota doccia	
		
		
	if(("visualizza_docce").equals(operazione)) {
		
		String data=request.getParameter("data_scelta2");
		int slot=Integer.parseInt(request.getParameter("slot_orario2"));
	
		ArrayList<ClientePrenotaDoccia> listaDoccePrenotate = db.getListaPrenotazioneDocce(data,slot);
		
		HttpSession session = request.getSession();
		for(int i=0; i< listaDoccePrenotate.size(); i++) {
			int id= listaDoccePrenotate.get(i).getId_doccia();
			
			session.setAttribute("docciaPrenotata"+id , listaDoccePrenotate.get(i));
		}
		
		String data_sessione = (String)session.getAttribute("data_sess");
		if(data_sessione== null) {
			
			session.setAttribute("data_sess_d", data);
			
			
		}
		
		String slot_orario_sessione = (String)session.getAttribute("slot_orario_sess");
		if(slot_orario_sessione==null) {
			
			session.setAttribute("slot_orario_sess_d", slot);
			
		}
		
	}
		
		if(("dati_doccia").equals(operazione)) {
			String id_docciaString = request.getParameter("id_doccia");
			
			int id = Integer.parseInt(id_docciaString.substring(6));
			Doccia doccia = db.getDocciaFromDb(id);

			
		
			response.setContentType("application/json");
				
			PrintWriter out = response.getWriter();

			String result= "{\"id\":\""+doccia.getId_doccia()+"\"," +
				  "\"accesso\":\""+doccia.getAccesso_disabili()+"\""+
				   "}";
				  
				  out.print(result);
				  System.out.print(result);
		}
		
		
		if(("prenota_doccia").equals(operazione)) {
			
			int id_doccia = Integer.parseInt(request.getParameter("id_doccia"));
			
			int id_cliente = Integer.parseInt(request.getParameter("id_cliente"));
			
			
			String data= request.getParameter("data");
			String slot_orarioDString= request.getParameter("slot_orario");
			
			
			int slot_orario=0;
			if((slot_orarioDString).equals("9:00-9:40")) {
				slot_orario=1;
			}
			if((slot_orarioDString).equals("10:00-10:40")) {
				slot_orario=2;
			}
			if((slot_orarioDString).equals("11:00-11:40")) {
				slot_orario=3;
			}
			if((slot_orarioDString).equals("12:00-12:40")) {
				slot_orario=4;
			}
			if((slot_orarioDString).equals("15:00-15:40")) {
				slot_orario=5;
			}
			if((slot_orarioDString).equals("16:00-16:40")) {
				slot_orario=6;
			}
			if((slot_orarioDString).equals("17:00-17:40")) {
				slot_orario=7;
			}
			if((slot_orarioDString).equals("18:00-18:40")) {
				slot_orario=8;
			}
			if((slot_orarioDString).equals("19:00-19:40")) {
				slot_orario=9;
			}
			if((slot_orarioDString).equals("20:00-20:40")) {
				slot_orario=10;
			}
			
			
			int id_prenot_disp=db.firstIdPrenotazioneDocciaAvailable();
			 
			boolean flag=false; 
			ClientePrenotaDoccia doccia_verifica=db.getPrenotazioneDoccia(id_doccia, slot_orario, data);
			  
			if(doccia_verifica.getId_prenota_doccia()!= id_doccia ) {
				 flag=db.insertPrenotazioneDoccia(id_prenot_disp,id_cliente,id_doccia, slot_orario, data);
			}
			 
			
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			
			
			String result= "{\"res\":\""+flag+"\"}";
			out.print(result);
			 
			
		}	
		
		//sotto-opzione4-> elimina doccia
if(("lista_prenotazioni_doccia").equals(operazione)) {
			
			int id_cliente =Integer.parseInt(request.getParameter("id_cliente"));
			
			ArrayList<ClientePrenotaDoccia> lista_prenotazioni =  db.getPrenotazioneDocciaById(id_cliente);
			
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			
			HttpSession session = request.getSession();
			
			if(lista_prenotazioni.size()==0) {
				String result= "{\"result\":\""+"Nessuna Prenotazione"+"\"}";
				out.print(result);
			}else {

				for(int i=0; i<lista_prenotazioni.size(); i++) {
					
					ClientePrenotaDoccia prenotazione = lista_prenotazioni.get(i);
					int id_doccia= lista_prenotazioni.get(i).getId_doccia();
					
					Doccia doccia =(Doccia) db.getDocciaFromDb(id_doccia);		
					
					session.setAttribute("doccia"+i , doccia);	
					session.setAttribute("prenotazione"+i, prenotazione);
					
				}
				String result= "{\"result\":\""+"true"+"\"}";
				out.print(result);
							
			}
					
		}
		
		if(("elimina_prenotazione_doccia").equals(operazione)) {
			
			
			int id_prenotazione = Integer.parseInt(request.getParameter("id"));
			response.setContentType("application/json");				
			PrintWriter out = response.getWriter();

			boolean modificata = db.eliminaPrenotazioneDoccia(id_prenotazione);
			String result= "{\"result\":\""+modificata+"\"}";
			out.println(result);
			
		}
	
		
		//sotto-opzione 5-> prenotazione piatto
		if(("visualizza_menu").equals(operazione)) {
			
			ArrayList<Piatto> menu=db.menuFromDb();
			
			
			for(int i=0; i< menu.size(); i++) {
				int id= menu.get(i).getId_piatto();
				//passo il menu in sessione --> ogni piatto con l'id
				
				HttpSession session = request.getSession();
				session.setAttribute("piatto"+id , menu.get(i));
				
			}
			
			
		
		}
		
		
		
		if(("prenotazione_bar").equals(operazione)) {
			int idOrdineAvailable= db.firstIdPrenotazionePiattoAvailable();
			String nome_piatto= request.getParameter("nome_piatto");
		
			
			if(nome_piatto.contains("*") ) {
				String nome=nome_piatto.substring(3);
				System.out.println(nome_piatto.substring(3));
				nome_piatto=nome;
			}
			
			
			
			int id_piatto= db.getOrdinePiatto(nome_piatto); //da Piatto
			
			Piatto piatto_considerato= db.getPiatto(id_piatto);
					
			int id_cliente = Integer.parseInt(request.getParameter("id_cliente"));
			int quantita = Integer.parseInt(request.getParameter("quantita"));
			int stato_pagamento = Integer.parseInt(request.getParameter("stato_pagamento"));
			
			boolean s_pagamento=false;
			if(stato_pagamento==0) {
				s_pagamento=false;
			}else {
				s_pagamento=true;
			}
			String stato_completamento= request.getParameter("stato_completamento");
			String data_prenotazione= request.getParameter("data_prenotazione");
			
			System.out.println("idOrdineAvailable "+ idOrdineAvailable +" id_p_corretto "+id_piatto+" stato_pagamento "+ stato_pagamento );
			System.out.println("nome_piatto "+ nome_piatto +" id_cliente "+id_cliente+" quantita "+ quantita );
			System.out.println("stato_completamento "+ stato_completamento +"id_cliente "+id_cliente + "data_prenotazione "+ data_prenotazione );	
			
			ClientePrenotaPiatto ordine_singolo= new ClientePrenotaPiatto();
			ordine_singolo.setId_ordine(idOrdineAvailable);
			ordine_singolo.setId_piatto(id_piatto);
			ordine_singolo.setId_cliente(id_cliente);
			ordine_singolo.setQuantita(quantita);
			ordine_singolo.setStato_pagamento(s_pagamento);
			ordine_singolo.setStato_completamento(stato_completamento);
			ordine_singolo.setData_ordine(data_prenotazione);
			
			boolean isInserito=false;
			ArrayList<ClientePrenotaPiatto> lista_ordini= db.ordiniPiattiFromDb();
			if(lista_ordini.contains(ordine_singolo)) {
				System.out.println("la prenotazione è già avvenuta");
			}else {
				//controllo se la quantità richiesta è disponibile
				if(ordine_singolo.getQuantita()<piatto_considerato.getDisponibilita()) {
					isInserito= db.insertPrenotazionePiatto(idOrdineAvailable, id_piatto, id_cliente, quantita , stato_pagamento,stato_completamento,data_prenotazione  );
					if(isInserito==true) {
						System.out.println("E' stato inserito correttamente");
					}else {
						System.out.println("Non è stato inserito");
					}
				}
				
			}
			
			
			 response.setContentType("application/json"); 
			 PrintWriter out =response.getWriter();
			  
			  
			 String result= "{\"res\":\""+isInserito+"\"}"; 
			 out.print(result);
			 
			
			
			
		}
		
		//sotto-opzione6-> modifica lista bar
if(("lista_prenotazioni_bar").equals(operazione)) {
			
			int id_cliente =Integer.parseInt(request.getParameter("id_cliente"));
			
			ArrayList<ClientePrenotaPiatto> lista_ordini =  db.getListaOrdinibyId(id_cliente);
			
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			
			HttpSession session = request.getSession();
			
			if(lista_ordini.size()==0) {
				String result= "{\"result\":\""+"Nessuna Prenotazione"+"\"}";
				out.print(result);
			}else {

				for(int i=0; i<lista_ordini.size(); i++) {
					
					ClientePrenotaPiatto ordine = lista_ordini.get(i);
					int id_piatto= lista_ordini.get(i).getId_piatto();
					
					Piatto piatto =(Piatto) db.getPiatto(id_piatto);		
					
					session.setAttribute("piatto"+i , piatto);	
					session.setAttribute("ordine"+i, ordine);
					
				}
				String result= "{\"result\":\""+"true"+"\"}";
				out.print(result);
							
			}
					
		}
		
		if(("modifica_ordine_bar").equals(operazione)) {
			
			int id_ordine = Integer.parseInt(request.getParameter("id"));
			int quantita = Integer.parseInt(request.getParameter("quantita"));
			

			// setta quantita ordine
			boolean update_ordine = db.updateQuantitaOrdine(id_ordine, quantita);
			
			response.setContentType("application/json");				
			PrintWriter out = response.getWriter();
			
			if(update_ordine) {

				String result= "{\"result\":\""+"true"+"\"}";
				out.println(result);
				
			}else {
				String result= "{\"result\":\""+"false"+"\"}";
				out.println(result);
			}

			
		}
		
		if(("elimina_ordine_bar").equals(operazione)) {
			
			
			int id = Integer.parseInt(request.getParameter("id"));
			response.setContentType("application/json");				
			PrintWriter out = response.getWriter();

			boolean modificata = db.eliminaOrdine(id);
			String result= "{\"result\":\""+modificata+"\"}";
			out.println(result);
			
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
