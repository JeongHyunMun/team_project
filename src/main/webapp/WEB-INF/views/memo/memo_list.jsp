<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.css">
		<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		
	<script src="${pageContext.request.contextPath}/resources/js/memo.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/memo.css">
</head>

<body>
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container">
			<a class="navbar-brand" href="main.do?mid=${user.id}">DIARY'S</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link"
						href="main.do?mid=${user.id}">홈</a></li>
					<li class="nav-item"><a class="nav-link" style="cursor:pointer;" onclick="location.href='memo_list.do?id=${user.id}'">메모</a></li>
					<li class="nav-item"><a class="nav-link"
						href="list.do?id=${user.id}">가계부</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">공지사항</a></li>
						<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="logout.do">로그아웃</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Page Header-->
<header class="py-5 bg-light border-bottom mb-4" style="background-image:url('${pageContext.request.contextPath}/resources/img/back5.jpg')">
		<div class="text-center my-5">
			<!--                     <h1 class="fw-bolder">Welcome to Blog Home!</h1>
                    <p class="lead mb-0">A Bootstrap 5 starter layout for your next blog homepage</p> -->
		</div>
		</div>
	</header>
	<div id="nav">
	<div id="main_box">
		<div align="center">
		<button type="button" class="btn btn-secondary " value="글쓰기"
				onclick="location.href='memo_insert_form.do?id=${user.id}'">글쓰기</button>

		</div>
		
		<c:forEach var="vo" items="${ list }">
			<div class="visit_box">
				<div class="type_title"> ${vo.title} <span id="regdate">${vo.regdate}</span></div>
				
				<div class="type_content"><pre>${vo.content}<br></pre>
					<c:if test="${vo.filename ne 'no_file' }">
					<img src="/resources/upload/${vo.filename}" width="300px" height="230px"/>
					</c:if>
				</div>

				<div class="type_btn">
					<form method="POST" enctype="multipart/form-data">
						<input type="hidden" name="filename" value="${vo.filename}">
						<input type="hidden" name="id" value="${user.id}">
						<input type="hidden" name="idx" value="${vo.idx}"> 
						<input type="hidden" name="name"  value="${vo.name}">
						<input type="hidden" name="pwd" value="${vo.pwd}"> password 
						<input type="password" name="c_pwd"> 
						<input type="button" value="수정" onclick="modify(this.form);"> 
						<input type="button" value="삭제" onclick="del(this.form);">
						<!-- form태그에있는 name의 파라미터들은 서버쪽으로 넘어갈때 다 넘어간다. -->
					</form>
				</div>
			</div>
		</c:forEach>
	</div>
	</div>
<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>