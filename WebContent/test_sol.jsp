<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답지</title>
<link type="text/css" rel="stylesheet" href="default.css">
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
var score=0;
var Tid;
var Ttesting;
var link;
var i=0;
function getValues(){
	var Tscore = document.getElementById("Tscore").value;
	if(Tscore==0) {score = 100;}
	else if(i!=0) {score = parseInt(100-(100/i)*Tscore);}
		Tid = document.getElementById("postW").value;
		Ttesting = document.getElementById("Ttesting").value;
		link = "test_saving.jsp?Tid="+Tid+"&Ttesting="+Ttesting+"&Tscore="+score;
		
		window.opener.location.href=link;
		window.close();
	};
	
$(document).ready( function() {
			const text = $('#pC').html();
			const arr = text.split(".");
			var ret_txt = "";
			$('#pC').html(function(index, html) {
				for (var i = 0; i < arr.length; i++) {
					const t = arr[i];
					ret_txt += t + '. <br>';
				}
				return ret_txt;
			}); //.를 기준으로 줄넘김을 위한 함수
		
		
        $('#pC span, #pC font').html(function (index, html) {
            if ($(this).css("background-color") == 'rgb(255, 255, 0)') {
                i++;
            };
        });
        
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

#pC {
	margin-top: 100px;
	padding-left: 30px;
	line-height: 30px;
	font-size: 1.1em;
}
</style>
</head>
<body>

	<%@ include file="dbconn.jsp"%>
	<%
	String postW = request.getParameter("postW");
	int Ttesting = Integer.parseInt(request.getParameter("Ttesting"));
	ResultSet rs = null;
	Statement stmt = null;
	String postC = null;
	try {
		String sql = "select postC from post where postW='" + postW + "'";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
			postC = rs.getString(1);
		}
	} catch (SQLException ex) {
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
	<input type="hidden" id="postW" value='<%=postW%>'>
	<input type="hidden" id="Ttesting" value='<%=Ttesting%>'>
	<nav>
		<div>
			<label for="Tscore">틀린 개수 :</label> <input type="number" value=0
				id="Tscore">
			<button type="button" onclick="getValues()">테스트종료하기</button>
		</div>
	</nav>


	<div id="pC"><%=postC%></div>
</body>
</html>