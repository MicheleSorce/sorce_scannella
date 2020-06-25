<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title> Home Amministratore </title>
<link Rel="icon" type="image/ico" href="../immagini/logo.png"> <!-- per il logo in alto -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Sofia"><!-- per la scrittua in alto -->
<link href="../css/AmministratoreCSS.css" type="text/css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"><!-- Per il navbar -->
<script src="https://code.jquery.com/jquery-3.4.0.min.js" type="text/javascript"></script>
<script>
//pulsante lingua

//*
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
  
$(document).ready(function(){
	

		    $( "#opzione1" ).on( "click", function() {
			  
		    	$(".riuso").html('<div id="spiaggia"><img src="../immagini/mappa_vuota.jpg" width="100%" height="100%"></div>');  
		    	
		    	/*
		    	
		    	 <div  class="contenitore" >
		    	 <a id="surfista"style="font-size:50px;z-index:2;position:absolute;top:5px;left: 990px"> &#127940;&#8205;&#9794;&#65039; </a>
		    	 <a id="barchetta" style="font-size:50px;z-index:2;position:absolute;top:-3px;left:125px"> &#128675;</a>
		    	 <a id="runner" style="font-size:50px;z-index:2;position:absolute;top:75px;left:390px">&#127939;  </a>
		    	 <a id="granchio1" style="font-size:15px;z-index:2;position:absolute;top:110px;left:990px"> &#129408; </a>
		    	<a id="granchio2" style="font-size:15px;z-index:2;position:absolute; top:120px;left:1010px"> &#129408; </a>

		    	<a id="ombrellone1" class="img_ombrellone"style="font-size:60px;z-index:2;position:absolute;top:230px;left: 80px">&#9969;&#65039;</a>
		    	<a id="ombrellone2" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:230px;left:240px">&#9969;&#65039;</a>
		    	<a id="ombrellone3" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:230px;left:400px">&#9969;&#65039;</a>
		    	<a id="ombrellone4" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:230px;left:720px">&#9969;&#65039;</a> 
		    	<a id="ombrellone5" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:230px;left:870px">&#9969;&#65039;</a>
		    	<a id="ombrellone6" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:230px;left:1020px">&#9969;&#65039;</a>

		    	<a id="ombrellone7" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:370px;left: 80px">&#9969;&#65039;</a>
		    	<a id="ombrellone8" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:370px;left:240px">&#9969;&#65039;</a>
		    	<a id="ombrellone9" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:370px;left:400px">&#9969;&#65039;</a>
		    	<a id="ombrellone10" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:370px;left:720px">&#9969;&#65039;</a> 
		    	<a id="ombrellone11" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:370px;left:870px">&#9969;&#65039;</a>
		    	<a id="ombrellone12" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:370px;left:1020px">&#9969;&#65039;</a>

		    	<a id="ombrellone13" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:510px;left:240px">&#9969;&#65039;</a>
		    	<a id="ombrellone14" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:510px;left:400px">&#9969;&#65039;</a>
		    	<a id="ombrellone15" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:510px;left:720px">&#9969;&#65039;</a> 
		    	<a id="ombrellone16" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:510px;left:870px">&#9969;&#65039;</a>  
		    	 	
		    	<a id="ombrellone17" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:680px;left:80px">&#9969;&#65039;</a> 	
		    	<a id="ombrellone18"class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:680px;left:240px">&#9969;&#65039;</a> 
		    	<a id="ombrellone19" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:680px;left:720px">&#9969;&#65039;</a> 	
		    	<a id="ombrellone20" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:680px;left:870px">&#9969;&#65039;</a> 


		    	<a id="ombrellone21" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:820px;left:80px">&#9969;&#65039;</a> 
		    	<a id="ombrellone22" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:820px;left:240px">&#9969;&#65039;</a> 
		    	<a id="ombrellone23" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:820px;left:720px">&#9969;&#65039;</a> 	
		    	<a id="ombrellone24" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:820px;left:870px">&#9969;&#65039;</a>  
		    	</div>

		    	*/
		    	
		    //	<div id="spiaggia">
		    //	<img src="../immagini/mappa_vuota.jpg" width="100%" height="100%">
		    //	</div>
		    });
		    
		    $( "#opzione2" ).on( "click", function() {		  
		    	$(".riuso").html('<br><br><br><div id="pagamenti" style="height: 700px"><table style="border:2px solid blu; width: 80%; position: relative;left: 10%;"><tr><th>Numero Ombrellone</th><th>Nome Intestatario</th><th>Conto Obrellone</th><th>Stato Prezzo</th></tr><tr><td></td><td></td><td></td><td></td></tr></table></div>');
		    	
		    	//<div id="pagamenti" style="height: 700px">
		    	//	<table style="border:2px solid blu; width: 80%; position: relative;left: 10%;">
		    	//		<tr>
		    	//			<th>Numero Ombrellone</th><th>Nome Intestatario</th><th>Conto Obrellone</th><th>Stato Prezzo</th>
		    	//		</tr>
		    	//		<tr>
	    		//		<td></td><td></td><td></td><td></td>
	    		//		</tr>
		    	//	</table>
		    	//</div>
		    	
		    });
		    
		    $( "#opzione3" ).on( "click", function() {	  
		    	$(".riuso").html('<br><br><br><div id="servizi" style="height: 700px; background-color:blue;"><button>Modifica</button><button>Elimina</button></div>');
		    	//<div id="servizi" style="height: 700px">
		    	//   		<button>Modifica</button>
		    	//   		<button>Elimina</button>
		    	//   	</div>
		    });
 

});	   
	  
	  
	  
	  

</script>


</head>
<body class=”it”>

	<div class="navbar" style= "width:99% " >
		  <a class="active" href="#"><i class="fa fa-fw fa-home"></i> Home</a> 
		 
		  <a href="#finale" ><i class="fa fa-fw fa-envelope"></i> Contatti</a> 
		  <a href="logIn.html"><i class="fa fa-fw fa-user"></i> Login</a>
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

	<div id="mySidenav_left" class="sidenav" >
	  <a href="#" id="opzione1" style="top: 170px;">Spiaggia</a>
		<a href="#" id="opzione2">Stato Pagamenti</a>
		<a href="#" id="opzione3">Servizi</a>
	
	</div>
	
	
<div class="riuso" >


<%--  <% // Using session...
   HttpSession session1 = request.getSession();
   String user = (String) session1.getAttribute("user");
   %>
<span class="session"> Welcome:<%=user%></span>
 --%>


<div class="bg_top"> 
	<div style="text-align: left; padding:8%;">
		<br /><br /><br /><br />
		<div class="descrizione txt_hover">
		<h2 style="font-family:Sofia;color:white;  font-size: 70px;text-align: center;" >Amministrazione</h2>
		<p style="font-variant: small-caps;color:white; font-size:40px; text-align: center;"> Benvenuto testa di... ${ammin.nome}!</p>
		
		</div>
	</div>
</div>
 
<br />

<div style="text-align:center">
	<hr width="300px"/><div><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i></div> <br/>
	<em>Relax, mare, natura, cultura e divertimento in un’unica, completa, soluzione. </em><br /> <br />
	<i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>
	<hr width="300px"/>
</div>	


</div>



<div id="finale" class="footer-bottom" style="font-variant: small-caps;">

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
	      <strong>Dott. Scannella &amp; Dott. Sorce</strong><br />
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


