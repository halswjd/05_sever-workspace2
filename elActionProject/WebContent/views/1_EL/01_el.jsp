<%@page import="com.kh.model.vo.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 	<h3>1. 기존의 방식대로 스크립틀릿과 표현식 이용해서 각 Scope에 담겨있는 값 뽑아서 화면 출력</h3>
 	
 	<%--
 	<%
 		String classRoom = (String)request.getAttribute("classRoom");
 		Person student = (Person)request.getAttribute("student");
 		
 		String academy = (String)session.getAttribute("academy");
 		Person teacher = (Person)session.getAttribute("teacher");
	%>
	
	<p>
		학원명 : <%= academy  %> <br>
		강의실 : <%= classRoom %> <br>
		강사 : <%= teacher.getName() %>, <%= teacher.getAge() %>, <%= teacher.getGender() %> <br><br>
		
		수강생 정보
		<ul>
			<li>이름 : <%= student.getName() %></li>
			<li>나이 : <%= student.getAge() %></li>
			<li>성별 : <%= student.getGender() %></li>
		</ul>
		
	</p>
	 --%>
	 
	 <h3>2. EL을 이용해서 보다 쉽게 해당 Scope에 저장된 값들 출력하기</h3>
	 <p>
	 	EL을 이용해서 getXXX을 통해 값을 빼올 필용 없이 EL구문 내에 키값만 제시하면 바로 접근 가능 <br>
	 	기본적으로 EL은 JSP내장객체를 구분하지 않고 자동으로 모든 내장객체에 키값을 검색해서 조재하는 경우 값을 가져옴 <br>	
	 </p>
	 
	 <p>
	 	학원명 : ${ academy } <br>
	 	강의장 : ${ classRoom } <br>
	 	강사 : ${ teacher.name }, ${ teacher.age }, ${ teacher.gender } <br><br>
	 	<!-- 
	 		teacher에 접근하면 벨류값은 Person 객체임
	 		해당 Person 객체의 필드에 담긴 값을 출력하고자 한다면 .필드명으로 접근하면 됨
	 		=> 내부적으로 getter 메소드 찾아서 실행됨 (getter메소드 없으면 당연 안됨)
	 		   즉, getter 메소드는 항상 필수적으로 만들어놓아야함!!
	 		   getter 메소드 하나 지우면 오류나는것을 확인 할 수 있음
	 	 -->
	 	 
	 	 수강생정보
	 	 <ul>
	 	 	<li>이름 : ${ student.name }</li>
	 	 	<li>나이 : ${ student.age }</li>
	 	 	<li>성별 : ${ student.gender }</li>
	 	 </ul>
	 	
	 </p>
	 
	 <h3>3. 단, EL 사용시 내장 객체들에 저장된 키값이 동일할 경우</h3>
	 scope 값 : ${ scope }<br> <!-- request영역 값이 출력됨, 가장 좁은 영역의 값이 출력되는걸 알 수 있음-->
	 <!-- 
	 	EL은 공유범위가 제일 작은 Scope에서부터 해당 키값을 검색함
	 	page => request => session => application
	 	
	 	만일, 모든 영역에서 못찾을 경우 => 아무것도 출력안됨(오류는 안남)
	 	
	  -->
	  
	  test 값 : ${ test } <br> <!-- 아무것도 출력안됨 -->
	  
	  <h3>4. 직접 Scope를 지정해서 접근하기</h3>
	  <%
	  	// pageScope에 담기
	  	pageContext.setAttribute("scope", "page");
	  %>
	  
	  pageScope에 담긴 값 : ${ scope } 또는 ${ pageScope.scope } <br>
	  <!-- page 출력 -->
	  requestScope에 담긴 값 : ${ requestScope.scope } <br>
	  <!-- request 출력 -->
	  sessionScope에 담긴 값 : ${ sessionScope.scope } <br>
	  <!-- session 출력 -->
	  applicationScope에 담긴 값 : ${ applicationScope.scope }<br><br>
	  <!-- application 출력 -->
	  
	  <!-- 
	  		각 영역에 중복된 키값으로 데이터 저장시켜놨다면
	  		Scope를 직접 지정해서 키값 제시하는게 제일 정확
	  		
	  		단지 키값만 제시하면 잘못된(의도하지않은) 데이터가 뽑힐 수 있음
	   -->
	  
	 강의장 : ${ seesionScope.classRoom } <!-- 잘못된 영역이라 아무것도 출력안됨 -->
</body>
</html>