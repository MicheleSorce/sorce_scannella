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

import pkg.bean.Cliente;
import pkg.bean.ClientePrenotaDoccia;
import pkg.bean.ClientePrenotaOmbrellone;
import pkg.bean.Doccia;
import pkg.bean.Ombrellone;
import pkg.db.DBQuery;

/**
 * Servlet implementation class BagninoServlet
 */
@WebServlet("/BagninoServlet")
public class BagninoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BagninoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DBQuery db= new DBQuery();
		String operazione = request.getParameter("operazione");
		
		
		//visualizza lo stato spiaggia 
		if(("visualizza_spiaggia").equals(operazione)) {
		
			String data=request.getParameter("data_scelta0");
			String slot_orarioString1= request.getParameter("slot_orario0");
			
			
			int slot_orario=0;
			if((slot_orarioString1).equals("3")) {
				slot_orario=1;
			} 
			if((slot_orarioString1).equals("4")) {
				slot_orario=2;
			} 
			
			ArrayList<ClientePrenotaOmbrellone> listaOmbrelloniPrenotati = db.getListaPrenotazioneOmbrellone(data,slot_orario);
			
			if(listaOmbrelloniPrenotati.size()==0) {
		        response.setContentType("text/html");        
		        PrintWriter out = response.getWriter();
		        String result="Nessuna Prenotazione";
		        out.print(result);
		      }
			
			
			for(int i=0; i< listaOmbrelloniPrenotati.size(); i++) {
				int id= listaOmbrelloniPrenotati.get(i).getId_ombrellone();
				HttpSession session = request.getSession();
				session.setAttribute("ombrellonePrenotato"+id , listaOmbrelloniPrenotati.get(i));
			}	
			
		
		}
		
		//Visualizza i dati dell'ombrellone
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
					+ "\"stato_pulizia\":\""+ombrellone.getPulito() +"\","
					+ "\"num_persone\":\""+prenotazione.getNum_persone()+"\","
					+ "\"num_lettini\":\""+prenotazione.getNum_lettini()+"\","
					+ "\"num_sdraio\":\""+prenotazione.getNum_sdraio()+"\","
					+ "\"nome\":\""+cliente.getNome()+"\","
					+ "\"cognome\":\""+cliente.getCognome()+"\","
					+ "\"telefono\":\""+cliente.getTelefono()+"\""
					+ "}";
			
		    out.print(result);
					
		}

		if(("visualizza_docce").equals(operazione)) {
		
			String data=request.getParameter("data_scelta2");
			int slot=Integer.parseInt(request.getParameter("slot_orario2"));
		
			ArrayList<ClientePrenotaDoccia> listaDoccePrenotate = db.getListaPrenotazioneDocce(data,slot);
			
			if(listaDoccePrenotate.size()==0) {
		        response.setContentType("text/html");        
		        PrintWriter out = response.getWriter();
		        String result="Nessuna Prenotazione";
		        out.print(result);
		      }
			
		
			for(int i=0; i< listaDoccePrenotate.size(); i++) {
				int id= listaDoccePrenotate.get(i).getId_doccia();
				HttpSession session = request.getSession();
				session.setAttribute("docciaPrenotata"+id , listaDoccePrenotate.get(i));
			}
		}
		
		
		if(("dati_prenotazione_doccia").equals(operazione)) {
			
			String id_docciaString = request.getParameter("id_doccia");
			String slot_orarioDString= request.getParameter("slot_orario2");
			String dataD= request.getParameter("data2");
			
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
			
			int id = Integer.parseInt(id_docciaString.substring(6));
			Doccia doccia = db.getDocciaFromDb(id);

			
			ClientePrenotaDoccia prenotazione = db.getPrenotazioneDoccia(id,slot_orario,dataD);
			int id_cliente= prenotazione.getId_cliente();
			Cliente cliente = db.getCliente(id_cliente);
		
			response.setContentType("application/json");
				
			PrintWriter out = response.getWriter();

			String result= "{\"id\":\""+doccia.getId_doccia()+"\"," +
				  "\"accesso\":\""+doccia.getAccesso_disabili()+"\","+
				  "\"nome\":\""+cliente.getNome()+"\"," +
				  "\"cognome\":\""+cliente.getCognome()+"\"," +
				  "\"telefono\":\""+cliente.getTelefono()+"\"" + "}";
				  
				  out.print(result);		
		}
		
		//visualizza spiaggia pulizia
			if(("visualizza_spiaggia_pul").equals(operazione)) {
			
				String data=request.getParameter("data_scelta3");
				String slot_orarioString= request.getParameter("slot_orario3");
				
				int slot_orario2=0;
				if((slot_orarioString).equals("1")) {
					slot_orario2=1;
				} if ((slot_orarioString).equals("2")){
					slot_orario2=2;
				}
				
				ArrayList<ClientePrenotaOmbrellone> listaOmbrelloniPrenotati = db.getListaPrenotazioneOmbrellone(data,slot_orario2);
				
				if(listaOmbrelloniPrenotati.size()==0) {
			        response.setContentType("text/html");        
			        PrintWriter out = response.getWriter();
			        String result="Nessuna Prenotazione";
			        out.print(result);
			      }
				
				
				//System.out.println("data: "+data+" slot:"+slot);
				for(int i=0; i< listaOmbrelloniPrenotati.size(); i++) {
					int id= listaOmbrelloniPrenotati.get(i).getId_ombrellone();
					//System.out.println("OMBRELLONI PRENOTATI id:"+id);
					HttpSession session = request.getSession();
					session.setAttribute("ombrellonePrenotato"+id , listaOmbrelloniPrenotati.get(i));
				}	
				
			
			}
		
		if(("pulizia_spiaggia").equals(operazione)) {
			
			int  idOmbr_daPulire= Integer.parseInt(request.getParameter("id_ombr_pulire"));
			String isPulito=request.getParameter("isPulito");
			
			int status=0;
			if(isPulito.equals("pulito")) {
				status=1;
				
			}
			if(isPulito.equals("non_pulito")) {
				status=0;
				
			}
		    boolean isModified=db.setStatoPulito(idOmbr_daPulire, status);
		    
	        response.setContentType("text/html");        
	        PrintWriter out = response.getWriter();
	        
	        out.print(isModified);
			 
			 
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
