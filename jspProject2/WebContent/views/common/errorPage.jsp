<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%@ include file="menubar.jsp" %>

<% String errorMsg = (String)request.getAttribute("errorMsg"); %>

<h3 align="center" style="color:red"> <%= errorMsg %></h3>
<div id="test" style="height:500px; width:500px; border:1px solid black";>
</div>

<%@ include file="test.jsp" %>


<h3></h3>

</body>
</html>