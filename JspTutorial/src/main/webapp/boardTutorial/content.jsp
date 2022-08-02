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
<title>boardTutorial/content.jsp</title>
</head>
<body>
<!-- http://localhost:8080/JspTutorial/boardTutorial/content.jsp?num=1 -->
<%
// request에서 num파라미터 가져오기
// String -> int형으로 형변환
int num = Integer.parseInt(request.getParameter("num"));

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
//위와 같은 코드도 가능하지만 코드가 길어지고 가독성이 떨어져 변수에 저장하여 아래와 같이 사용
Connection con = DriverManager.getConnection(dbUrl, dbId, dbPass);

// 3단계 연결정보를 이용해서 sql구문을 만들기 => PreparedStatement 내장객체 준비
// String sql = "select * from 테이블이름 where 조건열=값";
String sql = "select * from board where num=?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setInt(1, num);

// 4단계 sql구문을 실행 => 실행 결과 저장(select) 
// => sql구문을 실행한 결과 저장하는 내장객체 ResultSet
ResultSet rs = pstmt.executeQuery();

// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
// if  rs.next() 결과에서 다음행 이동하고 데이터 있으면 true => 열접근=> 출력
if(rs.next()){
	%>
<table border="1">
<tr><td>글번호</td><td><%=rs.getInt("num") %></td>
    <td>글쓴날짜</td><td><%=rs.getTimestamp("date") %></td></tr>
<tr><td>글쓴이</td><td><%=rs.getString("name") %></td>
    <td>조회수</td><td><%=rs.getInt("readcount") %></td></tr>
<tr><td>글제목</td><td colspan="3"><%=rs.getString("subject") %></td></tr>
<tr><td>글내용</td><td colspan="3"><%=rs.getString("content") %></td></tr>
<tr><td colspan="4">
<input type="button" value="글수정" onclick="location.href='updateForm.jsp?num=<%=rs.getInt("num")%>'">
<input type="button" value="글삭제" onclick="location.href='deleteForm.jsp?num=<%=rs.getInt("num")%>'"></td></tr>
</table>	
	<%
}
%>
<a href="list.jsp">글목록</a>
</body>
</html>