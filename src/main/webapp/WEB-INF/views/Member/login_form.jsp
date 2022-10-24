<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet" type="text/css" />

	<style>
		#gg {
		width:200px; 
		hegiht:100px;
		border-radius:0.8em;
			background-image:url('${pageContext.request.contextPath}/resources/img/kakao_login_large.png');
			background-size:cover;
			  background-repeat: no-repeat;
  background-position: center;
		}
	</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
<script>
		function send(f) {
			
			let url = "login.do";
			let param = "id="+f.id.value+"&pwd="+f.pwd.value;
			sendRequest( url, param, resultFn, "POST" );
		}
		
		function resultFn() {
			if ( xhr.readyState == 4 && xhr.status == 200 ) {
				
				//no_id, no_pwd, clear 중 하나를 받는다
				//data = [{'res':'no_id'}, {'id':'hong'}]
				var data = xhr.responseText;
				var json = eval(data);
				
				if( json[0].res == 'no_id' ) {
					alert("아이디가 없습니다");
				} else if ( json[0].res == 'no_pwd' ) {
					alert("비밀번호 불일치");
				} else {
					//alert('${user.id}');
					location.href = "main.do?mid="+json[1].id;
					
				}
			}
		}
	</script>

	

</head>


<body>
 <div id="background">       
    <video id="background" src="${pageContext.request.contextPath}/resources/video/background3.mp4" muted autoplay loop></video>
    <div class="btngroup">
        <div class="login" align="center">
            <h3>LOGIN PAGE</h3>
            <form>
                <table border="1">
                    <tr>
                        <td><input class="login_input" type="text" name="id" placeholder="아이디" /></td>
                    </tr>
                    <tr>
                        <td><input class="login_input"  type="password" name="pwd" placeholder="비밀번호" /></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="button" value="로그인" onclick="send(this.form);"/>
                            <input id="login_input2" type="button" value="회원가입" onclick="location.href='insert_form.do'"/>
                        </td>
                    </tr>
                </table>
           </form>
        </div>
        <button id="gg"> ggg</button>
        <ul>
      <li onclick="kakaoLogin();">
        <a href="javascript:void(0)">
            <img src="${pageContext.request.contextPath}/resources/img/kakao_login_large.png">
        </a>
      </li>
  </ul>
  <script>
  //카카오로그인
  function kakaoLogin() {

    $.ajax({
        url: '/getKakaoAuthUrl',
        type: 'get',
        async: false,
        dataType: 'text',
        success: function (res) {
            location.href = res;
        }
    });

  }

  $(document).ready(function() {

      var kakaoInfo = '${kakaoInfo}';

      if(kakaoInfo != ""){
          var data = JSON.parse(kakaoInfo);

          alert("카카오로그인 성공 \n accessToken : " + data['accessToken']);
          alert(
          "user : \n" + "email : "
          + data['email']  
          + "\n nickname : " 
          + data['nickname']);
      }
  });  

  </script>
  
 
</body>
</html>