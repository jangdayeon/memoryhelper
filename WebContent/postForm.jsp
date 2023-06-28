<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>




<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
  <link type="text/css" rel="stylesheet" href="default.css">
  <link type="text/css" rel="stylesheet" href="postForm.css">
  <link type="text/css" rel="stylesheet" href="poster.css">
  
<style>
form {
	text-align: left;
}
</style>
</head>
<body>
	<%request.setCharacterEncoding("UTF-8");%>
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
			<button type="button" onclick="location.href='postForm.jsp?UserId=<%=user_id%>'">글쓰기</button>
		</div>
	</header><br>

	<div id="bodyAndFooter">
	<div class="container">
		<%@ include file="dbconn.jsp" %>
		<form method=post action="posting.jsp">
		<input type="hidden" name="type" value="add">
		<input type="hidden" name="id" value="<%=user_id%>">
			<div class="form-group">
				<select name="category" style="width:20%; padding:8px; float:right; margin-bottom : 25px">
					<%
						ResultSet rs = null;
						Statement stmt = null;
						try{
							String sql = "select distinct category from categorys where id='"+user_id+"'";
							stmt = conn.createStatement();
							rs=stmt.executeQuery(sql);
							while(rs.next()){
							String cat = rs.getString(1);
					%>
					
					<option value="<%=cat%>"><%=cat%></option>
					<%
        			}
        		} catch (SQLException ex) {
        			out.println("categorys 테이블에서 category 호출을 실패했습니다.");
        		} finally {
        			
        		}
            %>
					</select>
				<input type="text" class="form-control" placeholder="제목을 입력하세요" name="postT"
					required="required" /> 
					
			</div>
			<div style="color: #165e9a; text-align:center; font-size:1.2em;"><br>테스트 팁! <span style="background-color:yellow;">Yellow 형광팬</span>으로 칠한 부분이 문제로 나오니 원하는 곳에 <span style="background-color:yellow;">Yellow 형광팬</span>으로 칠해주세요:D</div>
			<br>		
			
  			<textarea name="postC" style="text-align:left" id="summernote"></textarea>
  
			<br>
			<button type="submit" class="btn btn-primary" onclick="alert('추가했습니다');">글쓰기 완료</button>
		</form>
	</div>
	<footer class="foot">
    <h5>made by 장다연 for 웹서버구축 class</h5>
</footer>
</div>
<script>
        $(document).ready(function() {
        	$.summernote.options.lang = 'utf-8';
            $.summernote.options.airMode = false;
           
          $("#summernote").summernote({
        	  height: 600,
        	  placeholder : "글을 입력하세요",
				disableResizeEditor:true,
				disableDragAndDrop: true,
				dialogsFade: true,
				shortcuts: false,
				tabDisable: false,
				codeviewFilter: false,
				  codeviewIframeFilter: true,
				  
              toolbar: [
            	    // [groupName, [list of button]]
            	 
            	    ['style', ['bold', 'italic', 'underline', 'clear']],
            	    ['font', ['strikethrough', 'superscript', 'subscript']],
            	    ['fontsize', ['fontsize']],
            	    ['color', ['color']],
            	    ['para', ['ul', 'ol', 'paragraph']],
            	    ['codeview']
            	  ]
          });
        });
</script>
</body>
</html>