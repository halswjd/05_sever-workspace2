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
        height: 500px;
        margin: auto;
        margin-top: 50px;
    } /* 쓰기 귀찮으면 메뉴바에 추가하면 됨*/

    #enroll-Form input, #enroll-Form textarea{
        width: 100%;
        box-sizing: border-box;
    }

</style>

</head>
<body>
	
	<jsp:include page="../common/menubar.jsp"></jsp:include>
	
	<div class="outer" align="center">
        <br>
        <h2>공지사항 작성하기</h2>
        <br>

        <form action="insert.no" id="enroll-Form" method="post">
            <table>
                <tr>
                    <th width="50">제목</th>
                    <td width="450"><input type="text" name="title" required></td>
                </tr>

                <tr>
                    <th>내용</th>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <textarea name="content" rows="10" style="resize: none;" required></textarea>
                    </td>
                </tr>

            </table>

            <br><br>

            <div>
                <button type="submit">등록하기</button>
                <button type="reset">초기화</button>
                <button type="button" onclick="history.back();">뒤로가기</button>
            </div>
           <!-- onclick="history.back(); => 뒤로가기 -->
        </form>

    </div>
</body>
</html>