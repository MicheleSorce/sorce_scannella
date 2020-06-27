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




@WebServlet("/MappaSpiaggiaServlet2")

public class MappaSpiaggiaServlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MappaSpiaggiaServlet2() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ArrayList<Ombrellone> listaOmbrelloni= new ArrayList<Ombrellone>();
		int num_ombrelloni= 24;
		DBQuery db= new DBQuery();
	
		for(int i=1; i<=num_ombrelloni; i++){ // la lista deglio ombrelloni � di 24
		//	Ombrellone mappaSpiaggiaOmbrelloni[i]=db.getOmbrelloneFromDb(i);
			
			Object[] res=db.getOmbrelloneFromDb(i); //data la riga dell'ombrellone i-esimo salviamo in un array di objec ogni campo della riga
			
			Ombrellone ombr = new Ombrellone();
			ombr.setId_ombrellone(i);
			ombr.setNum_persone((Integer)res[1]);
			ombr.setNum_lettini((Integer)res[2]);
			ombr.setNum_sdraio((Integer)res[3]);
			ombr.setSlot_orario((Integer)res[4]);
			ombr.setData_prenotazione((String)res[5]);
			ombr.setZona((String)res[6]);
			ombr.setPrezzo((Float)res[7]);
			ombr.setLibero((Boolean)res[8]);
			ombr.setPulito((Boolean)res[9]);
			
			listaOmbrelloni.add(ombr);
		}
		
		request.setAttribute("listaOmbrelloni", listaOmbrelloni);
		
		for(Ombrellone ombrellone : listaOmbrelloni) {
	/* System.out.println(ombrellone.getId_ombrellone()+" lettini: "+ombrellone.getNum_lettini()+" zona: "+ombrellone.getZona()+" prezzo: "+ombrellone.getPrezzo() +" pulito: "+ombrellone.getPulito());*/
			String stringa= ombrellone.getId_ombrellone()+" lettini: "+ombrellone.getNum_lettini()+" zona: "+ombrellone.getZona()+" prezzo: "+ombrellone.getPrezzo() +" pulito: "+ombrellone.getPulito();
			response.setContentType("application/json");
			 PrintWriter out = response.getWriter();
			 out.print(stringa);
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
