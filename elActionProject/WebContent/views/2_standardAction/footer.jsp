<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		String year = new SimpleDateFormat("yyyy").format(new Date());
	%>

<<<<<<< HEAD
<<<<<<< HEAD
	Copyright © 1998-<%=year %> KH Information Educational Institute All Right Reserved <br>
	
	test : ${ param.test }<br>

=======
	Copyright © 1998-<%= year %> KH Information Educational Institute All Right Reserved <br>
	
	test : ${ param.test }<br>
>>>>>>> 2791e74f934b8f27c9b1ab54ba06e27f02708697
=======
	Copyright © 1998-<%= year %> KH Information Educational Institute All Right Reserved <br>
	
	test : ${ param.test }<br>
>>>>>>> 2791e74f934b8f27c9b1ab54ba06e27f02708697
</body>
</html>