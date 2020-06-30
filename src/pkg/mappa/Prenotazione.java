package pkg.mappa;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/Prenotazione")
public class Prenotazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Prenotazione() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/*
		 * int id_ombrellone=Integer.parseInt(request.getParameter("id_ombrellone"));
		 * System.out.println(id_ombrellone);
		 */
		String id_ombrellone=request.getParameter("id_ombrellone");
		System.out.println(" ajaje " +id_ombrellone);
		
		
	/*	int num_persone= Integer.parseInt(request.getParameter("num_persone"));
		System.out.println(num_persone);
		
		int num_lettini=Integer.parseInt(request.getParameter("num_lettini"));
		System.out.println(num_lettini);
		
		int num_sdraio=Integer.parseInt(request.getParameter("num_sdraio"));
		System.out.println(num_sdraio);*/
		
		//String zona=request.getParameter("zona");
	//	int prezzo=Integer.parseInt(request.getParameter("prezzo")); 
	//	int stato_occupazione=0;			//nel db stato_occupazione=1
	//	int stato_pulizia=1;
	
		//devo settarli nella tabella ombrellone
	//	String data=request.getParameter("data");
	//	System.out.println(data);
	//	String slot=request.getParameter("slot");
		//System.out.println(slot);
		//devo settare data, slot in cliente_prenota_ombrellone
		
		//devo settare  tot_pagamento in cliente
	//	Float tot_pagamento=Float.parseFloat(request.getParameter("tot_pagamento"));
	//	System.out.println(tot_pagamento);
	
	
	request.setAttribute("prenotazione", id_ombrellone);
	
	
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
