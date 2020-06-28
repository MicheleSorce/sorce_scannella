package pkg.mappa;


import pkg.bean.Ombrellone;
import pkg.db.DBQuery;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/DatiOmbrelloneServlet")

public class DatiOmbrelloneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		DBQuery db= new DBQuery();
	
		
		String  string_ombr=request.getParameter("id_ombrellone"); 
		System.out.println("id_ombrell stringa passata" +string_ombr);
		int id_ombrellone = Integer.parseInt(string_ombr.substring(10));
		System.out.println("dvcdfv stringa trasformata" +id_ombrellone);
		
		Ombrellone ombrellone_sel=db.getOmbrelloneFromDb(id_ombrellone);
		
		request.setAttribute("ombrellone_sel", ombrellone_sel);	
		System.out.println("pkgrnkhbdcw"+ombrellone_sel);
	
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
