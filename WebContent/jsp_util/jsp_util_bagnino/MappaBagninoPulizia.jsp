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
	
 $(".img_ombrellone").click(function() {
		var id=$(this).attr("id");
		
		var color = $( this ).css( "background-color" );
		$("#radio1").removeAttr("checked"); 
		$("#radio2").removeAttr("checked"); 
		
		$.post("../BagninoServlet", { 
    		operazione: "dati_prenotazione_ombrellone",
    		id_ombrellone : id,
    		slot_orario: slot_orario_o,
    		data: data
    		
    		}, function(data, status) {
	         if (status == "success"){
	        	
  				$("#id_ombr").attr("value", data.id);
  				$("#zona_ombr").attr("value", data.zona  );	
  				$("#pulizia_ombr").attr("value", data.stato_pulizia  );	

  				
				
				if(data.stato_pulizia=="true"){
					$("#radio1").attr("checked","checked");
				 
				}
				if(data.stato_pulizia=="false"){
				
					$("#radio2").attr("checked","checked");
					
				}
				
				
  				
	   			if(color == "rgb(255, 7, 0)"){
					$("#libero").attr("value", "No");
					$("#radio1").attr("disabled","disabled");
					$("#radio2").attr("disabled","disabled");
					$("#radio2").attr("checked","checked");
					$("#aggiorna_pulizia").attr("disabled", "disabled");
				}else{
					$("#libero").attr("value", "Si");
					$("#radio1").removeAttr("disabled"); 
					$("#radio2").removeAttr("disabled"); 
					$("#aggiorna_pulizia").removeAttr("disabled");
					
					
				}	 	
	         }
	         
	 
     });
    }); 

 $("#aggiorna_pulizia").click(function() {
		
		var stato_pulizia = $('input[name="pulito"]:checked').val();
		$.post("../BagninoServlet", { 
	  		operazione : "pulizia_spiaggia",
	  		id_ombr_pulire : $("#id_ombr").val(),
		    isPulito : stato_pulizia,
 		
  		}, function(data, status) {
       if (status == "success")	 
    	   if(data=="true"){
           	alert("Stato pulizia aggiornato");
			
    	   }
       if(data=="false"){
       		alert("Errore aggiornamento stato pulizia.\nRiprova.");

       }
			
      });
 }); 
 
 
	     
    
   
    
});



</script>


<div>
<br><br><br>
<div style="text-align:center; ">
	<hr width="300px"/><div><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i></div> <br/>
	<div> <h2 id="data"></h2><h2 id="slot_orario"></h2></div>
	<h4>Clicca sull'ombrellone desiderato per ottenere maggiori informazioni.</h4>
	<i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>
	<hr width="300px"/><br>
	
	
</div>
	 <h2 id="data" style="text-align: center; color: blue;"></h2><h2 id="slot_orario" style="text-align: center; color: blue;"></h2>
	

	

<div class="form_css_pul">

<form id="div_show" >
<br>
	<fieldset>
	<legend>Dati generali</legend>
	
	ID-Ombrellone:<br><input id="id_ombr"  type="text" readonly value=" "><br><br>
	Libero:<br><input id="libero"  type="text" readonly value=""><br><br>
	Zona:<br><input id="zona_ombr" type="text" readonly value=""><br><br>
	Pulito:<br><input id="pulizia_ombr" type="text" readonly value=""><br><br>
	
	</fieldset>
<br><br>
	<fieldset>
	<legend id="stato_pulizia" >Stato pulizia</legend>
		<input type="radio" id="radio1" name="pulito" value="pulito" />Disinfettato e pulito<br/>
		<input type="radio" id="radio2" name="pulito" value="non_pulito" />Da Disinfettare e da pulire
		<br><br>
		<input style="margin-right: 3px;"type="button" id="aggiorna_pulizia" value="Aggiorna" />
	</fieldset>
</form>
</div>


 <div  class="contenitore_pul" style="margin-left: 30%;" >
 
	<a id="surfista"  style="font-size:50px;z-index:1;position:absolute;top:5px;left: 990px"> &#127940;&#8205;&#9794;&#65039; </a>
	<a id="pedalò" class="ristorante" style="font-size:80px;z-index:1;position:absolute;top:-25px;left:125px"> &#128676;</a>
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

