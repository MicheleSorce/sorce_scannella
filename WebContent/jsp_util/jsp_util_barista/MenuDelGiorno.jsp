<%@page import="pkg.bean.Piatto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>

   <%  
   int elementi=16;
   int id_lista=0;
   
   for(int i=1;i<elementi;i++){// 15 piatti nel menu
      if(session.getAttribute("piatto"+i)!=null){
    	  
    	 Piatto piatto=(Piatto) session.getAttribute("piatto"+i);
    	 
         if(("bibita").equals(piatto.getTipo())){//se è una bevanda   
        	String bibita= piatto.getNome();
         	String prezzo= piatto.getPrezzo()+"€";
        	String checked="";
         	if(piatto.getMenu_giorno()==true){
            	 checked="checked";
             }
        	 
         	 
         	 id_lista =i;
         	 String id_lista_bevanda= "bevanda"+id_lista;
         	 String id_disp_bevanda= "disp_"+id_lista_bevanda;         	 
         	 
			 String list= "<tr>"
					 	+"<td class='Td1'><input type='checkbox' class='menu_giorno' id='"+id_lista_bevanda+"' "+checked+"  name='"+"' value='"+"'></td>"
						+"<td id='"+id_lista_bevanda+"'>"+bibita+"</td>"
			 			+"<td class='Td3'>"+prezzo+"</td>"
						+"</tr>";
			%>        
       	      <script type="text/javascript">      	      
        	        $("#bibita").append("<%=list%>");
       	      </script>    
   	    	<%     
         }
         if(("cibo").equals(piatto.getTipo())){//se è un cibo
        	 
        	 String cibo= piatto.getNome();
        	 String prezzo= piatto.getPrezzo()+"€";
        	 String checked="";
	         if(piatto.getMenu_giorno()==true){
	        	 checked="checked";
	         }
	         
	         id_lista =i;
        	 String id_lista_cibo= "cibo"+id_lista;
        	 String id_disp_cibo= "disp_"+id_lista_cibo;
        	 
			 String list= "<tr>"
					 +"<td class='Td1'><input type='checkbox' class='menu_giorno' id='"+id_lista_cibo+"' "+checked+"  name='"+"' value='"+"'></td>"
					 +"<td id='"+id_lista_cibo+"'>"+cibo+"</td>"
					 +"<td class='Td3'>"+prezzo+"</td>"
					 +"</tr>";
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
      
<style>
#menu{
	
	width: 40%;
	background-color: rgba(0,0,0,0.8);
    color: white;
    margin: auto;
    text-align: center;
    border: 2px solid white;
    padding: 30px;
    
    }

button{
	 background-color: #4c7caf;
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
  background-color: rgb(0,0,0);
  font-style:italic;
  color: white;
}
td.Td1{ 
    width: 100px;
}
td.Td3{ 
 	text-align: center; 
 } 
.elementi_menu td:hover {
	background-color: rgb(0,0,0);
}
.elementi_menu tr:hover {
	background-color: rgba(160,160,160,0.48);
}

</style>    


<script type="text/javascript">

$(document).ready(function() {
	
	var id;

 	$(".menu_giorno").click(function(){
 		
		$("#modifica_piatto_giorno").show();
		id=$(this).attr("id");
	});
	
 	$("#modifica_piatto_giorno").click(function() {

 		var Id= "#"+id;
 		var valore;
 				
 		if($(Id).prop("checked")==true) {
 		    valore = 1;
 		} 
 		if($(Id).prop("checked")==false) {
 			valore = 0;	
 		}
 		

 		$.post("../BarServlet", { 
			operazione : "modifica_piatto_giorno",
			identificativo: id,
			valore: valore
    		}, function(data, status) {
		         if (status == "success" )	{
		        	 
		        	 if(data.result=="true"){
			        	 window.alert("Piatto aggiornato nel Menu Giorno!");

		        	 } if(data.result=="false"){
			        	 window.alert("Errore aggiornamento nel Menu!");

		        	 }
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
        <div>Ogni piatto del menù del giorno viene aggiornata singolarmente</div>
    <hr>
    <h3 style="font-size: 20px;">Bibita</h3>
    
	<table class="elementi_menu" id="bibita">
		<tr><th>Menu del giorno</th><th>Nome</th><th>Prezzo</th><tr>
	</table>
			    
    <h3 style="font-size: 20px;">Panini e Insalate</h3>

	<table class="elementi_menu" id="cibo">
		<tr><th>Menu del giorno</th><th>Nome</th><th>Prezzo</th><tr>	
	</table>

	<hr>
   		<div id="info">*  Piatto del giorno</div>
   	<hr>
   	
   	<button id='modifica_piatto_giorno' hidden="">Modifica</button>
 </div>