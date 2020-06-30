package pkg.bar;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
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
        // TODO Auto-generated constructor stub
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
			if(id_String.length()<12) {//in caso di cibo
				int id= Integer.parseInt(id_String.substring(9));
				int valore = Integer.parseInt(request.getParameter("valore"));
				
				boolean result =db.updateDisponibilita(id,valore);
				
			}
			if(id_String.length()>12) {//in caso di bevanda
				
				int id= Integer.parseInt(id_String.substring(12));
				int valore = Integer.parseInt(request.getParameter("valore"));
				
				boolean result =db.updateDisponibilita(id,valore);

			}
					
		}
		
		if(("lista_ordinazioni").equals(operazione)) {
			
			HttpSession session = request.getSession();
			
			ArrayList<ClientePrenotaPiatto> ordini_piatti = db.ordiniPiattiFromDb();
			
			// potrebbe essere utile per scorrere gli ordini----------------
			int num_ordini= ordini_piatti.size(); 
			
			for(int i=0; i< num_ordini; i++) {
				int idOrdine= ordini_piatti.get(i).getId_ordine();

				session.setAttribute("ordine"+idOrdine , ordini_piatti.get(i));
			}
			session.setAttribute("numOrdini" , num_ordini);

		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
