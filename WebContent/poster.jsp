<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.Date"%>
<%@ page import="java.io.Reader"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<link type="text/css" rel="stylesheet" href="postForm.css">
<link type="text/css" rel="stylesheet" href="poster.css">
<link type="text/css" rel="stylesheet" href="default.css">
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	%>
	<%@ include file="dbconn.jsp"%>
	<%@ page import="javabean.postBean"%>
	<%
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String id = "";
	String category = "";
	String postW = request.getParameter("postW");
	String postT = "";
	String postC = "";
	Date postW_d = null;

	ResultSet rs = null;
	Statement stmt = null;
	try {

		String sql0 = "select * from post where postW = '" + postW + "'";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql0);
		while (rs.next()) {
			id = rs.getString(1);
			category = rs.getString(2);
			postW_d = rs.getTimestamp(3);
			postT = rs.getString(4);
			postC = null;
			Reader reader = null;
			try {
		reader = rs.getCharacterStream("postC");
		if (reader != null) {
			StringBuilder buff = new StringBuilder();
			char[] ch = new char[512];
			int len = -1;

			while ((len = reader.read(ch)) != -1) {
				buff.append(ch, 0, len);
			}

			postC = buff.toString();
		}
			} catch (IOException ex) {
		out.println("익셉션 발생:" + ex.getMessage());
			} finally {

		if (reader != null)
			reader.close();
			}
		}
	} catch (SQLException ex) {
		out.println("post 테이블에서 게시글 호출을 실패했습니다.");
		out.println(ex.getMessage());

	} finally {
	}
	%>
	<header class="page-header">
		<div class="logo">
			<a href="main.jsp">
				<h2>MEMORYHELPER</h2>
			</a>
		</div>
		<div class="header-right">
			<%
			session.setAttribute("UserId",id);
			%>
			<%=id%>님, 환영합니다!
			<button type="button" onclick="location.href='login.html'">로그아웃</button>
			<button type="button" onclick="location.href='postForm.jsp?UserId=<%=id%>'">글쓰기</button>
		</div>
	</header>
	<br>

	<div id="bodyAndFooter">
		<div class="container" style="width : 760px">

			<form method="post" action="posting.jsp?postW=<%=postW%>">
				<input type="hidden" name="type" value="edit">
				<table>
					<tr>
						<td id="label">제목</td>
						<td id="con"><input type="text" value=<%=postT%> name="postT"
							required="required" /></td>
					</tr>
					<tr>
						<td id="label" >카테고리</td>
						<td id="con"> <select id="category_sel" name="category_sel"> <!-- category 변수 중복으로 이름 바꿈 -->
								<%
								rs = null;
								stmt = null;
								String cat = null;
								try {
									String sql = "select distinct category from categorys where id='" + id + "'";
									stmt = conn.createStatement();
									rs = stmt.executeQuery(sql);
									while (rs.next()) {
										cat = rs.getString(1);
										if (category.equals(cat)) {
								%>
								<option value="<%=cat%>" selected><%=cat%></option>
								<%
								} else {
								%>
								<option value="<%=cat%>"><%=cat%></option>
								<%
								}
								}
								} catch (SQLException ex) {
								out.println("categorys 테이블에서 category 호출을 실패했습니다.");
								} finally {

								}
								%>
						</select></td>
					</tr>
					<tr>
						<td id="label">업로드시간</td>
						<td id="con"><%=df.format(postW_d)%></td>
					</tr>
					<tr><td><div style="color: #165e9a; text-align:center; font-size:1.2em;"><br>테스트 팁! <span style="background-color:yellow;">Yellow 형광팬</span>으로 칠한 부분이 문제로 나오니 원하는 곳에 <span style="background-color:yellow;">Yellow 형광팬</span>으로 칠해주세요:D</div></td></tr>
					
					<tr>
						<td id="label">내용</td>
						<td id="con"><textarea name="postC" id="summernote"><%=postC %></textarea></td>
					</tr>
					
				</table>
				<br>
				<button type="submit" class="btn btn-primary" onclick="alert('수정했습니다');">수정 완료</button>
			</form>
		</div>
		<footer class="foot">
				<h5>made by 장다연 for 웹서버구축 class</h5>
			</footer>
	</div>
	<script>
		$(document)
				.ready(
						function() {
							$("#summernote")
									.summernote(
											{
												height: 300,
												width: 700,
												disableResizeEditor:true,
												toolbar : [
														// [groupName, [list of button]]
														[
																'style',
																[
																		'bold',
																		'italic',
																		'underline',
																		'clear' ] ],
														[
																'font',
																[
																		'strikethrough',
																		'superscript',
																		'subscript' ] ],
														[ 'fontsize',
																[ 'fontsize' ] ],
														[ 'color', [ 'color' ] ],
														[
																'para',
																[ 'ul', 'ol',
																		'paragraph' ] ],
														[ 'height',
																[ 'height' ] ] ]
											});
						});
	</script>

</body>
</html>