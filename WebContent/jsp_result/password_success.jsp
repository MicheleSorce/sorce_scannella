<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dati corretti</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js" ></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<style>

body {
  padding: 0;
    margin: 0;
    font-family: 'Lato';
  text-align: center;
}

#intro-text {
  position: relative;
  animation: mymove 5s;
}

@keyframes mymove {
  from {left: -200px;}
  to {left: 0px;}
}

.section {
    padding-top: 40px;
    font-size: 1em;
    text-align: center;
    background: #f1ede3;
    width: 100%;
    height: 800px;
    color: #555;
  
}

.time-circle {
  position: relative;
  background: linear-gradient(to bottom, #BE4405, #F6C60C);
  width: 400px;
  height: 400px;
  border-radius: 50%;
  border: 4.5px solid #555;
  overflow: hidden;
  padding: 0px;
  margin: 0 auto;
  margin-bottom: 10px;
  box-shadow: 0 0 20px rgba(0,0,0,0.4);
  text-align: center;

 
}
.night .time-circle{
  background: linear-gradient(to bottom, #111936, #285A7B);
  border-color: #e9e5d5;
}
.sun {
  margin-top: 20px;
  background: #F2EF88;
  box-shadow: 0 0 20px rgba(242, 239, 136, 0.4);
  width: 30%;
  height: 30%;
  border-radius: 50%;
  position: relative;
  left: 35%;
  top: 48%;

  -webkit-animation: pulse 5s ease infinite alternate;
    animation: pulse 5s ease infinite alternate;

}
@keyframes pulse {
    0% {box-shadow: 0 0 20px rgba(242, 239, 136, 0.4);}
    50% {box-shadow: 0 0 40px rgba(242, 239, 136, 1);}
    100% {box-shadow: 0 0 20px rgba(242, 239, 136, 0.4);}
}
@-webkit-keyframes pulse {
    0% {box-shadow: 0 0 20px rgba(242, 239, 136, 0.4);}
    50% {box-shadow: 0 0 40px rgba(242, 239, 136, 1);}
    100% {box-shadow: 0 0 20px rgba(242, 239, 136, 0.4);}
}
.night .sun {
  top: 70%;
  left: 20%;

  
}

.night  {
  left: 65%;
  top: -10%;

 
}


.water {
  position: absolute;
  background: repeating-radial-gradient(ellipse farthest-corner at center -400%, #f5c30e 30%, #518eac 90%) repeat scroll 0 0 #518eac;
  width: 100%;
  height: 200px;
  top: 68%;

 
}
.water{
  background: repeating-radial-gradient(ellipse farthest-corner at center -400%, #7fa1bb 30%, #1d425a 90%) repeat scroll 0 0 #1d425a;
}



</style>



<body>
<div class="section">
   <div class="time-circle">
         <div class="sun"></div>
         <div class="water"></div>
   </div>
   <div id="intro-text">
         <h1 >&#9989; La password è stata inserita con successo.</h1>
         <h1> Adesso puoi effettuare il login.</h1>
         <a href="html/logIn.html" style="margin-left: 45%;" >Accedi </a>
   </div>


</div>
</body>
