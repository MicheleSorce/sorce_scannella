<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Home Cliente</title>
<link Rel="icon" type="image/ico" href="../immagini/logo.png"> <!-- per il logo in alto -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Sofia"><!-- per la scrittua in alto -->

<link href="../css/ClienteCSS.css" type="text/css" rel="stylesheet">
<link href="../css/InsertDataWindow.css" type="text/css" rel="stylesheet">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"><!-- Per il navbar -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>
</head>




<script>


function clickdropbtn1() {
  document.getElementById("myDropdown1").classList.toggle("show");

}
function clickdropbtn2() {
	  document.getElementById("myDropdown2").classList.toggle("show");

	  
	}
function clickdropbtn3() {
	  document.getElementById("myDropdown3").classList.toggle("show");
	  
	}

// Chiude il menù a tendina se l'utente clicca fuori 
window.onclick = function(event) {
  if (!event.target.matches(".dropbtn")) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains("show")) {
        openDropdown.classList.remove("show");
      }
    }
  } 
}

$(function(){
    var dtToday = new Date();
    
    var day = dtToday.getDate();
    var month = dtToday.getMonth() + 1;
    var year = dtToday.getFullYear();

    if(month < 10)
        month = '0' + month.toString();
    if(day < 10)
        day = '0' + day.toString();

    var minDate = year + '-' + month + '-' + day;    
    $('#data_scelta0').attr('min', minDate);
    $('#data_scelta0').attr('value', minDate);
    $('#data_scelta2').attr('min', minDate);
    $('#data_scelta2').attr('value', minDate);
});



$(document).ready(function() {
 
//sotto-opzione1->prenota ombrellone
    $("#prenota_ombr").click(function() {   
    	
    	$("#id_dati_scelta_doccia").hide();
   		$("#id_data_scelta").css("display","block");    
    });
    
    $("#conferma_data").click(function() {
    	$.post("../ClienteServlet", { 
    		operazione : "visualizza_spiaggia_prenot",
    		data_scelta : $("#data_scelta0").val(),
    		slot_orario: $("#slot_orario0").val()
    		
    		}, function(data, status) {
         if (status == "success")
          
         $('#riuso').load("../jsp_util/jsp_util_cliente/MappaPrenotazioneOmbrCliente.jsp");
     	 $("#id_data_scelta").hide();
	
         });
    });
    
 //sotto-opzione2->Modifica/Elimina prenotazione    
 
 $("#modifica_ombr").click(function() {
    	   	
    	$.post("../ClienteServlet", { 
    		
    		operazione : "lista_prenotazioni",
    		id_cliente : "${cliente.idCliente}"
    		
    		}, function(data, status) {
		         if (status == "success")
		        	 
		          	if(data.result=="Nessuna Prenotazione"){
		          		alert("Non sono ancora state effettuate prenotazioni");
		          	}	          	
		          	if(data.result=="true"){
		                $('#riuso').load("../jsp_util/jsp_util_cliente/PrenotazioniOmbrCliente.jsp");
		                
		          	}
				
		         });
    });
	
//sotto-opzione3-> prenota doccia
	$("#prenota_docc").click(function() {   
			$("#id_data_scelta").hide();
			$("#id_dati_scelta_doccia").css("display","block");    
	});
	
	$("#conferma_data2").click(function() {
		$.post("../ClienteServlet", { 
			operazione : "visualizza_docce",
			data_scelta2 : $("#data_scelta2").val(),
		  	slot_orario2: $("#slot_orario2").val()
		  	
			}, function(data, status) {
		     if (status == "success")
		      
			     $('#riuso').load("../jsp_util/jsp_util_cliente/MappaPrenotDocceCliente.jsp");
			 	 $("#id_dati_scelta_doccia").hide();
		
		     });
	});

	//sotto-opzione4-> modifica/elimina doccia
	
	$("#elimina_pren_doccia").click(function() {
	   	
    	$.post("../ClienteServlet", { 
    		
    		operazione : "lista_prenotazioni_doccia",
    		id_cliente : "${cliente.idCliente}"
    		
    		}, function(data, status) {
		         if (status == "success")
		        	 
		          	if(data.result=="Nessuna Prenotazione"){
		          		alert("Non sono ancora stati effettuate prenotazioni alle doccie");
		          	}	          	
		          	if(data.result=="true"){
		                $('#riuso').load("../jsp_util/jsp_util_cliente/PrenotazioniDocciaCliente.jsp");
		                
		          	}
				
		         });
    });
	
	
	
	
	//sotto-opzione5->prenotazione bar
	$("#prenota_bar").click(function() {
		$("#id_dati_scelta_doccia").hide();
		$("#id_data_scelta").hide();
			
		$.post("../ClienteServlet", { 
			operazione : "visualizza_menu",
			
			}, function(data, status) {
		     if (status == "success")
		      
			     $('#riuso').load("../jsp_util/jsp_util_cliente/MenuPrenotazioneCliente.jsp");
			 	
		
		     });
	});
	
	//sotto-opzione6->Modifica prenotazione bar
$("#modifica_bar").click(function() {
	   	
    	$.post("../ClienteServlet", { 
    		
    		operazione : "lista_prenotazioni_bar",
    		id_cliente : "${cliente.idCliente}"
    		
    		}, function(data, status) {
		         if (status == "success")
		        	 
		          	if(data.result=="Nessuna Prenotazione"){
		          		alert("Non sono ancora stati effettuati ordini al bar");
		          	}	          	
		          	if(data.result=="true"){
		                $('#riuso').load("../jsp_util/jsp_util_cliente/PrenotazioniBarCliente.jsp");
		                
		          	}
				
		         });
    });



});




