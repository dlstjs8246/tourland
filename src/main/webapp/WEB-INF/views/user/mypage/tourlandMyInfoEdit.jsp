<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<style>
/* 본문 */
section div#editProfile {
	width: 1000px;
	height: 100%;
	margin-left: 200px;
}

section div#editProfile h1 {
	width: 200px;
	height: 30px;
	padding: 20px;
	border-bottom: 1px solid #929292;
}

section div#editProfile form {
	width: 500px;
	margin: 0 auto;
	padding-top: 50px;
}

section div#editProfile label {
	width: 120px;
	float: left;
	font-weight: bold;
}

section div#editProfile p {
	height: 60px;
}

section div#editProfile input {
	width: 250px;
	height: 30px;
	border: none;
	border-bottom: 1px solid #929292;
	padding-left: 10px;
}

.red {
	color: red;
}
.error{
	display: none;
	color:red;
	position: absolute;
}

section div#editProfile #btns button {
	width: 200px;
	height: 30px;
	border: none;
}

section div#editProfile #withdraw {
	background: maroon;
	color: #fff;
}

section div#editProfile #btns input {
	width: 200px;
	height: 30px;
	border: none;
}

#btns input#submit {
	background: steelblue;
	color: #fff;
}

#info {
	font-size: 13px;
	color: #929292;
	margin-left: 10px;
}
</style>
</head>
<body>
	<%@ include file="../../include/userHeader.jsp"%>
		<c:if test="${mypage=='mypageuser'}">
		<script>
			$(function(){
				$("#withdraw").click(function(){
					var id = $("input[name='userid']").val();
					var res = confirm("정말로 탈퇴하시겠습니까?");
					if(res){
						location.href="${pageContext.request.contextPath}/customer/logoutWithdrawal?id="+id;
						alert("탈퇴되었습니다.");
					}
				})
				
				$("#submit").click(function(){
					$("form").submit(function(e){
						var userid = $("input[name='userid']").val();
						$(".error").css("display","none");
						var username=$("input[name='username']").val();
						var userbirth = $("input[name='userbirth']").val();
						var usertel = $("input[name='usertel']").val();
						var userpassport = $("input[name='userpassport']").val();
						
						//이름 정규표현식
						var nameReg = /^[가-힣]{2,5}$/; //네임은 2-5 한글
						if (nameReg.test(username) == false) {
							$("input[name='username']").next().css("display", "inline");
							  return false;
						  }
						//생년월일정규표현식
						var birthReg = /^(1|2)[0-9]{3}-(01|02|03|04|05|06|07|08|09|10|11|12)-(01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31)$/; 
						if (birthReg.test(userbirth) == false) {
							$("input[name='userbirth']").next().css("display", "inline");
							  return false;
						  }
						//전화번호 정규 표현식
						var phoneReg = /^(010|011|019|018|017)-[0-9]{3,4}-[0-9]{4}$/; 
						if (phoneReg.test(usertel) == false) {
							$("input[name='usertel']").next().css("display", "inline");
							  return false;
						  }
						//여권번호 정규 표현식
						var passportReg = /^(M|S|R|G|D)[0-9]{8}$/;
						if(passportReg.test(userpassport)==false){
							$("input[name='userpassport']").next().css("display", "inline");
							  return false;
						}
						var res = confirm("수정하시겠습니까?");
						if(res){
							location.href="${pageContext.request.contextPath}/editProfile";
							alert("수정이 완료되었습니다.");
						}
						return false;
					})
				})
			})
		</script>
	</c:if>
	
	<c:if test="${mypage=='mypageemp'}">
		<script>
			$(function(){	
				$("#submit").click(function(){
					$("form").submit(function(e){
						var empid = $("input[name='empid']").val();
						$(".error").css("display","none");
						var empname=$("input[name='empname']").val();
						var empbirth = $("input[name='empbirth']").val();
						var emptel = $("input[name='emptel']").val();
						
						//이름 정규표현식
						var nameReg = /^[가-힣]{2,5}$/; //네임은 2-5 한글
						if (nameReg.test(empname) == false) {
							$("input[name='empname']").next().css("display", "inline");
							  return false;
						  }
						//생년월일정규표현식
						var birthReg = /^(1|2)[0-9]{3}-(01|02|03|04|05|06|07|08|09|10|11|12)-(01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31)$/; 
						if (birthReg.test(empbirth) == false) {
							$("input[name='empbirth']").next().css("display", "inline");
							  return false;
						  }
						//전화번호 정규 표현식
						var phoneReg = /^(010|011|019|018|017)-[0-9]{3,4}-[0-9]{4}$/; 
						if (phoneReg.test(emptel) == false) {
							$("input[name='emptel']").next().css("display", "inline");
							  return false;
						  }					
						
						var res = confirm("수정하시겠습니까?");
						if(res){
							location.href="${pageContext.request.contextPath}/editProfile";
							alert("수정이 완료되었습니다.");
						}
					})
				})
			})
		</script>
	</c:if>
	<section>
		<%@ include file="../../include/userMyPageMenu.jsp"%>
		<div id="editProfile">
			<h1>내 정보 수정</h1>
			<span id="info">투어랜드는 고객님의 개인정보가 외부로 노출되지 않도록 항상 노력하고 있습니다.</span>
			<form action="editProfile" method="post" autocomplete="off">
				<c:choose>
					<c:when test="${mypage=='mypageuser'}">
					<input type="hidden" value="${Auth.userno }" name="userno">
						<p>
							<label>아이디</label><input type="text" value="${Auth.userid }" name="userid" readonly="readonly" style="background-color: lightgray;">
						</p>
						<p>
							<label>비밀번호</label> <input type="password" name="userpass" value="${pass}" required="required">
						</p>
						<p>
							<label>이름</label> <input type="text" name="username" value="${Auth.username}" required="required">
							<span class="error">이름은 2~5글자의 한글입니다.</span>
						</p>
						<p>
							<label>생년월일</label> <input type="text" name="userbirth" value=<fmt:formatDate value="${Auth.userbirth}" pattern="yyyy-MM-dd"/> required="required">
							<span class="error">생년월일 양식 예) 1991-12-18</span>
						</p>
						<p>
							<label>주소</label> <input type="text" name="useraddr" value="${Auth.useraddr }" required="required">
						</p>
						<p>
							<label>전화번호</label> <input type="text" name="usertel" value="${Auth.usertel }" required="required">
							<span class="error">전화번호 양식 예)010-4245-3825</span>
						</p>
						<p>
							<label><span class="red">* </span>여권번호</label> <input type="text" name="userpassport" value="${Auth.userpassport }" required="required">
							<span class="error">여권번호 양식 예)M12345678</span>
						</p>
						<p id="btns">
							<input type="submit" id="submit" value="수정" style="cursor: pointer">
							<button type="button" id="withdraw" style="cursor: pointer">투어랜드 탈퇴</button>
						</p>
					</c:when>
					<c:when test="${mypage=='mypageemp'}">
					<input type="hidden" value="${Auth.empno }" name="empno">
						<p>
							<label>아이디</label><input type="text" value="${Auth.empid }" name="empid" readonly="readonly" style="background-color: lightgray;">
						</p>
						<p>
							<label>비밀번호</label> <input type="password" name="emppass" value="${pass}" required="required">
						</p>
						<p>
							<label>이름</label> <input type="text" name="empname" value="${Auth.empname}" required="required">
							<span class="error">이름은 2~5글자의 한글입니다.</span>
						</p>
						<p>
							<label>생년월일</label> <input type="text" name="empbirth" value=<fmt:formatDate value="${Auth.empbirth}" pattern="yyyy-MM-dd"/> required="required">
							<span class="error">생년월일 양식 예) 1991-12-18</span>
						</p>
						<p>
							<label>주소</label> <input type="text" name="empaddr" value="${Auth.empaddr }" required="required">
						</p>
						<p>
							<label>전화번호</label> <input type="text" name="emptel" value="${Auth.emptel }" required="required">
							<span class="error">전화번호 양식 예)010-4245-3825</span>
						</p>
						<p id="btns">	
							<input type="submit" id="submit" value="수정" style="cursor: pointer;margin-left:84px;">
						</p>
					</c:when>
				</c:choose>
			</form>
		</div>
	</section>
	<%@ include file="../../include/userFooter.jsp"%>