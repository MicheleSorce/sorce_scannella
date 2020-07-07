<%@page import="pkg.bean.Piatto"%>
<%@page import="pkg.bean.ClientePrenotaPiatto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>

<%
	int numOrdini=50; // massimo numero di ordini 

	for(int i=0;i<numOrdini;i++){
				
		if(session.getAttribute("ordine"+i)!=null && session.getAttribute("piatto"+i)!=null){
			ClientePrenotaPiatto ordine =(ClientePrenotaPiatto) session.getAttribute("ordine"+i);
			Piatto piatto = (Piatto) session.getAttribute("piatto"+i);
			
			
			int id_prenotazione= ordine.getId_ordine();	
			int piattoID= ordine.getId_piatto();
			String nome_piatto= piatto.getNome();
			int quantita= ordine.getQuantita();
			float prezzo= piatto.getPrezzo()*quantita;
			String statoOrdine= ordine.getStato_completamento();
			boolean stato_pagamento= ordine.getStato_pagamento();
			
			int disponibilita_piatto= piatto.getDisponibilita();
			
      	
    	String list= "<tr class='prenotazione'  id='"+id_prenotazione+"'>"+
    			"<td class='id_piatto'>"+piattoID+"</td>"+
    			"<td>"+nome_piatto+"</td>"+
    			"<td>"+
    			"<input type='number'min='0' max='20' disabled='disabled' class='quantita' value='"+quantita+"'>"+
    			"</td>"+
    			"<td>"+prezzo+"€"+"</td>"+
    			"<td id='disponibilita_piatto'>"+disponibilita_piatto+"</td>"+
    			"<td class='stato_ordine'>"+statoOrdine+"</td>"+
    			"<td class='stato_pagamento'>"+stato_pagamento+"</td>"+
    			"<td><button hidden class='mod_ord' id='mod_pren_ombr"+id_prenotazione+"'>Modifica</button></td>"+
    			"<td><button hidden class='elim_ord' id='elimina_pren_piatto"+id_prenotazione+"'>Elimina</button></td>"+
    		"<tr>";
      
		%>
   	      <script type="text/javascript">     
    	        $("#lista_ordini_piatti").append("<%=list%>");
   	      </script>       
	    <%   
	    session.removeAttribute("piatto"+i);
	    session.removeAttribute("ordine"+i);
		}
		
	}

%>

<script type="text/javascript">


$(document).ready(function() {
	
	var id;
	var id_piatto;
	var quantita;
	var disponibilita;

	
	$(".prenotazione").click(function() {
		
		id= $(this).attr('id');
		
		var stato_prenotazione = $(this).find(".stato_ordine").html();
		disponibilita = $(this).find("#disponibilita_piatto").html();
		
		if(stato_prenotazione=="Ordinato"){
			
			$(this).find("input").removeAttr('disabled');
			$(this).find(".mod_ord").show();
			$(this).find(".elim_ord").show();
			

			quantita = $(this).find(".quantita").val();
			id_piatto = $(this).find(".id_piatto").html();
			
		}
		
			
			
		
	
	});

	$( ".mod_ord" ).click(function() {
		
		var diponibilita_new=disponibilita-quantita;
		
		
		if(diponibilita_new<0){
			alert("La quantità scelta non è disponibile in dispenza \nScegline una minore. ");
		}
		if(diponibilita_new>=0){
			
			$.post("../ClienteServlet", { 
				
				operazione : "modifica_ordine_bar",
				id: id,
				quantita: quantita
	    		}, function(data, status) {
			         if (status == "success" )
			        	 
			        	 if(data.result=="true"){
			        		 alert("Ordine Aggiornato");
			        	 }
				         if(data.result=="false"){
			        		 alert("Errore aggiornamento ordine");
			        	 }
			});
			
		}


	
	
	});

	$( ".elim_ord" ).click(function() {
		var result = window.confirm("Sei sicuro di voler eliminare l'ordine?");
		
		if(result===true){
			
			$.post("../ClienteServlet", { 
				operazione : "elimina_ordine_bar",
				id: id				
	    		}, function(data, status) {
			         if (status == "success" )	
			        	
			        	 if(data.result=="true"){
			        		 alert("Ordine Eliminato");
			        		 location.reload();
			        	 }
				         if(data.result=="false"){
			        		 alert("Errore aggiornamento ordine");
			        	 }              
			});
		}
	
	});

});

</script>

<style>

table {
  border: 2px solid white;
  margin: auto;
  text-align: center;
}
th,td{
    padding: 8px;
    font-size: 15px;
}

#menu{
 	width: 70%;
    color: white;
    background-image: linear-gradient(to bottom , #FFFFFF 0%, #4293ff 100%);
    text-align: center;
    margin: auto;
    border: 2px solid #4293ff;
    border-radius: 6px 6px 6px 6px;
    padding: 20px;
    margin-top: 2px;
}

.elementi_menu th{
	font-weight: bold;
	background-color: black;
    font-style: oblique;
	font-size: 20px;
	text-align: center;
}
.table{
	width: 100%;
	text-align: center;
	border-collapse: collapse;
	border: 2px solid white; 
}
.table th{
	background-color: #4293ff;
}
.table tr:hover {
	
 	background-color: #4393ff; 
}

.elim_ord{
	background-color: rgba(160,160,160,0.48);
    color: white;
    border: 1px solid red; 
    font-size: 15px;
    font-family: none;
    margin: 2px;
    border-radius: 5px;
    width: auto;
}
.elim_ord:hover {
	background-color: red;
	color: white;
	border: 2px solid white; 
}
#title{
	border: 1px solid white;
    width: inherit;
    margin: auto;
    padding-bottom: px;
    padding: 8px;
    margin-bottom: 12px;
    font-size: x-large;
}
.mod_ord{

	background-color: rgba(160,160,160,0.48);
    color: white;
    border: 1px solid blue; 
    font-size: 15px;
    font-family: none;
    margin: 2px;
    border-radius: 5px;
    width: auto;
}
.mod_ord:hover {
	background-color: blue;
	color: white;
	border: 2px solid white; 
}

    
select option {
    width: 80%;
    background-color: darkgray;
}


</style>
	<br><br><br><br>
	
    <div id="menu">
    
    <img src="../immagini/logo.png" width="68px" height="60px" style="text-align: left;">
    <h2 id="title" style="color: #1b7af7">Prenotazioni Bar di ${cliente.nome} ${cliente.cognome}</h2>
     <h4>Clicca sul piatto di cui vuoi modificare/eliminare la prenotazione.</h4>
    <h4><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>Ricorda puoi eliminare/modificare solo le prenotazioni in stato ordine "Ordinato" </h4>
    
    <div><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i></div>
    <br>

    <table class="table"  id="lista_ordini_piatti">
 		<tr>	
 			<th>ID Piatto</th><th>Piatto</th><th>Quantità</th><th>Prezzo</th><th>Disponibilità dispensa</th><th>Stato Ordine</th><th>Stato Pagamento</th><th id="modifica_ordine_th"></th><th id="elmini_ordine_th"></th>
 		</tr>
 	</table>

    </div>