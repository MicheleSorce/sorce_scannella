package pkg.Ammin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
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
			
			//System.out.println("data: "+data+" slot:"+slot);
			for(int i=0; i< listaOmbrelloniPrenotati.size(); i++) {
				int id= listaOmbrelloniPrenotati.get(i).getId_ombrellone();
				//System.out.println("OMBRELLONI PRENOTATI id:"+id);
				HttpSession session = request.getSession();
				session.setAttribute("ombrellonePrenotato"+id , listaOmbrelloniPrenotati.get(i));
			}	
		
		}
		
		if(("dati_prenotazione_ombrellone").equals(operazione)) {
			
			String id_ombrelloneString = request.getParameter("id_ombrellone");
			String slot_orario= request.getParameter("slot_orario");
			String data= request.getParameter("data");
			
			
			int id = Integer.parseInt(id_ombrelloneString.substring(10));
			System.out.println("id_ombrellone "+id+" data: "+data+" slot_orario: "+slot_orario);
	
			Ombrellone ombrellone = db.getOmbrelloneFromDb(id);
			System.out.println("Id_ombrellone dopo query "+ombrellone.getId_ombrellone());
			
			
			response.setContentType("application/json");
			
			
			PrintWriter out = response.getWriter();
			
		//	String result = "{\"id\":\"" +  ombrellone.getId_ombrellone() + "\"}";
			
	//		String result = "{\"id\":\"" +  ombrellone.getId_ombrellone() + " \" }";
	//		String result2= "{'id':'"+ombrellone.getId_ombrellone()+"','zona':'"+ombrellone.getZona()+"'}";
			String result= "{\"id\":\""+ombrellone.getId_ombrellone()+"\","
							+ "\"zona\":\""+ombrellone.getZona()+"\","
							+ "\"prezzo\":\""+ombrellone.getPrezzo()+"\","
							+ "\"num_persone\":\""+ombrellone.getNum_persone()+"\","
							+ "\"num_lettini\":\""+ombrellone.getNum_lettini()+"\","
							+ "\"num_sdraio\":\""+ombrellone.getNum_sdraio()+"\""
							+ "}";
			
		    out.print(result);
			
			
		
					
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
