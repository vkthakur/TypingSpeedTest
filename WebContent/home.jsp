<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.mongodb.*" %>
<%@page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HOME</title>
</head>
<body background="image.jpg">

<%
DBCollection users,level;
MongoClient mongo=new MongoClient("localhost",27017);
DB db=mongo.getDB("Type");
users=db.getCollection("users");
level=db.getCollection("level");

BasicDBObject query=new BasicDBObject();
String uname=session.getAttribute("userid").toString();
query.put("username",uname);
DBCursor cursor=users.find(query);
DBObject obj=cursor.next();
String name=(String)obj.get("name");


if((session.getAttribute("userid")==null) || (session.getAttribute("userid")==""))
{
	response.sendRedirect("index.jsp");
}

%>
<span style="float:left">
<a href="leaderboard.jsp">Leaderboard</a>
</span>

<span style="float:center">
<a href="profile.jsp">My Profile</a>
</span>

<span style="float:right">
<a href="logout.jsp">Logout</a>
</span>
<center>
<h4>Welcome  <%=name%></h4>

<form action="operation.jsp" method="post">

<input type="submit" name="0" value ="Level 0" style="width:200px;height=30px;"/>
<br><br>
<input type="submit" name="1" value ="Level 1" style="width:200px;height=30px;"/>
<br><br>
<input type="submit" name="2" value ="Level 2" style="width:200px;height=30px;"/>
<br><br>
<input type="submit" name="3" value ="Level 3" style="width:200px;height=30px;"/>
<br><br>
<input type="submit" name="4" value ="Level 4" style="width:200px;height=30px;"/>
<br><br>
<input type="submit" name="5" value ="Level 5" style="width:200px;height=30px;"/>
<br><br>

</form>

</center>

</body>
</html>