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

<script>

$(function(){
	$("form").submit(function(e){
		
		var no = "${no}";
		var searchType = "${cri.searchType}";
		var keyword = "${cri.keyword}";
		var searchType2 = "${cri.searchType2}";
		var checkPass= $("input[name='checkPass']").val();
		var userId = $("input[name='userid']").val();
		var twowayPath = $(this).attr("data-name");
		
		var whoWroteThis = "${custBoardVO.writer}";
		var whoWroteThisPlan = "${planBoardVO.writer}";
        var loginedId = "${Auth.username}";
        
        
        if(whoWroteThis == ""){
           if(whoWroteThisPlan != loginedId){
            	$(".error").css("display", "inline");
            	return false;
            }
        }else{
        	 if(whoWroteThis != loginedId){
             	$(".error").css("display", "inline");
             	return false;
             }
        }
        
      
			 $.ajax({
				url:"${pageContext.request.contextPath}/customer/EditPasswordCheck/"+userId+"/"+checkPass,
				type:"get",
				dataType:"text",
				success:function(res){
					console.log(res);
					if(res=="NoPass"){
						$(".error").css("display", "inline");
						return false;
					}else{
						if(twowayPath =="custBoard"){
						  location.href = "${pageContext.request.contextPath}/customer/tourlandCustBoardDetail?no="+no+"&page=${pageMaker.cri.page}&searchType="+searchType+"&keyword="+keyword;
						}if(twowayPath =="planBoard"){
							location.href = "${pageContext.request.contextPath}/customer/tourlandPlanBoardDetail?no="+ no +"&page=${pageMaker.cri.page}&searchType="+searchType + "&searchType2=" + searchType2+"&keyword=" + keyword;	
						}
						
					}
				}
		    })

		
		return false; //submit버튼을 클릭하는거랑 아작스가 가는건 별개다 ajax는 지만 따로 갓다옴
	})
})
</script>

	<section>
		<%@ include file="../../include/userBoardMenu.jsp"%> 
		<div id="editProfile">
		<h1>내 글 열람</h1>
			<span id="info">본인이 작성한 글만 열람 가능합니다.</span>
	<c:if test="${where == 'custBoard'}">
		<form action="tourlandCustBoardDetail" method="get" data-name="custBoard">
			<c:choose>
				<c:when test="${mypage=='mypageuser'}">
					 <input type="hidden" name="no" value="${no}">
					<p>
						<input type="hidden" name="userid" value="${Auth.userid}" readonly="readonly">
					</p>
					<p>
						<label>비밀번호</label><input type="password" name="checkPass" placeholder="고객님의 로그인 비밀번호를 입력해주세요." required="required">
					</p>
						<span class="error">작성자, 혹은 비밀번호가 일치하지 않습니다</span>
				</c:when>
			</c:choose>
				<p id="btns">
					<button type="submit" id="withdraw" style="cursor: pointer">확인</button>
				</p>
			</form>
	 </c:if>
	 <c:if test="${where == 'planBoard'}">
		<form action="tourlandPlanBoardDetail" method="get" data-name="planBoard">
			<c:choose>
				<c:when test="${mypage=='mypageuser'}">
					 <input type="hidden" name="no" value="${no}">
					<p>
						<input type="hidden" name="userid" value="${Auth.userid}" readonly="readonly">
					</p>
					<p>
						<label>비밀번호</label><input type="password" name="checkPass" placeholder="비밀번호를 재입력해주세요." required="required">
					</p>
						<span class="error">작성자, 혹은 비밀번호가 일치하지 않습니다</span>
				</c:when>
			</c:choose>
				<p id="btns">
					<button type="submit" id="withdraw" style="cursor: pointer">확인</button>
				</p>
			</form>
		</c:if>
		</div>
	</section>
<%@ include file="../../include/userFooter.jsp"%>