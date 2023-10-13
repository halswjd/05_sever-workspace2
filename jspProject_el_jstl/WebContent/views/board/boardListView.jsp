<%@page import="com.kh.board.model.vo.Board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.kh.common.model.vo.PageInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        .outer{
            background-color: black;
            color: white;
            width: 1000px;
            height: 600px;
            margin: auto;
            margin-top: 50px;
        }

        .list-area{
            border: 1px solid white;
            text-align: center;
        }
        
        .list-area>tbody>tr:hover{
        	background: gray;
        	cursor:pointer;
        }

    </style>

</head>
<body>
	
	<jsp:include page="../common/menubar.jsp"></jsp:include>
    
    <div class="outer">
        <br>
        <h2 align="center">일반게시판</h2>
        <br>
<!-- 어제 수업 안들어서 이해 잘 되누?? 찐 파일 공유 할 줄 알았으면 필기를 좀 잘할 걸ㅎㅎ 중간중간 오타가 있어도 이해 바랍니다. 
 -->
		
        <!--로그인한 회원 만 보여지는 div-->
        <c:if test="${ not empty loginMember }">
	        <div align="right" style="width: 860px;">
	           <a href="enrollForm.bo" class="btn btn-sm btn-secondary">글작성</a>
	            <br>
	            <br>
	        </div>
	     </c:if>

        <table align="center" class="list-area">
            <thead>
                <tr>
                    <th width="70">글번호</th>
                    <th width="80">카테고리</th>
                    <th width="300">제목</th>
                    <th width="100">작성자</th>
                    <th width="50">조회수</th>
                    <th width="100">작성일</th>
                </tr>
            </thead>

            <tbody>
            	
           	<c:choose>
           		<c:when test="${ empty list }">
	                <!--case1. 게시글이 없을 경우-->
	                <tr>
	                    <td colspan="6">조회된 게시글이 없습니다.</td>
	                </tr>
                </c:when>
                <c:otherwise>
                	<c:forEach var="b" items="${ list }">
	                <!--case2. 게시글이 있을 경우-->
	                <tr>
	                    <td>${ b.boardNo }</td>
	                    <td>${ b.category }</td>
	                    <td>${ b.boardTitle }</td>
	                    <td>${ b.boardWriter }</td>
	                    <td>${ b.count }</td>
	                    <td>${ b.createDate }</td>
	                </tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			
            </tbody>
        </table>
        
        <script>
        	$(function(){
        		$(".list-area>tbody>tr").click(function(){
        			//const num = $(this).children().eq(0).text()
        			
        			location.href='detail.bo?bno='+ $(this).children().eq(0).text()
        			
        			
        		})
        	})
        
        </script>
        
        
        <br><br>

        <div class="paging-area" align="center">
        
        	<c:if test="${ currentPage ne 1 }">
            <button onclick="location.href='list.bo?cpage=${ currentPage -1 }'"> &lt; </button>
            </c:if>
            
            <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
            	
            	<c:choose>
            	<c:when test="${ p eq pi.currentPage }">
            	
		            <button disabled>${ p }</button>
	            
	            </c:when>
	            <c:otherwise>
	            
		            <button onclick="location.href='list.bo?cpage=${ p }'">${ p }</button>
	            </c:otherwise>
	            </c:choose>
            
            </c:forEach>
            
            <c:if test="${ pi.currentPage ne pi.maxPage }">
	            <button onclick="location.href='list.bo?cpage=${ pi.currentPage +1 }"> &gt; </button>
			</c:if>
        </div>


    </div>

</body>
</html>