<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="pkg.bean.ClientePrenotaOmbrellone" %>
<%@ page import="pkg.bean.Ombrellone" %>
<link href="../css/MappaAmmin.css" type="text/css" rel="stylesheet">
<jsp:useBean id="ombrellone" scope="session" class="pkg.bean.Ombrellone"/>

<!-- Colora l'ombrellone rosso o verde a seconda se era libero o occupato -->
	<%	for(int i=1;i<25;i++){
			if(session.getAttribute("ombrellonePrenotato"+i)!=null){
				ClientePrenotaOmbrellone o=(ClientePrenotaOmbrellone) session.getAttribute("ombrellonePrenotato"+i);
				String ombr = "ombrellone"+i;
				String data = o.getData_prenotazione();
				int slot = o.getSlot_orario();
				String slot_orario="";
				if(slot==1){
					slot_orario="Mattina";
				}if(slot==2){
					 slot_orario="Pomeriggio";
				}
			%>
			<script type="text/javascript">
				$("#data").text("<%=data%>");
				$("#slot_orario").text("<%=slot_orario%>");
				$(<%=ombr%>).css("background-color","#ff0700");//rosso		
			</script>		
		<%			session.removeAttribute("ombrellonePrenotato"+i);
			}
			
		}
	%>
	
<script type="text/javascript">

$(document).ready(function() {
	
	



     
     

    
	$(".img_ombrellone").click(function() {

		
		var id=$(this).attr("id");
		var data= $("#data").text();
		var slot_orario= $("#slot_orario").text();
		 var color = $( this ).css( "background-color" );
		 
    	$.post("../AmminServlet", { 
    		operazione: "dati_prenotazione_ombrellone",
    		id_ombrellone : id,
    		slot_orario: slot_orario,
    		data: data
    		
    		}, function(data, status) {
	         if (status == "success"){     	
	        	
	        	var stato;
	        	var id_ombr= "#"+id;
	        	
	 	        if(color == "rgb(255, 7, 0)"){
	 	        	stato="No";  
	 	        }else{
	 	        	stato="Si";   
	 	        }       

	        	
	        	$("#libero").attr("value", stato);
  				$("#id_ombr").attr("value", data.id);			           
 				$("#zona_ombr").attr("value", data.zona  );	
   				$("#prezzo_ombr").attr("value", data.prezzo );  				
   				
   				$("#num_persone").attr("value", data.num_persone );
   				$("#num_lettini").attr("value", data.num_lettini );
   				$("#num_sdraio").attr("value", data.num_sdraio);

				$("#nome_cliente").attr("value",data.nome);
				$("#cognome_cliente").attr("value",data.cognome);
				$("#tel_cliente").attr("value",data.telefono);
				$("#pagato").attr("value",data.pagato);
			
  				if(stato=="Si"){
  					
  					$("#libero").css("font-weight","bold");
  					$("#nome_cliente").attr("value","NULL");
  					$("#cognome_cliente").attr("value","NULL");
  					$("#tel_cliente").attr("value","NULL");
  					$("#pagato").attr("value","NULL");
  				}
  				location.href="#div_show";
	         }
	 
     });
    });

	
});
  


</script>


<div>
<br><br><br>
<div class="periodo">
	 <h2 id="data"></h2>
	 <h2 id="slot_orario"></h2>
</div>	
	<br><br>
	
<style>
.dati{ 
	float: left;
    margin-right: 10px;
    width: 25%;
    height:100%;
    position: relative;
}
.dati2{ 
	float: left;
    margin-right: 5px;
    padding:5px;
    width: 45%;
    position: relative;
}
	
