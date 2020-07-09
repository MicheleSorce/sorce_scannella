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
				
		if(session.getAttribute("prenotazione"+i)!=null && session.getAttribute("Ombrellone"+i)!=null){
			ClientePrenotaOmbrellone prenozioneOmr =(ClientePrenotaOmbrellone) session.getAttribute("prenotazione"+i);
			Ombrellone ombrellone= (Ombrellone) session.getAttribute("Ombrellone"+i);
			
		int id_prenotazione = prenozioneOmr.getId_prenotazione();
		int cliente= prenozioneOmr.getId_cliente();
		int slot= prenozioneOmr.getSlot_orario();
		String date= prenozioneOmr.getData_prenotazione();
		int ombr= prenozioneOmr.getId_ombrellone();
		String zona= ombrellone.getZona();
		int persone= prenozioneOmr.getNum_persone();
		int lettini= prenozioneOmr.getNum_lettini();//5€
		int sdraio= prenozioneOmr.getNum_sdraio();//3€
		float prezzoOmbrellone= ombrellone.getPrezzo();
		int prezzo = (lettini*5)+(sdraio*3);
		boolean pagato = prenozioneOmr.getPagato();
		
		String periodo="";
		if(slot==1){
			 periodo="Mattina";	
		}		
		if(slot==2){
			 periodo="Pomeriggio";	
		}
		
		String selPer1="";
		String selPer2="";
		String selPer3="";
		String selPer4="";
		String selPer5="";
		
      	if(persone==1){
     		 selPer1="selected";    		
		}
     	if(persone==2){
     		selPer2="selected";    		
		}
     	if(persone==3){
     		selPer3="selected";
  		}
     	if(persone==4){
     		selPer4="selected";    		
		}
     	if(persone==5){
     		selPer5="selected";
  		}
		
     	String selLet0="";
     	String selLet1="";
     	String selLet2="";
     	String selLet3="";
     	
     	if(lettini==0){
   		 selLet0="selected";    		
		}
      	if(lettini==1){
    		 selLet1="selected";    		
		}
    	if(lettini==2){
    		selLet2="selected";    		
		}
    	if(lettini==3){
    		selLet3="selected";
 		}
    	String selSdr0="";
     	String selSdr1="";
     	String selSdr2="";
     	String selSdr3="";
     	
     	if(sdraio==0){
      		selSdr0="selected";    		
		}
      	if(sdraio==1){
      		selSdr1="selected";    		
		}
    	if(sdraio==2){
    		selSdr2="selected";    		
		}
    	if(sdraio==3){
    		selSdr3="selected";
 		}
      	
      	String list= "<tr class='prenotazione' id='"+id_prenotazione+"'>"+
      					"<td>"+cliente+"</td>"+
      					"<td>"+ombr+"</td>"+
      					"<td class='data_ordine'>"+date+"</td>"+
      					"<td>"+periodo+"</td>"+
      					"<td>"+zona+"</td>"+
      					"<td>"+
      					"<select class='select_persone' disabled='disabled'>"+
     	       				"<option "+selPer1+" value='1'>1</option>"+
     	      	       		"<option "+selPer2+" value='2'>2</option>"+
      	       				"<option "+selPer3+" value='3'>3</option>"+
      	       				"<option "+selPer4+" value='4'>4</option>"+
          	       			"<option "+selPer5+" value='5'>5</option>"+
      	     		  	"</select>"+
      					"</td>"+
      					"<td>"+
      					"<select class='select_lettini' disabled='disabled'>"+
      						"<option "+selLet0+" value='0'>0</option>"+
     	       				"<option "+selLet1+" value='1'>1</option>"+
     	      	       		"<option "+selLet2+" value='2'>2</option>"+
      	       				"<option "+selLet3+" value='3'>3</option>"+
      	     		  	"</select>"+
      					"</td>"+
      					"<td>"+
      					"<select class='select_sdraio' disabled='disabled'>"+
      						"<option "+selSdr0+" value='0'>0</option>"+
     	       				"<option "+selSdr1+" value='1'>1</option>"+
     	      	       		"<option "+selSdr2+" value='2'>2</option>"+
      	       				"<option "+selSdr3+" value='3'>3</option>"+
      	     		  	"</select>"+
      					"</td>"+
      					"<td>"+prezzo+"€ +"+prezzoOmbrellone+"€</td>"+
      					"<td class='stato_ordine stato_ombrellone_"+cliente+"'>"+pagato+"</td>"+
      					"<td><button hidden class='mod_ord' id='mod_pren_ombr"+id_prenotazione+"'>Modifica</button></td>"+
      					"<td><button hidden class='elim_ord' id='elimina_pren_ombr"+id_prenotazione+"'>Elimina</button></td>"+
      				"<tr>";
      
		%>
   	      <script type="text/javascript">      	      
    	        $("#lista_ordini_ombrelloni").append("<%=list%>");
    	        
   	      </script>    
	    <%   
	    session.removeAttribute("prenotazione"+i);
	    session.removeAttribute("Ombrellone"+i);
		}
		
	}

