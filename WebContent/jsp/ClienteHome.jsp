<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>HomeCliente</title>
<link Rel="icon" type="image/ico" href="../immagini/logo.png"> <!-- per il logo in alto -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Sofia"><!-- per la scrittua in alto -->
<link href="../css/ClienteCSS.css" type="text/css" rel="stylesheet">
<link href="../css/InsertDataWindow.css" type="text/css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"><!-- Per il navbar -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>
</head>
<script>

//imposta il giorno corrente
$(function(){
    var dtToday = new Date();

    var month = dtToday.getMonth() + 1;
    var day = dtToday.getDate();
    var year = dtToday.getFullYear();

    if(month < 10)
        month = '0' + month.toString();
    if(day < 10)
        day = '0' + day.toString();

    var maxDate = year + '-' + month + '-' + day;    
    $('#data_first').attr('min', maxDate);
});

$(document).ready(function() {
	$("#opzione1").click(function() {
		$.post("../MappaSpiaggiaServlet", {
			name : "nome",
			balance :"cognome"
		}, function(data) {
			
				$("#result").text(data.result);
	
	});
});
	
	


function myFunction() {
  document.getElementById("myDropdown").classList.toggle("show");
  
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(event) {
	
}
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
</script>







<body class=”it” >



<div class="bg_top"> 
	<div class="navbar" >
		  <a class="active" href="#"><i class="fa fa-fw fa-home"></i> Home</a> 
		 
		  <a href="#finale" ><i class="fa fa-fw fa-envelope"></i> Contatti</a> 
		  <a id="id_logout" href="../LogoutServlet" ><i class="fa fa-fw fa-user"></i> Logout</a> 
		  <a href="https://www.google.com/maps/dir/37.2669805,13.5784017/Realmonte+-+Baia+delle+Sirene-Giallonardo,+92010+Realmonte+AG/@37.3003778,13.4278911,12z/data=!3m1!4b1!4m9!4m8!1m1!4e1!1m5!1m1!1s0x131a7b97e08653c7:0x264a8eab65c24eb!2m2!1d13.4173862!2d37.3150145"><i class="fa fa-car"></i> Come arrivare</a>
		  <div class="dropdown">
		  <a onclick="myFunction()" class="dropbtn "> <i class="fa fa-language" aria-hidden="true"></i> Lingua</a>
			  <div id="myDropdown" class="dropdown-content">
			   <a > &#127470;&#127481;</a>  <a> &#127468;&#127463; </a>
			  </div>
		  </div>
		  <div style="float:right">
		  	  <a href="https://www.whatsapp.com/" ><i class="fa fa-whatsapp" aria-hidden="true"></i></a> 
		  	  <a href="https://web.telegram.org/#/login"><i class="fa fa-telegram" aria-hidden="true"></i></a>
			  <a href="https://www.instagram.com/accounts/login/?hl=it"  ><i class="fa fa-instagram" aria-hidden="true"></i></a>
			  <a href="https://it-it.facebook.com/login/"  >  <i class="fa fa-facebook"></i></a> 
			  <a href="https://twitter.com/login?lang=it" ><i class="fa fa-twitter"></i></a> 
			  <a href="https://www.youtube.com/"><i class="fa fa-youtube"></i></a> 
		  </div>
	</div>

	<div id="mySidenav_left" class="sidenav">

 	  <a id="opzione1"  onclick="document.getElementById('id01').style.display='block'" style="width:auto;">Prenotazione Ombrellone</a> 
	  <a href="#" style="width:auto;" id="opzione2">Prenotazione Pedalò</a>
	  <a href="#" style="width:auto;" id="opzione3">Modifica Prenotazione</a>
	  <a href="#" style="width:auto;" id="opzione4">Elimina Prenotazione</a>
	</div>

	<!-- <div id="mySidenav_right" class="sidenav">
	  <a href="#" id="opzione5">Ordine </br> Bar</a>
	  <a href="#" id="opzione6">Riepilogo Costo Servizi</a>
	  <a href="#" id="opzione7">Ordine Doccia</a>
	  <a href="#" id="opzione8">Riepilogo Costo Ombrellone</a>
	</div> -->
	
<br /><br /><br /><br />
	<div class="txt_hover" style="text-align: left; padding:2%;" >
		
		
		<h2 style="font-family:Sofia; font-size: 70px;text-align: center;" >Benvenuto ${cliente.nome} ${cliente.cognome}</h2>
		<p style="font-variant: small-caps; font-size:25px; text-align: center;">sulla tua HomePage!</p>
	</div>
</div>


<div id="id01" class="modal" style="text-align: center;">
  
  <form class="modal-content" action="/action_page.php">
    <div class="container">
      <h1>Inserisci data di prenotazione</h1>
      
      <hr>
      <b>Scegli il giorno </b>

   
	<input id="data_first" type="date" name="bday" min="2020-11-11" >

      <br><br>
      <div class="clearfix">
        <button type="submit" >Conferma</button>
      </div>
      
    </div>
  </form>
</div>


<br />
<div style="text-align:center">
	<hr width="300px"/><div><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i></div> <br/>
	<em>Relax, mare, natura, cultura e divertimento in un’unica, completa, soluzione.</em> 
	<br /> <br />
	<i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>
	<hr width="300px"/>
</div>	
<br />


<br /><br />

<div  style="background-color: yellow;"   id="mappa_div">

wlijebwevpijwvn
<span id="result"></span>

</div>





 

<!-- <br /> -->
<!-- <div style="text-align:center"> -->
<!-- 	<hr width="300px"/><div><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i></div> <br/> -->
<!-- 	<em>I nostri servizi </em><br /> <br /> -->
<!-- 	<div class="w3-content w3-section" style="max-width:500px; position:relative; margin-left:35%"> -->
<!-- 	  <img  src="../immagini/vacanze-al-mare-800x400.jpg" style="width:100%; "> -->
<!-- <!-- 	  <img class="mySlides" src="../immagini/ragazza.jpg" style="width:100%"> --> 
<!-- <!-- 	  <img class="mySlides" src="../immagini/vacanze-al-mare-800x400.jpg"  style="width:100%"> --> 
<!--  	</div>  -->
<!--  <br/> -->
<!-- 	<i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i> -->
<!-- 	<hr width="300px"/> -->
<!-- </div>	 -->
<!-- <br /> -->




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

