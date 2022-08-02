<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberTutorial/main.jsp</title>
</head>
<body>
<% 
// 세션값을 변수에 저장
String id = (String)session.getAttribute("id");
// 세션값이 없으면 loginForm.jsp로 이동
if(id == null){
	response.sendRedirect("loginForm.jsp");
}
%>
<!--  세션값을 받아와서 출력 -->
<%=id%>님 로그인 하셨습니다.
<a href="loginForm.jsp">로그인</a>
<a href="logout.jsp">로그아웃</a><br>
<a href="info.jsp">회원정보조회</a>
<a href="updateForm.jsp">회원정보수정</a>
<a href="deleteForm.jsp">회원정보삭제</a>
<%
if(id != null){
	// 세션 id값이 admin일 경우 회원목록이 보이도록 if조건절 사용
	if(id.equals("admin")){
		%>
		<a href="list.jsp">회원목록</a>
		<%
	}
}

%>

</body>
</html>