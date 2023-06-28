<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="default.css">
    <title>테스트설정</title>
    <style>
    body {
        background-color: #0a4f6a;
    }
    form {
        width: 100%;
        border-top: 1px solid #444444;
        border-collapse: collapse;
    }

    div {
        width :60%;
        padding:10px 40px;
        background-color: #fffcec;
        margin:0 auto;
        text-align: center;
    }
    input {
        margin-bottom: 20px;
    }
    input:nth-child(1){
        margin-top:40px;
    }
    button {
        margin-bottom: 40px;
    }
</style>
</head>
<body>
	<% String postW = request.getParameter("postW"); %>
    <form method="post" action="javascript:testStart()">
        <div>
            <h2> 테스트 설정 </h2>
        제한시간(분) : <input type="number" min="1" max="50" value="0" id="min"><br>
        <!-- 힌트(답 잠깐 확인) : <input type="number" min="0" max="15" value="0" id="hint"> <br> -->
        <button type="submit">테스트 시작하기</button>
        </div>
    </form>
    <script>
    var min;
    var sum;
	function testStart(){
		min = document.getElementById("min").value;
		<!--hint = document.getElementById("hint").value; -->
		hint = 0;
		alert('시험을 시작합니다. 화이팅!');
		window.opener.location.href='test.jsp?postW=<%=postW%>'+'&min='+min+'&hint='+hint;
		window.close();
	}
</script>
</body>
</html>