<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberTutorial/info.jsp</title>
</head>
<body>
<%
// 로그인하면 세션값이 생성 => 페이지 상관없이 값이 유지 => 세션값 가져오기
String id = (String)session.getAttribute("id");

// JDBC를 사용하여 DB에 접근하는 일반적인 순서
// 1. Driver 클래스 로드
// 2. DB 연결을 위한 Connection 객체 생성
// 3. SQL을 담는 Statement 또는 PreparedStatement 객체 생성
// 4. SQL 실행
// 5. 리소스 정리

// 1단계 JDBC Driver 로드
// JDBC Driver 로드 코드 :  Class.forName("JDBC Driver 주소");
// Class.forname()을 통해 MySQL DBMS에 접근할 수 있는 JDBC Driver클래스가
// Class Loader에 의해 Load된다.
Class.forName("com.mysql.cj.jdbc.Driver");
// 2단계 JDBC 프로그램 이용해서 DB서버에 접속 => 연결정보 저장
// String dbUrl = "jdbc:mysql://localhost:3306/연결되어야하는 DB명 입력 위치?serverTimezone=UTC";
// DB연결 주소
String dbUrl = "jdbc:mysql://localhost:3306/jspdb1?serverTimezone=UTC";
// DB연결 시 접속 아이디
String dbId = "root";
// DB연결 시 접속 아이디 비밀번호
String dbPass = "1234";
// DB연결 정보를 Connection형 con변수에 저장
// Connection con = DriverManager.getConnection(DB접속 주소, DB접속 아이디, DB접속 비밀번호);
// Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jspdb1?serverTimezone=UTC", "root", "1234");
// 위와 같은 코드도 가능하지만 코드가 길어지고 가독성이 떨어져 변수에 저장하여 아래와 같이 사용
Connection con = DriverManager.getConnection(dbUrl, dbId, dbPass);

// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
// String sql = "select * from 테이블이름 where 조건열=값";
String sql = "select * from members where id=?";
PreparedStatement pstmt = con.prepareStatement(sql);
// request에서 가져온 파라미터 id값을 입력 
pstmt.setString(1, id);

// 4단계 sql구문을 실행 =>실행 결과 저장(select)
// => sql구문을 실행한 결과 저장하는 내장객체 ResultSet
ResultSet rs = pstmt.executeQuery();



%>
<table border="1">
<%
// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
// if(rs.next()) 결과에서 다음행 이동하고 데이터 있으면 true => 아이디 일치 
//                                                  => 아이디와 일치된 정보 출력
// else										   false => 아이디 없음

if(rs.next()) {
	%>
	<tr>
	 <th>아이디</th>
	 <th>비밀번호</th>
	 <th>이름</th>
	 <th>가입날짜</th>
	</tr>
	<tr>
	 <td><%=rs.getString("id") %></td>
	 <td><%=rs.getString("pass") %></td>
	 <td><%=rs.getString("name") %></td>
	 <td><%=rs.getString("date") %></td>
	</tr>
	<%
} else {
	%> 
	<%="로그인이 필요합니다." %>
	<% 
}
%>
</table>
<a href="main.jsp">메인으로 이동</a>
</body>
</html>