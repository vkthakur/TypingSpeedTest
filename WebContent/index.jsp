<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Typing Test</title>
</head>
<body background="image.jpg">
<center>
	<%

    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == ""))
    {
    
    
	%>
	<form action = "login.jsp" method ="post">
	
	<h2>LOGIN</h2>
	<h3>Username</h3><input type ="text" name = "user"/>
	<br>
	<h3>Password</h3><input type="password" name="pass"/>
	<br><br>
	<input type="submit" name= "A" value ="Login"  style="width: 200px;height: 30px;"/>
	<br><br>
	<input type="submit" name="B" value="Register"  style="width: 200px;height: 30px;"/>
	</form>
	<%
    }
    else
    {
    	response.sendRedirect("home.jsp");
    }
	%>
	
</center>
</html>