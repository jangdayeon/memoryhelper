<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.Date"  %>
<%@ page import="java.io.Reader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%request.setCharacterEncoding("UTF-8");%>
	<jsp:useBean id="post" class="javabean.postBean" scope="page"/>
	
	<jsp:setProperty name="post" property="id" param="id"/>
	
	
	<jsp:setProperty name="post" property="postT" param="postT"/>
	<jsp:setProperty name="post" property="postC" param="postC"/>
	
	<%@ include file="dbconn.jsp" %>
	<% String type = request.getParameter("type"); %>
	<%
	String id = post.getId();
	String postT = post.getPostT();
	String postC = post.getPostC();
	
	PreparedStatement pstmt = null;
	
	try{
		if(type.equals("add")){
			%>
			<jsp:setProperty name="post" property="category" param="category"/>
			<%
			String category = post.getCategory();
		String sql = "insert into post values(?,?,sysdate(),?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		pstmt.setString(2,category);
		
		pstmt.setString(3,postT);
		pstmt.setString(4,postC);
		
		pstmt.executeUpdate();
		
		}
		else if(type.equals("edit")){%>
			
			<jsp:setProperty name="post" property="category" param="category_sel"/><%
				String postW = request.getParameter("postW");
				String category = post.getCategory();
				
				String sql = "update post set category = ?, postT = ?, postC = ? where postW = ?;";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,category);
				pstmt.setString(2,postT);
				
				pstmt.setString(3,postC);
				pstmt.setString(4,postW);
				pstmt.executeUpdate();
				
		}
		else if(type.equals("del")){
			String postW = request.getParameter("postW");
			String sql = "delete from post where postW = ?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, postW);
			pstmt.executeUpdate();
			
		}
	} catch (SQLException ex){
		
		out.println("post 테이블 삽입이 실패했습니다.<br>");
		out.println("SQLException: "+ex.getMessage());
	} finally {
		
		response.sendRedirect("main.jsp");	
		if (pstmt != null) pstmt.close();
		if (conn != null) conn.close();
	}
	%>
</body>
</html>