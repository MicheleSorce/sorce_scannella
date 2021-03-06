package pkg.init;



import pkg.bean.*;
import pkg.db.DBQuery;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



@WebServlet("/LoginServlet")

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		DBQuery db= new DBQuery();
		
		
		HttpSession session = request.getSession(true);
	    
		String email =request.getParameter("insert_email");
		String pw =request.getParameter("insert_password");					//dal form
	
		String type= db.whoUserType(email, pw);

		
		
		
		switch(type) {
			case("amministratore"):
				
				Amministratore ammin= (Amministratore)session.getAttribute("ammin");
				if(ammin == null) {
					ammin= new Amministratore();
					session.setAttribute("ammin", ammin);
				}
				Object[] array_fields=(Object[])db.searchAmm_Bar_Bag(email,type,"id_amministratore");
				ammin.setIdAmministratore((Integer)array_fields[0]);
				ammin.setNome((String)array_fields[1]);
				ammin.setCognome((String)array_fields[2]);
				ammin.setTelefono((String)array_fields[3]);
				ammin.setEmail((String)array_fields[4]);
				ammin.setPw((String)array_fields[5]);
				ammin.setData((String)array_fields[6]);
				ammin.setSesso((Integer)array_fields[7]);	
				
				String address_a="/jsp/AmministratoreHome.jsp";
				
				response.sendRedirect(request.getContextPath() + address_a);
				
				break;
			case("barista"):
				Barista barista= (Barista)session.getAttribute("barista");
				if(barista == null) {
					barista= new Barista();
					session.setAttribute("barista", barista);
				}
				Object[] array_fields2=(Object[])db.searchAmm_Bar_Bag(email,type,"id_barista");
				barista.setIdBarista((Integer)array_fields2[0]);
				barista.setNome((String)array_fields2[1]);
				barista.setCognome((String)array_fields2[2]);
				barista.setTelefono((String)array_fields2[3]);
				barista.setEmail((String)array_fields2[4]);
				barista.setPw((String)array_fields2[5]);
				barista.setData((String)array_fields2[6]);
				barista.setSesso((Integer)array_fields2[7]);
				
				String address_bar="/jsp/BarHome.jsp";
				response.sendRedirect(request.getContextPath() + address_bar);
				break;
			case("bagnino"):
				Bagnino bagnino= (Bagnino)session.getAttribute("bagnino");
				if(bagnino == null) {
					bagnino= new Bagnino();
					session.setAttribute("bagnino", bagnino);
				}
				Object[] array_fields3=(Object[])db.searchAmm_Bar_Bag(email,type,"id_bagnino");
				bagnino.setIdBagnino((Integer)array_fields3[0]);
				bagnino.setNome((String)array_fields3[1]);
				bagnino.setCognome((String)array_fields3[2]);
				bagnino.setTelefono((String)array_fields3[3]);
				bagnino.setEmail((String)array_fields3[4]);
				bagnino.setPw((String)array_fields3[5]);
				bagnino.setData((String)array_fields3[6]);
				bagnino.setSesso((Integer)array_fields3[7]);
				
				String address_bag="/jsp/BagninoHome.jsp";
				response.sendRedirect(request.getContextPath() + address_bag);
				break;
			case("cliente"):
				Cliente cliente= (Cliente)session.getAttribute("cliente");
				if(cliente == null) {
					cliente= new Cliente();
					session.setAttribute("cliente", cliente);
				}
				Object[] array_fields4=(Object[])db.searchCliente(email,"id_cliente");
				cliente.setIdCliente((Integer)array_fields4[0]);
				cliente.setNome((String)array_fields4[1]);
				cliente.setCognome((String)array_fields4[2]);
				cliente.setTelefono((String)array_fields4[3]);
				cliente.setEmail((String)array_fields4[4]);
				cliente.setPw((String)array_fields4[5]);
				cliente.setData((String)array_fields4[6]);
				cliente.setSesso((Integer)array_fields4[7]);
				cliente.setTot_pagamento((Float)array_fields4[8]);
				
				String address_c="/jsp/ClienteHome.jsp";
				response.sendRedirect(request.getContextPath() + address_c);
				
				break;
			default: //utente non registrato perchè non trova email-pw sul db
				String address_out="/jsp_result/login_failed.jsp";
				response.sendRedirect(request.getContextPath() + address_out);
				break;
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
