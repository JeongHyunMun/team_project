<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/memo_write.css">


<script>
	function send(f) {
		let id = "${user.id}";
		f.action = "memo_insert.do?id=" + id;
		f.method = "post";
		f.submit();
	}
</script>



</head>
<body>
	<!--  파일을 전송하는 폼태그에는 아래의 두가지 속성이 반드시 추가되어 있어야 한다 -->
	<form method="POST" enctype="multipart/form-data">
			<input type="hidden" name="id" value="${user.id}">
			<input type="hidden" name="name" value="${user.name}">

		<div class="container" role="main">
			<h2>Memo Write Form</h2>

			<div class="mb-3">
				<label for="title">작성자</label> <input type="text"
					class="form-control" name="title" id="title"
					value="${user.name}" disabled >
			</div>
			<div class="mb-3">
				<label for="reg_id">제목</label> <input type="text"
					class="form-control" name="title" id="reg_id"
					placeholder="제목을 입력해 주세요" value="${vo.title}">
			</div>
			<div class="mb-3">
				<label for="content">내용</label>
								<!-- wrap='on' : textarea에서 작성된 글이 길어서 다음줄로 넘어갔을 때 
								 엔터값으로 인지할 수 있도록 해주는 속성 -->
				<textarea class="form-control" rows="5" name="content" id="content"
					placeholder="내용을 입력해 주세요" wrap='on'></textarea>
			</div>
			<div class="mb-3">
				<label for="pwd">비밀번호</label> <input type="password" class="form-control"
					name="pwd" id="tag" placeholder="비밀번호를 입력해 주세요">
			</div>
			
			
			<div class="mb-3">
			<label for="file">사진첨부</label>
				 <input id="file" type="file" class="form-control"
					name="photo" id="tag" >
			</div>
		<input type="button" class="btn btn-sm btn-primary" id="btnSave" value="글쓰기" onclick="send(this.form);"> 
		<input
			type="button" value="목록으로" class="btn btn-sm btn-primary" id="btnList"
			onclick="location.href='memo_list.do?id=${user.id}'">
	</div>

	</form>

</body>
</html>