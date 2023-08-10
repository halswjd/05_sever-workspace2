<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
        /* div{border: 1px solid red; box-sizing: border-box;} */
        #footer{width: 1000px; height: 150px;} /*임시로 지정 : 이 스타일 반영 안됨*/

        #footer>div{width: 100%;}
        #footer_1{height: 20%;}
        #footer_2{height: 80%;}
        
        #p1{height: 80%; padding: 5px 15px ;}
        #p2{height: 20%; text-align: center;}

        #footer_1>a {
            text-decoration: none;
            color: black;
            font-weight: 600;
            margin: 15px;
            vertical-align: middle; /*수직정렬 중에 가운데.. 가끔 안되는 태그 있음.. */
        }

        #footer_2>p {
            width: 100%;
            /* border: 1px solid blue; */
            box-sizing: border-box;
            margin: 0;
            /* fz12 */
            font-size: 12px;
            color: rgb(58, 58, 58);
        }


    </style>
</head>
<body>
	<div id="footer">
        <div id="footer_1">
            <a href="#">이용약관</a> | <!-- 보통 링크는 마지막, 그 전에는 # 넣어둠 -->
            <a href="#">개인정보취급방침</a> |
            <a href="#">인재채용</a> |
            <a href="#">고객센터</a>
        </div>
        <div id="footer_2">
            <p id="p1">
                강남지원 1관 : 서울특별시 강남구 테헤란로14길 6 남도빌딩 2F, 3F, 4F, 5F, 6F <br>
                강남지원 2관 : 서울특별시 강남구 테헤란로10길 9 그랑프리 빌딩 4F, 5F, 7F <br>
                강남지원 3관 : 서울특별시 강남구 테헤란로 130 호산빌딩 5F, 6F <br>
                종로지원 : 서울특별시 중구 남대문로 120 그레이츠 청계(구 대일빌딩) 2F, 3F <br>
                당산지원 : 서울특별시 영등포구 선유동2로 57 이레빌딩(구관) 19F, 20F
            </p>
            <p id="p2">
                Copyright © 1998-2023 KH Information Educational Institute All Right Reserved
            </p>
        </div>
    </div>
</body>
</html>