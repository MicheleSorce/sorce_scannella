<%@page import="pkg.bean.Amministratore"%>
<%@page import="pkg.bean.Bagnino"%>
<%@page import="pkg.bean.Barista"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>


<script>




var currentTab = 0; // Current tab is set to be the first tab (0)
showTab(currentTab); // Display the current tab
$("#registrati").hide();


$(function(){
    var dtToday = new Date();
    
    var day = dtToday.getDate();
    var month = dtToday.getMonth() + 1;
    var year = dtToday.getFullYear();

    if(month < 10)
        month = '0' + month.toString();
    if(day < 10)
        day = '0' + day.toString();

    var maxDate = year + '-' + month + '-' + day;    
    $('#data_nascita').attr('max', maxDate);
    
});



$("#registrati").click(function () {
	
	var bool= checkpassword();

	if( ($("#password").val()=="" || $("#confermaPassword").val()=="") && bool=="false"){
		alert("inserisci la password");
	}
	if(bool){
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
		    
		   	 if(x == "true"){		    		 
		   		 alert("Registrazione avvenuta con successo");
		   		 location.reload();
		   	 }
		   	 if(x == "false"){		    		 
		   		 alert("Errore di registrazione\nCompila i campi correttamente.");
		   	 }

		    });
	}

});

	



function showTab(n) {
 
  var x = document.getElementsByClassName("tab");
  x[n].style.display = "block";
  
  if (n == 0) {
    document.getElementById("prevBtn").style.display = "none";
  } else {
    document.getElementById("prevBtn").style.display = "inline";
  }  
  if (n == (x.length - 1)) {
	
    document.getElementById("nextBtn").style.display = "none";
    document.getElementById("prevBtn").style.display = "none";
    document.getElementById("registrati").style.display = "inline";
    
    
  } else {
    document.getElementById("nextBtn").innerHTML = "Next";
  }
  
  if (n == 1) {
	  $('#nextBtn').click( function() {
	  
		 $.post("../AmminServlet", { 
			 
			 operazione: "check_mail",
			 email:$("#email").val(),
			 mansione: $("#mansione option:selected").val()

				}, function(data, status) {
		    	 if (status == "success")
			    	 
			    	 var x=data.id;
	
		    	 if(x == "registrato"){
		    		 
		    		 alert("Email già in uso.\nUsane una diversa.");
		    		 $("#email").css("border","2px solid red");
		    		 
		    		 nextPrev(-1);
		    	 }
		  });
	  });
	  
	}
  
  fixStepIndicator(n)
}



function nextPrev(n) {
  var x = document.getElementsByClassName("tab");
  if (n == 1 && !validateForm()) return false;
  x[currentTab].style.display = "none";
  currentTab = currentTab + n;
  if (currentTab >= x.length) {
    document.getElementById("regForm").submit();
    return false;
  }
  showTab(currentTab);
}

function validateForm() {
  var x, y, i, valid = true;
  x = document.getElementsByClassName("tab");
  y = x[currentTab].getElementsByTagName("input");
  for (i = 0; i < y.length; i++) {
    if (y[i].value == "") {
      y[i].className += " invalid";
      valid = false;
    }
  }
  if (valid) {
    document.getElementsByClassName("step")[currentTab].className += " finish";
  }
  return valid; 
}

function fixStepIndicator(n) {
  var i, x = document.getElementsByClassName("step");
  for (i = 0; i < x.length; i++) {
    x[i].className = x[i].className.replace(" active", "");
  }
  x[n].className += " active";
}




function checkpassword(){
	 var ck_password = /^[A-Za-z0-9]{8,12}$/;// controllo sulla validità della password
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
			
			return true; 
	  }

}


</script>





<style>
* {
  box-sizing: border-box;
}

body {
	background: fixed;
	background: no-repeat;
	background-image: url("../immagini/spiaggia.jpg");

	
}
#principale{
	 
  	background-color: rgba(0,0,0, 0.4); 
 	color: white;
 	font-weight: bold;
	width: 50%;
	position: relative;
	left: 25%;
	padding: 25px;

}

#regForm {
  background-color: rgba(0,0,0, 0.5);
  margin: 20px auto;
  padding: 30px;
  width: 70%;
  min-width: 300px;
}

h1 {
  text-align: center;  
}

input {
  padding: 10px;
  width: 100%;
  font-size: 17px;
  font-family: Raleway;
  border: 1px solid #aaaaaa;
}
input:hover{
	border: 2px solid blue;
}
input.invalid {
  background-color: #ffdddd;
}

.tab {
  display: none;
}

button {
	 
  background-color: #4c7caf;
  color: white;
  border-radius: 5px;
  padding: 8px 12px;
  margin: 2px 2px;
  cursor: pointer;
  font-size: 18px;
  width: auto;
 
}

button:hover {
  opacity: 0.8;
}

#prevBtn {
  background-color: #bbbbbb;
}

.step {
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #4c7caf;
  border: none;  
  border-radius: 50%;
  display: inline-block;
  opacity: 0.5;
}

.step.active {
  opacity: 1;
}

.step.finish {
  background-color: ghostwhite;
}
</style>

<br><br><br>



<div id="principale">
<img style="margin-left: 42%;" alt="logo" src="../immagini/logo.png" id="logo" width="100px" height="100px">

<h1>Registrati a MSBeach </h1>
	<form id="regForm" method="post">
	  <h1>Registrazione</h1>

	  <div class="tab">
	  		<div>Mansione</div>
		<select style="font-size:18px;" id="mansione" name="mansione" >
			<option value="amministratore" selected="selected" >Amministratore </option>
			<option value="bagnino">Bagnino</option>
			<option value="barista">Barista</option>
		</select><br><br><br>
	  	Nome 
	    <p><input type="text" name="nome"id="nome" placeholder="Mario" required></p>
	    Cognome
	    <p><input type="text" name="cognome" id="cognome" placeholder="Rossi" required></p>
	  </div>
	  <div class="tab">
	   Email
	    <p><input type="email" name="email" required id="email" placeholder="mario.rossi@gmail.com"></p>
	   Telefono
	    <p><input type="text" name="telefono" id="telefono" placeholder="+39 ..." required></p>
	  </div>
	  <div class="tab">Data di nascita
	    <p><input type="date" name="data_nascita" id="data_nascita" max="" required></p>
	  
	    Sesso<br><br>
	    <div style="margin-left: 30%;">
		    Maschio<input type="radio" name="genere" value="1" id="sessoM" checked="checked">
			Femmina<input type="radio" name="genere" value="2" id="sessoF">
			Altro<input type="radio" name="genere" value="3" id="sessoA">
		</div>
		
		
	  </div>
	  <div class="tab">Password
	    <p><input type="password" name="password" id="password" required></p>
	    Conferma Password
	    <p><input type="password" name="confermaPassword"  id="confermaPassword" required></p>
		<p id="print" style="color: red;font-size:x-small;"></p>	
	  </div>
	  <div style="overflow:auto;">
	    <div style="float:right;">
	      <button type="button" id="prevBtn" onclick="nextPrev(-1)">Previous</button>
	      <button type="button" id="nextBtn" onclick="nextPrev(1)">Next</button>
		  <button type="button" value="Iscriviti" id="registrati" class="pulsanti">Submit</button>   
	    </div>
	  </div>
	  <!-- Circles which indicates the steps of the form: -->
	  <div style="text-align:center;margin-top:40px;">
	    <span class="step"></span>
	    <span class="step"></span>
	    <span class="step"></span>
	    <span class="step"></span>
	  </div>
	</form>
</div>



