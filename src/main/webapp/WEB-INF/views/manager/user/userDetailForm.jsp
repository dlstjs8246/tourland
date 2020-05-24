<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
  label {
    float: left;
    width: 150px;
    margin-left:20px;
  }
  span.errorMsg{
     color: tomato;
     display: none;
  }
  
</style>
<script>
 
	var userno = ${userVO.userno };
	var searchType = "${cri.searchType}";
	var keyword = "${cri.keyword}";
	
	var usersecess = ${usersecess};
	 
	$(function(){
		
	 //일반 유저 정보인지 탈퇴 유저 정보인지에 따라 폼 스타일 다르게 하기 
		if(usersecess==1){
			$("#detaiLForm input").css("background","lavender");
			$("input").attr("readonly","readonly");
		}
     //정규 표현식 ,빈칸인 경우는 부트 스트랩의 기본 설정으로 이미 설정되어있음 
		$("form").submit(function(e){
			$(this).attr("onsubmit","");
			$(".errorMsg").css("display", "none");
			var username = $("input[name='username']").val();
			var userbirth = $("input[name='userbirth']").val();
			var usertel = $("input[name='usertel']").val();
			var useraddr = $("input[name='useraddr']").val();
			var userauth = $("input[name='userauth']").val();
			var userid = $("input[name='userid']").val();
			var userpass = $("input[name='userpass']").val();
			var forCheckId = $("#forCheckId").val

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

			
		    //사원 아이디 정규 표현식, 회원 아이디 규칙과 동일
		    var idReg = /^[a-z0-9]{5,12}$/i; //영어, 숫자 6-15
		    if (idReg.test(userid) == false) {
				$("input[name='userid']").next().css("display", "inline");
				  return false;
			  }
		   
		    //사원 비밀번호 정규 표현식, 회원 비밀번호 규칙과 동일함
		    var pwdReg = /^[a-zA-Z0-9!@#%^&*]{4,15}/;
			 if(pwdReg.test(userpass) == false){
				 $("input[name='userpass']").next().css("display","inline");
				 return false;
		     }
			 
			 if(forCheckId =="exist"){
				 return false;
			 }
			 
			

		})
		
		$("#btnCheck").click(function(){
			var empid = $("input[name='userid']").val();
			 //아이디 중복 ajax로 처리하기
			 $.ajax({
				url:"empIdCheck/"+empid,
				type:"get",
				dataType:"text",
				success:function(res){
					console.log(res);
					if(res=="exist"){
						$("input[name='empid']").next().next().next().css("display", "inline");
		//				$("form").attr("onsubmit","return false;");
					}
				}
				 
		    })
			
		})
		
		 //리스트로 버튼 눌렀을 때 리스트로 돌아가기 
		$("#btnReturnToList").click(function(){
			location.href="${pageContext.request.contextPath}/manager/userMngList/${usersecess}/?searchType="+searchType+"&keyword="+keyword;
		})
	})
	
</script>
<div class="content">
	<div class="row">
		<div class="col-sm-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">고객 정보</h3>
				</div>
				<form role="form" action="userRegister" method="post" id="detaiLForm">
					<div class="box-body">
					    <input type="hidden" value="" id="forSubmit">
						<div class="form-group">
							<label>고객 번호</label>
							<input type="text" name="userno" value="${userVO.userno }" readonly="readonly" style="background:lavender;" >
						</div>
						<div class="form-group">
							<label>고객 이름</label>
							<input type="text" name="username" required="required" placeholder=" 한글 2-5자리" value="${userVO.username }">
							<span class="errorMsg">이름을 한글 2자리에서 5자리로 입력해주세요.</span>
						</div>
						<div class="form-group">
							<label>생년월일</label>
							<input type="text" name="userbirth" required="required"  placeholder=" 2000-02-02" value="<fmt:formatDate value='${userVO.userbirth }' pattern='yyyy-MM-dd'/>">
							<span class="errorMsg">생년월일 형식에 맞게 넣어주세요. 예시: 2000-02-02</span>
						</div>
						<div class="form-group">
							<label>전화번호</label>
							<input type="text" name="usertel" required="required"  placeholder=" 010-4334-4321" value="${userVO.usertel }">
							<span class="errorMsg">형식에 맞게 넣어주세요 예시: 010-4334-4321</span>
						</div>
						<div class="form-group">
							<label>주소</label>
							<input type="text" name="useraddr" required="required" value="${userVO.useraddr }">
						</div>
						<div class="form-group">
							<label>여권번호</label>
							<input type="text" name="userpassport" required="required" value="${userVO.userpassport }">
						</div>
						<div class="form-group">
							<label>보유쿠폰</label>
							<select style="width:155px; height:25px">
							   <c:forEach var="couponList" items="${couponList }">
							     <option>${couponList.cname }</option>
							   </c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label>고객 아이디</label> 
							<input type="text" name="userid" required="required"  placeholder=" 영문,숫자 포함 5-12자리" value="${userVO.userid }">
						<!-- 	<button id="btnCheck" type="button">중복확인</button> -->
							<span class="errorMsg">영문, 숫자 포함 5-12자리를 넣어주세요</span>
							<span class="errorMsg">중복되는 아이디 입니다. 다른 아이디를 입력해주세요.</span>
						</div>
						<div class="form-group">
							<label>비밀번호</label>
							<input type="text" name="userpass" placeholder=" 영문, 숫자 포함 5-12자리" value="${userVO.userpass }">
							<span class="errorMsg">영문, 숫자 포함 5-12자리를 넣어주세요</span>
						</div>
						<div class="box-footer">
							<!-- <button type="submit" class="btn btn-primary">등록</button> -->
							<button type="button" class="btn btn-primary" style="margin-top:10px;" id="btnReturnToList">리스트로 돌아가기</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<%@ include file="../../include/footer.jsp"%>