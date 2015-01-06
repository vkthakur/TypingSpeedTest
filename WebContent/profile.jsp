<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.mongodb.*" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Profile</title>
</head>
<body>
<%

String username = session.getAttribute("userid").toString();
DBCollection profile;
MongoClient mongo=new MongoClient("localhost",27017);
DB db=mongo.getDB("Type");
profile=db.getCollection("profile");

BasicDBObject obj=new BasicDBObject();
obj.put("username",username);
DBCursor csr=profile.find(obj);

DBObject myobj=csr.next();
out.println("<h2>"+username+"</h2>");
%>
<center>
<table border="true">
<tr>
<td>Level</td>
<td>Best Accuracy</td>
<td>Best Time</td>
<td>Best Wpm</td>
</tr>
<%
Double btime,bacc,bwpm;
DBObject nwobj=(DBObject)myobj.get("level_1");
btime=(Double)nwobj.get("btime");
bacc=(Double)nwobj.get("bacc");
bwpm=(Double)nwobj.get("bwpm");
%>
<tr>
<td>Level 1</td>
<td><%=bacc%></td>
<td><%=btime%></td>
<td><%=bwpm %></td>
</tr>

<%
DBObject nwobj2=(DBObject)myobj.get("level_2");
btime=(Double)nwobj2.get("btime");
bacc=(Double)nwobj2.get("bacc");
bwpm=(Double)nwobj2.get("bwpm");
%>
<tr>
<td>Level 2</td>
<td><%=bacc%></td>
<td><%=btime%></td>
<td><%=bwpm %></td>
</tr>

<%
DBObject nwobj3=(DBObject)myobj.get("level_3");
btime=(Double)nwobj3.get("btime");
bacc=(Double)nwobj3.get("bacc");
bwpm=(Double)nwobj3.get("bwpm");
%>
<tr>
<td>Level 3</td>
<td><%=bacc%></td>
<td><%=btime%></td>
<td><%=bwpm %></td>
</tr>

<%
DBObject nwobj4=(DBObject)myobj.get("level_4");
btime=(Double)nwobj4.get("btime");
bacc=(Double)nwobj4.get("bacc");
bwpm=(Double)nwobj4.get("bwpm");
%>
<tr>
<td>Level 4</td>
<td><%=bacc%></td>
<td><%=btime%></td>
<td><%=bwpm %></td>
</tr>

<%

DBObject nwobj5=(DBObject)myobj.get("level_5");
btime=(Double)nwobj5.get("btime");
bacc=(Double)nwobj5.get("bacc");
bwpm=(Double)nwobj5.get("bwpm");
%>
<tr>
<td>Level 5</td>
<td><%=bacc%></td>
<td><%=btime%></td>
<td><%=bwpm %></td>
</tr>

</table>





<% 


%>


</center>

</body>
</html>