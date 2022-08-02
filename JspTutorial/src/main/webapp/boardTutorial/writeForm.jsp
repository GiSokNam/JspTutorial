<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardTutorial/writeForm.jsp</title>
</head>
<body>
<!--action="writePro.jsp"의 의미 
form에 기입된 name값, pass값, subject값, content값이 submit
이벤트 발생 시  method="post" 유형으로 
파라미터값을 request에 담아 writePro.jsp로 전송 -->

<!-- method의 종류 get방식 과 post방식이 있으며
get방식의 경우 웹페이지 주소창에 form에 기입된 값들이 표시되어
전송되는 방식이며 이로인해 보안상 문제가 발생할수있다는 단점이 존재한다

post방식의 경우 파라미터형식으로 데이터를 끼워 전송해주기 때문에
웹페이지 주소창에 form에 기입된 값들이 표시되지않아 보안상 안전한 방식
 -->
<form action="writePro.jsp" method="post">
<table border="1">
<tr><td>글쓴이</td><td><input type="text" name="name"></td></tr>
<tr><td>비밀번호</td><td><input type="password" name="pass"></td></tr>
<tr><td>제목</td><td><input type="text" name="subject"></td></tr>
<tr><td>내용</td>
    <td><textarea name="content" rows="10" cols="20"></textarea></td></tr>
<tr><td colspan="2"><input type="submit" value="글쓰기"></td></tr>
</table>
</form>
</body>
</html>

