<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%request.setCharacterEncoding("UTF-8"); %>
	<jsp:useBean id="mem" class="javabean.memberBean" scope="page"/>
	
	<jsp:setProperty name="mem" property="id" param="id"/>
	<jsp:setProperty name="mem" property="pw" param="pw"/>
	<jsp:setProperty name="mem" property="birth" param="birth"/>

	<%@ include file="dbconn.jsp" %>
	
	<%
	
	String id = mem.getId();
	String pw = mem.getPw();
	String birth = mem.getBirth();
	
	PreparedStatement pstmt = null;
	
	try{
		String sql = "insert into member(id, pw, birth) values(?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		pstmt.setString(2,pw);
		pstmt.setString(3,birth);
		pstmt.executeUpdate();
		

	} catch (SQLException ex){
		
		out.println("Member 테이블 삽입이 실패했습니다.<br>");
		out.println("SQLException: "+ex.getMessage());
	} finally {
		
		if (pstmt != null) pstmt.close();
		if (conn != null) conn.close();
		
		response.sendRedirect("login.html");
	}
	
	%>
	
</body>
</html>