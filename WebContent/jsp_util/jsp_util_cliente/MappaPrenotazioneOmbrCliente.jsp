<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="pkg.bean.ClientePrenotaOmbrellone" %>
<%@ page import="pkg.bean.Ombrellone" %>
<link href="../css/Mappa.css" type="text/css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.0.min.js" type="text/javascript"></script>

<jsp:useBean id="ombrellone" scope="session" class="pkg.bean.Ombrellone"/>

<!-- Colora l'ombrellone rosso o verde a seconda se era libero o occupato -->
	
	<%
	String data_tit=(String)session.getAttribute("data_sess");
	int f=(Integer)session.getAttribute("slot_orario_sess");
	
	
	String slot_orario_o="";
	if(f==1){
		slot_orario_o="Mattina";
	}if(f==2){
		 slot_orario_o="Pomeriggio";
	}
	
	session.removeAttribute("data_sess");
	session.removeAttribute("slot_orario_sess");
	
	
	int count_ombr_prenotati=0;
		for(int i=1;i<25;i++){
			if(session.getAttribute("ombrellonePrenotato"+i)!=null){
				count_ombr_prenotati++;
				ClientePrenotaOmbrellone o=(ClientePrenotaOmbrellone) session.getAttribute("ombrellonePrenotato"+i);
				String ombr = "ombrellone"+i;
				
				
			%>
			<script type="text/javascript">
				$(<%=ombr%>).css("background-color","#ff0700");//rosso	
				
			</script>		
		<%		session.removeAttribute("ombrellonePrenotato"+i);
			}
			
		}
	
	%>

	
<script type="text/javascript">


$(document).ready(function() {
	
	$("#data").text("<%=data_tit%>");
	$("#slot_orario").text("<%=slot_orario_o%>");
	
	var data= $("#data").text();
	var slot_orario_o= $("#slot_orario").text();

	if(<%=count_ombr_prenotati%>==24){
		alert("Gli ombrelloni sono tutti prenotati.\nScegli uno slot orario diverso.");
	}
	

	$("#hide_if_No").hide();	
 	$(".img_ombrellone").click(function() {

 		 
		var id=$(this).attr("id");
		
		var color = $( this ).css( "background-color" );
		
		$.post("../ClienteServlet", { 
    		operazione: "dati_prenotazione_ombrellone",
    		id_ombrellone : id,
    		slot_orario: slot_orario_o,
    		data: data
    		}, function(data, status) {
	         if (status == "success"){
	        	
  				$("#id_ombr_form").attr("value", data.id);
  				$("#id_ombr_form").attr("readonly", "readonly");
  				if(color == "rgb(255, 7, 0)"){
  					$("#stato_ombr_form").attr("value", "No");	
  					$("#hide_if_No").hide();
  				}else{
  					$("#stato_ombr_form").attr("value", "Si");
  					$("#hide_if_No").show();
  				}
  		
  				$("#stato_ombr_form").attr("readonly", "readonly");
  				
  				$("#zona_ombr_form").attr("value", data.zona);
  				$("#zona_ombr_form").attr("readonly", "readonly");
  				
  				$("#prezzo_ombr_form").attr("value", data.prezzo);
  				$("#prezzo_ombr_form").attr("readonly", "readonly");
  				$("#prezzo_lettino").attr("value",  "5.0");
  				$("#prezzo_lettino").attr("readonly", "readonly");
  				$("#prezzo_sdraio").attr("value", "3.0");
  				$("#prezzo_sdraio").attr("readonly", "readonly");
  				
  
  				
  				$("#costo_tot_ombrellone").attr("value", data.prezzo);
  			
  				
  				$("#num_lettini_form").val("0");
  				$("#num_sdraio_form").val("0");
  				
  				 var tot_sdraio,tot_lett, tot_ombr;
  				
  				if( $("#num_lettini_form").val() == "0" ){
  					$("#costo_tot_lettini").val( "0");
  				}
  				
  				if( $("#num_sdraio_form").val() == "0" ){
  					$("#costo_tot_sdraio").val("0");
  				}
  				
  				var tot_sdraio=parseFloat(document.getElementById("costo_tot_sdraio").value);
  				var tot_lett=parseFloat(document.getElementById("costo_tot_lettini").value);
  				var tot_ombr=parseFloat(document.getElementById("costo_tot_ombrellone").value);
  			
  				
  				var tot= tot_ombr+ tot_lett+ tot_sdraio;
  				$("#costo_totale").attr("value", tot);	
  				
  				
	         }
    	 });
    }); 

	$("#prenota_azione").click(function() {
		
		
		
		var id1=$("#id_ombr_form").val();		
		var color = $( this ).css( "background-color" );
		var id_cli= ${cliente.idCliente};
		
		$.post("../ClienteServlet", { 
    		operazione: "prenota_ombrellone",
    		id_ombrellone : id1,
    		slot_orario1: slot_orario_o,
    		data1: data,
    		id_cliente: id_cli,		
			num_persone : $("#num_persone_form").val(),
			num_lettini : $("#num_lettini_form").val(),
			num_sdraio : $("#num_sdraio_form").val(),
			
    		}, function(data, status) {
    			if (status == "success"){
	  		           if(data.res == "true"){
	  						alert("La prenotazione è avvenuta con successo.\nBuon divertimento!");
	  		           }
	  		           if(data.res == "false"){  
	  		        	 alert("Errore di registrazione prenotazione.\nRiprova");
  		           }	
    			}
    			
		     });
	});
 
 
	     
    
   
    
});



