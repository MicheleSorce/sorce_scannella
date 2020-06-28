package pkg.mappa;


import pkg.bean.Ombrellone;
import pkg.db.DBQuery;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;



@WebServlet("/DatiOmbrelloneServlet")

public class DatiOmbrelloneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		DBQuery db= new DBQuery();
	
		
		String  string_ombr=request.getParameter("id_ombrellone"); 
		int id_ombrellone = Integer.parseInt(string_ombr.substring(10));	
		Ombrellone ombrellone_sel=db.getOmbrelloneFromDb(id_ombrellone);
		
		//----------------
		
		
		/*
		 * HttpSession session = request.getSession(true);
		 * session.setAttribute("ombrellone_sel", ombrellone_sel); Ombrellone ombr=
		 * (Ombrellone)session.getAttribute("ombrellone_sel"); if(ombr == null) { ombr=
		 * new Ombrellone(); session.setAttribute("ombr", ombr);
		 * 
		 * }
		 */
        
          
        //----------------------
		request.setAttribute("ombrellone_sel", ombrellone_sel);	

	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
