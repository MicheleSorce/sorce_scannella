<%@page import="javax.swing.text.Document"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="pkg.bean.ClientePrenotaOmbrellone" %>
<link href="../css/Mappa.css" type="text/css" rel="stylesheet">

	
	
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
 <div  class="contenitore" >
	<a id="surfista"style="font-size:50px;z-index:2;position:absolute;top:5px;left: 990px"> &#127940;&#8205;&#9794;&#65039; </a>
	<a id="pedalò" class="ristorante" style="font-size:80px;z-index:2;position:absolute;top:-25px;left:125px"> &#128676;</a>
	<a id="runner" style="font-size:50px;z-index:2;position:absolute;top:75px;left:390px">&#127939;  </a>
	<a id="granchio1" style="font-size:15px;z-index:2;position:absolute;top:110px;left:990px"> &#129408; </a>
	<a id="granchio2" style="font-size:15px;z-index:2;position:absolute; top:120px;left:1010px"> &#129408; </a>
	
	<a id="ombrellone1" class="img_ombrellone ombrellone_pos " style="top:19%;left: 4% ;">&#9969;&#65039;</a>
	<a id="ombrellone2" class="img_ombrellone ombrellone_pos " style="top:19%;left:13%;">&#9969;&#65039;</a>
	<a id="ombrellone3" class="img_ombrellone ombrellone_pos " style="top:19%;left:21%;">&#9969;&#65039;</a>
	<a id="ombrellone4" class="img_ombrellone ombrellone_pos " style="top:19%;left:35%;">&#9969;&#65039;</a> 
	<a id="ombrellone5" class="img_ombrellone ombrellone_pos " style="top:19%;left:44%;">&#9969;&#65039;</a>
	<a id="ombrellone6" class="img_ombrellone ombrellone_pos " style="top:19%;left:53%;">&#9969;&#65039;</a>
	
	<a id="ombrellone7" class="img_ombrellone ombrellone_pos" style=" top:370px;">&#9969;&#65039;</a>
	<a id="ombrellone8" class="img_ombrellone ombrellone_pos " style=" top:370px;left:13%;">&#9969;&#65039;</a>
	<a id="ombrellone9" class="img_ombrellone ombrellone_pos " style=" top:370px;left:21%;">&#9969;&#65039;</a>
	<a id="ombrellone10" class="img_ombrellone ombrellone_pos" style=" top:370px;left:35%;">&#9969;&#65039;</a> 
	<a id="ombrellone11" class="img_ombrellone ombrellone_pos" style=" top:370px;left:44%;">&#9969;&#65039;</a>
	<a id="ombrellone12" class="img_ombrellone ombrellone_pos" style=" top:370px;left:53%;">&#9969;&#65039;</a>
	
	<a id="ombrellone13" class="img_ombrellone ombrellone_pos" style=" top:510px;left:13%;">&#9969;&#65039;</a>
	<a id="ombrellone14" class="img_ombrellone ombrellone_pos" style=" top:510px;left:21%;">&#9969;&#65039;</a>
	<a id="ombrellone15" class="img_ombrellone ombrellone_pos" style=" top:510px;left:35%;">&#9969;&#65039;</a> 
	<a id="ombrellone16" class="img_ombrellone ombrellone_pos" style=" top:510px;left:44%;">&#9969;&#65039;</a>  
	 	
	<a id="ombrellone17" class="img_ombrellone ombrellone_pos" style=" top:680px;left:4%;">&#9969;&#65039;</a> 	
	<a id="ombrellone18"class="img_ombrellone ombrellone_pos" style=" top:680px;left:13%;">&#9969;&#65039;</a> 
	<a id="ombrellone19" class="img_ombrellone ombrellone_pos" style=" top:680px;left:35%;">&#9969;&#65039;</a> 	
	<a id="ombrellone20" class="img_ombrellone ombrellone_pos" style=" top:680px;left:44%;">&#9969;&#65039;</a> 
	
	<a id="ristorante" class="ristorante"   style=" top:846px;left:483px;">&#127860;</a>
	
	<a id="doccia1" class="img_ombrellone ombrellone_pos"  style="font-size:20px;z-index:2;position:absolute;top:850px;left:647px;">&#128705;</a> 
	<a id="doccia2" class="img_ombrellone ombrellone_pos"  style="font-size:20px;z-index:2;position:absolute;top:870px;left:647px;">&#128705;</a> 
	<a id="doccia3" class="img_ombrellone ombrellone_pos"  style="font-size:20px;z-index:2;position:absolute;top:890px;left:647px;">&#128705;</a> 
	<a id="doccia4" class="img_ombrellone ombrellone_pos"  style="font-size:20px;z-index:2;position:absolute;top:910px;left:647px;">&#128705;</a> 
	
	
	<a id="ombrellone21" class="img_ombrellone ombrellone_pos" style=" top:820px;left:4%;">&#9969;&#65039;</a> 
	<a id="ombrellone22" class="img_ombrellone ombrellone_pos" style=" top:820px;left:13%;">&#9969;&#65039;</a> 
	<a id="ombrellone23" class="img_ombrellone ombrellone_pos" style=" top:820px;left:35%;">&#9969;&#65039;</a> 	
	<a id="ombrellone24" class="img_ombrellone ombrellone_pos" style=" top:820px;left:44%;">&#9969;&#65039;</a>  




</div>

<div class="info_ombrelloni">ciaook</div>



	<%	for(int i=1;i<25;i++){
			if(session.getAttribute("ombrellonePrenotato"+i)!=null){			
				session.removeAttribute("ombrellonePrenotato"+i);
			}
		}
	%>
	