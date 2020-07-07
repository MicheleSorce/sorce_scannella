<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="pkg.bean.ClientePrenotaDoccia" %>

<link href="../css/Mappa.css" type="text/css" rel="stylesheet">

<!-- Colora la doccia rosso o verde a seconda se era libera o occupata -->
	<%	
	String data_tit=(String)session.getAttribute("data_sess_d");
	int slot2=(Integer)session.getAttribute("slot_orario_sess_d");

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
	
	session.removeAttribute("data_sess_d");
	session.removeAttribute("slot_orario_sess_d");
	
	int count_docce_prenotate=0;
	for(int i=1;i<5;i++){
			if(session.getAttribute("docciaPrenotata"+i)!=null){
				count_docce_prenotate++;
				ClientePrenotaDoccia d=(ClientePrenotaDoccia) session.getAttribute("docciaPrenotata"+i);
				String docc = "doccia"+i;
			%>
			<script type="text/javascript">
				$(<%=docc%>).css("background-color","#ff0700");//rosso	
				
			</script>		
		<%		session.removeAttribute("docciaPrenotata"+i);
			}
		}	
		%>
	
<script type="text/javascript">



$(document).ready(function() {
	
	$("#data").text("<%=data_tit%>");
	$("#slot_orario").text("<%=slot_orario%>");
	var data= $("#data").text();
	var slot_orario= $("#slot_orario").text();
	
	if(<%=count_docce_prenotate%>==4){
		alert("Le docce sono tutte prenotate.\nScegli uno slot orario diverso.");
	}
	
	$(".img_doccia_d").click(function() {
		var id=$(this).attr("id");
		var color = $( this ).css( "background-color" );
	
		$.post("../ClienteServlet", { 
    		operazione: "dati_doccia",
    		id_doccia : id,
    		slot_orario: slot_orario,
    		data: data
    		}, function(data, status) {
	         if (status == "success"){
	          
  				$("#id_doccia").attr("value", data.id);			
	   			if(color == "rgb(255, 7, 0)"){
					$("#libero").attr("value", "No");
					$("#prenota_azione").attr("disabled", "disabled" );
				}else{
					$("#libero").attr("value", "Si");	
					$("#prenota_azione").removeAttr("disabled");
				}	      
	   			
	   			if(data.accesso =="true"){
	   				$("#disabile_doccia").attr("value", "Si");	
	   			}else{
	   				$("#disabile_doccia").attr("value", "No");	
	   			}
	         }
	         
	 
     });
    });

	
	
$("#prenota_azione").click(function() {
		
		var id1=$("#id_doccia").val();		
		var color = $( this ).css( "background-color" );
		var id_cli= ${cliente.idCliente};
		
		$.post("../ClienteServlet", { 
    		operazione: "prenota_doccia",
    		id_doccia : id1,
    		slot_orario: slot_orario,
    		data: data,
    		id_cliente: id_cli,		
			
    		}, function(data, status) {
    			if (status == "success"){
	  		           if(data.res == "true"){
	  						alert("La prenotazione è avvenuta con successo.");
	  		           }
	  		           if(data.res == "false"){  
	  		        	 alert("Errore di registrazione prenotazione.\nRiprova");
  		           }	
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
	<h4 id="doccia_prova" >Clicca sulla doccia desiderata per ottenere maggiori informazioni.</h4>
	
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
	  Accesso Disabile:<br><input id="disabile_doccia"  type="text" readonly value=" "><br>
	  
  </fieldset><br><br>
  <input style="margin-left: 35%;"  id="prenota_azione" type="submit" value="Prenota" >
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
