<%@page import="java.util.ArrayList" %>
<%@page import="pkg.bean.Piatto"%>
<%@page import="pkg.bean.ClientePrenotaPiatto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>

<style>
#menu{
	
	width: 40%;
	background-image: linear-gradient(to top left, #FFFFFF 0%, #4293ff 100%);

    color: #eaffff;
    margin-left: 15%;
    text-align: center;
    border: 2px solid #eaffff;
    padding: 30px;
    border-radius: 6px 6px 6px 6px;
    }
#resoconto{
	float: right;
	
	width: 40%;
	background-image: linear-gradient(to top right, #FFFFFF 0%, #4293ff 100%);
    color: #eaffff;
    margin-left: 45%;
    text-align: center;
    border: 2px solid #eaffff;
    padding: 30px;
    margin-top: -541px;
    border-radius: 6px 6px 6px 6px;
    }    

button{
	 background-color: #1a70f0;
	 color: white;
	 padding: 8px 8px;
	 margin: 2px 0px;
	 border: none;
	 cursor: pointer;
	 width: 40%;
	 opacity: 0.9;
	 font-size: 15px;
}

#info{
	text-align: left;
	font-size: 15px; 
}
.elementi_menu{
	width: 100%;
	text-align: center;
}
.elementi_menu th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: center;
  background-color: #1a70f0;
  font-style:italic;
  color: white;
}
td.Td3{ 
 	text-align: center; 
 } 
.elementi_menu td:hover {
	background-color: #5ca2ff;
}
.elementi_menu tr:hover {
	background-color: #1a70f0;
}

	text-align: center;
}
</style> 


