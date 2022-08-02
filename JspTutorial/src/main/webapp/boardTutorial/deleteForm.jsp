<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardTutorial/deleteForm.jsp</title>
</head>
<body>
<%
// 글정보를 가져오기 위한 num값
// request에서 num파라미터 가져오기
int num = Integer.parseInt(request.getParameter("num"));
%>
<form action="deletePro.jsp" method="post">
<!--action="deletePro.jsp"의 의미 
form에 기입된 pass값이 submit
이벤트 발생 시  method="post" 유형으로 
파라미터값을 request에 담아 deletePro.jsp로 전송 -->

<!-- method의 종류 get방식 과 post방식이 있으며
get방식의 경우 웹페이지 주소창에 form에 기입된 값들이 표시되어
전송되는 방식이며 이로인해 보안상 문제가 발생할수있다는 단점이 존재한다

post방식의 경우 파라미터형식으로 데이터를 끼워 전송해주기 때문에
웹페이지 주소창에 form에 기입된 값들이 표시되지않아 보안상 안전한 방식
 -->
<input type="hidden" name="num" value="<%=num %>">
<table border="1">
<tr><td>비밀번호</td><td><input type="password" name="pass"></td></tr>
<tr><td colspan="2"><input type="submit" value="글삭제"></td></tr>
</table>
</form>
</body>
</html>

