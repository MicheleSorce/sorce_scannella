package pkg.init;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pkg.bean.Cliente;
import pkg.db.DBQuery;

@WebServlet({"/RegistrazioneServlet", "/registrazione"})

public class RegistrazioneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RegistrazioneServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		Cliente cliente= new Cliente();
		DBQuery db= new DBQuery();
		
		String nome =request.getParameter("nome");					//dal form
		String cognome =request.getParameter("cognome");
		String telefono=request.getParameter("telefono");
		String email=request.getParameter("email");
		String pw=request.getParameter("password");
		String data_nascita=request.getParameter("data_nascita");
			String gen=request.getParameter("genere");
		Integer genere=Integer.parseInt(gen);
		
		cliente.setNome(nome);										//bean
		cliente.setCognome(cognome);
		cliente.setTelefono(telefono);
		cliente.setEmail(email);
		cliente.setPw(pw);
		cliente.setData(data_nascita);
		cliente.setSesso(genere);
		cliente.setTot_pagamento(0);
		
		request.setAttribute("cliente", cliente);
		
		if(db.isRegistrated(cliente)) {
			String address="/jsp_result/registrazione_failed.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(address);
			dispatcher.forward(request, response);
		}else {
		    db.insertCliente(cliente);
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
