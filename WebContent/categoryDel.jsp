<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="default.css">
<meta charset="UTF-8">
<title>카테고리 삭제</title>
<style>
body {
	background-color: #0a4f6a;
}

form {
	width :80%;
    padding:40px 10px;
    background-color: #fffcec;
    margin:0 auto;
    text-align:center;
}

li {
	padding: 5px 0px;
	list-style-type:none;
}
ul {
	padding-left:0px;
}

div {
	color: blue;
}
</style>
</head>
<body>
	<%@ include file="dbconn.jsp"%>
	<form method=post action="category_ing.jsp">
		<div style="text-align:center">
			삭제하실 카테고리명을 선택하시고, <br> 삭제하기 버튼을 눌러주세요. 
		</div>
		<div style="color:red; text-align:center"> <br> 카테고리 삭제시 <br> 해당 카테고리 게시글도 같이 삭제됩니다! </div>
		<ul>
			<%
			String id = request.getParameter("id");
			ResultSet rs = null;
			Statement stmt = null;
			try {
				String sql = "select category from categorys where id='" + id + "'";
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					String category = rs.getString("category");
			%>
			<li><%=category%><input type="radio" name="category"
				value=<%=category%>></li>
			<%
			}
			} catch (SQLException ex) {
			out.println("category 추가에 실패했습니다.");
			} finally {
			if (rs != null)
			rs.close();
			if (stmt != null)
			stmt.close();
			if (conn != null)
			conn.close();
			}
			%>

		</ul>
		<input type="submit" value="삭제하기"> <input type="hidden"
			name="selection" value="del">
	</form>
</body>
</html>