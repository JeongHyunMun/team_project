	function del(f){
		var id = "${user.id}";
		var pwd = f.pwd.value;//원본 비밀번호
		var c_pwd=f.c_pwd.value;//비교를 위한 비밀번호
		
		if(pwd != c_pwd){
		alert('비밀번호가 달라용');
		return;
		}
		//Ajax를 통해 idx를 서버로 전송
		var url="memo_delete.do?id="+id;
		var param="&idx="+f.idx.value + "&filename="+f.filename.value;
		//delete.do?idx=1   &pwd=1111&c_pwd=1111
		sendRequest(url,param,resultFunc,"Post");
	}
	//삭제 결과를 확인할 콜백 메서드
	function resultFunc(){
		var id = "${user.id}";
		if(xhr.readyState == 4 && xhr.status==200){
			//컨트롤러에서 삭제 후 return해준 데이터를 받는다
			var data = xhr.responseText;
			if(data =='no'){
				alert("삭제실패");
				return;
			}else{
				alert("삭제성공");
				location.href="memo_list.do?id="+id;
			}
			
		}
	}


	/* 수정버든 클릭 */
	function modify(f) {
		var pwd = f.pwd.value; // 원본 비밀번호 
		var c_pwd = f.c_pwd.value; // 비교를 위한 비밀번호

		if (pwd != c_pwd) {
			alert('비밀번호가 다릅니다');
			return;
		}
		
		f.action = "memo_modify_form.do";
		f.method="post";
		f.submit();
	}