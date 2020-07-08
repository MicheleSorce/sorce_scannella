<%@page import="pkg.bean.ClientePrenotaPiatto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>

<%
	int numOrdini=50; // massimo numero di ordini 

	for(int i=1;i<=numOrdini;i++){
		
		if(session.getAttribute("ordine"+i)!=null){
			ClientePrenotaPiatto prenotazione =(ClientePrenotaPiatto) session.getAttribute("ordine"+i);
			
      	int id_ordine= prenotazione.getId_ordine();
      	int id_piatto= prenotazione.getId_piatto();
      	int id_cliente= prenotazione.getId_cliente();
      	int quantita= prenotazione.getQuantita();
      	boolean stato_pagamento= prenotazione.getStato_pagamento();
      	String stato_completamento= prenotazione.getStato_completamento();
      
      	String id_ordine_tr="ordine"+id_ordine;
      	
      	String selOrd="";
      	String selPrep="";
      	String selCons="";
      	
      	if(("Ordinato").equals(stato_completamento)){
      		 selOrd="selected";    		
		}
      	if(("In Preparazione").equals(stato_completamento)){
      		selPrep="selected";    		
		}
      	if(("In Consegna").equals(stato_completamento)){
      		selCons="selected";
   		}
      	String list= "<tr>"+
      					"<td>"+id_ordine+"</td>"+
      					"<td id='piatto_"+id_ordine_tr+"'>"+id_piatto+"</td>"+
      					"<td>"+id_cliente+"</td>"+
      					"<td id='quantita_"+id_ordine_tr+"'>"+quantita+"</td>"+
      					"<td id='pagamento_"+id_ordine_tr+"'>"+stato_pagamento+"</td>"+
      					"<td>"+
      					"<select class='select_ord' id='"+id_ordine_tr+"'>"+
     	       				"<option "+selOrd+" value='Ordinato'>Ordinato</option>"+
     	      	       		"<option "+selPrep+" value='In Preparazione'>In Preparazione</option>"+
      	       				"<option "+selCons+" value='In Consegna'>In Consegna</option>"+
      	     		  	"</select>"+
      					"</td>"+
      					"<td><button hidden class='elim_ord' id='elimina_ordine"+id_ordine+"'>Elimina</button></td>"+
      				"<tr>";
      
		%>
   	      <script type="text/javascript">      	      
    	        $("#lista_ordini").append("<%=list%>");
    	        
   	      </script>    
	    <%   
		}
	}

%>

<script type="text/javascript">

$(document).ready(function() {
	
	$(".select_ord").change(function(){
		var id= $(this).attr("id");//ordineNUM
		
		var serch= "#"+id+" option:selected";
		var serch2= "#pagamento_"+id;
		
		var stato_ordine= $( serch ).text();
		var statoPagamento=  $(serch2).html();
		var serch_button="#elimina_"+id;
		var id_quantita= "#quantita_"+id;
		var id_piatto= "#piatto_"+id;
		
		$.post("../BarServlet", { 
			operazione : "modifica_stato_ordine",
			id: id,
			stato: stato_ordine
			

    		}, function(data, status) {
		         if (status == "success" )	{
		        	 if(data.result=="true"){
		        		 window.alert("Stato ordine aggiornato correttamente!");
		        	 } if(data.result=="false"){
		        		 window.alert("Errore aggiornato stato ordine!");
		        	 }
		        	 
		         }                   
		});
		
		if(stato_ordine=="In Consegna"){
			
			var result = confirm("La quantità del piatto verrà aggiornata nella dispensa");
			
			if(result == "true"){
				alert("ok");
				var quantita_usata=$(id_quantita).html();
				var id= $(id_piatto).html();
				
				$.post("../BarServlet", { 
					operazione : "modifica_quantia_piatto",
					id: id,
					quantita_usata: quantita_usata
		    		} , function(data, status) {
				         if (status == "success" )	{
				        	 if(data.result=="true"){
				        	 } if(data.result=="false"){
				        	 }
				         }                   
				});
				

			}
			if(statoPagamento == "true" ){
				$(serch_button).show();
			}

		}
		
		if(stato_ordine!="In Consegna"){
			$(serch_button).hide();
		}
		
	});
	
	$( ".elim_ord" ).click(function() {
		var result = window.confirm("Sei sicuro di voler eliminare l'ordine?");
		var id= $(this).attr("id");
		
		if(result==true){
			
			$.post("../BarServlet", { 
				operazione : "elimina_ordine",
				id: id
				
	    		}, function(data, status) {
			         if (status == "success" )	{
			        	 
			        	 if(data.result=="true"){
			        	 	alert("Ordine eliminato");
			        	 window.location.reload();
			        	 }if(data.result=="false"){
			        		 window.alert("Errore aggiornato stato ordine!");
			        	 }
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
 padding: 15px;
 font-size: 18px;
}

#menu{
 	width: 60%;
    color: white;
    background-color: rgba(0,0,0,0.8);
    text-align: center;
    margin: auto;
    border: 2px solid white;
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
.elementi_menu{
	width: 100%;
	text-align: center;
	border-collapse: collapse;
	border: 2px solid black; 
}
.elementi_menu tr:hover {
	
 	background-color: rgba(160,160,160,0.48); 
}
.elementi_menu td:hover {
	background-color: black;
}
.elim_ord{
	background-color: rgba(160,160,160,0.48);
    color: white;
    border: 1px solid red; 
    font-size: 15px;
    font-family: none;
    margin: 2px;
    border-radius: 5px;
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
</style>
	
    <div id="menu">
    <img src="../immagini/logo.png" width="68px" height="60px" style="text-align: left;">
    <h2 id="title">Lista Ordinazioni</h2>
    <div><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i></div>
    	<hr>
   		 <hr>
 	<table class="elementi_menu"  id="lista_ordini">
 		<tr>	
 			<th>Id Ordine</th><th>Piatto</th><th>Cliente</th><th>Quantità</th><th>Stato Pagamento</th><th>Stato Completamento</th><th id="elmini_ordine_th"></th>
 		</tr>
 	</table>

    		<hr>
    </div>