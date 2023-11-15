<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
	display: flex;
	flex-direction: column;
	align-items: center;
	height: 100vh;
}
section{
padding-top: 0px;
}


.nav-var {
	padding: 130px 0px 10px 0px;
	font-size: 20px;
	font-weight: bolder;
	display: flex;
	width: 1280px;
	margin: 0 auto;
	justify-content: space-between;
}

hr {
	margin: 0 auto;
	width: 100%;
	border-width: 2px;
}

.menu-img {
	width: 200px;
	height: 200px;
	background-color: purple;
	margin: 20px auto;
	padding: 10px;
}

.menu-name {
	text-align: center;
	margin: 10px auto;
	font-size: 35px;
	margin: 0 auto;
	padding: 20px;
	width: 70%;
	border-top: 1px solid gray;
}

.option-list-wrap {
	width: 70%;
	border: 1px solid black;
	margin: 0 auto;
	padding: 20px 40px 20px 40px;
}

.option-category {
	font-size: 25px;
}

.option-list {
	padding-bottom: 20px;
}

.plus-cart-but {
	display: flex;
	width: 100%;
	justify-content: center;
}
</style>

<script>

let resultArr = [];
let optionString ="" ;
function insertCart(){
	
	
	let option = 'input[name="option"]:checked';
	let optionList = document.querySelectorAll(option);
	resultArr = [];
	  optionList.forEach((el) => {
	    resultArr.push(el.value );
	  });
	  
	  console.log(resultArr);
	  
	  optionString = resultArr.toString();  //
	  
	  
   
}


function sendOptionJson() {
    alert("작동  !!");
    console.log(resultArr);
    
    let test  = { options :resultArr };
  
    
    optionString = resultArr.toString();  
  
    document.frm.options.value  = optionString;
    
    
    alert(    document.frm.options.value  );
    document.frm.submit();
    
    
    /*
    $.ajax({
        type: "POST", // 요청 유형을 POST로 변경
        url: "/baemin/cartList",
        contentType: "application/json",
        data: JSON.stringify({ options: optionString }), // 데이터를 요청 본문에 보냄
        success: function(data) {
            console.log("/cartList로 데이터 성공적으로 전송");
           
        },
        error: function(error) {
            // 에러 처리
            console.error("/cartList로 데이터 전송 중 오류 발생", error);
        }
    });*/
}



</script>

</head>
<body>
	<jsp:include page="../base/header.jsp" />
		<nav class="nav-var">
		<a href="">치킨</a><a>피자</a><a>햄버거</a><a>족발,보쌈</a><a>한식</a><a>중식</a><a>일식</a><a>양식</a><a>분식</a><a>디저트</a><a>야식</a>
	</nav>
	<section class="content">

	<hr>
		<div>
			<form  name="frm"   method="post"  action="/baemin/cartList?menuCode=${menuCode}">
				<div>
					<div class="menu-img"></div>
					<div class="menu-name">메뉴선택에서 불러와야함</div>
				</div>
				<div class="option-list-wrap">
					<c:forEach items="${Categorylist}" var="item">
						<div>
							<span class="option-category">${item}</span><br>
							<c:forEach items="${list}" var="items">
								<c:if test="${item eq items.optionCategory}">
									<c:choose>
										<c:when test="${items.optionSelectType eq 1 }">
											<div class="option-list">
												<input type="radio" name="option"
													value="${items.optionCode}" onclick="insertCart()">
												<span>${items.optionName}</span> <span>${items.optionPrice}</span>
												<input type="hidden" name="${items.optionCode}"
													value="${items.optionCode}">
											</div>
										</c:when>
										<c:otherwise>
											<div class="option-list">
												<input type="checkbox" name="option"
													value="${items.optionCode} ${items.optionName}  ${items.optionPrice} " onclick="insertCart()">
												<span>${items.optionName}</span> <span>${items.optionPrice}</span>
												<input type="hidden" name="${items.optionCode}"
													value="${items.optionCode}">
											</div>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:forEach>
						</div>
					</c:forEach>
					<input type="text"  name="options">
				</div>

				<div class="plus-cart-but">
					<button type="button"   onclick="sendOptionJson()">장바구니에 추가</button>
				</div>
			</form>
		</div>

	</section>
	<jsp:include page="../base/footer.jsp" />
</body>
</html>