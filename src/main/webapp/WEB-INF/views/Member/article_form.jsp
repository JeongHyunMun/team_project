<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.6.0.js"></script> -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css" />

<script>
	function send(f) {		
		
		document.getElementById("id").value = document.getElementById("userid").innerHTML;

		/* 	f.action="Article.do?id="+${user.id};
		 f.method="post"; */
		f.submit();
	}

	$(function() {

		$(".datepicker").datepicker({
			dateFormat : "yy/m/d"
		}).val();

	});
</script>
</head>
<body>
	<form method="POST" action="Article_insert.do">
		<table border="1" align="center">
			<input type="hidden" name="id" id=id>
			<caption>:::새 일정 쓰기:::</caption>
			<tr>
				<th>제목</th>
				<td><input name="title"></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td id="userid">${user.id}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" rows="10" cols="70"></textarea></td>
			</tr>
			<tr>
				<th>시작날짜</th>
				<td><input class="datepickerf" id="f_date"></td>
			</tr>
			<tr>
			<tr>
				<th>끝나는날</th>
				<td><input class="datepickerl" id="l_date"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="button"
					value="일정등록하기" onclick="send(this.form);"> <input
					type="button" value="메인으로" onclick="location.href='main.do'">
			</tr>
		</table>
	</form>
</body>
</html>