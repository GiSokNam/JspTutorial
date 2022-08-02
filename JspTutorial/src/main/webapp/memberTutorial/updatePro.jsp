<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberTutorial/updatePro.jsp</title>
</head>
<body>
<%
// 회원정보 업데이트 시 한글이 사용되므로 한글 깨짐을 방지하기위해
// post request 한글처리
request.setCharacterEncoding("utf-8");

// request id pass name 파라미터 값 가져오기 => 변수 저장
// 파라미터 값을 가져오기 위한 코드 : request.getParameter("input태그의 name값을 입력");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");

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
// String sql = "select * from 테이블이름 where 조건열=값 and 조건열=값";
String sql = "select * from members where id=? and pass=?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1, id);
pstmt.setString(2, pass);

// 4단계 sql구문을 실행=> 실행 결과 저장(select) 
// => sql구문을 실행한 결과 저장하는 내장객체 ResultSet
ResultSet rs = pstmt.executeQuery();

// 5단계 결과를 가지고 출력하거나 배열변수 저장(select)
// if  rs.next() 결과에서 다음행 이동하고 데이터 있으면 true => 아이디 비밀번호 일치
//       //3단계 수정 String sql="update 테이블이름 set 수정열=값 where 조건열=값";
//       //4단계 sql구문을 실행 (insert, update, delete)
//       // main.jsp 이동
// else                              데이터 없으면 false => 아이디 비밀번호 틀림
//                                   // 아이디 비밀번호 틀림메시지 출력 , 뒤로이동
if(rs.next()){
	// 5단계 결과 값을 가지고 DB수정을 위해 
	// 3단계 수정 String sql = "update 테이블이름 set 수정열=값 where 조건열=값";
	sql = "update members set name=? where id=?";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1, name);
	pstmt.setString(2, id);
	
	// 4단계 sql구문을 실행 (update)
	pstmt.executeUpdate();
	
	// main.jsp 이동
	response.sendRedirect("main.jsp");
}else{
	%>
	<script type="text/javascript">
		alert("아이디 비밀번호 틀림");
		history.back();
	</script>
	<%
}
%>
</body>
</html>