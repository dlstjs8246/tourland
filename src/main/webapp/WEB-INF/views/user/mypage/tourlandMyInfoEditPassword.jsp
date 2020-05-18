<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    padding-top: 81px;
    position: relative;
}

section div#editProfile label {
    width: 75px;
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

section div#editProfile #btns button {
	width: 145px;
    height: 35px;
    border: none;
    position: absolute;
    top: 215px;
    left: 120px;
    background: maroon;
	color: #fff;
}
#info {
	font-size: 13px;
	color: #929292;
	margin-left: 10px;
}
input[name='userid']{
	background-color: lightgray;
}
.error{
    color: red;
    position: absolute;
    top: 174px;
    left: 84px;
    display: none;
}    
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../../include/userHeader.jsp"%>
<c:if test="${mypage=='mypageuser'}">
<script>
$(function(){
	$("form").submit(function(e){
		var checkPass= $("input[name='checkPass']").val();
		var totalId = $("input[name='userid']").val();
		
			 //아이디 중복 ajax로 처리하기
			 $.ajax({
				url:"EditPasswordCheck/"+totalId+"/"+checkPass,
				type:"get",
				dataType:"text",
				success:function(res){
					console.log(res);
					if(res=="NoPass"){
						$(".error").css("display", "inline");
						return false;
					}else{
						location.href="${pageContext.request.contextPath}/tourlandMyInfoEdit";
					}
				}
		    })
		return false; //submit버튼을 클릭하는거랑 아작스가 가는건 별개다 ajax는 지만 따로 갓다옴
	})
})
</script>
</c:if>
<c:if test="${mypage=='mypageemp'}">
<script>
$(function(){
	$("form").submit(function(e){
		var checkPass= $("input[name='checkPass']").val();
		var totalId = $("input[name='empid']").val();

			 //아이디 중복 ajax로 처리하기
			 $.ajax({
				url:"EditPasswordCheck/"+totalId+"/"+checkPass,
				type:"get",
				dataType:"text",
				success:function(res){
					console.log(res);
					if(res=="NoPass"){
						$(".error").css("display", "inline");
						return false;
					}else{
						location.href="${pageContext.request.contextPath}/tourlandMyInfoEdit";
					}
				}
		    })
		return false; //submit버튼을 클릭하는거랑 아작스가 가는건 별개다 ajax는 지만 따로 갓다옴
	})
})
</script>
</c:if>
	<section>
		<%@ include file="../../include/userMyPageMenu.jsp"%>
		<div id="editProfile">
		<h1>내 정보 수정</h1>
			<span id="info">투어랜드는 고객님의 개인정보가 외부로 노출되지 않도록 항상 노력하고 있습니다.</span>
		
		<form action="tourlandMyInfoEdit" method="get">
			<c:choose>
				<c:when test="${mypage=='mypageemp' }">
					<p>
						<label>아이디</label><input type="text" name="empid" value="${Auth.empid}" readonly="readonly" style="background-color: lightgray;">
					</p>
					<p>
						<label>비밀번호</label><input type="password" name="checkPass" placeholder="비밀번호를 재입력해주세요.">
					</p>
						<span class="error">비밀번호가 일치하지 않습니다</span>
				</c:when>
				<c:when test="${mypage=='mypageuser'}">
					<p>
						<label>아이디</label><input type="text" name="userid" value="${Auth.userid}" readonly="readonly">
					</p>
					<p>
						<label>비밀번호</label><input type="password" name="checkPass" placeholder="비밀번호를 재입력해주세요.">
					</p>
						<span class="error">비밀번호가 일치하지 않습니다</span>
				</c:when>
			</c:choose>
				<p id="btns">
					<button type="submit" id="withdraw" style="cursor: pointer">확인</button>
				</p>
			</form>
		</div>
	</section>
<%@ include file="../../include/userFooter.jsp"%>