var a=0;

function changeNumlettini() {
	
	var prezzo_lettino= document.getElementById("prezzo_lettino").value;
	var num_lettini =document.getElementById("num_lettini_form").value;
	
	var tot_lettini = prezzo_lettino * num_lettini;

	document.getElementById("costo_tot_lettini").value = tot_lettini ;

}

function changeNumSdraio() {
	
	var prezzo_sdraio= document.getElementById("prezzo_sdraio").value;
	var num_sdraio =document.getElementById("num_sdraio_form").value;
	var tot_sdraio = prezzo_sdraio * num_sdraio;
	document.getElementById("costo_tot_sdraio").value = tot_sdraio ;
	
}


$("#num_sdraio_form, #num_lettini_form").change(function(){
	var a=parseFloat(document.getElementById("costo_tot_sdraio").value);
	var b=parseFloat(document.getElementById("costo_tot_lettini").value);
	var c=parseFloat(document.getElementById("costo_tot_ombrellone").value);
	var d= a+b+c;
	$("#costo_totale").attr( "value",  d);
	
});	
	

</script>


<div>
<br><br><br>
<div id="prenotazione_prova"style="text-align:center; ">
	<hr width="300px"/><div><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i></div> <br/>
	<div> <h2 id="data"></h2><h2 id="slot_orario"></h2></div>
	<h4>Clicca sull'ombrellone desiderato per ottenere maggiori informazioni.</h4>
	<i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>
	<hr width="300px"/><br>
	
	
</div>
	 <h2 id="data" style="text-align: center; color: blue;"></h2><h2 id="slot_orario" style="text-align: center; color: blue;"></h2>
	

	

<div class="form_css_cliente_prenotazione">

<form id="div_show" >

	<fieldset>
	<legend>Dati generali</legend>
	
	ID-Ombrellone:<br><input id="id_ombr_form" name="id_ombr_form" type="text"  value=" "><br>
	Libero:<br><input id="stato_ombr_form" name="stato_ombr_form" type="text" value=""><br>
	Zona:<br><input id="zona_ombr_form" name="zona_ombr_form" type="text"  value=""><br><br>
	Prezzo ombrellone €/pz:<br><input id="prezzo_ombr_form" name="prezzo_ombr_form" type="text" onchange="changeOmbrellone()" value="" ><br>
	Prezzo lettino €/pz:<br><input id="prezzo_lettino" name="prezzo_lettino" type="text"  value=" "><br>
	Prezzo sdraio €/pz:<br><input id="prezzo_sdraio" name="prezzo_sdraio" type="text"  value=" "><br>
	</fieldset>
<br>
<div id="hide_if_No" > 
		<fieldset>
		<legend>Dati prenotazione</legend>
		<!-- Aggiungere giorno e periodo (non modificabili) -->
			Numero persone:
			<select id="num_persone_form"  name="num_persone"> 
				<option value="1">1</option>
				<option value="2">2</option>						
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
			</select> <br>
			<i class="fa fa-exclamation-triangle" aria-hidden="true"> Max 5 persone</i>
			<br><br>
			Numero lettini:
			<select id="num_lettini_form" onchange="changeNumlettini()" name="num_lettini"> 
				<option value="0">0</option>
				<option value="1">1</option>
				<option value="2">2</option>						
				<option value="3">3</option>
			</select> <br>
			<i class="fa fa-exclamation-triangle" aria-hidden="true"> Max 3 lettini</i>
			<br><br>
			Numero sdraio:
			<select id="num_sdraio_form"  onchange="changeNumSdraio()"  name="num_sdraio"> 
				<option value="0">0</option>
				<option value="1">1</option>
				<option value="2">2</option>						
				<option value="3">3</option>
			</select> <br>
			<i class="fa fa-exclamation-triangle" aria-hidden="true"> Max 3 sdraio</i>
				<br><br>
		
		</fieldset><br />
		
		<fieldset>
		<legend>Dati pagamento</legend>
		Costo tot ombrellone <br><input id="costo_tot_ombrellone" name="costo_tot_ombrellone" type="text" value=""><br> 	<!-- //value lo prendo la sopra -->
		Costo tot lettini:<br><input id="costo_tot_lettini" name="costo_tot_lettini"  type="text" value="0"><br>
		Costo tot sdraio:<br><input id="costo_tot_sdraio" name="costo_tot_sdraio" type="text" value="0">
		<br/>
		<hr style="background-color: black">
		
		Costo totale :<input id="costo_totale" name="costo_totale" type="text" value=" ">
		</fieldset>
		
		<br>
		<input style="float: right" id="prenota_azione" type="submit" value="Prenota" >
 </div>