%>

<script type="text/javascript">


$(document).ready(function() {
	
	var dtToday = new Date();
	
	var id;
	var persone;
	var lettini;
	var sdraio;

	$(".prenotazione").click(function() {
		
		id= $(this).attr('id');
		var data_prenotazione_String = $(this).find(".data_ordine").html();
		
		var myDate= new Date(data_prenotazione_String);
		
		
		if(dtToday< myDate){
			
			$(this).find("select").removeAttr('disabled');
			$(this).find(".mod_ord").show();
			$(this).find(".elim_ord").show();
						
			persone = $(this).find(".select_persone").val();
			lettini = $(this).find(".select_lettini").val();
			sdraio = $(this).find(".select_sdraio").val();					
		}
		if(dtToday >= myDate){
			alert("Non è possibile modificare tale prenotazione in quanto coincide o precede la data corrente.");
		}	
			
		
	
	});

	$( ".mod_ord" ).click(function() {

		$.post("../ClienteServlet", { 
			
			operazione : "modifica_ordine_ombr",
			id: id,
			lettini: lettini,
			persone: persone,
			sdraio: sdraio
    		}, function(data, status) {
		         if (status == "success" )
		        	 
		        	 if(data.result=="true"){
		        		 alert("Ordine Aggiornato");
		        	 }
			         if(data.result=="false"){
		        		 alert("Errore aggiornamento ordine");
		        	 }
		});
	
	
	});

	$( ".elim_ord" ).click(function() {
		var result = window.confirm("Sei sicuro di voler eliminare l'ordine?");
		
		if(result===true){
			
			$.post("../ClienteServlet", { 
				operazione : "elimina_ordine_ombr",
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

    
select option { /* -----------------------NON FUNZIONA-------------------*/
    width: 80%;
    background-color: darkgray;
}


</style>
	<br><br><br><br>
	
    <div id="menu">
    
    <img src="../immagini/logo.png" width="68px" height="60px" style="text-align: left;">
    <h2 id="title" style="color: #1b7af7">Prenotazioni Ombrelloni di ${cliente.nome} ${cliente.cognome}</h2>
    <h4>Clicca sull'ombrellone per modificare/eliminare la prenotazione.</h4>
    <h4><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>Ricorda puoi modificare/eliminare solo le prenotazioni successive alla data odierna </h4>
    <div><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i></div>
    <br>

 	<table class="table"  id="lista_ordini_ombrelloni">
 		<tr>	
 			<th>ID Cliente</th><th>Ombrellone</th><th>Data</th><th>Slot Orario</th><th>Zona</th><th>Numero Persone</th><th>Lettini 5€</th><th>Sdraio 3€</th><th>Prezzo</th><th>Stato Pagamento</th><th id="modifica_ordine_th"><th id="elmini_ordine_th"></th>
 		</tr>
 	</table>

    </div>