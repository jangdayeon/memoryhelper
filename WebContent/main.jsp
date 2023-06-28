<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.Reader"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.text.SimpleDateFormat"%>

<!doctype html>
<html>

<head>
<link type="text/css" rel="stylesheet" href="default.css">
<link type="text/css" rel="stylesheet" href="main.css">
<link type="text/css" rel="stylesheet" href="poster.css">

<title>MEMORYHELPER</title>
<meta charset="utf-8">
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script>
	function load(URL) {
		var popup = window.open(URL, "category",
				"left=100%,top=100%,width=400px,height=400px");
		
		popup.addEventListener('beforeunload',function(){
			location.reload();
		});
	}
	
	$(document).ready(function() {
		$('dd#art-text').html(function(index, html) {
			return html.replace(/<[^>]*>?/g, '');
		});
		$('dt').html(function(index, html) {
			return html.replace(/<[^>]*>?/g, '');
		});
	});
	
</script>
<style>
dl > a{
	text-decoration:none;
}
dl > a:visited{
	color:#38547B;
}
dl >  a:link{
	color:#1f7eb1;
}
dl > a:hover{
	color:#fff319;
}
</style>
</head>

<body>
	<%@ include file="dbconn.jsp"%>
	<header class="page-header">
		<div class="logo">
			<a href="main.jsp">
				<h2>MEMORYHELPER</h2>
			</a>
		</div>
		<div class="header-right">
			<%
			String user_id = (String) session.getAttribute("UserId");
			%>
			<%=user_id%>님, 환영합니다!
			<button type="button" onclick="location.href='login.html'">로그아웃</button>
			<button type="button" onclick="location.href='postForm.jsp'">글쓰기</button>
		</div>
	</header>
	<div id="bodyAndFooter">
		<section class="middle" style="width:70%; margin:0 auto; min-height:300px">
			<nav class="side" style="margin:20px 0px; min-height:500px">
				<!-- 카테고리 디비 연결해서 배열로 출력 -->
				<p class="sideName">
					<b>카테고리</b>
				</p>
				<ul>
					<%
					ResultSet rs = null;
					Statement stmt = null;
					try {
						String sql = "select distinct category from categorys where id='" + user_id + "'";
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql);

						while (rs.next()) {
							String cat = rs.getString(1);
					%>
					<li id="category"><%=cat%></li>
					<%
					}
					} catch (SQLException ex) {
					out.println("categorys 테이블에서 category 호출을 실패했습니다.");
					} finally {

					}
					%>
				</ul>
				<ul>
					<hr width="125px" align="left">
					<li id="liBtn"><button type="button"
							onclick="javascript:load('categoryAdd.jsp?id=<%=user_id%>')">추가</button></li>
					<li id="liBtn"><button type="button"
							onclick="javacript:load('categoryDel.jsp?id=<%=user_id%>')">삭제</button></li>
					<li id="liBtn"><button type="button"
							onclick="javascript:load('categoryEdit.jsp?id=<%=user_id%>')">수정</button></li>
				</ul>
			</nav>

			<main class="center">
				<%
				rs = null;
				stmt = null;
				try {
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					String sql = "select * from post where id = '" + user_id + "'";
					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql);
					while (rs.next()) {
						String category = rs.getString(2);
						Date postW = rs.getTimestamp(3);
						String postT = rs.getString(4);

						String postC = null;
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
				%>
				<article>
					<dl>
						<a href="poster0.jsp?postW=<%=postW%>"><dt style="word-break:break-all; white-space:nowrap; overflow:hidden; text-overflow:ellipsis">
							<%=postT%>
						</dt></a>
						<dd id="art-cldr">
							<%=df.format(postW)%></dd>
						<dd id="art-text" style="display: -webkit-box; -webkit-box-orient: vertical;-webkit-line-clamp: 5;overflow:hidden; margin-bottom:30px;word-break:break-all;">
							<%=postC%>
						</dd>
					</dl>
				</article>
				
				<%
				}
				} catch (SQLException ex) {
				out.println("post 테이블에서 게시글 호출을 실패했습니다.");
				out.println(ex.getMessage());

				} finally {
				if (rs != null)
				rs.close();
				if (stmt != null)
				stmt.close();
				if (conn != null)
				conn.close();
				}
				%>

			</main>

		</section>
		<footer class="foot">
			<h5>made by 장다연 for 웹서버구축 class</h5>
		</footer>
	</div>
</body>

</html>