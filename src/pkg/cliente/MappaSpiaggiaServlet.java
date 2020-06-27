package pkg.cliente;
import pkg.bean.*;
import pkg.db.DBQuery;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




@WebServlet("/MappaSpiaggiaServlet")

public class MappaSpiaggiaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MappaSpiaggiaServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ArrayList<ClientePrenotaOmbrellone> listaOmbrelloni= new ArrayList<ClientePrenotaOmbrellone>();
		//int num_ombrelloni= 24;
		DBQuery db= new DBQuery();
	
		String data=request.getParameter("data_scelta");
		
		listaOmbrelloni=db.getListaPrenotazioneOmbrellone(data);
	
		request.setAttribute("listaOmbrelloni", listaOmbrelloni);
		
		for(int i=0; i<listaOmbrelloni.size(); i++) {
	/* System.out.println(ombrellone.getId_ombrellone()+" lettini: "+ombrellone.getNum_lettini()+" zona: "+ombrellone.getZona()+" prezzo: "+ombrellone.getPrezzo() +" pulito: "+ombrellone.getPulito());*/
			//String stringa= ombrellone.getId_ombrellone()+" lettini: "+ombrellone.getNum_lettini()+" zona: "+ombrellone.getZona()+" prezzo: "+ombrellone.getPrezzo() +" pulito: "+ombrellone.getPulito();
			
			response.setContentType("application/json");
			 PrintWriter out = response.getWriter();
			 out.print(listaOmbrelloni.toString());
		}


		if(listaOmbrelloni.isEmpty()) {
			  	String address="/jsp_result/registrazione_failed.jsp";
				RequestDispatcher dispatcher = request.getRequestDispatcher(address);
				dispatcher.forward(request, response); 
		  }else { 
			  String address="/jsp_result/registrazione_success.jsp";
			  RequestDispatcher dispatcher= request.getRequestDispatcher(address);
			  dispatcher.forward(request ,response);
			  }
		 
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
