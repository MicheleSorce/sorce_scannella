package pkg.init;

//import pkg.bean.*;
import pkg.db.DBQuery;


import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/LoginServlet")

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		DBQuery db= new DBQuery();
		
		String email =request.getParameter("insert_email");
		String pw =request.getParameter("insert_password");					//dal form
	
		String type= db.whoUserType(email, pw);
		response.getWriter().append("Served at: "+ type);
		
		
		
		switch(type) {
			case("amministratore"):
				//Amministratore ammin= new Amministratore();
			//	request.setAttribute("amministratore", ammin);
				//query al db per prendersi tutti gli altri dati 
				//settarlo nella sessione
				
				String address_a="/html/AmministratoreSpiaggia.html";
				RequestDispatcher dispatcher_a = request.getRequestDispatcher(address_a);
				dispatcher_a.forward(request, response);
				break;
			case("barista"):
				String address_bar="/html/Bar.html";
				RequestDispatcher dispatcher_bar = request.getRequestDispatcher(address_bar);
				dispatcher_bar.forward(request, response);
				break;
			case("bagnino"):
				String address_bag="/html/Bagnino.html";
				RequestDispatcher dispatcher_bag = request.getRequestDispatcher(address_bag);
				dispatcher_bag.forward(request, response);
				break;
			case("cliente"):
				String address_c="/html/Cliente.html";
				RequestDispatcher dispatcher_c = request.getRequestDispatcher(address_c);
				dispatcher_c.forward(request, response);
				break;
			default: //utente non registrato perche non trova email-pw sul db
				String address_out="/jsp_result/login_failed.jsp";
				RequestDispatcher dispatcher_out = request.getRequestDispatcher(address_out);
				dispatcher_out.forward(request, response);
				break;
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
