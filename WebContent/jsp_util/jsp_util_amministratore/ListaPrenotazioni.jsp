<%@page import="pkg.bean.Piatto"%>
<%@page import="pkg.bean.Ombrellone"%>
<%@page import="pkg.bean.Cliente"%>
<%@page import="pkg.bean.ClientePrenotaOmbrellone"%>
<%@page import="pkg.bean.ClientePrenotaPiatto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>

<%
	int numOrdini=50; // massimo numero di ordini 

	for(int i=0;i<numOrdini;i++){
		
		if(session.getAttribute("cliente"+i)!=null){
			Cliente cliente =(Cliente) session.getAttribute("cliente"+i);
		
	 	int id_cliente= i;
      	String nome= cliente.getNome();
      	String cognome= cliente.getCognome();
      	String telefono= cliente.getTelefono();
      	String email= cliente.getEmail();
      	
      	String list= "<tr class='cliente' id='"+id_cliente+"'>"+
      					"<td>"+id_cliente+"</td>"+
      					"<td>"+nome+"</td>"+
      					"<td>"+cognome+"</td>"+
      					"<td>"+telefono+"</td>"+
      					"<td>"+email+"</td>"+
      				"<tr>";
      
		%>
   	      <script type="text/javascript">      	      
    	        $("#lista_clienti").append("<%=list%>");
    	        
   	      </script>    
	    <%  
	    session.removeAttribute("cliente"+i);
		}
		if(session.getAttribute("OmbrPrenotazione"+i)!=null && session.getAttribute("Ombrellone"+i)!=null){
			ClientePrenotaOmbrellone prenozioneOmr =(ClientePrenotaOmbrellone) session.getAttribute("OmbrPrenotazione"+i);
			Ombrellone ombrellone= (Ombrellone) session.getAttribute("Ombrellone"+i);
			
		int id_prenotazione = prenozioneOmr.getId_prenotazione();
		int cliente= prenozioneOmr.getId_cliente();
		int ombr= prenozioneOmr.getId_ombrellone();
		String zona= ombrellone.getZona();
		int persone= prenozioneOmr.getNum_persone();
		int lettini= prenozioneOmr.getNum_lettini();//5€
		int sdraio= prenozioneOmr.getNum_sdraio();//3€
		float prezzoOmbrellone= ombrellone.getPrezzo();
		float prezzo = (lettini*5)+(sdraio*3)+prezzoOmbrellone;
		String pagato = String.valueOf( prenozioneOmr.getPagato());

		
		String pagato_false="";
		String pagato_true="";
		
		if(("true").equals(pagato)){
			pagato_true="selected";
		}
		if(("false").equals(pagato)){
			pagato_false="selected";
		}
      	
      	String list= "<tr class='prenotazione ombrellone_"+cliente+"'>"+
      					"<td>"+cliente+"</td>"+
      					"<td>"+ombr+"</td>"+
      					"<td>"+zona+"</td>"+
      					"<td>"+persone+"</td>"+
      					"<td>"+lettini+"</td>"+
      					"<td>"+sdraio+"</td>"+
      					"<td>"+prezzo+"€</td>"+
 	      					"<td>"+
 	      					"<select class='stato_ordine_ombr' id='"+id_prenotazione+"'>"+
 	     	       				"<option "+pagato_true+" value='true'>true</option>"+
 	     	      	       		"<option "+pagato_false+" value='false'>false</option>"+
 	      	     		  	"</select>"+
 	      					"</td>"+
      					"<td><button hidden class='elim_ord' id='elimina_pren_ombr"+id_prenotazione+"'>Elimina</button></td>"+
      				"<tr>";
      
		%>
   	      <script type="text/javascript">      	      
    	        $("#lista_ordini_ombrelloni").append("<%=list%>");
    	        
   	      </script>    
	    <%   
	    session.removeAttribute("OmbrPrenotazione"+i);
	    session.removeAttribute("Ombrellone"+i);
		}
		if(session.getAttribute("PiattoPrenotazione"+i)!=null && session.getAttribute("Piatto"+i)!=null){
			ClientePrenotaPiatto prenozionePiatto =(ClientePrenotaPiatto) session.getAttribute("PiattoPrenotazione"+i);
			Piatto piatto = (Piatto) session.getAttribute("Piatto"+i);
			
		int id_prenotazione= prenozionePiatto.getId_ordine();	
		int cliente= prenozionePiatto.getId_cliente();
		String nome_piatto= piatto.getNome();
		int quantita= prenozionePiatto.getQuantita();
		float prezzo= piatto.getPrezzo()*quantita;
		String stato_pagamento= String.valueOf(prenozionePiatto.getStato_pagamento());
		
		String pagato_false="";
		String pagato_true="";
		
		if(("true").equals(stato_pagamento)){
			pagato_true="selected";
		}
		if(("false").equals(stato_pagamento)){
			pagato_false="selected";
		}
      	
      	String list= "<tr class='prenotazione piatto_"+cliente+"'>"+
      					"<td>"+cliente+"</td>"+
      					"<td>"+nome_piatto+"</td>"+
      					"<td>"+quantita+"</td>"+
      					"<td>"+prezzo+"€"+"</td>"+
	      					"<td>"+
	      					"<select class='stato_ordine_piatto' id='"+id_prenotazione+"'>"+
	     	       				"<option "+pagato_true+" value='true'>true</option>"+
	     	      	       		"<option "+pagato_false+" value='false'>false</option>"+
	      	     		  	"</select>"+
	      					"</td>"+
	      					"<td><button hidden class='elim_ord' id='elimina_pren_piatto"+id_prenotazione+"'>Elimina</button></td>"+
      				"<tr>";
      	

		%>
   	      <script type="text/javascript">     
    	        $("#lista_ordini_piatti").append("<%=list%>");
   	      </script>    
	    <%   
	    session.removeAttribute("PiattoPrenotazione"+i);
	    session.removeAttribute("Piatto"+i);
		}
	}

