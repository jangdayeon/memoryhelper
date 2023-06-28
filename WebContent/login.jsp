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


	<%@ include file="dbconn.jsp" %>
	
	<%
	
	String id = mem.getId();
	String entered_pw = mem.getPw();
	String correct_pw = null; 
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		String sql = "select distinct pw from member where id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		rs = pstmt.executeQuery();
		while(rs.next()){
			correct_pw = rs.getString("pw");
		}
		if(correct_pw!=null){
		if(entered_pw.equals(correct_pw)){
			session.setAttribute("UserId",id);
			response.sendRedirect("main.jsp");	
		}
		else {
	%>
	<script>alert('로그인에 실패했습니다!');history.back(1);</script>
	<%
			
		}
		}
		else {
			%>
			<script>alert('로그인에 실패했습니다!');</script>
			<%
					response.sendRedirect("login.html");
		
		}
		
		if (pstmt != null) pstmt.close();
		if (conn != null) conn.close();
		

	} catch (SQLException ex){
		
		out.println("Member 테이블 삽입이 실패했습니다.<br>");
		out.println("SQLException: "+ex.getMessage());
	} finally {
		
		
		
	}
	
	%>
	
</body>
</html>