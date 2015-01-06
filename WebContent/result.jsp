<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.mongodb.*" %>
<%@page import="java.io.*" %>
<%@page import="java.lang.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Result</title>
</head>
<body>
<%
DBCollection level,quest,profile;
MongoClient mongo=new MongoClient("localhost",27017);
DB db=mongo.getDB("Type");

level=db.getCollection("level");
quest=db.getCollection("quest");
profile=db.getCollection("profile");

String username=session.getAttribute("userid").toString();


long endTime=System.currentTimeMillis();
long startTime=Long.valueOf(request.getParameter("start")).longValue();
long timediff=(endTime-startTime)/1000;
String typed=request.getParameter("mypara");
String original=request.getParameter("para");

char[] type=typed.toCharArray();
char[] orig=original.toCharArray();

int stge=Integer.parseInt(request.getParameter("stge"));

int origlen=original.length();
int typelen=typed.length();

int count=0;
int space=0;
for(int i=0;i<origlen;i++)
{
	if(typelen==i)
	{
		count+=origlen-i;
		break;
	}
	
	else
	{
		if(type[i]==' ')
		{
			space+=1;
			
		}
		if(type[i]!=orig[i])
		{
			count+=1;
		}
	}
}

double success=((origlen-count)*(100))/(origlen*1.0);
int words=space+1;
//System.out.println("typedlen:"+typelen);
if(type[0]==' '&& typelen==1)
{
	words=0;
}
//System.out.println("wpm"+words);
double min=timediff/60.0;
double wpm=words/min;

BasicDBObject query=new BasicDBObject();
query.put("stage",stge);

DBCursor cursor=quest.find(query);
DBObject obj=cursor.next();
double ttime=(Double)obj.get("time");
double accuracy=(Double)obj.get("acc");

if(timediff<=ttime && success>=accuracy)
{
	BasicDBObject qry=new BasicDBObject();
	qry.put("username",username);
	DBCursor csr=level.find(qry);
	DBObject ob=csr.next();
	int st=(Integer)ob.get("stage");
	
	BasicDBObject myqur1=new BasicDBObject();
	myqur1.put("username",username);
	DBCursor mycsr=profile.find(myqur1);
	DBObject myob=mycsr.next();
	String mylvl;
	mylvl="level_"+stge;
	
	DBObject innerlvl=(DBObject)myob.get(mylvl);
	Double tt,cc,ww;
	tt=(Double)innerlvl.get("btime");
	cc=(Double)innerlvl.get("bacc");
	ww=(Double)innerlvl.get("bwpm");
	
	Double dble=timediff/60.0;
	if(tt > dble)	tt=dble;
	if(cc < success)	cc=success;
	if(ww < wpm) ww=wpm;
	
	BasicDBObject myqry1=new BasicDBObject();
	myqry1.put("bacc",cc);
	myqry1.put("btime",tt);
	myqry1.put("bwpm",ww);
	
	BasicDBObject myqry2=new BasicDBObject();
	myqry2.put(mylvl,myqry1);
	BasicDBObject myset=new BasicDBObject("$set",myqry2);
	BasicDBObject srch=new BasicDBObject();
	srch.put("username",username);
	profile.update(srch,myset);
	

	if(st==stge)
	{	//System.out.println("in if condition");
		int point=st*100;
		//System.out.println("points"+point);
		BasicDBObject qry1=new BasicDBObject();
		qry1.put("username",username);
		qry1.put("stage",stge+1);
		qry1.put("points",point);
		BasicDBObject myname=new BasicDBObject();
		myname.put("username",username);
		level.update(myname,qry1);	
	}
	
	
	out.println("<center>");
	out.println("<h2>RESULTS</h2>");
	%>
	
		<h4>Paragraph which had to be typed</h4>
		<br>
		<textarea readonly cols="100" rows="20" name="para" Style="font-size: 12px;"><%=original%></textarea>
		<br><br>
		<h4>Paragraph which you typed</h4>
		<br>
		<textarea readonly cols="100" rows="20" name="mypara" Style="font-size: 12px;"><%=typed%></textarea>
		<br><br>

	<% 
	
	out.println("<h3>Accuracy :"+success+"<h3>");
	out.println("<h3>Words per Minute :"+wpm+"<h3>");
	out.println("<h3>Time in Seconds:"+timediff+"<h3>");
	out.println("<h1>Congratulations!! You have successfully completed this level</h1>");
	out.println("<center> <a href="+"'home.jsp'"+">Back To Home</a><center>");
	out.println("</center");
	
	
	
	
}
else
{
	out.println("<center>");
	out.println("<h2>RESULTS</h2>");
	
	%>
	
	<h4>Paragraph which had to be typed</h4>
	<br>
	<textarea readonly cols="100" rows="20" name="para" Style="font-size: 12px;"><%=original%></textarea>
	<br><br>
	<h4>Paragraph which you typed</h4>
	<br>
	<textarea readonly cols="100" rows="20" name="mypara" Style="font-size: 12px;"><%=typed%></textarea>
	<br><br>

<% 
	
	out.println("<h3>Accuracy :"+success+"<h3>");
	out.println("<h3>Words per Minute :"+wpm+"<h3>");
	out.println("<h3>Time in Seconds:"+timediff+"<h3>");
	out.println("<h1>TRY AGAIN!!!!</h1>");
	out.println("<center> <a href="+"'home.jsp'"+">Back To Home</a><center>");
	out.println("</center");
	
}





%>


</body>
</html>