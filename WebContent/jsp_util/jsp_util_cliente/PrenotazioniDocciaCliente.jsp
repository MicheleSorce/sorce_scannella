<%@page import="pkg.bean.Doccia"%>
<%@page import="pkg.bean.ClientePrenotaDoccia"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>

<%
	int numOrdini=50; // massimo numero di ordini 

	for(int i=0;i<numOrdini;i++){
				
		if(session.getAttribute("prenotazione"+i)!=null && session.getAttribute("doccia"+i)!=null){
			ClientePrenotaDoccia prenotazione =(ClientePrenotaDoccia) session.getAttribute("prenotazione"+i);
			Doccia doccia = (Doccia) session.getAttribute("doccia"+i);
			
			int id_prenotazione = prenotazione.getId_prenota_doccia();
			int id_doccia= prenotazione.getId_doccia();
			int slot = prenotazione.getSlot_orario();
			String data_prenotazione = prenotazione.getData_prenotazione();
			Boolean accesso_disabili = doccia.getAccesso_disabili();
			
			String slot_orario="";
			
			if(slot==1){
				slot_orario="9:00-9:40";
			}if(slot==2){
				slot_orario="10:00-10:40";
			}if(slot==3){
				slot_orario="11:00-11:40";
			}if(slot==4){
				slot_orario="12:00-12:40";
			}if(slot==5){
				slot_orario="15:00-15:40";
			}if(slot==6){
				slot_orario="16:00-16:40";
			}if(slot==7){
				slot_orario="17:00-17:40";
			}if(slot==8){
				slot_orario="18:00-18:40";
			}if(slot==9){
				slot_orario="19:00-19:40";
			}if(slot==10){
				slot_orario="20:00-20:40";
			}
			
      	
    	String list= "<tr class='prenotazione'  id='"+id_prenotazione+"'>"+
    			"<td>"+id_doccia+"</td>"+
    			"<td>"+slot_orario+"</td>"+
    			"<td>"+data_prenotazione+"</td>"+
    			"<td>"+accesso_disabili+"</td>"+
    			"<td><button hidden class='elim_ord' id='elimina_pren_piatto"+id_prenotazione+"'>Elimina</button></td>"+
    		"<tr>";
      
		%>
   	      <script type="text/javascript">     
    	        $("#lista_ordini_piatti").append("<%=list%>");
   	      </script>       
	    <%   
	    session.removeAttribute("prenotazione"+i);
	    session.removeAttribute("doccia"+i);
		}
		
	}

%>

<script type="text/javascript">


$(document).ready(function() {
	
	var id_prenotazione;
	
	$(".prenotazione").click(function() {
		
		id_prenotazione= $(this).attr('id');	
		$(this).find(".elim_ord").show();	

	});



	$( ".elim_ord" ).click(function() {
		var result = window.confirm("Sei sicuro di voler eliminare la prenotazione?");
		
		if(result===true){
			
			$.post("../ClienteServlet", { 
				operazione : "elimina_prenotazione_doccia",
				id: id_prenotazione				
	    		}, function(data, status) {
			         if (status == "success" )	
			        	
		        	 if(data.result=="true"){
		        		 alert("Prenotazione Eliminata");
		        		 location.reload();
		        	 }
			         if(data.result=="false"){
		        		 alert("Errore aggiornamento prenotazione");
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
    <h2 id="title" style="color: #1b7af7">Prenotazioni Docce ${cliente.nome} ${cliente.cognome}</h2>
     <h4>Clicca sulla doccia per eliminare la prenotazione.</h4>
    <div><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i></div>
    <br>

    <table class="table"  id="lista_ordini_piatti">
 		<tr>	
 			<th>ID Doccia</th><th>Slot Orario</th><th>Data Prenotazione</th><th>Accesso Disabili</th><th id="elmini_ordine_th"></th>
 		</tr>
 	</table>

    </div>