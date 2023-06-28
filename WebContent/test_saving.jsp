<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import ="java.util.Date"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
		<%
		String Tid = request.getParameter("Tid");
		int Ttesting = Integer.parseInt(request.getParameter("Ttesting"));
		int Tscore = Integer.parseInt(request.getParameter("Tscore"));
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		String postC = null;
		try {
			out.println(Tid);
			
			String sql = "insert into test values(?,sysdate(),?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,Tid);
			pstmt.setInt(2,Tscore);
			pstmt.setInt(3,Ttesting);
			
			pstmt.executeUpdate();
		}
		 catch (SQLException ex) {
			out.println("test 테이블에서 test record insert를 실패했습니다.");
			out.println("SQLException: "+ex.getMessage());
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
			
			response.sendRedirect("main.jsp");
		}
		%>
</body>
</html>