</script>





<body class=”it” >




	<div class="navbar" >
		  <a class="active" href="#"><i class="fa fa-fw fa-home"></i> Home</a> 
		 
		  <a href="#finale" ><i class="fa fa-fw fa-envelope"></i> Contatti</a> 
		  <a id="id_logout" href="../LogoutServlet" ><i class="fa fa-fw fa-user"></i> Logout</a> 
		  <a href="https://www.google.com/maps/dir/37.2669805,13.5784017/Realmonte+-+Baia+delle+Sirene-Giallonardo,+92010+Realmonte+AG/@37.3003778,13.4278911,12z/data=!3m1!4b1!4m9!4m8!1m1!4e1!1m5!1m1!1s0x131a7b97e08653c7:0x264a8eab65c24eb!2m2!1d13.4173862!2d37.3150145"><i class="fa fa-car"></i> Come arrivare</a>
		
		
		  <div style="float:right">
		  	  <a href="https://www.whatsapp.com/" ><i class="fa fa-whatsapp" aria-hidden="true"></i></a> 
		  	  <a href="https://web.telegram.org/#/login"><i class="fa fa-telegram" aria-hidden="true"></i></a>
			  <a href="https://www.instagram.com/accounts/login/?hl=it"  ><i class="fa fa-instagram" aria-hidden="true"></i></a>
			  <a href="https://it-it.facebook.com/login/"  >  <i class="fa fa-facebook"></i></a> 
			  <a href="https://twitter.com/login?lang=it" ><i class="fa fa-twitter"></i></a> 
			  <a href="https://www.youtube.com/"><i class="fa fa-youtube"></i></a> 
		  </div>
	</div>
	
	

	

<div class="dropdown">
  <button onclick="clickdropbtn1()" class="dropbtn" style=" background-color: #1a70f0; width: 110px;top: 26px;">
  	Ombrellone
  </button>
  
  <div id="myDropdown1" class="dropdown-content" style="top:49%; margin-left:97px">
	  <div >
	  	<a id="prenota_ombr">Prenota Ombrellone</a> 
	    <a id="modifica_ombr">Modifica/Elimina Prenotazione</a>
	   </div>
  </div>
  
  <br/><br/>
  
   <button onclick="clickdropbtn2()" class="dropbtn" style=" background-color:#1a70f0 ; width: 110px;top: 180px;">
   	Doccia
   </button>
   
  <div id="myDropdown2" class="dropdown-content" style="top:265%; margin-left:80px">
    <a id="prenota_docc">Prenota Doccia</a>
    <a id="elimina_pren_doccia">Modifica/Elimina Prenotazione</a>
  </div>
  
    <br/><br/>
    
   <button onclick="clickdropbtn3()" class="dropbtn" style=" background-color: #1a70f0; width: 80px;top: 320px;">
   	Bar
   </button>
   
  <div id="myDropdown3" class="dropdown-content" style="top:465%; margin-left:60px">
    <a id="prenota_bar">Prenota Piatto/Bevanda</a>
    <a id="modifica_bar">Modifica/Elimina Prenotazione</a>
  </div>
  
</div>

<br />


