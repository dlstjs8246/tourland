<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
/* 본문 */
section{
	height:800px;
}
section div#editProfile {
	width: 1073px;
	height: 100%; 
	margin-left: 22%;
}
section div#editProfile h1 {
	width: 200px;
	height: 30px;
	padding: 20px;
	border-bottom: 1px solid #929292;
}

section div#editProfile form {
    width: 462px;
    margin: 5px auto;
    padding-top: 60px;
}

section div#editProfile label {
	width: 120px;
	float: left;
	font-weight: bold;
}

section div#editProfile p {
	height: 70px;
}

section div#editProfile input {
	width: 250px;
	height: 30px;
	border: none;
	border-bottom: 1px solid #929292;
}
section div#editProfile #withdraw {
	background: maroon;
	color: #fff;
}

section div#editProfile #inputs input {
	width: 200px;
    height: 40px;
    border: none;
    margin: 20px 0px 0px 95px;
}

#inputs input#submit {
	background: steelblue;
	color: #fff;
}

.info {
	font-size: 13px;
	color: #929292;
	margin-left: 10px;
}

label {
	float: left;
	width: 150px;
	margin-left: 20px;
}

.errorMsg {
	color: tomato;
	margin-left: 140px;
	font-size: smaller;
 	display: none;
}
#notInfo{
	color: tomato;
    position: absolute;
    top: 705px;
    left: 795px;
}
</style>

<body>
	<%@ include file="../include/userHeader.jsp"%>
	<script>
	$(function(){
		var send ="${send}";
		var sendMail ="${sendMail}";
		alert(send);
		$("form").submit(function(e){
			$(".errorMsg").css("display", "none");
			var name = $("input[name='username']").val();
			var birth = $("input[name='userbirth']").val(); 
			var tel = $("input[name='usertel']").val();
			var email = $("input[name='useremail']").val();
			
			
			
			//이름 정규표현식
			var nameReg = /^[가-힣]{2,5}$/;
			if (nameReg.test(name) == false) {
				$("input[name='username']").next().next().css("display", "inline");
				  return false;
			  }
			
			//생년월일 정규표현식
			var birthReg = /^(1|2)[0-9]{3}-(01|02|03|04|05|06|07|08|09|10|11|12)-(01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31)$/; 
			if (birthReg.test(birth) == false) {
				$("input[name='userbirth']").next().next().css("display", "inline");
				  return false;
			  }
			
			//전화번호 정규표현식
			var phoneReg = /^(010|011|019|018|017)-[0-9]{3,4}-[0-9]{4}$/; 
			if (phoneReg.test(tel) == false) {
				$("input[name='usertel']").next().next().css("display", "inline");
				  return false;
			  }
			
			//이메일 정규표현식
			var emailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			if(emailReg.test(email)==false){
				$("input[name='useremail']").next().next().css("display", "inline");
				  return false;
			}	
			
			if(send=="확인"){
				alert("메일이 발송되었습니다. 로그인화면으로 이동합니다.");
			}
			
		})
	})
	
	
	
	
</script>
	<section>
		<div id="editProfile">
			<h1>ID, Password 찾기</h1>
			<span class="info">투어랜드는 고객님의 개인정보가 외부로 노출되지 않도록 항상 노력하고 있습니다.</span><br>
			<span class="info">이름과 생년월일, 전화번호, 이메일을 입력해주세요.</span>
			<form action="tourlandFindIdPw" method="post" autocomplete="off">
				<c:choose>
					<c:when test="${inputStay!=null }">
						<p>
							<label>이름</label> 
							<input type="text" name="username" required="required" placeholder="한글 2-5자리" value="${inputStay.username}"><br> 
							<span class="errorMsg">이름을 한글 2자리에서 5자리로 입력해주세요.</span>
						</p>
						<p>
							<label>생년월일</label>
							<input type="text" name="userbirth" required="required" placeholder="예) 2000-02-02" value=<fmt:formatDate value="${inputStay.userbirth}" pattern="yyyy-MM-dd"/>><br>
					 		<span class="errorMsg">생년월일 형식에 맞게 넣어주세요. 예시:2000-02-02</span>
						</p>
						<p>
							<label>전화번호</label> 
							<input type="text" name="usertel" required="required" placeholder=" 예) 010-4334-4321" value="${inputStay.usertel}"><br>
							<span class="errorMsg">형식에 맞게 넣어주세요 예시: 010-4334-4321</span>
						</p>
						<p>
							<label>이메일</label> 
							<input type="text" name="useremail" required="required" placeholder="메일형식을 써주세요" value="${emailStay }"><br> 
							<span class="errorMsg">유효하지 않은 이메일 형식입니다.</span>
						</p>
					</c:when>
					<c:otherwise>
						<p>
							<label>이름</label> 
							<input type="text" name="username" required="required" placeholder="한글 2-5자리"><br> 
							<span class="errorMsg">이름을 한글 2자리에서 5자리로 입력해주세요.</span>
						</p>
						<p>
							<label>생년월일</label>
							<input type="text" name="userbirth" required="required" placeholder="예) 2000-02-02"><br>
					 		<span class="errorMsg">생년월일 형식에 맞게 넣어주세요. 예시:2000-02-02</span>
						</p>
						<p>
							<label>전화번호</label> 
							<input type="text" name="usertel" required="required" placeholder=" 예) 010-4334-4321"><br>
							<span class="errorMsg">형식에 맞게 넣어주세요 예시: 010-4334-4321</span>
						</p>
						<p>
							<label>이메일</label> 
							<input type="text" name="useremail" required="required" placeholder="메일형식을 써주세요"><br> 
							<span class="errorMsg">유효하지 않은 이메일 형식입니다.</span>
						</p>
					</c:otherwise>
				</c:choose>
				
				<c:if test="${NotInfo!=null }">
					<p id="notInfo">${NotInfo }</p>
				</c:if>
				
				<p id="inputs">
					<input type="submit" id="submit" value="ID,Password 찾기" style="cursor: pointer"> 
				</p>
			</form>
		</div>
	</section>
<%@ include file="../include/userFooter.jsp"%>