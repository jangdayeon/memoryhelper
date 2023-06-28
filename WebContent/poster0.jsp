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
<link type="text/css" rel="stylesheet" href="postForm.css">
<link type="text/css" rel="stylesheet" href="poster.css">
<link type="text/css" rel="stylesheet" href="default.css">

<script>
	function load(URL) {
		window.open(URL, "category",
				"left=100%,top=50%,width=400px,height=400px,overflow=hidden");
	}
</script>
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
	<div id="checking" style="padding-bottom:30px">
		<div class="container" style="width : 760px; margin : 0 auto">
		<br>
				<input type="button" class="btn btn-primary" onclick="location.href='poster.jsp?postW=<%=postW%>'" value="수정하기" style="margin-left:5px"></button>
				<input type="button" class="btn btn-primary" onclick="alert('삭제했습니다');location.href='posting.jsp?postW=<%=postW%>&type=del'" value="삭제하기" style="margin-left:5px"></button>
				<input type="button" class="btn btn-primary" onclick="javascript:load('test_setting.jsp?postW=<%=postW%>')"  value="시험보기" style="margin-left:5px"></button>
				<input type="button" class="btn btn-primary" onclick="javascript:load('test_record.jsp?Tid=<%=postW%>&postT=<%=postT %>')" value="시험기록"></button>
				<table>
					<tr>
						<td id="label">제목</td>
						<td id="con"><%=postT %></td>
					</tr>
					<tr>
						<td id="label" >카테고리</td>
						<td id="con"><%=category %></td>
					</tr>
					<tr>
						<td id="label">업로드시간</td>
						<td id="con"><%=df.format(postW_d)%></td>
					</tr>
					<tr>
						<td id="label">내용</td>
						<td id="con" style="background-color : white; height:fit-content; word-break:break-all"><span><%=postC %></span></td>
					</tr>
					
				</table>
				
		</div></div>
		<footer class="foot">
				<h5>made by 장다연 for 웹서버구축 class</h5>
			</footer>
	</div>
</body>
</html>