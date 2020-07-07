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

import pkg.bean.ClientePrenotaPiatto;
import pkg.bean.Piatto;
import pkg.db.DBQuery;

/**
 * Servlet implementation class BarServlet
 */
@WebServlet("/BarServlet")
public class BarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public BarServlet() {
        super();
       
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		DBQuery db= new DBQuery();
		String operazione = request.getParameter("operazione");
		if(("menu_bar").equals(operazione)) {
			
			ArrayList<Piatto> menu=db.menuFromDb();
			
			
			for(int i=0; i< menu.size(); i++) {
				int id= menu.get(i).getId_piatto();
				//passo il menu in sessione --> ogni piatto con l'id
				
				HttpSession session = request.getSession();
				session.setAttribute("piatto"+id , menu.get(i));
				
			}

			
		}
		if(("modifica_disponibilita").equals(operazione)) {

			String id_String = request.getParameter("identificativo");
			
			boolean result=false;
			
			if(id_String.length()<12) {//in caso di cibo
				int id= Integer.parseInt(id_String.substring(9));
				int valore = Integer.parseInt(request.getParameter("valore"));
				
				 result = db.updateDisponibilita(id,valore);
				

				
			}
			if(id_String.length()>12) {//in caso di bevanda
				
				int id= Integer.parseInt(id_String.substring(12));
				int valore = Integer.parseInt(request.getParameter("valore"));
				
				 result =db.updateDisponibilita(id,valore);

			}
			
			response.setContentType("application/json");				
			PrintWriter out = response.getWriter();		
			String result_String= "{\"result\":\""+result+"\"}";
			out.println(result_String);
					
		}
		
		if(("lista_ordinazioni").equals(operazione)) {
			
			HttpSession session = request.getSession();
			
			ArrayList<ClientePrenotaPiatto> ordini_piatti = db.ordiniPiattiFromDb();
			
			int num_ordini= ordini_piatti.size(); 
			
			for(int i=0; i< num_ordini; i++) {
				int idOrdine= ordini_piatti.get(i).getId_ordine();
				
				session.setAttribute("ordine"+idOrdine , ordini_piatti.get(i));
			}
			session.setAttribute("numOrdini" , num_ordini);

		}
		
		
		if(("modifica_stato_ordine").equals(operazione)) {

			String id_ordineString = request.getParameter("id");
			String stato_ordine = request.getParameter("stato");
			
			int id= Integer.parseInt(id_ordineString.substring(6));
			
			boolean result =db.updateStatoOrdine(id,stato_ordine);
		
			response.setContentType("application/json");				
			PrintWriter out = response.getWriter();		
			String result_String= "{\"result\":\""+result+"\"}";
			out.println(result_String);
		}
		

		if(("elimina_ordine").equals(operazione)) {

			String id_ordineString = request.getParameter("id");
			
			int id= Integer.parseInt(id_ordineString.substring(14));
			
			boolean result =db.eliminaOrdine(id);
			response.setContentType("application/json");				
			PrintWriter out = response.getWriter();		
			String result_String= "{\"result\":\""+result+"\"}";
			out.println(result_String);
			HttpSession session = request.getSession();
			session.removeAttribute("ordine"+id);
			
		}
		
		
		if(("modifica_quantia_piatto").equals(operazione)) {

			int id = Integer.parseInt(request.getParameter("id"));
			int quantita_usata = Integer.parseInt(request.getParameter("quantita_usata"));

			boolean result =db.updateQuantitaPiatto(id,quantita_usata);
			
			response.setContentType("application/json");				
			PrintWriter out = response.getWriter();		
			String result_String= "{\"result\":\""+result+"\"}";
			out.println(result_String);
		
		}
		
		if(("modifica_piatto_giorno").equals(operazione)) {

			

			String id_String = request.getParameter("identificativo");
			boolean result=false;
			if(id_String.length()<=6) {//in caso di cibo
				
				 int id= Integer.parseInt(id_String.substring(4));	
				 int valore = Integer.parseInt(request.getParameter("valore"));

				 result =db.updateMenuGiorno(id,valore);
			}
			if(id_String.length()>6) {//in caso di bevanda			
				
				 int id= Integer.parseInt(id_String.substring(7));
				 int valore = Integer.parseInt(request.getParameter("valore"));

				 result =db.updateMenuGiorno(id,valore);
			}
			
			response.setContentType("application/json");				
			PrintWriter out = response.getWriter();		
			String result_String= "{\"result\":\""+result+"\"}";
			out.println(result_String);
		

		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
