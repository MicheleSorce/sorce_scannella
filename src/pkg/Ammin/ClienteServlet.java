package pkg.Ammin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import pkg.bean.ClientePrenotaOmbrellone;

import pkg.bean.Ombrellone;
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
		
		
		//visualizza lo stato spiaggia 
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
			session.setAttribute("data_sess", data_sess);
			System.out.println("data_sess " + data_sess);
			
			session.setAttribute("slot_orario_sess", slot_orario_sess);
			System.out.println("sloooot_sess " + slot_orario_sess);
			
		
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
			System.out.println(request.getParameter("id_ombrellone"));
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
			
			System.out.println("data: " + data + " slot: " + slot_orario+ " id_ombrel: " + id_ombrellone + " num_sdraio:" + num_sdraio);
			System.out.println("numpersone: " + num_persone + " num_lettini: " + num_lettini+ " id_cliente: " + id_cliente);
			
			
			int id_prenot_disp=db.firstIdPrenotazioneOmbrAvailable();
			System.out.println("id_prenot_disp: " + id_prenot_disp );
			
			boolean flag=false;
			ClientePrenotaOmbrellone ombr_verifica=db.getPrenotazioneOmbrellone(id_ombrellone, slot_orario, data);
			
			
			if(ombr_verifica.getId_ombrellone()!= id_ombrellone ) {
				flag=db.insertPrenotazioneOmbrellone(id_prenot_disp,id_cliente, id_ombrellone, data, slot_orario,num_persone, num_lettini, num_sdraio);
				if(flag==true)  {
					System.out.println("E' stato inserito" );
				}else {
					System.out.println("Non è stato inserito" );
				}
			}else {
				System.out.println("E' già presente nel db: " + flag );
			}
			
			
			
			System.out.println("E' stato inserito nel db? " + flag );
			
			
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			
			
			String result= "{\"res\":\""+flag+"\"}";
			out.print(result);
			 
			System.out.println(result);
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
