<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>JSTL Core Library</h1>
	
	<h3>1. 변수(속성 == attribute)</h3>
	<pre>
	* 변수 선언과 동시에 초기화 (c:set var="" value="" [scope=""])
	- 변수 선언하고 초기값을 대입해두는 기능을 제공
	- 해당 변수를 어떤 scope에 담아둘껀지 지정 가능함 (생략시 기본적으로 pageScope에 담김)
	=> 즉, 해당 scope에 setAttribute를 통해서 key-value 형태로 데이터를 담아놓는 거라고 생각하면 됨
	=> c:set 으로 선언된 변수는 EL로 접근해서 사용가능 (스크립팅 원소로는 접근 불가!)
	
	- 변수 타입을 별도로 지정하지 않음
	- 초기값을 반드시 지정해둬야됨!
	</pre>
	
	<c:set var="num1" value="10"/> <!-- pageContext.setAttribute("num1","10") -->
	<c:set var="num2" value="20" scope="request"/> <!-- request.setAttribute("num2", "20" -->
	
	num1의 변수값 : ${ num1 } <br>
	num2의 변수값 : ${ num2 } <br>
	
	<c:set var="result" value="${ num1 + num2 }" scope="session"/>
	result 변수값 : ${ result } <br><br>
	
	${ pageScope.num1 } <br>
	${ requestScope.num2 } <br>
	${ sessionScope.result } <br>
	${ requestScope.result } <!-- 없어서 아무것도 출력안됨 --><br>
	
	<!-- value 속성 대신에 시작태그와 종료태그 사이에 초기값 지정 가능 -->
	<c:set var="result" scope="request">
		9999
	</c:set>
	
	${ requestScope.result } <br>
	<!-- request 영역의 result 출력됨 -->
	
	<hr>
	
	<pre>
	* 변수 삭제 (c:remove var="제거하고자하는 변수명" [scope:""])
	- 해당 scope영역에서 해당 변수를 찾아서 제거하는 태그
	- scope지정 생략시 모든 scope에서 해당 변수 다 찾아서 제거함
	=> 즉, 해당 scope에 .removeAttribute를 통해 제거하는거라고 생각하면 됨
	</pre>
	
	1) 특정 scope지정해서 삭제 <br>
	<c:remove var="result" scope="request"/>
	request에 삭제 후 result : ${ result } <br><br>
	<!-- session 영역의 result 출력됨 -->
	
	2) 모든 scope에서 삭제 <br>
	<c:remove var="result"/>
	모두 삭제 후 result : ${ result } <br><br> 
	<!-- 공백 출력 -->
	
	<hr>
	
	<pre>
	* 변수(데이터) 출력 (c:out value="출력하고자하는 값" [default="기본값"] [escapeXml="true|false"])
	- 데이터를 출력하고자 할 때 사용하는 태그
	</pre>
	
	<c:out value="${ result }"/>
	<c:out value="${ result }" default="없음"></c:out>
</body>
</html>