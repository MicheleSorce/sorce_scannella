<%@page import="pkg.bean.ClientePrenotaPiatto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>

<%
	
	int numOrdini= (Integer) session.getAttribute("numOrdini");
	session.removeAttribute("numOrdini");
	
	for(int i=1;i<=numOrdini;i++){
		ClientePrenotaPiatto prenotazione =(ClientePrenotaPiatto) session.getAttribute("ordine"+i);
			
      	int id_ordine= prenotazione.getId_ordine();
      	int id_piatto= prenotazione.getId_piatto();
      	int id_cliente= prenotazione.getId_cliente();
      	int quantita= prenotazione.getQuantita();
      	boolean stato_pagamento= prenotazione.getStato_pagamento();
      	String stato_completamento= prenotazione.getStato_completamento();

      	String list= "<tr>"+
      					"<td>"+id_ordine+"</td>"+
      					"<td>"+id_piatto+"</td>"+
      					"<td>"+id_cliente+"</td>"+
      					"<td>"+quantita+"</td>"+
      					"<td>"+stato_pagamento+"</td>"+
      					"<td>"+
      					"<input type='text' class='stato_comp' id='"+i+"' value='"+stato_completamento+"'"+
      					"</td>"+
      				"<tr>";
      
      	
//       	<select id="+i+">
//       		<option value="Ordinato" selected="selected">Ordinato</option>
//       		<option value="In Consegna">In Consegna</option>
//       		<option value="In Preparazione">In Preparazione</option>
//       	</select><br /><br />

		%>
   	      <script type="text/javascript">      	      
    	        $("#lista_ordini").append("<%=list%>");
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
   background-color: rgba(0,0,0,0.8);
   text-align: center;
   margin: auto;
   border: 2px solid white;
   padding: 30px;
}
.elementi_menu{
	width: 100%;
	text-align: left;
}
.elementi_menu tr:hover {
	background-color: rgba(160,160,160,0.48);
}

</style>

    <div id="menu">
    <h2>Lista Ordinazioni</h2>
 	<table class="elementi_menu"  id="lista_ordini">
 		<tr>	
 			<th>Id Ordine</th><th>Piatto</th><th>Cliente</th><th>Quantita</th><th>Stato Pagamento</th><th>Stato Completamento</th>
 		</tr>

 	</table>
    </div>