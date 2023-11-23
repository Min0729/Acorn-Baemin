<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<c:set var="path" value="<%=request.getContextPath()%>"></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Result</title>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style>

/* CSS 스타일 정의 */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

a {
	text-decoration: none;
}

body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column;
	align-items: center;
	height: 100vh;
	align-items: center;
}

.container {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

.login-title {
	text-align: center;
	padding: 20px;
	font-size: 18px;
}

h1 {
	color: #333;
}

.login-form p {
	font-size: 20px;
	color: #555;
}

.login-form {
	background-color: #fff;
	padding: 20px;
	max-width: 360px;
	width: 100%;
	border: 3px solid #82d9d0;
	box-shadow: 0px 0px 5px #ccc;
	border-radius: 10px;
}

.login-form span {
	display: block;
	margin-bottom: 10px;
	font-weight: bolder;
}

input[type="text"], input[type="password"] {
	width: 99%;
	height: 30px;
	padding: 10px;
	font-size: 20px;
	margin-bottom: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.vertical-center {
	line-height: 30px;
	/* 이 값을 조정해서 세로 중앙 정렬의 높이를 조절할 수 있음 */
}

input:focus {
	border-color: #0982f0;
	/* 포커스 시 테두리 색상 설정 */
	outline: none;
	/* 포커스 아웃라인 제거 */
}

input[type="button"] {
	font-weight: bolder;
	font-size: 20px;
	background-color: #82d9d0;
	color: white;
	height: 50px;
	padding: 10px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	width: 250px;
	display: block;
	margin: 0 auto;
}

a {
	color: #007bff;
	text-decoration: none;
}

.options {
	position: relative;
	align-items: center;
	height: 20px;
}

.optlab1 {
	left: 0px;
}

.optlab2 {
	right: 0px;
}

.options label {
	margin-right: 200px;
	/* 각 옵션 사이의 간격 조절 */
	position: absolute;
}

.remember-me {
	display: flex;
	align-items: center;
	font-size: 12px;
}

.remember-links {
	font-size: 15px;
	left: 0px;
}

.signup-link {
	margin-top: 10px;
	text-align: right;
	font-size: 18px;
}

.right-links {
	text-align: right;
}

.kakao {
	margin-top: 20px;
	text-align: center;
}
</style>

</head>

<body>
	<script>
	// 로그인 클릭 시 radio 조건 체크
	function login() {
    const logintypes = document.getElementsByName("logintype");
    let selectedLogintype = null;
    for (let i = 0; i < logintypes.length; i++) {
        let item = logintypes[i];
        if (item.checked) {
            selectedLogintype = item.value;
            break;
        }
    }

    if (selectedLogintype) {
        const form = document.getElementById("loginForm");
        if (selectedLogintype === "customer") {
            form.action = "${path}/login";
        } else if (selectedLogintype === "seller") {
            form.action = "${path}/login2";
        } 
        form.submit();
    } else {
        alert("입력 정보를 확인해주세요.");
    }		
}	
		
// Enter 키 누를 시 로그인 button click과 같은 효과
document.addEventListener("DOMContentLoaded", function() {
	const form = document.getElementById("loginForm");
	
	form.addEventListener("submit", function(event) {
        const userId = document.getElementsByName("userId")[0].value;
        const userPw = document.getElementsByName("userPw")[0].value;

        if (userId === "" || userPw === "") {
            event.preventDefault();
            alert("로그인에 실패했습니다. 입력 정보를 확인해주세요.");
        }
    });

	form.addEventListener("keypress", function(event) {
      	if (event.key === "Enter") {
          event.preventDefault(); 
          login(); 
        }
    });
});
			
		
		
</script>
	<jsp:include page="../base/header_login.jsp" />

	<c:forEach items="${list}" var="item">
	${item}
	</c:forEach>

	<section id="content">
		<div class="container">
			<div id="header-links">
				<c:choose>
					<c:when test="${empty sessionScope.user}">
						<!-- 사용자가 로그아웃 상태인 경우 -->
						<!-- <a href="${path}/login">로그인</a>-->
					</c:when>
					<c:otherwise>
						<!-- 사용자가 로그인 상태인 경우 -->
						<a href="${path}/logout">로그아웃</a>
					</c:otherwise>
				</c:choose>
			</div>
			<!-- 로그인 폼 -->
			<form class="login-form" action="${path}/login" method="post"
				id="loginForm">


				<div class="login-title">
					<h1>로그인</h1>
					<br>
				</div>
				<div class="options">
					<label class="optlab1"> <input type="radio"
						name="logintype" value="customer" checked>손님
					</label> <label class="optlab2"> <input type="radio"
						name="logintype" value="seller">사장님
					</label>
				</div>

				<span></span> <input type="text" name="userId" placeholder="아이디"
					class="vertical-center"> <br> <span></span> <input
					type="password" name="userPw" placeholder="비밀번호"
					class="vertical-center"> <br>

				<!-- 아이디 저장 (Remember Me) 체크박스 -->
				<!-- <label class="remember-me"> <input type="checkbox"
					name="rememberMe"> 아이디 저장
				</label> -->
				<span></span> <span></span>
				<!-- 아이디 찾기와 비밀번호 찾기 링크 -->
				<div class="remember-links right-links">
					<a href="/baemin/findIdForm">아이디 찾기</a> | <a
						href="/baemin/findPwForm">비밀번호 찾기</a>
				</div>
				<span></span><span></span>
				<p class="signup-link">
					<a href="${path}/select_signup">회원가입</a>
				</p>
				<br> <input type="button" id="loginForm" value="로그인"
					onclick="login()">
				<div id="messageDiv">
					<c:if test="${not empty message}">
						<script>
				            alert("${message}");
				        </script>
					</c:if>
				</div>

				<div class="kakao">
					<label class="kakao_login"> <input type="radio"
						name="option" value="kakao">카카오로 간편 로그인
					</label>
				</div>
			</form>

			<a href="javascript:kakaoLogin();"><img src="./kakao_login.png"
				alt="카카오계정 로그인" style="height: 100px;" /></a>

			<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
			<script>
        window.Kakao.init('5e1731c3f7c3d4a983be89d9de5add7e');

        function kakaoLogin() {
            window.Kakao.Auth.login({
                scope: 'profile_nickname, account_email, talk_message', //동의항목 페이지에 있는 개인정보 보호 테이블의 활성화된 ID값을 넣습니다.
                success: function(response) {
                    console.log(response) // 로그인 성공하면 받아오는 데이터
                    window.Kakao.API.request({ // 사용자 정보 가져오기 
                        url: '/v2/user/me',
                        success: (res) => {
                            const kakao_account = res.kakao_account;
                            console.log(kakao_account)
                        }
                    });
                     window.location.href='/baemin/home' //리다이렉트 되는 코드
                },
                fail: function(error) {
                    console.log(error);
                }
            });
        }
            window.Kakao.init('5e1731c3f7c3d4a983be89d9de5add7e');
        	function kakaoLogout() {
            	if (!Kakao.Auth.getAccessToken()) {
        		    console.log('Not logged in.');
        		    return;
        	    }
        	    Kakao.Auth.logout(function(response) {
            		alert(response +' logout');
        		    window.location.href='/baemin/home'
        	    });
        };
    </script>

		</div>
	</section>
	<jsp:include page="../base/footer.jsp" />


</body>

</html>