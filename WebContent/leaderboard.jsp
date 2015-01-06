<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@page import="com.mongodb.*" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Leaderboard</title>
</head>
<body>

<%
DBCollection users,level;
MongoClient mongo=new MongoClient("localhost",27017);
DB db=mongo.getDB("Type");
users=db.getCollection("users");
level=db.getCollection("level");


BasicDBObject sort=new BasicDBObject();
sort.put("points",-1);
DBCursor cursor=level.find().sort(sort);
int i=0;

%>
<center>
<h1>WORLD LEADERBOARD</h1>
<h4>
<table border="true">
<tr>
<td>RANK</td>
<td>USERNAME</td>
<td>SCORE</td>

</tr>

<% 

while(cursor.hasNext())
{
	DBObject obj=cursor.next();
	i++;
	String usr=(String)obj.get("username");
	int points=(Integer)obj.get("points");
	
	%>
<tr>
<td><%=i %></td>
<td><%=usr %></td>
<td><%=points %></td>


</tr>
	
	
	
	<%
}

%>

</h4>
</table>
</center>
</body>
</html>