</form>
</div>




 <div  class="contenitore_pul" >
 
	<a id="surfista"  style="font-size:50px;z-index:1;position:absolute;top:5px;left: 990px"> &#127940;&#8205;&#9794;&#65039; </a>
	<a id="pedalò" class="ristorante" style="font-size:80px;z-index:1;position:absolute;top:-25px;left:221px"> &#128676;</a>
	<a id="runner" style="font-size:50px;z-index:1;position:absolute;top:75px;left:390px">&#127939;  </a>
	<a id="granchio1" style="font-size:15px;z-index:1;position:absolute;top: 100px;left: 910px;"> &#129408; </a>
	<a id="granchio2" style="font-size:15px;z-index:1;position:absolute;  top:80px;left: 900px;"> &#129408; </a>


  
	<a id="ombrellone1" class="img_ombrellone" style=" top:230px;left: 80px; ">&#9969;&#65039;</a>	
	
	<a id="ombrellone2" class="img_ombrellone" style=" top:230px;left:240px;">&#9969;&#65039;</a>
	<a id="ombrellone3" class="img_ombrellone" style=" top:230px;left:400px;">&#9969;&#65039;</a>
	<a id="ombrellone4" class="img_ombrellone" style=" top:230px;left:720px; ">&#9969;&#65039;</a> 
	<a id="ombrellone5" class="img_ombrellone" style=" top:230px;left:870px; ">&#9969;&#65039;</a>
	<a id="ombrellone6" class="img_ombrellone" style=" top:230px;left:1020px; ">&#9969;&#65039;</a>
	
	<a id="ombrellone7" class="img_ombrellone" style=" top:370px;left: 80px; ">&#9969;&#65039;</a>
	<a id="ombrellone8" class="img_ombrellone" style=" top:370px;left:240px; ">&#9969;&#65039;</a>
	<a id="ombrellone9" class="img_ombrellone" style=" top:370px;left:400px; ">&#9969;&#65039;</a>
	<a id="ombrellone10" class="img_ombrellone" style=" top:370px;left:720px; ">&#9969;&#65039;</a> 
	<a id="ombrellone11" class="img_ombrellone" style=" top:370px;left:870px; ">&#9969;&#65039;</a>
	<a id="ombrellone12" class="img_ombrellone" style=" top:370px;left:1020px; ">&#9969;&#65039;</a>
	
	<a id="ombrellone13" class="img_ombrellone" style=" top:510px;left:240px; ">&#9969;&#65039;</a>
	<a id="ombrellone14" class="img_ombrellone" style=" top:510px;left:400px; ">&#9969;&#65039;</a>
	<a id="ombrellone15" class="img_ombrellone" style=" top:510px;left:720px; ">&#9969;&#65039;</a> 
	<a id="ombrellone16" class="img_ombrellone" style=" top:510px;left:870px; ">&#9969;&#65039;</a>  
	 	
	<a id="ombrellone17" class="img_ombrellone" style=" top:680px;left:80px; ">&#9969;&#65039;</a> 	
	<a id="ombrellone18"class="img_ombrellone" style=" top:680px;left:240px; ">&#9969;&#65039;</a> 
	<a id="ombrellone19" class="img_ombrellone" style=" top:680px;left:720px; ">&#9969;&#65039;</a> 	
	<a id="ombrellone20" class="img_ombrellone" style=" top:680px;left:870px; ">&#9969;&#65039;</a> 
	
	<a id="ristorante" class="ristorante"   style="top:846px;left:483px;">&#127860;</a>
	
	<a id="doccia1" class="img_doccia"  style="top:850px;left:647px;">&#128705;</a> 
	<a id="doccia2" class="img_doccia"  style="top:870px;left:647px;">&#128705;</a> 
	<a id="doccia3" class="img_doccia"  style="top:890px;left:647px;">&#128705;</a> 
	<a id="doccia4" class="img_doccia"  style="top:910px;left:647px;">&#128705;</a> 
	
	
	<a id="ombrellone21" class="img_ombrellone" style=" top:820px;left:80px; ">&#9969;&#65039;</a> 
	<a id="ombrellone22" class="img_ombrellone" style=" top:820px;left:240px; ">&#9969;&#65039;</a> 
	<a id="ombrellone23" class="img_ombrellone" style=" top:820px;left:720px; ">&#9969;&#65039;</a> 	
	<a id="ombrellone24" class="img_ombrellone" style=" top:820px;left:870px; ">&#9969;&#65039;</a>  

</div>


</div>

