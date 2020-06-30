<%@page import="pkg.bean.Piatto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>

   <%  
   
   for(int i=1;i<15;i++){// 15 piatti nel menu
      if(session.getAttribute("piatto"+i)!=null){
    	  
    	 Piatto piatto=(Piatto) session.getAttribute("piatto"+i);
    	 int id_lista=0;
         if(("bibita").equals(piatto.getTipo())){//se è una bevanda   
        	 String bibita= piatto.getNome()+"______________"+piatto.getPrezzo();
         	 id_lista+=1;
         	 String id_lista_bevanda= "bevanda"+id_lista;
           %>
           
       	      <script type="text/javascript">      	      
        	        $("#bibita").append("<li id='<%=id_lista_bevanda%>'><%=bibita%></li>");
       	      </script>    
   	    	<%     
         }
         if(("cibo").equals(piatto.getTipo())){//se è un cibo
        	 String cibo= piatto.getNome()+"______________"+piatto.getPrezzo();
        	 id_lista+=1;
        	 String id_lista_cibo= "cibo"+id_lista;
             %>
             
      	      <script type="text/javascript">      	      
       	        $("#cibo").append("<li id='<%=id_lista_cibo%>'><%=cibo%></li>");
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
.elementi_menu{
	text-align: left;
}
li{

	text-align: center;
}
</style>      
    <div id="menu">
    <h2>Menu MSBeach</h2>
    <hr>
    <h3>Bibita</h3>
	    <ul class="elementi_menu" id="bibita">
	    </ul>
    
    <h3>Panini e Insalate</h3>
    	<ul class="elementi_menu" id="cibo">
    	</ul>
    </div>