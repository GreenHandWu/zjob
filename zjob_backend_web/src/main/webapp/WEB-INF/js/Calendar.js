<script language="JavaScript" type="text/JavaScript">
<!--

var i_dag=new Date();
var dag = i_dag.getDate();
var maaned = i_dag.getMonth()+1;
var maanednu,aarnu,Calendarformfelt
var aar = i_dag.getYear();
var dage = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
var monthname = new Array("January","February","March","April","May","June","July","August","September","October","November","December")
var useSunday = <%IF Aspdatagrid.USCalendar then response.write("1") else response.write("0")%>

function updateform(dagen, feltet)
{
var laget = document.getElementById('Calendar1');
if (!aarnu) aarnu = aar
if (!maanednu) maanednu = maaned
eval("document.forms[0]."+feltet).value = dagen+" "+(monthname[maanednu-1])+", "+aarnu;
laget.style.visibility = "hidden"
laget.style.zindex = 100
resetlag()
}

function closecalendar()
{
var laget = document.getElementById('Calendar1');
laget.style.visibility = "hidden"
laget.style.zindex = 100
resetlag()
}

function resetlag()
{
var laget = document.getElementById('Calendar1');
laget.style.left=(0);
laget.style.top=(0);
aarnu = aar;
maanednu = maaned;
}

function flyt() { 
 var Calendarlayer,Left,Top,TheField,parentoffset,x,y,innerx,innery,Totalx,Totaly;
 		Calendarlayer=document.getElementById('Calendar1')
		Calendarlayer.style.visibility = "visible"
 		Left=-10;
		Top=25;
		innerx=0;
		innery=0;
 		TheField="document.all['"+Calendarformfelt+"']";
		Parentoffset=".offsetParent";
		x=parseInt(eval(TheField+Parentoffset+".offsetLeft"));
		y=parseInt(eval(TheField+Parentoffset+".offsetTop"));
		innerx=parseInt(eval(TheField+".offsetLeft"));
		innery=parseInt(eval(TheField+".offsetTop"));
		Totalx=parseInt(x+innerx+Left);
		if (Totalx < 5) Totalx = 25;
		Totaly=parseInt(y+innery+Top);
		if (Totaly < 5) Totaly = 25;
  		Calendarlayer.style.left=Totalx+'px';
		Calendarlayer.style.top=Totaly+'px';
}





function skift(antal)
{
if (!aarnu) aarnu = aar
if (!maanednu ) maanednu = maaned + antal;
else
 maanednu = maanednu + antal;
 
if (maanednu<1){
 maanednu = maanednu +12 
 aarnu = aarnu -1
 }
if (maanednu >12){
 maanednu = maanednu-12
 aarnu = aarnu+1
 }
 kalender(aarnu,maanednu)
}

function kalender(ar,mnd)
{ 
var laget = document.getElementById('Calendar1');
var indhold;
i_dag = new Date(ar,mnd-1,1);
start = i_dag.getDay();
if (!useSunday) {
if (start==0) start =6
else
start = start -1
}

if((ar % 4 ==0 && ar % 100 !=0)|| 
 ar % 400 == 0) dage[1]=29;
else dage[1]=28;

indhold ="<TABLE CELLSPACING=0 CELLPADDING=2 BORDER=0 class=\"Frame\">";
indhold+="<TR><TD>";
indhold+="<TABLE CELLSPACING=0 CELLPADDING=2 BORDER=0 class=\"CalendarTable\">";
indhold+=" <th class=\"Calendartabelhead\">";
indhold+=" <Th onClick=\"skift(-12)\" class=\"CalendartabelheadHand\"><<</Th>";
indhold+=" <td colspan=3 class=\"Calendartabelhead\">"+ar+"<Th  onClick=\"skift(12)\" class=\"CalendartabelheadHand\">>></th>";
indhold+=" <Th onClick=\"closecalendar()\" class=\"CalendartabelheadHand\">x</th>";
indhold+="<TR><th class=\"Calendartabelhead\">";
indhold+="<Th onClick=\"skift(-1)\" class=\"CalendartabelheadHand\"><</Th></th>";
indhold+="<th colspan=3 class=\"Calendartabelhead\">"+mnd+"</th><Th  onClick=\"skift(1)\" class=\"CalendartabelheadHand\">></th>";
indhold+="<Th class=\"Calendartabelhead\"></th>";
if (useSunday) {
indhold+="<TR><TH class=\"Calendarweekdays\">S</TH><TH class=\"Calendarweekdays \">M</TH><TH class=\"Calendarweekdays \">T</TH>";
indhold+="<TH class=\"Calendarweekdays \">W</TH>";
indhold+="<TH class=\"Calendarweekdays \">T</TH><TH class=\"Calendarweekdays \">F</TH><TH class=\"Calendarweekdays \">L</TH></TR>";
}
else
{
indhold+="<TR><TH class=\"Calendarweekdays \">M</TH><TH class=\"Calendarweekdays \">T</TH><TH class=\"Calendarweekdays \">O</TH>";
indhold+="<TH class=\"Calendarweekdays \">T</TH>";
indhold+="<TH class=\"Calendarweekdays \">F</TH><TH class=\"Calendarweekdays \">L</TH><TH class=\"Calendarweekdays \">S</TH></TR>";
}

indhold+="<TR ALIGN=RIGHT>";

var celle =0;
for(i=0; i<start; i++)
{
indhold+="<TD>&#160;</TD>";
celle ++;
}
for (i=1; i<=dage[mnd-1]; i++)
{
if ((dag==i)&&(mnd==maaned)&&(ar==aar))
indhold+="<TD onClick=\"updateform("+i+",Calendarformfelt)\" class=\"Calendarcell\" ><B>"+i+"</B></TD>";
else indhold+="<TD onClick=\"updateform("+i+",Calendarformfelt)\" class=\"Calendarcell\">"+i+"</td>";
celle ++
if (celle==7)
{
indhold+="</TR><TR ALIGN=RIGHT>";
celle=0;
}
}
indhold+="</TR></TABLE>";
indhold+="</td></TR></TABLE>";
laget.innerHTML = indhold;
}
//-->
</script>
