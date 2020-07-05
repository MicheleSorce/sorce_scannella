<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="pkg.bean.ClientePrenotaDoccia" %>

<link href="../css/Mappa.css" type="text/css" rel="stylesheet">

<!-- Colora la doccia rosso o verde a seconda se era libera o occupata -->
	<%	for(int i=1;i<5;i++){
			if(session.getAttribute("docciaPrenotata"+i)!=null){
				ClientePrenotaDoccia d=(ClientePrenotaDoccia) session.getAttribute("docciaPrenotata"+i);
				
				
				String docc = "doccia"+i;
				String data2 = d.getData_prenotazione();
				
				
				int slot2 = d.getSlot_orario();
				
				
				String slot_orario=" ";
				if(slot2==1){
					slot_orario="9:00-9:40";
				}if(slot2==2){
					 slot_orario="10:00-10:40";
				}if(slot2==3){
					 slot_orario="11:00-11:40";
				}if(slot2==4){
					 slot_orario="12:00-12:40";
				}if(slot2==5){
					 slot_orario="15:00-15:40";
				}if(slot2==6){
					 slot_orario="16:00-16:40";
				}if(slot2==7){
					 slot_orario="17:00-17:40";
				}if(slot2==8){
					 slot_orario="18:00-18:40";
				}if(slot2==9){
					 slot_orario="19:00-19:40";
				}if(slot2==10){
					 slot_orario="20:00-20:40";
				}	
				
		
			%>
			<script type="text/javascript">
				$("#data").text("<%=data2%>");
				$("#slot_orario").text("<%=slot_orario%>");
				$(<%=docc%>).css("background-color","#ff0700");//rosso	
				
			</script>		
		<%		session.removeAttribute("docciaPrenotata"+i);
			}
	}	
		
	%>
	
<script type="text/javascript">

$(document).ready(function() {
    
	
	
	$(".img_doccia_d").click(function() {
		var id=$(this).attr("id");
		var data2= $("#data").text();
		var slot_orario2= $("#slot_orario").text();
		var color = $( this ).css( "background-color" );
	
		$.post("../BagninoServlet", { 
    		operazione: "dati_prenotazione_doccia",
    		id_doccia : id,
    		data2: data2,
    		slot_orario2: slot_orario2
    		}, function(data, status) {
	         if (status == "success"){
	          
  				$("#id_doccia").attr("value", data.id);			
	   			if(color == "rgb(255, 7, 0)"){
					$("#libero").attr("value", "No");	
				}else{
					$("#libero").attr("value", "Si");	
				}	      
	   			
	   			if(data.accesso =="true"){
	   				$("#disabile_doccia").attr("value", "Si");	
	   			}else{
	   				$("#disabile_doccia").attr("value", "No");	
	   			}
 					
 				
 				if(data.nome == "null"){
 					$("#nome_cliente").attr("value","Non disponibile");
 				}else{
 					$("#nome_cliente").attr("value",data.nome);
 				}
				
 				if(data.cognome == "null"){
 					$("#cognome_cliente").attr("value","Non disponibile");
 				}else{
					$("#cognome_cliente").attr("value",data.cognome);
 				}
 				
 				if(data.telefono == "null"){
 					$("#tel_cliente").attr("value","Non disponibile");
 				}else{
					$("#tel_cliente").attr("value",data.telefono);
 				}
 				// location.href = "#div_show"; 
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
	<h4>Clicca sulla doccia desiderata per ottenere maggiori informazioni.</h4>
	
	<i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i>
	<hr width="300px"/>
</div>
	 <h2 id="data" style="text-align: center; color: blue;"></h2><h2 id="slot_orario" style="text-align: center; color: blue;"></h2>
	
	<br><br>
	

<div id="div_show" class="form_css_bagnino" >


<h3>Dati doccia</h3>
<hr>

<form >

<div class="" >
  <fieldset >
  <legend>Dati generali</legend>
	  ID-Doccia:<br><input id="id_doccia" type="text" readonly value=" "><br>
	  Libero:<br><input id="libero" type="text" readonly value=" "><br>
	  Accesso Disabile:<br><input id="disabile_doccia"  type="text" readonly value=" "><br><br>
	  
  </fieldset>
  </div>

<div class="" >
  <fieldset >
  
  <legend>Dati Cliente referente</legend>
   
  <div style="float:left;">
  	Nome cliente:<br>
  	<input id="nome_cliente" type="text" readonly value=""><br>
  	Cognome cliente:<br>
  	<input id="cognome_cliente"  type="text" readonly value=""><br>
  	Telefono:<br>
  	<input id="tel_cliente" type="text" readonly value=" "><br>
  </div>

  </fieldset>
</div>

</form>

</div>
 <div  class="contenitore_docce">
 
	
	<a id="ristorante" class="ristorante"   style="top: 220px;left: 228px;">&#127860;</a>
	
	<a id="doccia1" class="img_doccia_d"  style="top: 223px;left: 420px;">&#128705;</a> 
	<a id="doccia2" class="img_doccia_d"  style="top:245px;left:420px;">&#128705;</a> 
	<a id="doccia3" class="img_doccia_d"  style="top:267px;left:420px;">&#128705;</a> 
	<a id="doccia4" class="img_doccia_d"  style="top:287px;left:420px;">&#128705;</a> 
	
</div>


</div>
