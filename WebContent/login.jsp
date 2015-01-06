<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.mongodb.*" %>
<%@page import="java.io.*" %>
<%@page import="java.security.*" %>
<%@page import="sun.misc.BASE64Encoder" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register</title>
</head>
<body background="image.jpg">
<%
	DBCollection users;
	MongoClient mongo=new MongoClient("localhost",27017);
	DB db=mongo.getDB("Type");
	users=db.getCollection("users");
	
	if(request.getParameter("B")!=null)
	{
		%>
		<form action="register.jsp" method="post">
		<center>
		<h2>Typing Test Registration Page</h2>
		<h3>Name</h3><input type="text" name="name"><br>
		<h3>Username</h3><input type="text" name="username"><br>
		<h3>Password</h3><input type="password" name="pass"><br>
		<h3>E-mail ID</h3><input type="text" name="email"><br>
		<br>
		<input type="submit" value="Enter" style="width: 200px;height: 30px;"/>
		
		
		</center>
		
		</form>
		
		
		
		
		
		
		<% 
	}
	
	else
	{
		String username=request.getParameter("user");
		String password=request.getParameter("pass");
		
		MessageDigest msgdgt=MessageDigest.getInstance("MD5");
		msgdgt.update(password.getBytes("UTF-8"));
		byte rawbyte[]=msgdgt.digest();
		String hashvalue=(new BASE64Encoder()).encode(rawbyte);
		
		BasicDBObject query=new BasicDBObject();
		query.put("username",username);
		query.put("password",hashvalue);
		
		DBCursor cursor=users.find(query);
		if(cursor.hasNext())
		{
			session.setAttribute("userid",username);
			response.sendRedirect("home.jsp");
			
			
		}
		else
		{
			out.println("<center>");
			out.println("<h4>");
			out.println("Wrong username and password combination.Please try again");
			out.println("<h4>");
			
			%>
			
			<a href="index.jsp">Login</a>
			
			</center>
			
			<% 
		}
		
		
	}


%>


</body>
</html>