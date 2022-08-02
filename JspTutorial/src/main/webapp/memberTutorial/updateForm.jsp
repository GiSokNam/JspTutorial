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
<title>memberTutorial/updateForm.jsp</title>
</head>
<body>
<%
// 로그인하면 세션값이 생성 => 페이지 상관없이 값이 유지 => 세션값 가져오기
String id = (String)session.getAttribute("id");

// updateForm 화면에 로그인된 아이디와 관련된 정보를 화면에 보여주기위해
// DB연결이 필요하다

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

// 2단계 JDBC 프로그램 이용해서 디비서버에 접속 => 연결정보 저장
// String dbUrl = "jdbc:mysql://localhost:3306/연결되어야하는 DB명 입력 위치?serverTimezone=UTC";
// DB연결 시 접속 주소
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
// String sql="select * from 테이블이름 where 조건열=값";
String sql = "select * from members where id=?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1, id);

// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
// => sql구문을 실행한 결과 저장하는 내장객체 ResultSet
ResultSet rs = pstmt.executeQuery();

// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
// if  rs.next() 결과에서 다음행 이동하고 데이터 있으면 true => 열접근=> 출력
// 
if(rs.next()){
	%>
<form action="updatePro.jsp" method="post">
<!--action="updatePro.jsp"의 의미 
form에 기입된 id값, pass값, name값이 submit
이벤트 발생 시  method="post" 유형으로 
파라미터값을 request에 담아 updatePro.jsp로 전송 -->

<!-- method의 종류 get방식 과 post방식이 있으며
get방식의 경우 웹페이지 주소창에 form에 기입된 값들이 표시되어
전송되는 방식이며 이로인해 보안상 문제가 발생할수있다는 단점이 존재한다

post방식의 경우 파라미터형식으로 데이터를 끼워 전송해주기 때문에
웹페이지 주소창에 form에 기입된 값들이 표시되지않아 보안상 안전한 방식
 -->
아이디 : <input type="text" name="id" value="<%=rs.getString("id") %>" readonly><br>
비밀번호 : <input type="password" name="pass"><br>
이름 : <input type="text" name="name" value="<%=rs.getString("name") %>"><br>
<input type="submit" value="회원정보수정">
</form>	
	<%
}
%>
<a href="main.jsp">메인으로 이동</a>
</body>
</html>
