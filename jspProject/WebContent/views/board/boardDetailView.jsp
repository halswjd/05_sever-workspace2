<%@page import="com.kh.board.model.vo.Attachment"%>
<%@page import="com.kh.board.model.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Board b = (Board)request.getAttribute("b");
	// 글번호, 카테고리명, 제목, 내용, 작성자, 작성일
	Attachment at = (Attachment)request.getAttribute("at");
	// 첨부파일이 없다면 null
	// 첨붚파일이 있다면 파일번호, 원본명, 수정명, 파일경로
%>
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
	<%@ include file="../common/menubar.jsp" %>

    <div class="outer">
        <br>
        <h2 align="center">일반게시판 상세보기</h2>
        <br>

        <table id="detail-area" border="1" align="center">

            <tr>
                <th width="70">카테고리</th>
                <td width="70"><%= b.getCategory() %></td>
                <th width="70">제목</th>
                <td width="350"><%= b.getBoardTitle() %></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td><%= b.getBoardWriter() %></td>
                <th>작성일</th>
                <td><%= b.getCreateDate() %></td>
            </tr>
            <tr>
                <th>내용</th>
                <td colspan="3">
                    <p style="height: 200px;"><%= b.getBoardContent() %></p>
                </td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td colspan="3">
                	<% if(at == null){ %>
	                    <!-- case1. 첨부파일이 없을 경우 -->
	                    첨부파일이 없습니다
                    <%}else {%>
	                    <!-- case2. 첨부파일이 있을 경우 -->
	                    <!-- <a href = "폴더경로/바뀐파일명">원본명.png</a> -->
	                    <!-- href = /jsp/resources/board_upfiles/바뀐이름.png -->
	                    <a download="<%= at.getOriginName() %>" href="<%= contextPath %>/<%= at.getFilePath() %>/<%= at.getChangeName()%>"><%= at.getOriginName() %></a>
	                    <!-- a속성값에 download -> 링크 클릭시 수정명으로 저장됨 -->
	                    <!-- 원본명으로 저장하고싶으면 download 속성값으로 원본명 제시 -->
                    <%} %>
                </td>
            </tr>
        </table>
        
        
        
        
        <br>

        <div align="center">
            <a href="<%= contextPath %>/list.bo?cpage=1" class="btn btn-sm btn-secondary">목록가기</a>
            <!-- 로그인한 사용자가 게시글 작성자일 경우 -->
            <% if(loginMember != null && loginMember.getUserId().equals(b.getBoardWriter())) {%>
	            <a href="<%= contextPath %>/updateForm.bo?bno=<%= b.getBoardNo() %>" class="btn btn-sm btn-warning">수정하기</a>
	            <a href="#" class="btn btn-sm btn-danger">삭제하기</a>
            <%} %>
        </div>

        <br>

        <div id="reply-area">
            <table border="1" align="center">
                <thead>
                    <tr>
                        <th>댓글작성</th>
    					
    					<% if(loginMember != null){ %>
	                        <!-- 로그인한 사용자만 보이는 화면 -->
	                        <td>
	                            <textarea name="" id="replyContent" rows="3" cols="50" style="resize: none;"></textarea>
	                        </td>
	                        <td><button onclick="insertReply();">댓글등록</button></td>
                        <%}else {%>
	                        <!-- 로그인 안한 사용자가 보는 화면-->
	                        <td>
	                            <textarea name="" id="" cols="50" rows="3" style="resize: none;" readonly>로그인 후 이용가능한 서비스입니다.</textarea>
	                        </td>
	                        <td><button disabled>댓글등록</button></td>
                        <%} %>
                             
                    </tr>
                </thead>
                <tbody>
                    <!-- 댓글 들어 올 자리 
                    <tr>
                        <td>admin</td>
                        <td>ㅎㅎ재밌네요</td>
                        <td>23/08/24 14:42</td>
                    </tr>-->
                    
                </tbody>
            </table>
	
			<script>
				$(function(){
					selectReplyList();
					
					// setInterval(특정함수, 특정시간);
					setInterval(selectReplyList,1000); // 1초단위로 selectReplyList함수 실행됨
					// => 활용예 : 실시간 top
				})
			
				// ajax로 해당게시글에 딸린 댓글 목록 조회용
				function selectReplyList(){
					$.ajax({
						url:"rlist.bo",
						data:{bno:<%= b.getBoardNo()%>},
						success:function(list){
							// console.log(list);
							
							let result = "";
							for(let i=0; i<list.length; i++){
								result += "<tr>"
										+ "<td>" + list[i].replyWriter + "</td>" 
										+ "<td>" + list[i].replyContent + "</td>"
										+ "<td>" + list[i].createDate + "</td>"
										+ "</tr>"
							}
							
							$("#reply-area tbody").html(result);
						},
						error:function(){
							console.log("댓글조회용 ajax 통신 실패!");
						}
					})
				}
				
				// ajax로 댓글 작성용 함수
				function insertReply(){
					$.ajax({
						url:"rinsert.bo",
						data:{
							  content:$("#replyContent").val(),
							  bno:<%= b.getBoardNo() %>
							 },
						type:"post",
						success:function(result){
							
							if(result > 0){ // 댓글 작성 성공! => 갱신된 댓글 리스트 조회
								selectReplyList();
								// textarea 댓글 쓴거 지워주기
								$("#replyContent").val("");
							}
						},
						error:function(){
							console.log("댓글작성용 ajax 통신 실패");
						}
					})
				}
				
			</script>
        </div>

    </div>


</body>
</html>