<div id="riuso" >
	<div class="bg_top"> 
	<div  style="text-align: left; padding:2%;" >
		
		<div class="descrizione txt_hover">
		<h2 style="font-family:Sofia; font-size: 70px;text-align: center;" >Benvenuto ${cliente.nome} ${cliente.cognome}</h2>
		<p style="font-variant: small-caps; font-size:25px; text-align: center;"> sulla tua HomePage!</p> 
	</div>
	</div>
	</div>
	
	<div style="text-align:center">
	<hr width="300px"/><div><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i></div> <br/>
	<em>Relax, mare, natura, cultura e divertimento in un’unica, completa, soluzione.</em> 
	<br /> <br />
	<i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>
	<hr width="300px"/>
</div>	
<br />
</div>



<div id="id_data_scelta" class="modal" style="text-align: center;">
	<div class="modal-content">
		<div class="container" >
	     	<h2>Inserisci data di prenotazione</h2> 
	    	<hr> 
	         <b>Giorno: </b> 
			<input id="data_scelta0" type="date" name="data_scelta" min="2020-05-29" value="" required="required"> <br><br>
			<b>Periodo: </b> 
			<select id="slot_orario0" name="slot">
				<option value="1"> Mattina </option>
				<option value="2"> Pomeriggio </option>
			</select>
			 <br><br> 
	      	<div class="clearfix"> 
	       		 <button id="conferma_data">Conferma</button> 
	     	</div> 
	   </div>
	</div>
</div>


<div id="id_dati_scelta_doccia" class="modal" style="text-align: center;">
	<div class="modal-content">
		<div class="container" >
	     	<h2>Dati Docce</h2> 
	    	<hr> 
	    	<div>Inserisci i dati del giorno del quale vuoi vedere lo stato delle docce</div>
	         <br><br>
	         <b>Giorno: </b> 
			<input id="data_scelta2" type="date" name="data_scelta" min="2020-05-29" value="" required="required"> <br><br>
			<b>Turno: </b> 
			<select id="slot_orario2" >
				<option value="1"> 9:00-9:40 </option>
				<option value="2"> 10:00-10:40 </option>
				<option value="3"> 11:00-11:40 </option>
				<option value="4"> 12:00-12:40 </option>
				<option value="5"> 15:00-15:40 </option>
				<option value="6"> 16:00-16:40 </option>
				<option value="7"> 17:00-17:40 </option>
				<option value="8"> 18:00-18:40 </option>
				<option value="9"> 19:00-19:40 </option>
				<option value="10"> 20:00-20:40 </option>
			</select>
			 <br><br><br> 
	      	<div class="clearfix"> 
	       		 <button id="conferma_data2">Conferma</button> 
	     	</div> 
	   </div>
	</div>
</div>



<br />



<br /><br />

<div  id="mappa_div" style="margin-left: 0%;">
	
</div>





<div id="finale" class="footer-bottom" style="font-variant: small-caps; ">

    <h2  > Contatti</h2>
    <hr color="#a7f0ff"/>
      
	<div class="posizionamento_riga_dx">
	      <h4>Informazioni sull'azienda</h4>                 
	      <strong>Beach S.R.L.</strong><br />
	      <i class="fa fa-map-marker"></i> Piazza Umberto I, 28 <br />
	      93014 Mussomeli (CL)
	</div>
	<div class="posizionamento_riga_centrale">
	      <h4>Informazioni sui contatti</h4>                 
	      <strong>Dott. Scannella  &amp; Dott. Sorce</strong><br />
	      
	      <i class="fa fa-phone"></i> +339 4927388 <br />
	      <i class="fa fa-envelope" ></i> <a href="mailto:mariaeleonorascannella@gmail.com">mariaeleonorascannella@gmail.com</a> <br />
	      <i class="fa fa-envelope"></i> <a href="mailto:michele.sorce98@virgilio.it">michele.sorce98@virgilio.it</a> <br />
	</div>   
	
	 <div class="posizionamento_riga_sx">
	      <h4>Orario Business</h4>             
	      <i class="fa fa-clock-o"></i> Lun-Ven: <span>09:00-13:00 14:00-18:00 </span> <br />
	      <i class="fa fa-clock-o"></i> Sab: 09:00-13:00 <br />
	      <i class="fa fa-clock-o"></i> Dom: Chiuso <br />


	  <img src="../immagini/logo.png" width="68px" height="60px" style="padding-left:40%">
	  <div style="color: black; text-align: center;">Copyright &copy; 2020. All Rights Reserved.</div>

	 </div>	
</div>
</body>
</html>

