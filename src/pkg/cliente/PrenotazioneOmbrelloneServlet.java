package pkg.cliente;

import pkg.bean.*;
import pkg.db.DBQuery;

import java.io.IOException;

import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/PrenotazioneOmbrelloneServlet")

public class PrenotazioneOmbrelloneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		DBQuery db= new DBQuery();
	
		String data=request.getParameter("data_scelta");
		int slot=Integer.parseInt(request.getParameter("slot_orario"));

		ArrayList<ClientePrenotaOmbrellone> listaOmbrelloniPrenotati = db.getListaPrenotazioneOmbrellone(data,slot);
		request.setAttribute("listaOmbrelloni", listaOmbrelloniPrenotati);
		
		
		for(int i=0; i< listaOmbrelloniPrenotati.size(); i++) {
			int id= listaOmbrelloniPrenotati.get(i).getId_ombrellone();
			HttpSession session = request.getSession();
			session.setAttribute("ombrellonePrenotato"+id , listaOmbrelloniPrenotati.get(i));
		}
	
			String address = "/jsp/ClienteHome.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		}
		
		
		
		
		
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
