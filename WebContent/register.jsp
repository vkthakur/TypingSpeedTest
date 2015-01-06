<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="com.mongodb.*" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="java.security.*" %>
<%@page import="sun.misc.BASE64Encoder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<%
DBCollection users,level,profile;
MongoClient mongo=new MongoClient("localhost",27017);
DB db=mongo.getDB("Type");
users=db.getCollection("users");
level=db.getCollection("level");
profile=db.getCollection("profile");

String name=request.getParameter("name");
String username=request.getParameter("username");
String password=request.getParameter("pass");
String email=request.getParameter("email");

BasicDBObject query =new BasicDBObject();
query.put("username",username);
DBCursor cursor=users.find(query);
if(cursor.hasNext())
{	
	out.println("<center>");
	out.println("<h4>");
	out.println("Username already exists.Please use another username");
	out.println("<h4>");
	
	%>
	
	<a href="index.jsp">Login</a>
	
	</center>
	
	<% 
	
}
else
{
	query.put("name",name);
	query.put("email",email);
	MessageDigest msgdgt=MessageDigest.getInstance("MD5");
	msgdgt.update(password.getBytes("UTF-8"));
	byte rawbyte[]=msgdgt.digest();
	String hashvalue=(new BASE64Encoder()).encode(rawbyte);
	query.put("password",hashvalue);
	users.insert(query);
	BasicDBObject lvl =new BasicDBObject();
	lvl.put("username",username);
	lvl.put("stage",0);
	lvl.put("points",0);
	level.insert(lvl);
	BasicDBObject prfle=new BasicDBObject();
	prfle.put("username",username);
	BasicDBObject blevel=new BasicDBObject();
	blevel.put("bacc",0.0);
	blevel.put("btime",9999999.0);
	blevel.put("bwpm",0.0);
	prfle.put("level_1",blevel);
	prfle.put("level_2",blevel);
	prfle.put("level_3",blevel);
	prfle.put("level_4",blevel);
	prfle.put("level_5",blevel);
	profile.insert(prfle);
	
	response.setStatus(response.SC_MOVED_TEMPORARILY);
	response.setHeader("Location","index.jsp");
}




%>

</body>
</html>