%>

<script type="text/javascript">

$(document).ready(function() {
	alert("1. Clicca sul cliente per visualizzare i dati delle prenotazioni. \n2. Clicca sulla prenotazione pagata per eliminarla.");

	$(".prenotazione").hide();

	$(".cliente").click(function() {
		
		
		var id= $(this).attr("id");		
		var ombrellone= ".ombrellone_"+id;
		var piatto= ".piatto_"+id;

		
		$(".prenotazione").hide();
		$(ombrellone).show();
		$(piatto).show();		
	});
	
	$(".stato_ordine_ombr").change(function(){
		var stato_ordine=$(this).val();
		
		var id= $(this).attr("id");//ordineNUM
		var id_elimina="#elimina_pren_ombr"+id;
		
		if(stato_ordine=="true"){
			$(id_elimina).show();
		}else{
			$(id_elimina).hide();
		}
		
		var id_String= "modifica_ord_ombr"+id;
		
		//Aggiungere metodo che aggiorna l'ordine nel db
		$.post("../AmminServlet", { 
			operazione : "modifica_ordine",
			id: id_String,
			stato_ordine: stato_ordine
			
    		}, function(data, status) {
		         if (status == "success" )	
		        	
        		alert("Aggiornamento Stato Pagamento Ombrellone");
	        	//location.reload();
        	
            
		});
		
	});
	
	$(".stato_ordine_piatto").change(function(){
		var stato_ordine=$(this).val();
		
		var id= $(this).attr("id");//ordineNUM
		var id_elimina="#elimina_pren_piatto"+id;
		
		if(stato_ordine=="true"){
			$(id_elimina).show();
		}else{
			$(id_elimina).hide();
		}
		
		var id_String= "modifica_ord_piatto"+id;
		//Aggiungere metodo che aggiorna l'ordine nel db
		$.post("../AmminServlet", { 
			operazione : "modifica_ordine",
			id: id_String,
			stato_ordine: stato_ordine
			
    		}, function(data, status) {
		         if (status == "success" )	
		        	
        		alert("Aggiornamento Stato Pagamento Piatto");
	        	//location.reload();
        	
            
		});
		
	});


	$( ".elim_ord" ).click(function() {
		var result = window.confirm("Sei sicuro di voler eliminare l'ordine?");
		var id= $(this).attr("id");
		
		if(result===true){
			
			$.post("../AmminServlet", { 
				operazione : "elimina_ordine",
				id: id
				
	    		}, function(data, status) {
			         if (status == "success" )	
			        	
	        		alert("Stato Aggiornamento: "+data);
		        	location.reload();
	        	
                
			});
		}
	
	});

});

</script>

<style>
table {
  border: 2px solid white;
  margin: auto;
  text-align: cente;
}
th,td{
    padding: 8px;
    font-size: 15px;
}


#menu{
 	width: 70%;
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
.table{
	width: 100%;
	text-align: center;
	border-collapse: collapse;
	border: 2px solid black; 
}
.table th{
	background-color: black;
}
.table tr:hover {
	
 	background-color: rgba(160,160,160,0.48); 
}
.table td:hover {
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

</style>
	<br><br><br><br>
	
    <div id="menu">
    
    <img src="../immagini/logo.png" width="68px" height="60px" style="text-align: left;">
    <h2 id="title">Pagamenti Data Corrente</h2>
    <div><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i></div>
    <br>
    <table class="table"  id="lista_clienti">
 		<tr>	
 			<th>ID Cliente</th><th>Nome</th><th>Cognome</th><th>Telefono</th><th>Email</th>
 		</tr>
 	</table>
    
    	<hr>
   		 <hr>
 	<table class="table"  id="lista_ordini_ombrelloni">
 		<tr>	
 			<th>ID Cliente</th><th>Ombrellone</th><th>Zona</th><th>Numero Persone</th><th>Lettini 5€</th><th>Sdraio 3€</th><th>Prezzo</th><th>Stato Pagamento</th><th id="elmini_ordine_th"></th>
 		</tr>
 	</table>
    	<hr>
    <table class="table"  id="lista_ordini_piatti">
 		<tr>	
 			<th>ID Cliente</th><th>Piatto</th><th>Quantità</th><th>Prezzo</th><th>Stato Pagamento</th><th id="elmini_ordine_th"></th>
 		</tr>
 	</table>

    </div>