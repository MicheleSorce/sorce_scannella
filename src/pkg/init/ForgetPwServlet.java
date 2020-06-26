package pkg.init;


import pkg.db.DBQuery;


import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




@WebServlet("/ForgetPwServlet")

public class ForgetPwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ForgetPwServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		boolean modified;
		
		DBQuery db= new DBQuery();
		
		String email =request.getParameter("insert_email");
		String pw =request.getParameter("insert_password");					//dal form
	
		modified= db.modifyPw(email, pw); //true-> modificato pw-> trovata email in una delle 4 tabelle
		if(modified) {
			String address = "/jsp_result/password_success.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);	
		}else {
			String address = "/jsp_result/password_failed.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		}
		
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
