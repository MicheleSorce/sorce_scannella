package pkg.init;

import pkg.bean.*;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



@WebServlet("/LogoutServlet")

public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LogoutServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		
		HttpSession session = request.getSession(true);
	   
		Amministratore ammin= (Amministratore)session.getAttribute("ammin");
		if(ammin != null) {
			session.removeAttribute("ammin");

			response.sendRedirect(request.getContextPath() + "/html/Home.html");
			
		}else {
			Barista barista= (Barista)session.getAttribute("barista");
			if(barista != null) {
				session.removeAttribute("barista");
				response.sendRedirect(request.getContextPath() + "/html/Home.html");
			}else {
				Bagnino bagnino= (Bagnino)session.getAttribute("bagnino");
				if(bagnino != null) {
					session.removeAttribute("bagnino");
					response.sendRedirect(request.getContextPath() + "/html/Home.html");
				}else {
					Cliente cliente= (Cliente)session.getAttribute("cliente");
					if(cliente !=null) {
						session.removeAttribute("cliente");
						response.sendRedirect(request.getContextPath() + "/html/Home.html");
					}
				}
			}
		}
					
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
