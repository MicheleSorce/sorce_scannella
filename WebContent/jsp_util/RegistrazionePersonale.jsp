<%@page import="pkg.bean.Amministratore"%>
<%@page import="pkg.bean.Bagnino"%>
<%@page import="pkg.bean.Barista"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>


<script>

$(document).ready(function(){
	
	$('#input').keypress(function (e) {
		  if (e.which == 13) {
			  $("input").next().focus();
		    return false;  
		  }
	});
	
	//controllo password
	$("#confermaPassword").blur(function(){
		 var ck_password = /^[A-Za-z0-9]{8,12}$/;// controllo sulla validita della password
		 var password = document.getElementById("password").value;
		 var confermapassword = document.getElementById("confermaPassword").value;	  
		 		 
		  // controllo sugli input password
		  if (!ck_password.test(password)) {
				document.getElementById("print").innerHTML= "La password deve contenere almeno 8 e massimo 12 caratteri alfanumerici.";
				$('#password').css("borderColor","red");
				$('#password').focus();
				return false; 
		  }
		  if (confermapassword != password) {
			  document.getElementById("print").innerHTML= "Le password non coincidono.";
			  $('#confermaPassword').css("borderColor","red");
			  $('#confermaPassword').focus();
			  return false; 
		  }
		  if(confermapassword == password && ck_password.test(password)){
			  document.getElementById("print").innerHTML= "";
			    $('#password').css("borderColor","");
			    $('#confermaPassword').css("borderColor","");
				$('#date').focus();
				return false; 
		  }

	});
	
	 $("#form_personale").submit(function() {
		 
	 
		 $.post("../AmminServlet", { 
			 			 	
			 operazione : "registrazione_personale",
			 mansione: $("#mansione option:selected").val(),
			 nome: $("#nome").val(),
			 cognome:$("#cognome").val(),
			 telefono:$("#telefono").val(),
			 email:$("#email").val(),
			 password:$("#password").val(),
			 data_nascita:$("#data_nascita").val(),
			 genere:$("input[name='genere']:checked").val()

				}, function(data, status) {
		     if (status == "success")
		    	 
		    	 var x=data.id;
		     
		    	 if(x == "registrato"){		    		 
		    		 $("#email_error").show();
		    		 
		    		 alert("Email già in uso.");
		    	 }
		    	 if(x == "true"){		    		 
		    		 alert("Registrazione avvenuta con successo");	    		 
		    	 }
		    	 if(x == "false"){		    		 
		    		 alert("Errore di registrazione\nCompila i campi correttamente.");
		    	 }

		     });
	 });
	

  
});

</script>



<style type="text/css">

	body{
		
		background: fixed;
		background: no-repeat;
		background-image: url("../immagini/spiaggia.jpg");
	}
	#principale{
		 
		background-color: rgb(0,0,0); /* Fallback color */
	  	background-color: rgba(0,0,0, 0.6); /* Black w/opacity/see-through */
	 	color: white;
	 	font-weight: bold;
		width: 50%;
		position: relative;
		left: 25%;
		padding: 25px;
		text-align: center;
	
	}
	input:hover{
		border-color: #00FF99;
	}
	.pulsanti {
	    background-color: #4c7caf;
	    color: rgba(225,225,225,0.8);
	    padding: 8px 8px;
	    margin: 10px;
	    border: none;
	    cursor: pointer;
	    width: 20%;
	    opacity: 0.9;
	    font-size: 15px;
	}
	
	.pulsanti:hover {

		color: white;
	}
	
</style>

<br><br><br>

<div id="principale">

<img alt="logo" src="../immagini/logo.png" id="logo" width="100px" height="100px" >
<h1>MSBeach</h1>
<h2>Registra il tuo personale</h2>

<hr>
	<form id="form_personale" method="post" >
	
	<input name="operazione" value="registrazione_personale" hidden="">
	
	<b>Mansione </b> <br>
	<select id="mansione" name="mansione">
		<option value="amministratore" selected="selected">Amministratore </option>
		<option value="bagnino">Bagnino</option>
		<option value="barista">Barista</option>
	</select>
	<br><br>
	
	 <span style="font-variant: small-caps">Nome </span><br /><input type="text" name="nome"id="nome" placeholder="Mario" required="required"><br /><br />
	 <span style="font-variant: small-caps">Cognome</span><br /><input type="text" name="cognome" id="cognome" placeholder="Rossi" required="required"><br /><br />
	 <span style="font-variant: small-caps">Telefono</span><br /><input type="text" name="telefono" id="telefono" placeholder="+39 ..." required="required"><br /><br />
	 <span style="font-variant: small-caps">E-mail</span><br /><input type="email" name="email" required="required" id="email" placeholder="mario.rossi@gmail.com">
	 <div id="email_error" style="color: red;" hidden="hidden"> Email già in uso</div><br /><br />
	 <span style="font-variant: small-caps">Password</span><br /><input type="password" name="password" id="password" required="required"><br /><br />
	 <span style="font-variant: small-caps">Conferma Password</span><br /><input type="password" name="confermaPassword" id="confermaPassword" required="required"><br />
	 <p id="print" style="color: red;font-size:x-small;"></p>
	
	<fieldset>
	<legend>Dati anagrafici</legend>
	<span style="font-variant: small-caps">Data di nascita</span><br /> <input type="date" name="data_nascita" id="data_nascita" required="required"><br /><br />
	<span style="font-variant: small-caps">Sesso:</span><br>
	<input style="font-style: " type="radio" name="genere" value="1" id="sessoM" checked="checked">Maschio
	<input type="radio" name="genere" value="2">Femmina
	<input type="radio" name="genere" value="3">Altro
	</fieldset><br />
		
<hr>
	<br/>
	
	<input type="reset"value="Resetta" class="pulsanti">
	<input type="submit" value="Iscriviti" id="submit" class="pulsanti">
	
	</form>
	
</div>


