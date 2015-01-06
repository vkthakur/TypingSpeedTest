<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.mongodb.*" %>
<%@page import="java.io.*" %>
<%@page import="java.lang.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript" src="jquery.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Typing Test</title>
</head>
<body background="image.jpg">
<%
DBCollection level,quest;
MongoClient mongo=new MongoClient("localhost",27017);
DB db=mongo.getDB("Type");

level=db.getCollection("level");
quest=db.getCollection("quest");

String username=session.getAttribute("userid").toString();


if((session.getAttribute("userid")==null) || (session.getAttribute("userid")==""))
{
	response.sendRedirect("index.jsp");
}

if(request.getParameter("0")!=null)
{
	BasicDBObject query1=new BasicDBObject();
	BasicDBObject query2=new BasicDBObject();
	BasicDBObject set=new BasicDBObject("$set",query2);
	//search parameters..
	query1.put("username",username);
	query2.put("stage",1);
	level.update(query1,set);
	response.sendRedirect("intro.html");
	
}
if(request.getParameter("1")!=null)
{
	BasicDBObject qry=new BasicDBObject();
	qry.put("username",username);
	DBCursor csr=level.find(qry);
	DBObject obj=csr.next();
	int stg=(Integer)obj.get("stage");
	
	BasicDBObject para=new BasicDBObject();
	para.put("stage",1);
	String mypara;
	DBCursor mycsr=quest.find(para);
	DBObject myobj=mycsr.next();
	mypara=(String)myobj.get("paragraph");
	char para1[]=mypara.toCharArray();
	
	
	//out.println("stg:"+stg);
	if(stg >= 1) 
	{
		long startTime=System.currentTimeMillis();
		int ctr=0;
		out.println("<center><h3>Type the text given below</h3></center>");
		%>
		
		
		
		<form action="result.jsp" method="post">
		
		<center>
		
		<input type="hidden" value="<%=startTime %>" name="start"/>
		<input type="hidden" value="1" name="stge"/>
		
		<!-- 
			<input type="text" value="<%=mypara%>" size="10">
			<textarea cols="100" rows="20" name="para" value="<%=mypara%>"> </textarea>
		
		ondrop="return false;"
		oncopy="return false;"
		 -->

		<p id="demo"></p>
		
		<textarea  oncopy="return false;"  id="dtext" cols="100" rows="20" name="para" Style="font-size: 12px;"><%=mypara%></textarea>
		
		<br><br>
		<div id="track-color">Track: </div>
		<br><br>
		<textarea   ondrop="return false;" cols="100" rows="20" name="mypara" Style="font-size: 12px;" id="text"> </textarea>
		
		
		
		<br><br>
		<input type="submit" name="result" value="Get Result" style="width:200px;height=30px;">
		<br><br>
		</center>
		
		
		
		</form>
		
		<div>
		<label>3. keypress() Message :</label><span id="msg-keypress"></span>
		</div>
		
		<div>
		<label>3. typed key() Message :</label><span id="msg-color"></span>
		</div>
		
		<div>
		<label>3. datebase key() Message :</label><span id="msg-dcolor"></span>
		</div>
		
		<div>
		<label>1. result color() Message :</label><span id="msg-rcolor"></span>
		</div>
		
		<div>
		<label>2. Top Para() Message :</label><span id="msg-rrcolor"></span>
		</div>
		
		<div>
		<label>3. rrresult color() Message :</label><span id="msg-rrrcolor"></span>
		</div>
		
		<div id="am"></div>
		<div id="aam"></div>
		
		<script type="text/javascript">
		var count = 0,name;
		function compare(key)
		{
			$('#msg-color').html('mytype ascii value'+key);
			
			var mykey,str,para;
			para=document.getElementById("dtext").value;
			para.split('');		
			var len = para.length;
			str=para.charAt(count);
			$('#msg-rrcolor').html('str char '+str);
			mykey=str.charCodeAt(0);
			$('#msg-dcolor').html('mytype ascii value'+mykey);
			if(mykey==key)	
				{
				
			    var result = str.fontcolor("green");
			    var txt = document.getElementById("track-color");
			    var newstr = para.substr(count+1,len-1);
			    name = name + result;
			    //alert(document.getElementById("track-color").innerHTML);
			    txt.innerHTML = name + newstr;
			    $('#msg-rrrcolor').html('matched'+result);
				}
			else
				{
				var newstr = para.substr(count+1,len-1);
			    var result = str.fontcolor("red");
			    var txt = document.getElementById("track-color");
			    name = name + result;
			    txt.innerHTML = name + newstr;
			    $('#msg-rrrcolor').html('not matched'+result);
				}
			count++;
		}
		
		$('#text').keypress(function(event){
			
			$('#msg-keypress').html('keypress() is triggered!, keyCode = ' 
		              + event.keyCode + ' which = ' + event.which)
		              
			var key;
			key=event.which;
			compare(key);
			
		});
		
		
		</script>
		
		<% 
		
	}
	else
	{
		out.println("<center><h4>Please complete previous level to access this level</h4></center>");
		out.println("<center> <a href="+"'home.jsp'"+">Back To Home</a><center>");
	}
	
	
}
if(request.getParameter("2")!=null)
{
	BasicDBObject qry=new BasicDBObject();
	qry.put("username",username);
	DBCursor csr=level.find(qry);
	DBObject obj=csr.next();
	int stg=(Integer)obj.get("stage");
	
	BasicDBObject para=new BasicDBObject();
	para.put("stage",2);
	String mypara;
	DBCursor mycsr=quest.find(para);
	DBObject myobj=mycsr.next();
	mypara=(String)myobj.get("paragraph");
	
	
	//out.println("stg:"+stg);
	if(stg >= 2) 
	{
		long startTime=System.currentTimeMillis();
		out.println("<center><h3>Type the text given below</h3></center>");
		%>
		
		
		
		<form action="result.jsp" method="post">
		
		<center>
		
		<input type="hidden" value="<%=startTime %>" name="start"/>
		<input type="hidden" value="2" name="stge"/>
		
		<!-- 
			<input type="text" value="<%=mypara%>" size="10">
			<textarea cols="100" rows="20" name="para" value="<%=mypara%>"> </textarea>
		 -->

		
		<textarea oncopy="return false;" readonly  cols="100" rows="20" name="para" Style="font-size: 12px;"><%=mypara%></textarea>
		
		<br><br>
		
		<textarea  ondrop="return false;" cols="100" rows="20" name="mypara" Style="font-size: 12px;"> </textarea>
		<br><br>
		<input type="submit" name="result" value="Get Result" style="width:200px;height=30px;">
		<br><br>
		</center>
		
		
		</form>
		
		<% 
		
	}
	else
	{
		out.println("<center><h4>Please complete previous level to access this level</h4></center>");
		out.println("<center> <a href="+"'home.jsp'"+">Back To Home</a><center>");
	}
	
}
if(request.getParameter("3")!=null)
{
	BasicDBObject qry=new BasicDBObject();
	qry.put("username",username);
	DBCursor csr=level.find(qry);
	DBObject obj=csr.next();
	int stg=(Integer)obj.get("stage");
	
	BasicDBObject para=new BasicDBObject();
	para.put("stage",3);
	String mypara;
	DBCursor mycsr=quest.find(para);
	DBObject myobj=mycsr.next();
	mypara=(String)myobj.get("paragraph");
	
	
	//out.println("stg:"+stg);
	if(stg >= 3) 
	{
		long startTime=System.currentTimeMillis();
		out.println("<center><h3>Type the text given below</h3></center>");
		%>
		
		
		
		<form action="result.jsp" method="post">
		
		<center>
		
		<input type="hidden" value="<%=startTime %>" name="start"/>
		<input type="hidden" value="3" name="stge"/>
		
		<!-- 
			<input type="text" value="<%=mypara%>" size="10">
			<textarea cols="100" rows="20" name="para" value="<%=mypara%>"> </textarea>
		 -->

		
		<textarea oncopy="return false;" readonly  cols="100" rows="20" name="para" Style="font-size: 12px;"><%=mypara%></textarea>
		
		<br><br>
		
		<textarea  ondrop="return false;" cols="100" rows="20" name="mypara" Style="font-size: 12px;"> </textarea>
		<br><br>
		<input type="submit" name="result" value="Get Result" style="width:200px;height=30px;">
		<br><br>
		</center>
		
		
		</form>
		
		<% 
		
	}
	else
	{
		out.println("<center><h4>Please complete previous level to access this level</h4></center>");
		out.println("<center> <a href="+"'home.jsp'"+">Back To Home</a><center>");
	}
	
}
if(request.getParameter("4")!=null)
{
	BasicDBObject qry=new BasicDBObject();
	qry.put("username",username);
	DBCursor csr=level.find(qry);
	DBObject obj=csr.next();
	int stg=(Integer)obj.get("stage");
	
	BasicDBObject para=new BasicDBObject();
	para.put("stage",4);
	String mypara;
	DBCursor mycsr=quest.find(para);
	DBObject myobj=mycsr.next();
	mypara=(String)myobj.get("paragraph");
	
	
	//out.println("stg:"+stg);
	if(stg >= 4) 
	{
		long startTime=System.currentTimeMillis();
		out.println("<center><h3>Type the text given below</h3></center>");
		%>
		
		
		
		<form action="result.jsp" method="post">
		
		<center>
		
		<input type="hidden" value="<%=startTime %>" name="start"/>
		<input type="hidden" value="4" name="stge"/>
		
		<!-- 
			<input type="text" value="<%=mypara%>" size="10">
			<textarea cols="100" rows="20" name="para" value="<%=mypara%>"> </textarea>
		 -->

		
		<textarea oncopy="return false;" readonly  cols="100" rows="20" name="para" Style="font-size: 12px;"><%=mypara%></textarea>
		
		<br><br>
		
		<textarea  ondrop="return false;" cols="100" rows="20" name="mypara" Style="font-size: 12px;"> </textarea>
		<br><br>
		<input type="submit" name="result" value="Get Result" style="width:200px;height=30px;">
		<br><br>
		</center>
		
		
		</form>
		
		<% 
		
	}
	else
	{
		out.println("<center><h4>Please complete previous level to access this level</h4></center>");
		out.println("<center> <a href="+"'home.jsp'"+">Back To Home</a><center>");
	}
	
}
if(request.getParameter("5")!=null)
{
	BasicDBObject qry=new BasicDBObject();
	qry.put("username",username);
	DBCursor csr=level.find(qry);
	DBObject obj=csr.next();
	int stg=(Integer)obj.get("stage");
	
	BasicDBObject para=new BasicDBObject();
	para.put("stage",5);
	String mypara;
	DBCursor mycsr=quest.find(para);
	DBObject myobj=mycsr.next();
	mypara=(String)myobj.get("paragraph");
	
	
	//out.println("stg:"+stg);
	if(stg >= 5) 
	{
		long startTime=System.currentTimeMillis();
		out.println("<center><h3>Type the text given below</h3></center>");
		%>
		
		
		
		<form action="result.jsp" method="post">
		
		<center>
		
		<input type="hidden" value="<%=startTime %>" name="start"/>
		<input type="hidden" value="5" name="stge"/>
		
		<!-- 
			<input type="text" value="<%=mypara%>" size="10">
			<textarea cols="100" rows="20" name="para" value="<%=mypara%>"> </textarea>
		 -->

		
		<textarea oncopy="return false;" readonly  cols="100" rows="20" name="para" Style="font-size: 12px;"><%=mypara%></textarea>
		
		<br><br>
		
		<textarea  ondrop="return false;" cols="100" rows="20" name="mypara" Style="font-size: 12px;"> </textarea>
		<br><br>
		<input type="submit" name="result" value="Get Result" style="width:200px;height=30px;">
		<br><br>
		</center>
		
		
		</form>
		
		<% 
		
	}
	else
	{
		out.println("<center><h4>Please complete previous level to access this level</h4></center>");
		out.println("<center> <a href="+"'home.jsp'"+">Back To Home</a><center>");
	}
	
}

%>

</body>
</html>