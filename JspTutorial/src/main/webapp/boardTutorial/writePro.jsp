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
<title>boardTutorial/writePro.jsp</title>
</head>
<body>
<%
// 글 작성 시 한글이 사용되므로 한글 사용시 글자 깨짐을 방지하기위해
// post request 한글처리
request.setCharacterEncoding("utf-8");

// request name pass subject content 파라미터 값 가져오기 => 변수 저장
// 파라미터 값을 가져오기 위한 코드 : request.getParameter("input태그의 name값을 입력");
String name = request.getParameter("name");
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

// 조회수
int readcount = 0;

//JDBC를 사용하여 DB에 접근하는 일반적인 순서
//1. Driver 클래스 로드
//2. DB 연결을 위한 Connection 객체 생성
//3. SQL을 담는 Statement 또는 PreparedStatement 객체 생성
//4. SQL 실행
//5. 리소스 정리

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

// num구하기 1씩 증가
int num = 0;
String sql = "select max(num) from board";
PreparedStatement pstmt = con.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();
if(rs.next()){
	num = rs.getInt("max(num)")+1;
}

// 3단계 연결 정보를 이용해서 sql구문 만들기 => preparedStatement 내장객체 준비
// String sql = "insert into 테이블이름(컬럼명,컬럼명..) values(컬럼값,컬럼값....);
// 날짜 now()
sql = "insert into board(num,name,pass,subject,content,readcount,date) values(?,?,?,?,?,?,now())";
pstmt = con.prepareStatement(sql);
pstmt.setInt(1, num);
pstmt.setString(2, name);
pstmt.setString(3, pass);
pstmt.setString(4, subject);
pstmt.setString(5, content);
pstmt.setInt(6, readcount);

// 4단계 sql구문을 실행 (insert)
pstmt.executeUpdate();

// 글목록 이동
response.sendRedirect("list.jsp");
%>
<%-- 글등록 성공 확인: <%=pstmt %> --%> 
</body>
</html>