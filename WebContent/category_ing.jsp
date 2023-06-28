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
	<jsp:useBean id="cat" class="javabean.categorysBean" scope="page"/>
	
	<jsp:setProperty name="cat" property="category" param="category"/>
	<jsp:setProperty name="cat" property="id" param="id"/>


	<%@ include file="dbconn.jsp" %>
	 <% String selection = request.getParameter("selection"); %>
	<%
	if(selection.equals("add")){
	String category = cat.getCategory();
	String id = cat.getId();
	PreparedStatement pstmt = null;
	
	try{
		String sql = "insert into categorys values(?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,category);
		pstmt.setString(2,id);
		
		pstmt.executeUpdate();
		%>
		<script>alert('카테고리 추가 성공!');
		opener.parent.location.reload();
		window.close();</script>
		<%

	} catch (SQLException ex){
		
		out.println("Member 테이블 삽입이 실패했습니다.<br>");
		out.println("SQLException: "+ex.getMessage());
	} finally {
		
		if (pstmt != null) pstmt.close();
		if (conn != null) conn.close();
		
		//response.sendRedirect("main.jsp");
	}
	} 
	else if (selection.equals("del")){
		String category = request.getParameter("category");
		String id = cat.getId();
		PreparedStatement pstmt = null;
		
		try{
			String sql= "delete from categorys where category ='"+category+"'";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			pstmt = null;
			sql= "delete from post where category ='"+category+"'";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			%>
			<script>alert('카테고리 삭제 성공!');
			opener.parent.location.reload();
			window.close();</script>
			<%
		} catch (SQLException ex){
			
			out.println("Member 테이블 삭제이 실패했습니다.<br>");
			out.println("SQLException: "+ex.getMessage());
		} finally {
			
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
			
			//response.sendRedirect("main.jsp");
		}
	}
	else if(selection.equals("edit")){
		String category = request.getParameter("category");
		String editingC = request.getParameter("editingC");
		PreparedStatement pstmt = null;
		
		try{
			String sql= "update categorys set category ='"+editingC+"' where category = '"+category+"'";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			%>
			<script>alert('카테고리 수정 성공!');
			opener.parent.location.reload();
			window.close();</script>
			<%
		} catch (SQLException ex){
			
			out.println("Member 테이블 수정이 실패했습니다.<br>");
			out.println("SQLException: "+ex.getMessage());
		} finally {
			
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
			
			//response.sendRedirect("main.jsp");
		}
	}
	
		
	%>
	
</body>
</html>