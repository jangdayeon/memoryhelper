<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ page import="java.io.Reader"%>
<%@ page import="java.io.IOException"%>
<!DOCTYPE html>
<html>
<head>
<title>test</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<link type="text/css" rel="stylesheet" href="default.css">
<script>
	var Ttesting = 0;
	$(document)
			.ready(
					function() {
						const text = $('#under').html();
						const arr = text.split(".");
						var ret_txt = "";
						$('#under').html(function(index, html) {
							for (var i = 0; i < arr.length; i++) {
								const t = arr[i];
								ret_txt += t + '. <br>';
							}
							return ret_txt;
						}); //.를 기준으로 줄넘김을 위한 함수

						$('#under span')
								.html(
										function(index, html) {
											if ($(this).css("background-color") == 'rgb(255, 255, 0)') {
												return '<input type="text" width="50px" id="span_'+index+'">';
											}
										});
						$('#under font').html(function(index, html){
			                if ($(this).css("background-color")== 'rgb(255, 255, 0)'){
			                    return '<input type="text" width="50px" placeholder="'+index+'" id="span_'+index+'">';
			                }
			            });

						$('#btn').click(function() {
							clearInterval(intervalId);
							timerElement.textContent = "타이머 종료!";
							alert("타이머 종료!");
							submit(Ttesting);
						});

						function submit(t) {
							alert("시험을 종료합니다. 답지를 확인하시고, 답지의 공백란에 틀린 개수를 적어주세요.");
							$("input").attr("readonly", true);
							var postW = document.getElementById("postW").value;
							var popup = window.open("test_sol.jsp?postW="+postW+"&Ttesting="+t, "답지",
									"left=100%,top=100%,width=800px,height=1200px");

						}
						;

						//////////////////////////////타이머////////////////////////

						var minutesInput = document.getElementById("min");
						var minutes = parseInt(minutesInput.value);
						var milliseconds = minutes * 60 * 1000; // 분을 밀리초로 변환
						var timerElement =null;
						var i=0;
						// 타이머 화면 업데이트 함수
						function updateTimer() {
							timerElement = document.getElementById("timer");
							var seconds = milliseconds / 1000;
							var displayMinutes = Math.floor(seconds / 60);
							var displaySeconds = Math.floor(seconds % 60);
							
							timerElement.textContent = displayMinutes
									.toString().padStart(2, "0")
									+ ":"
									+ displaySeconds.toString()
											.padStart(2, "0");

							milliseconds -= 1000; // 1초씩 감소
							i+=1;
							if(i%60==0) {Ttesting +=1;}
							if (milliseconds < 0) {
								clearInterval(intervalId);
								timerElement.textContent = "타이머 종료!";
								alert("타이머 종료!");
								submit(Ttesting);
							}
						}

						updateTimer(); // 초기 화면 설정

						var intervalId = setInterval(updateTimer, 1000); // 1초마다 화면 업데이트

						///////////////////////////////////////////////////////
					});
</script>
<style>
nav {
	background-color: #DBEBF4;
	position: fixed;
	z-index: 1;
	width: 100%;
	text-align: right;
	padding-right: 40px;
	top: 10px;
	padding-bottom: 10px;
	padding-top: 10px;
}

div {
	padding-right: 30px;
}

#under {
	margin-top: 100px;
	padding-left:30px; 
	line-height:30px;
	font-size:1.4em;
}
</style>
</head>
<body>
	<%
	int min = Integer.parseInt(request.getParameter("min"));
	int hint = Integer.parseInt(request.getParameter("hint"));
	String postW = request.getParameter("postW");
	%>
	<%@ include file="dbconn.jsp"%>
		<%
		ResultSet rs = null;
		Statement stmt = null;
		String postC = null;
		try {
			String sql = "select postC from post where postW='" + postW + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			Reader reader = null;
			while(rs.next()){
			postC = rs.getString(1);}
		}
		 catch (SQLException ex) {
			out.println("post 테이블에서 postC 호출을 실패했습니다.");
		} finally {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		}
		%>
	<input type="hidden" id="min" value=<%=min%>>
	<input type="hidden" id="postW" value='<%=postW%>'>
	<header>
		<nav>
			<div>
				남은시간 : <span id="timer"></span> <input type="button"
					value="제출 및 답 확인" id="btn">
			</div>
		</nav>
	</header>
	<section id="under">
		<!-- 아래는 해당 문자 -->
		
		<%=postC%>
	</section>


</body>

</html>