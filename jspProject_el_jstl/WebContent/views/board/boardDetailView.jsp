<%@page import="com.kh.board.model.vo.Attachment"%>
<%@page import="com.kh.board.model.vo.Board"%>
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
        height: auto;
        margin: auto;
        margin-top: 50px;
    }
</style>
</head>
<body>
<jsp:include page="../common/menubar.jsp"/>

<div class="outer">
    <br>
    <h2 align="center">일반게시판 상세보기</h2>
    <br>

    <table id="detail-area" border="1" align="center">

        <tr>
            <th width="70">카테고리</th>
            <td width="70">${ b.category }</td>
            <th width="70">제목</th>
            <td width="350">${ b.boardTitle }</td>
        </tr>
        <tr>
            <th>작성자</th>
            <td>${ b.boardWriter }</td>
            <th>작성일</th>
            <td>${ b.createDate }</td>
        </tr>
        <tr>
            <th>내용</th>
            <td colspan="3">
                <p style="height: 200px;">${ b.boardContent }</p>
            </td>
        </tr>
        <tr>
            <th>첨부파일</th>
            <td colspan="3">
            	<c:choose>
            	<c:when test="${ empty at }">
                   <!-- case1. 첨부파일이 없을 경우 -->
                   첨부파일이 없습니다.
                </c:when>
                <c:otherwise>
                <!-- case2. 첨부파일이 있을 경우 -->
                <a download="${ at.originName }" href="${ at.filePath }/${ at.changeName }">${ at.originName }</a>
                </c:otherwise>
                </c:choose>
            </td>
            
            
        </tr>

    </table>
    <br>

    <div align="center">
        <a href="list.bo?cpage=1" class="btn btn-sm btn-secondary">목록가기</a>

        <!-- 로그인한 사용자가 게시글 작성자일 경우 -->
        <c:if test="${ not empty loginMember and loginMember.userId eq b.boardWriter }">
	        <a href="updateForm.bo?bno=${ b.boardNo }" class="btn btn-sm btn-warning">수정하기</a>
	        <a href="#" class="btn btn-sm btn-danger">삭제하기</a>
        </c:if>
    </div>

    <br>

    <div id="reply-area">
        <table border="1" align="center">
            <thead>
                <tr>
                <th>댓글작성</th>
                <c:choose>
                <c:when test="${ not empty loginMember }">
	                <!-- 로그인한 사용자만 보이는 화면 -->
	                <td>
	                    <textarea id="replyContent" cols="50" rows="3" style="resize: none;"></textarea>
	                </td>
	                <td><button onclick="insertReply();">댓글등록</button></td>
                
                </c:when>
				<c:otherwise>
	                <!-- 로그인 안한 사용자가 보는 화면 -->
	                <td>
	                    <textarea cols="50" rows="3" style="resize: none;" readonly>로그인 후 이용가능한 서비스입니다.</textarea>
	                </td>
                	<td><button disabled>댓글등록</button></td>
            	</c:otherwise>
            	</c:choose>
            </tr>
            </thead>
            <tbody>
                
            </tbody>
            
        </table>
        
        <script>
        
        	$(function(){
        		selectReplyList();
        		
        		<!--setInterval(특정함수,특정시간);-->
        		setInterval(selectReplyList,1000);
        	})
        	
        	//ajax로 댓글 작성용
        	function insertReply(){
        		
        		$.ajax({
        			url:"rinsert.bo",
        			data:{
        				  content:$("#replyContent").val(), //textarea는 val도 가능(원래 글자 가져오는 건 .html)
        				  bno:${ b.boardNo }
        				  },
        		    type:"post",
        		    success:function(result){
        		    	
        		    	if(result > 0){ //댓글 작성 성공!! => 갱신된 댓글 리스트 조회
        		    		selectReplyList();
        		    	$("#replyContent").val("");
        		    		
        		    	}
        		    	
        		    },error:function(){
        		    	console.log("댓글 작성용 ajax통신 실패");
        		    }
        		})
        	}
        
        	//ajax로 해당 게시글에 딸린 댓글 목록 조회용
        	function selectReplyList(){
        		$.ajax({
        			url:"rlist.bo",
        			data:{bno:${ b.boardNo }},
        			success:function(list){
						console.log(list);     
					
					let result="";
					for(let i=0;i<list.length;i++){
						result += "<tr>"
									+ "<td>" + list[i].replyWriter + "</td>"
									+ "<td>" + list[i].replyContent + "</td>"
									+ "<td>" + list[i].createDate + "</td>"
								+ "</tr>"
					}
						$("#reply-area tbody").html(result);
						
        			},
        			error:function(){
        				console.log("댓글 조회용 ajax 통신 실패")
        			}
        		})
        	}
        
        </script>
        
    </div>



</div>

</body>
</html>