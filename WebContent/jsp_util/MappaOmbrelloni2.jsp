<%@page import="javax.swing.text.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="pkg.bean.ClientePrenotaOmbrellone" %>
<%@ page import="pkg.bean.Ombrellone" %>


<!-- Colora l'ombrellone rosso o verde a seconda se era libero o occupato -->
	<%	for(int i=1;i<25;i++){
			if(session.getAttribute("ombrellonePrenotato"+i)!=null){
				ClientePrenotaOmbrellone o=(ClientePrenotaOmbrellone) session.getAttribute("ombrellonePrenotato"+i);
				String ombrellone = "ombrellone"+i;								
			%>
			<script type="text/javascript">
				$(<%=ombrellone%>).css("background-color","#ff0700");//rosso		
			</script>		
		<%			
			}
		}
	%>
	
<script type="text/javascript">
$(document).ready(function() {
    
	$(".img_ombrellone").click(function() {
    	$.post("../DatiOmbrelloneServlet", { 
    		id_ombrellone : $(this).attr("id"),
    		}, function(data, status) {
	         if (status == "success")
	 
	            $("#id_ombr_form").attr("value",  "1" );			//GENERALIZZARE!!!!!!!!!!!!!!!!!!!!!!!
	 		
        		$("#stato_ombr_form").attr("value",  "Si" );
	            
	            if($("#stato_ombr_form").val()=="Si"){
	            	$("#hide_if_No").show();
	            }
	            $("#zona_ombr_form").attr("value",  "Vip" );	
	         	$("#prezzo_ombr_form").attr("value",  "25" );	
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
	 var a=parseInt(document.getElementById("costo_tot_sdraio").value);
	var b=parseInt(document.getElementById("costo_tot_lettini").value);
	var c= a+b;
	$("#costo_totale").attr( "value",  c);
	
});	
			
			



   

</script>



	
	<h2 style="text-align: center;" id="informazioni">
 	<%for(int i=1;i<25;i++){
		if(session.getAttribute("ombrellonePrenotato"+i)!=null){
		ClientePrenotaOmbrellone o =(ClientePrenotaOmbrellone) session.getAttribute("ombrellonePrenotato"+i);
			if(o.getSlot_orario()==1){%>
				 <%=o.getData_prenotazione()+" Mattina"  %>
			<%}if(o.getSlot_orario()==2){%>
			 	<%=o.getData_prenotazione()+" Pomeriggio" %>
			<%}
		break;
		}
	  }
 	 %>
	</h2>
	
	
	
<br><br><br>
 <div  class="contenitore" style="margin-left: 20%" >
	<a id="surfista"  style="font-size:50px;z-index:2;position:absolute;top:5px;left: 990px"> &#127940;&#8205;&#9794;&#65039; </a>
	<a id="pedalò" class="ristorante" style="font-size:80px;z-index:2;position:absolute;top:-25px;left:125px"> &#128676;</a>
	<a id="runner" style="font-size:50px;z-index:2;position:absolute;top:75px;left:390px">&#127939;  </a>
	<a id="granchio1" style="font-size:15px;z-index:2;position:absolute;top:110px;left:990px"> &#129408; </a>
	<a id="granchio2" style="font-size:15px;z-index:2;position:absolute; top:120px;left:1010px"> &#129408; </a>
	
	<a id="ombrellone1" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:230px;left: 80px ;background-color:#6fff45;">&#9969;&#65039;</a>
	
	
	<a id="ombrellone2" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:230px;left:240px;background-color:#6fff45 ;">&#9969;&#65039;</a>
	<a id="ombrellone3" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:230px;left:400px;background-color:#6fff45 ;">&#9969;&#65039;</a>
	<a id="ombrellone4" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:230px;left:720px;background-color:#6fff45 ;">&#9969;&#65039;</a> 
	<a id="ombrellone5" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:230px;left:870px;background-color:#6fff45 ;">&#9969;&#65039;</a>
	<a id="ombrellone6" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:230px;left:1020px;background-color:#6fff45 ;">&#9969;&#65039;</a>
	
	<a id="ombrellone7" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:370px;left: 80px;background-color:#6fff45;">&#9969;&#65039;</a>
	<a id="ombrellone8" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:370px;left:240px;background-color:#6fff45;">&#9969;&#65039;</a>
	<a id="ombrellone9" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:370px;left:400px;background-color:#6fff45;">&#9969;&#65039;</a>
	<a id="ombrellone10" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:370px;left:720px;background-color:#6fff45;">&#9969;&#65039;</a> 
	<a id="ombrellone11" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:370px;left:870px;background-color:#6fff45;">&#9969;&#65039;</a>
	<a id="ombrellone12" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:370px;left:1020px;background-color:#6fff45;">&#9969;&#65039;</a>
	
	<a id="ombrellone13" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:510px;left:240px;background-color:#6fff45;">&#9969;&#65039;</a>
	<a id="ombrellone14" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:510px;left:400px;background-color:#6fff45;">&#9969;&#65039;</a>
	<a id="ombrellone15" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:510px;left:720px;background-color:#6fff45;">&#9969;&#65039;</a> 
	<a id="ombrellone16" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:510px;left:870px;background-color:#6fff45;">&#9969;&#65039;</a>  
	 	
	<a id="ombrellone17" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:680px;left:80px;background-color:#6fff45;">&#9969;&#65039;</a> 	
	<a id="ombrellone18"class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:680px;left:240px;background-color:#6fff45;">&#9969;&#65039;</a> 
	<a id="ombrellone19" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:680px;left:720px;background-color:#6fff45;">&#9969;&#65039;</a> 	
	<a id="ombrellone20" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:680px;left:870px;background-color:#6fff45;">&#9969;&#65039;</a> 
	
	<a id="ristorante" class="ristorante"   style="font-size:60px;z-index:2;position:absolute;top:846px;left:483px;">&#127860;</a>
	
	<a id="doccia1" class="img_ombrellone"  style="font-size:20px;z-index:2;position:absolute;top:850px;left:647px;background-color:#6fff45;">&#128705;</a> 
	<a id="doccia2" class="img_ombrellone"  style="font-size:20px;z-index:2;position:absolute;top:870px;left:647px;background-color:#6fff45;">&#128705;</a> 
	<a id="doccia3" class="img_ombrellone"  style="font-size:20px;z-index:2;position:absolute;top:890px;left:647px;background-color:#6fff45;">&#128705;</a> 
	<a id="doccia4" class="img_ombrellone"  style="font-size:20px;z-index:2;position:absolute;top:910px;left:647px;background-color:#6fff45;">&#128705;</a> 
	
	
	<a id="ombrellone21" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:820px;left:80px;background-color:#6fff45;">&#9969;&#65039;</a> 
	<a id="ombrellone22" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:820px;left:240px;background-color:#6fff45;">&#9969;&#65039;</a> 
	<a id="ombrellone23" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:820px;left:720px;background-color:#6fff45;">&#9969;&#65039;</a> 	
	<a id="ombrellone24" class="img_ombrellone" style="font-size:60px;z-index:2;position:absolute;top:820px;left:870px;background-color:#6fff45;">&#9969;&#65039;</a>  
</div>



<div style="position:absolute; float: right; background-color: #59C3D8;height: 1020px; weight: 25%; padding:2%; ">


<h3>Dati ombrellone  </h3>
<hr>

<form action="../Prenotazione">

	<fieldset>
	<legend>Dati generali</legend>
	
	ID-Ombrellone:<br><input id="id_ombr_form" name="id_ombr_form" type="text" disabled="disabled" value=" "><br><br>
	Libero:<br><input id="stato_ombr_form" name="stato_ombr_form" type="text" disabled="disabled" value=""><br><br>
	Zona:<br><input id="zona_ombr_form" name="zona_ombr_form" type="text" disabled="disabled" value=""><br><br>
	Prezzo ombrellone €/pz:<br><input id="prezzo_ombr_form" name="prezzo_ombr_form" type="text" disabled="disabled" value=""><br><br>
	Prezzo lettino €/pz:<br><input id="prezzo_lettino" name="prezzo_lettino" type="text" disabled="disabled" value="5"><br><br>
	Prezzo sdraio €/pz:<br><input id="prezzo_sdraio" name="prezzo_sdraio" type="text" disabled="disabled" value="3">
	</fieldset>
<br><br>

<div id="hide_if_No" hidden="">
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
	
			<option value="1">1</option>
			<option value="2">2</option>						
			<option value="3">3</option>
		</select> <br>
		<i class="fa fa-exclamation-triangle" aria-hidden="true"> Max 3 lettini</i>
		<br><br>
		Numero sdraio:
		<select id="num_sdraio_form"  onchange="changeNumSdraio()" name="num_sdraio"> 
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
	Costo tot lettini:<br><input id="costo_tot_lettini" name="costo_tot_lettini"  type="text" value="5"><br>
	Costo tot sdraio:<br><input id="costo_tot_sdraio" name="costo_tot_sdraio" type="text" value="3">
	<br/>
	<hr style="background-color: black">
	
	Costo totale : <br><input id="costo_totale" name="costo_totale" type="text" value=" ">
	</fieldset>
	
	<br><br>
	<input style="float: right" id="prenota_azione" type="submit" value="Prenota" >
	</div>

</form>

</div>
	<%	for(int i=1;i<25;i++){
			if(session.getAttribute("ombrellonePrenotato"+i)!=null){			
				session.removeAttribute("ombrellonePrenotato"+i);
			}
		}
	%>