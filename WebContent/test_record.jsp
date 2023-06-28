<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테스트기록</title>
<style>
        body {
            background-color: #0a4f6a;
        }
        table {
            width: 100%;
            border-top: 1px solid #444444;
            border-collapse: collapse;
        }

        th,
        td {
            border-bottom: 1px solid #444444;
            border-left: 1px solid #444444;
            padding: 10px;
            background-color: #FCF8DF;
        }

        th:first-child,
        td:first-child {
            border-left: none;
        }
        
        th {
            background-color: #f4e89f;
        }

        div {
            width :80%;
            padding:40px 10px;
            background-color: #fffcec;
            margin:0 auto;
        }
    </style>
    <link type="text/css" rel="stylesheet" href="default.css">
</head>

<body>
	<%@ page import="java.util.ArrayList, javabean.testBean" %>
	<% String postT = request.getParameter("postT"); %>
    <div>
    <h3>테스트 기록</h3>
    <h4>- "<%=postT %>"</h4>
    
    <jsp:useBean id="tdb" class="javabean.testDatabase" scope="page" />
    <%	
    	String Tid = request.getParameter("Tid");
    	ArrayList<testBean> list = tdb.getTestList(Tid);
    	int counter = list.size();
    	if(counter == 0) {%><div style="text-align:center;">테스트 기록이 없습니다. <br>테스트를 시도해보세요!</div>
    	<%}
    	else if(counter > 0) {
    %>
    <table>
        <tr>
            <th>날짜</th>
            <th>점수</th>
            <th>테스트시간</th>
        </tr>
        <% for(testBean t : list) { %>
        <tr>
            <td><%= t.getTwhen()%></td>
            <td><%= t.getTscore()%></td>
            <td><%= t.getTtesting()%></td>
        </tr>
        <% }} %>
    </table>
    </div>
</body>

</html>