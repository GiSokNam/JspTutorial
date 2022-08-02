<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberTutorial/loginForm.jsp</title>
</head>
<body>
<!--action="loginPro.jsp"의 의미 
form에 기입된 id값 과 pass값이 submit
이벤트 발생 시  method="post" 유형으로 
파라미터값을 request에 담아 loginPro.jsp로 전송 -->

<!-- method의 종류 get방식 과 post방식이 있으며
get방식의 경우 웹페이지 주소창에 form에 기입된 값들이 표시되어
전송되는 방식이며 이로인해 보안상 문제가 발생할수있다는 단점이 존재한다

post방식의 경우 파라미터형식으로 데이터를 끼워 전송해주기 때문에
웹페이지 주소창에 form에 기입된 값들이 표시되지않아 보안상 안전한 방식
 -->
<form action="loginPro.jsp" method="post">
<h2>로그인</h2>
<hr>
아이디 : <input type="text" name="id" ><br>
비밀번호 : <input type="password" name="pass" ><br>
<input type="submit" value="로그인">
<!-- 회워가입 페이지로 넘기는 html태그 
<a href="URL"></a> -->
<a href="insertForm.jsp">회원가입</a>
</form>

</body>
</html>