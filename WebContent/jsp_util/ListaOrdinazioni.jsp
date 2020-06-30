<%@page import="pkg.bean.ClientePrenotaPiatto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>

<%
	
	int numOrdini= (Integer) session.getAttribute("numOrdini");
	for(int i=0;i<numOrdini;i++){
		ClientePrenotaPiatto prenotazione =(ClientePrenotaPiatto) session.getAttribute("ordine"+i);
		
		
      	int id_ordine= prenotazione.getId_ordine();
      	int id_piatto= prenotazione.getId_piatto();
      	int id_cliente= prenotazione.getId_cliente();
      	int quantita= prenotazione.getQuantita();
      	boolean stato_pagamento= prenotazione.getStato_pagamento();
      	String stato_completamento= prenotazione.getStato_completamento();

      	<tr><td>Id Ordine</td><td>Piatto</td><td>Cliente</td><td>Quantita</td><td>Stato Pagamento</td><td>Stato Completamento</td><tr>
      	
		String list= "<tr> <td id='"+id_lista_bevanda+"'>"+bibita+"</td><td class='Td3'>"+prezzo+"</td><td class='Td3'><input type='text' class='disponibilita' id='"+id_disp_bevanda+"' value='"+disponibilita+"'</td></tr>";

		%>
   	      <script type="text/javascript">      	      
    	        $("#bibita").append("<%=list%>");
   	      </script>    
	    <%   
	}

%>





<style>
table, th, td {
  border: 2px solid white;
  margin: auto;
  text-align: cente;
}
th,td{
 padding: 15px;
}
th{
	font-weight: bold;
}
#menu{
   width: 60%;
   color: white;
   text-align: center;
   margin: auto;
   border: 2px solid white;
   padding: 30px;
}
</style>








    <div id="menu">
    <h2>Lista Ordinazioni</h2>
 	<table id="lista_ordini">
 		<tr>	
 			<th>Id Ordine</th><th>Piatto</th><th>Cliente</th><th>Quantita</th><th>Stato Pagamento</th><th>Stato Completamento</th>
 		</tr>

 	</table>
    </div>