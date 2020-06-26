package pkg.cliente;
import pkg.bean.*;
import pkg.db.DBQuery;


import java.io.IOException;

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
		
		DBQuery db= new DBQuery();
	//	Ombrellone[] mappaSpiaggiaOmbrelloni=new Ombrellone[24];
		
		//for(int i=0; i< mappaSpiaggiaOmbrelloni.length; i++){
		//	Ombrellone mappaSpiaggiaOmbrelloni[i]=db.getOmbrelloneFromDb(i);
		//}
		boolean res=db.getOmbrelloneFromDb(2);
		
	//	request.setAttribute("ombrellone", ombr);
		
		if(res==false) {
			String address="/jsp_result/registrazione_failed.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		}else {
			String address="/jsp_result/registrazione_success.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
