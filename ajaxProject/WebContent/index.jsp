<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>
<body>
    <h1>AJAX의 개요</h1>

    <p>
        Asynchronous JavaScript And XML의 약자로 <br>
        서버로부터 데이터를 가져와서 전체 페이지를 새로 고치지 않고 일부만 로드할 수 있게 하는 기법 <br>
        우리가 기존에 a 태그로 요청 및 form 태그의 submit 요청 방식은 "동기식 요청" => 응답페이지가 돌아와야만 볼 수 있음 (페이지가 깜빡거림) <br><br>

        * 동기식 / 비동기식 <br>
        > 동기식 (a, form submit)
        <ul>
            <li>요청 처리 후 그에 해당하는 읍답페이지가 돌아와야지만 그 다음 작업 가능</li>
            <li>서버에 요청한 결과까지의 시간이 지연되면 무작정 계속 기다려야됨 (흰페이지로 보여질꺼임)</li>
            <li>전체 페이지를 응답해주기 때문에 기본적으로 페이지가 깜빡거림</li>
        </ul>
        <br>

        > 비동기식 (ajax)
        <ul>
            <li>현재 페이지를 그대로 유지하면서 중간중간마다 추가적으로 필요한 요청을 보내줄 수 있음</li>
            <li>요청을 보냈다고 해서 다른 페이지로 넘어가지 않음 (현재페이지 그대로 유지)</li>
            <li>요청을 보내놓고 그에 해당하는 응답(데이터)이 돌아올때까지 현재페이지에서 다른 작업을 할 수 있음</li>
            <li>페이지가 깜빡거리지 않음</li>
        </ul>
        EX) 실시간 급상승 검색어 로딩, 검색어 자동완성, 아이디 중복체크, 찜하기/해제하기, 추천, 댓글, 무한스크롤링(페이지대체) 등등..
        <br><br>

        * 비동기식의 단점 <br>
        - 현재 페이지에 지속적으로 리소스가 쌓임 => 페이지가 느려질 수 있음 <br>
        - 에러 발생시 디버깅 어려움 <br>
        - 요청 처리 후에 돌아온 응답데이터를 가지고 새로운 요소를 만들어서 화면을 구성해야함 => dom 요소들을 새로이 만들어내는 구문을 잘 익혀둬야함
        <br><br>

        * AJAX 구현 방식 => 순수 JavaScript 방식 / jQuery방식(코드가 간결하고 사용하기 쉬움)

    </p>
    
    <pre>
    * jQuery방식으로 AJAX 통신

    $.ajax({
        속성명:속성값,
        속성명:속성값,
        속성명:속성값
        ...
    });

    * 주요속성
    - url : 요청할 url (필수속성!!)
    - type|method : 요청전송방식 (get/post)
    - data : 요청시 전달할 값
    - success : ajax통신 성공했을 때 실행할 함수 정의
    - error : ajax통신 실패했을 때 실행할 함수 정의
    - complete : ajax통신 실패했든 성공했든간에 무조건 실행할 함수 정의
    </pre>

    <h1>jQuery 방식을 이용한 AJAX 테스트</h1>
    
    <h3>1. 버튼 클릭시 get방식으로 서버에 요청 및 응답</h3>

    입력 : <input type="text" id="input1">
    <button id="btn1">전송</button>
    <br>

    응답 : <span id="output1">현재 응답 없음</span>

    <script>
        $(function(){
            $("#btn1").click(function(){

                // 기존에 동기식 통신
                //location.href = 'jqAjax.do?input=' + $("#input1").val();

                // 비동기식 통신
                $.ajax({

                    // 요청 보내기
                    url:"jqAjax1.do", // 어느 url로 보낼것인지
                    data:{input:$("#input1").val()}, // 보낼 데이터, 키:벨류 형태(객체형태)로 보내야함 data 속성값은 객체로
                    type:"get", // 요청 방식 지정
                    
                    // 응답 받아 주기
                    success:function(result){ // 성공시 응답 데이터가 자동으로 매개변수로 넘어옴
                        console.log("ajax 통신성공!");
                        console.log(result);
                        $("#output1").text(result);
                    },
                    error:function(){
                        console.log("agax 통신실패!!!! ㅠㅠ");
                    },
                    complete:function(){
                        console.log("ajax통신 성공여부와 관계없이 무조건 호출!");
                    }
                })
            })
        })
    </script>


    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</body>
</html>