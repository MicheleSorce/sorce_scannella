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


@WebServlet("/PrenotazioneOmbrelloneServlet")

public class PrenotazioneOmbrelloneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		DBQuery db= new DBQuery();
	
		String data=request.getParameter("data_scelta");
		ArrayList<ClientePrenotaOmbrellone> listaOmbrelloniPrenotati = db.getListaPrenotazioneOmbrellone(data);
		request.setAttribute("listaOmbrelloni", listaOmbrelloniPrenotati);
		
		for(int i=0; i< listaOmbrelloniPrenotati.size(); i++) {
			request.setAttribute("ombrellonePrenotato"+i , listaOmbrelloniPrenotati.get(i));
			System.out.println("ombrellonePrenotato"+i);
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