<%  
  int elementi=16;
  int id_lista=0;
   

  for(int i=1;i<elementi;i++){// 15 piatti nel menu
      if(session.getAttribute("piatto"+i)!=null){
    	 
    	  
    	  
    	 Piatto piatto=(Piatto) session.getAttribute("piatto"+i);
    	 
         if(("bibita").equals(piatto.getTipo())){//se è una bevanda 
        	
        	String bibita= piatto.getNome();
         	String prezzo= piatto.getPrezzo()+"€";
         	
         	
        	int disponibilita= piatto.getDisponibilita();
        	
         	if(piatto.getMenu_giorno()==true){
            	 bibita= "*  "+bibita;
             }
        	 
         	
         	 id_lista =i;
         	 String id_lista_bevanda= "bevanda"+id_lista;		//id=bevanda1
         	
         	
         	 String id_qnt_bevanda= "quantita_"+id_lista_bevanda;	//id=quantita_bevanda1
         	
         	 ClientePrenotaPiatto prenot= new ClientePrenotaPiatto();
         	 
         	 
         	 int quantita=0; 
         		
         	 
			 String list= "<tr> "
						+"<td id='"+id_lista_bevanda+"'>"+bibita+"</td>"
			 			+"<td class='Td3'id='prz_"+id_lista+ "'>"+prezzo+"</td>"
			 			+"<td class='Td3 qnt_class'  id='l_"+id_lista+ "'> <i  class='less fa fa-minus-circle' aria-hidden='true'></i> <input type='text' class='canc_tutto' readonly  style='width:44px'  id='"+id_qnt_bevanda+"' value='"+quantita+"'> <i class='more fa fa-plus-circle' aria-hidden='true'></i></td>"
	 					+"<td><button style='width:auto' class='btn_aggiungi' id='"+id_lista+"'>Aggiungi</button></td>"
			 			+"<tr>";

%>
           
       	      <script type="text/javascript"> 
       	      		
        	        $("#bibita").append("<%=list%>");
       	      </script>    
   	    	<%     
         }
         if(("cibo").equals(piatto.getTipo())){//se è un cibo
        	
        	 String cibo= piatto.getNome();
        	 String prezzo= piatto.getPrezzo()+"€";
        	 
	         if(piatto.getMenu_giorno()==true){
	        	 cibo= "*  "+cibo;
	         }
	         
	         id_lista =i;
        	 String id_lista_cibo= "cibo"+id_lista;
        	 String id_qnt_cibo= "quantita_"+id_lista_cibo;
          	
         	 ClientePrenotaPiatto prenot= new ClientePrenotaPiatto();
         	 
         	 int quantita=0; 
         	  
			 String list= "<tr >"
					+"<td id='"+id_lista_cibo+"'>"+cibo+"</td>"
					+"<td class='Td3' id='prz_"+id_lista+ "'>"+prezzo+"</td>"
		 			
		 			+"<td class='Td3 qnt_class'  id='l_"+id_lista+ "'> <i  class='less fa fa-minus-circle' aria-hidden='true'></i> <input type='text' class='canc_tutto' readonly style='width:44px'  id='"+id_qnt_cibo+"' value='"+quantita+"'> <i class='more fa fa-plus-circle' aria-hidden='true'></i></td>"
		 			+"<td> <button style='width:auto' class='btn_aggiungi' id='"+id_lista+"'>Aggiungi</button></td>"
		 			+"<tr>";
					
             %>
             
      	      <script type="text/javascript">      	      
       	        $("#cibo").append("<%=list%>");
      	      </script>    
  	    	<%     
         }
         session.removeAttribute("piatto"+i);
      }
   }
      
      %>
      
      
      
      
      
      
 <script>



 
 
 $(document).ready(function() {
 
	 function quantitaIncrDecr(){
	    var valore;
	    $(".qnt_class .less").click(function(){
	        valore = parseInt($(this).parent().find("input").val());
	        if (valore > 0){
	        $(this).parent().find("input").val((valore-1));
	        }
	    });
	    $(".qnt_class .more").click(function(){
	        valore = parseInt($(this).parent().find("input").val()); 
	        
	        if (valore < 20){				
	        	$(this).parent().find("input").val((valore+1));
	        }
	    });
	   
	}

	$(function(){
		quantitaIncrDecr();
	});	
	
 	
	 
	 $(".btn_aggiungi").click(function() {	
		 	var id= $(this).attr("id");
		 	$("#quantita_bevanda"+id).attr("value", "0");
			$("#quantita_cibo"+id).attr("value", "0");
		 	
		 	if(id>4 && id<11){		//per la struttura del db
		 		var ident="#cibo"+id;
				var val1= $(ident).text();
				
				
				var valore="#quantita_cibo"+id;
				var val2= $(valore).val();
		 		
		 	}else{
		 		var ident="#bevanda"+id;
				var val1= $(ident).text();
				
				var valore="#quantita_bevanda"+id;
				var val2= $(valore).val();
				
		 		
		 	}
			var prezzo="#prz_"+id; 
			var val3=$(prezzo).text();
		
			
			if(val2!=0) {
				$("#primo").attr("value", val1);
				$("#primo_prz").attr("value", val3);
				$("#primo_qt").attr("value", val2);
				
			}
			if(val2==0){
				alert("Quantità non valida.");
				$("#primo").attr("value", " ");
				$("#primo_qt").attr("value", " ");
				$("#primo_prz").attr("value", " ");
				$("#ordina_prenot").attr("readonly", "readonly");
				$("#ordina_prenot2").attr("readonly", "readonly");
			}
			
		 });
	

	 
			
	 $("#ordina_prenot").click(function() {
		
		 var id_cli= ${cliente.idCliente};
		 var dtToday = new Date();
		    
		    var day = dtToday.getDate();
		    var month = dtToday.getMonth() + 1;
		    var year = dtToday.getFullYear();

		    if(month < 10)
		        month = '0' + month.toString();
		    if(day < 10)
		        day = '0' + day.toString();

		    var date = year + '-' + month + '-' + day;    
		 
			$.post("../ClienteServlet", { 
				operazione : "prenotazione_bar",
			
				nome_piatto: $("#primo").val(),
				id_cliente: id_cli,
				quantita:$("#primo_qt").val(),
				stato_pagamento: "0",
				stato_completamento: "Ordinato",
				data_prenotazione: date
				
				}, function(data, status) {
			     	if (status == "success")
			      	if(data.res=="true"){
			      		alert("Prenotazione avvenuta correttamente");
			      		$("#primo").attr("value", " ");
						$("#primo_qt").attr("value", " ");
						$("#primo_prz").attr("value", " ");
						
					
			      	}
			     	
			    	
			     });
		});
	 
	 

	 $("#ordina_prenot2").click(function() {
		 var id_cli= ${cliente.idCliente};
		 var dtToday = new Date();
		    
		    var day = dtToday.getDate();
		    var month = dtToday.getMonth() + 1;
		    var year = dtToday.getFullYear();

		    if(month < 10)
		        month = '0' + month.toString();
		    if(day < 10)
		        day = '0' + day.toString();

		    var date = year + '-' + month + '-' + day;    
		 
			$.post("../ClienteServlet", { 
				operazione : "prenotazione_bar",
			
				nome_piatto: $("#primo").val(),
				id_cliente: id_cli,
				quantita:$("#primo_qt").val(),
				stato_pagamento: "1",
				stato_completamento: "Ordinato",
				data_prenotazione: date
				
				}, function(data, status) {
			     	if (status == "success")
			      	if(data.res=="true"){
			      		alert("La prenotazione, avvenuta correttamente, è stata pagata.");
			      		$("#primo").attr("value", " ");
						$("#primo_qt").attr("value", " ");
						$("#primo_prz").attr("value", " ");
					
			      	}

			     });
		});
	
 });
 
 </script>     
  
  <div id="menu">
	 	<img src="../immagini/logo.png" width="68px" height="60px" style="text-align: left;">
	   <h2>Menu MSBeach  </h2>
	   <div><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i><i class="fa fa-star-o" aria-hidden="true"></i></div>
	   <hr>
	   <div>Scegli la quantità di ciò che desideri e lo aggiungi all'ordine.</div><br>
	   <hr>
	   <h3 style="font-size: 20px;">Bibita</h3>
	   
	<table class="elementi_menu" id="bibita">
		<tr><th>Nome</th><th>Prezzo</th><th>Quantità</th><tr>
	</table>
	 <br><hr>		    
	   <h3 style="font-size: 20px;">Panini e Insalate</h3>
	
	<table class="elementi_menu" id="cibo">
		<tr><th>Nome</th><th>Prezzo</th><th>Quantità</th><tr>	
	</table>
	
	<hr>
	  <div id="info">*  Piatto del giorno</div>
	  	<hr>
	  	
	  
 </div>
  
      
<div id="resoconto" >
 <h3>Ordine</h3>
 <hr>
 <div style="float:left">
Nome : <input id="primo" type=text /> <br>
Prezzo: <input id="primo_prz" type=text /> <br>
Quantità: <input id="primo_qt" type=text /> <br>
 
 <br>

 </div>

 <br><br><br><br><br>
  <hr>
 	<button id='ordina_prenot'>Ordina</button>
 	<button id='ordina_prenot2'>Ordina e Paga</button>
 </div>   
      
      
  
 
 
 
 
 