</style>

 <div  class="contenitore">
 
	<a id="surfista"  style="font-size:50px;z-index:2;position:absolute;top:5px;left: 990px"> &#127940;&#8205;&#9794;&#65039; </a>
	<a id="pedalò" class="ristorante" style="font-size:80px;z-index:2;position:absolute;top:-25px;left:125px"> &#128676;</a>
	<a id="runner" style="font-size:50px;z-index:2;position:absolute;top:75px;left:390px">&#127939;  </a>
	<a id="granchio1" style="font-size:15px;z-index:2;position:absolute;top: 100px;left: 910px;"> &#129408; </a>
	<a id="granchio2" style="font-size:15px;z-index:2;position:absolute;  top:80px;left: 900px;"> &#129408; </a>
	
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
	
	<a id="ristorante" class="ristorante"   style="font-size:60px;z-index:2;position:absolute;top:846px;left:483px;">&#127860;</a>
	
	<a id="doccia1" class="img_doccia"  style="top:850px;left:647px;">&#128705;</a> 
	<a id="doccia2" class="img_doccia"  style="top:870px;left:647px;">&#128705;</a> 
	<a id="doccia3" class="img_doccia"  style="top:890px;left:647px;">&#128705;</a> 
	<a id="doccia4" class="img_doccia"  style="top:910px;left:647px;">&#128705;</a> 
	
	
	<a id="ombrellone21" class="img_ombrellone" style=" top:820px;left:80px; ">&#9969;&#65039;</a> 
	<a id="ombrellone22" class="img_ombrellone" style=" top:820px;left:240px; ">&#9969;&#65039;</a> 
	<a id="ombrellone23" class="img_ombrellone" style=" top:820px;left:720px; ">&#9969;&#65039;</a> 	
	<a id="ombrellone24" class="img_ombrellone" style=" top:820px;left:870px; ">&#9969;&#65039;</a>  
</div>



<div id="div_show" class="form_css">


<h3>Dati ombrellone</h3>
<hr>

<form action="">

<div class="dati">
  <fieldset >
  <legend>Dati generali</legend>
	  ID-Ombrellone:<br><input id="id_ombr" name="id_ombr_form" type="text" readonly value=" "><br><br>
	  Libero:<br><input id="libero" name="stato_ombr_form" type="text" readonly value=""><br><br>
	  Zona:<br><input id="zona_ombr" name="zona_ombr_form" type="text" readonly value=""><br><br>
	  Prezzo ombrellone €/pz:<br><input id="prezzo_ombr" name="prezzo_ombr_form" type="text" readonly value=""><br><br>
  </fieldset>
  </div>

<div class="dati2">
  <fieldset >
  
  <legend>Dati Prenotazione Cliente</legend>

    <div class="dati2">
    Numero persone: <br><input id="num_persone" name="num_persone_form" type="text" readonly value=""><br>  
    <i class="fa fa-exclamation-triangle" aria-hidden="true"> Max 5 persone</i>
    <br><br>
    Numero lettini:<br><input id="num_lettini" name="num_lettini_form" type="text" readonly value=""><br>
    <i class="fa fa-exclamation-triangle" aria-hidden="true"> Max 3 lettini</i>
    <br><br>
    Numero sdraio:<br><input id="num_sdraio" name="num_sdraio_form" type="text" readonly value=""><br>
    <i class="fa fa-exclamation-triangle" aria-hidden="true"> Max 3 sdraio</i>
   </div>
   
  <div style="float:left;">
  	Nome cliente:<br>
  	<input id="nome_cliente" name="nome_cliente_form" type="text" readonly value=""><br>
  	Cognome cliente:<br>
  	<input id="cognome_cliente" name="cognome_cliente_form" type="text" readonly value=""><br>
  	Telefono:<br>
  	<input id="tel_cliente" name="tel_cliente_form" type="text" readonly value=" "><br>
  </div>


  
  </fieldset>
</div>
  <div class="dati">
  <fieldset >
  	<legend>Stato Pagamento Cliente</legend>
  	Pagamento: <br>
  	<input id="pagato" name="pagamento_form" type="text" readonly value="">
  </fieldset>
</div>  
  
</form>

</div>
</div>
