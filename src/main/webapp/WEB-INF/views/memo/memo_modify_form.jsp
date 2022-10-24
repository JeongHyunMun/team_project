<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<title>Insert title here</title>

	<script>
		function send(f) {
			let id = "${user.id}";
			let name = f.name.value;
			let content = f.content.value;
			let pwd = f.pwd.value;
			
			//유효성체크 했다쳐
			
			f.action = "memo_modify.do?id=" + id;
			f.method = "post";
			f.submit();
			
		}
	</script>


</head>
<body>
	<form>
		<input type="hidden" name="idx" value="${vo.idx}">
		
		<div class="container" role="main">
			<h2>Memo Modify Form</h2>

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
					placeholder="내용을 입력해 주세요" wrap='on'>${vo.content}</textarea>
			</div>
			
					<input type="button" class="btn btn-sm btn-primary" id="btnSave" value="수정" onclick="send(this.form);">
					<input type="button" class="btn btn-sm btn-primary" id="btnList"value="목록으로" onclick="location.href='memo_list.do?id=${user.id}'">
					</div>

		<input type="hidden" name="pwd" value="${vo.pwd}"></td>
		
	</form>
</body>
</html>