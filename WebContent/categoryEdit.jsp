<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="default.css">
<meta charset="UTF-8">
<title>카테고리 수정</title>
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
		<div>수정할 카테고리를 선택해주세요!</div>
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
			out.println("category 수정에 실패했습니다.");
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
			<br>
			<div>
				아래에 변경할 카테고리명을 작성하시고, <br> 수정하기 버튼을 눌러주세요!
			</div>
			<br>
			<input type="text" name="editingC">

		

		<input type="submit" value="수정하기"> <input type="hidden"
			name="selection" value="edit">
	</form>
</body>
</html>