<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<style>
	/* 본문 */
	
	section div#editProfile { width:1073px; height: 100%; 
							  margin-left: 22%;
							 }
	section div#editProfile h1 { width: 200px;
								 height: 30px;  
							     padding: 20px;
							     border-bottom: 1px solid #929292; }							  
	section div#editProfile form { width: 462px;
   									 margin: -30px auto;
   									 padding-top: 44px; }   
	section div#editProfile label { width: 120px;
								    float: left;
								    font-weight: bold;}
	section div#editProfile p { height: 70px; }
	section div#editProfile input { width: 250px; height: 30px; 
									border: none; border-bottom: 1px solid #929292;}
	.red { color: red;}
	section div#editProfile #btns button { width: 200px; height: 30px; 
										   border: none; }

	section div#editProfile #withdraw { background: maroon; color: #fff; }
	
	section div#editProfile #inputs input { width: 200px; height: 30px; 
										    border: none; }
	#inputs input#submit { background: steelblue; color: #fff; }		
	#info { font-size: 13px; color: #929292; 
			margin-left: 10px;  }		
	 label {
    float: left;
    width: 150px;
    margin-left:20px;
  }
  span.errorMsg{
     color: tomato;
     margin-left:140px;
     font-size: smaller;
     display: none;
  }	
  
  /* 주소  */
  #pAddr input{
    margin-left:140px;
  }		
  .inputAddr{
  	margin-bottom: 8px;
    position: relative;
    top: -55px;
    padding-left: 4px;
  }
 	  				  		
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<body>
	<%@ include file="../include/userHeader.jsp"%>		
	<script>
 
	var userno = ${userVO.userno };

    var didUcheckId = false;
    var validId = true;
    var useraddr ='';

	$(function(){

		$("#regForm input").change(function(){
			$(".errorMsg").css("display", "none");
		})
		
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
			var userpass2 = $("input[name='userpass2']").val();
			var forCheckId = $("#forCheckId").val(); 
			
			var postcode = $("input#sample6_postcode").val();
			var address = $("input#sample6_address").val();
			var detailAddress= $("input#sample6_detailAddress").val();
			var extraAddress = $("input#sample6_extraAddress").val();
			
			useraddr="("+postcode+")"+address+" "+detailAddress+" "+extraAddress;
			//alert(useraddr);
			$("input[name='useraddr']").val(useraddr);
			
			//이름 정규표현식
			var nameReg = /^[가-힣]{2,5}$/; //네임은 2-5 한글
			if (nameReg.test(username) == false) {
				$("input[name='username']").next().next().css("display", "inline");
				  return false;
			  }
			//생년월일정규표현식
			var birthReg = /^(1|2)[0-9]{3}-(01|02|03|04|05|06|07|08|09|10|11|12)-(01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31)$/; 
			if (birthReg.test(userbirth) == false) {
				$("input[name='userbirth']").next().next().css("display", "inline");
				  return false;
			  }
			//전화번호 정규 표현식
			var phoneReg = /^(010|011|019|018|017)-[0-9]{3,4}-[0-9]{4}$/; 
			if (phoneReg.test(usertel) == false) {
				$("input[name='usertel']").next().next().css("display", "inline");
				  return false;
			  }

			
		    //사원 아이디 정규 표현식, 회원 아이디 규칙과 동일
		    var idReg = /^[a-z0-9]{5,12}$/i; //영어, 숫자 5-15
		    if (idReg.test(userid) == false) {
				$("input[name='userid']").next().next().css("display", "inline");
				  return false;
			  }
		   
		    //사원 비밀번호 정규 표현식, 회원 비밀번호 규칙과 동일함
		    var pwdReg = /^[a-zA-Z0-9!@#%^&*]{4,15}/;
			 if(pwdReg.test(userpass) == false){
				 $("input[name='userpass']").next().css("display","inline");
				 return false;
		     }else if(userpass != userpass2){
		    	 $("input[name='userpass']").next().next().css("display","inline");
		    	 return false;
		     }
			 
			 if(forCheckId =="exist"){
				 return false;
			 }
			 
			 if(didUcheckId == false){
				 alert("아이디 중복 체크 해주세요");
				 return false;
			 }
			 
			 if(validId == false){
				 return false;
			 }
			 
			 alert("가입 축하 쿠폰이 발급 되었습니다. 마이페이지에서 확인하세요!");

		})
		
		$("#userpassword").change(function(){
			$(".errorMsg").css("display", "none");
			 //사원 비밀번호 정규 표현식, 회원 비밀번호 규칙과 동일함
		    var pwdReg = /^[a-zA-Z0-9!@#%^&*]{4,15}/;
			 if(pwdReg.test($(this).val()) == false){
				 $("input[name='userpass']").next().css("display","inline");
		     }
		})
		
		$("#userpassword2").change(function(){
			$(".errorMsg").css("display", "none");
			var userpass = $("input[name='userpass']").val();
			if(userpass != $(this).val()){
		    	 $("input[name='userpass2']").next().next().next().next().css("display","inline");
			}
		})
		
		$("#userId").change(function(){
			$(".errorMsg").css("display", "none");
			var idReg = /^[a-z0-9]{5,12}$/i; //영어, 숫자 5-15
		    if (idReg.test($(this).val()) == false) {
				$("input[name='userid']").next().next().css("display", "inline");
				  return false;
			  }
		})
		
		$("#btnCheck").click(function(){
			$(".errorMsg").css("display", "none");
			var empid = $("input[name='userid']").val();
			 //아이디 중복 ajax로 처리하기
			 $.ajax({
				url:"idCheck/"+empid,  //이 커맨드에서 유저아이디와 사원 아이디를 모두 확인하기에 
				type:"get",
				dataType:"text",
				success:function(res){
					console.log(res);
					didUcheckId = true;
					if(res=="exist"){
						$("input[name='userid']").next().next().next().css("display", "inline");
						validId = false;
					}else{
						$("input[name='userid']").next().next().next().next().css("display", "inline");
					}
				}
				 
		    })
			
		})
		
		
		//아이디 입력값이 달라질 때 마다 아이디 체크 여부를 초기화 
		$("#userId").change(function(){
			didUcheckId = false;
		    validId = true;
		})
		
		$("#btnRegisterCancel").click(function(){
			location.href="${pageContext.request.contextPath}/customer/tourlandMain";
		})
})
		
		//주소
	function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	                
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    /* // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr; */
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample6_postcode').value = data.zonecode;
	                document.getElementById("sample6_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	
	            }
	        }).open();
	    }
		
	</script>
			<section style="height:1000px;">
				<div id="editProfile">
				<h1>투어랜드 회원가입</h1>
				<span id="info">투어랜드는 고객님의 개인정보가 외부로 노출되지 않도록 항상 노력하고 있습니다.</span>
					<form action="tourlandRegister" method="post" id="regForm">
						<p>
							<input type="hidden" value="${autoNo }" name="userno">
						</p>
						<p>
							<label>고객 아이디</label> 
							<input type="text" name="userid" required="required"  placeholder=" 영문,숫자 포함 5-12자리" id="userId">
							<button id="btnCheck" type="button">중복확인</button>
							<span class="errorMsg">영문, 숫자 포함 5-12자리를 넣어주세요</span>
							<span class="errorMsg">중복되는 아이디 입니다. 다른 아이디를 입력해주세요.</span>
							<span class="errorMsg">사용 가능한 아이디입니다.</span>
						</p>
						<p>
							<label>비밀번호</label>
							<input type="password" name="userpass" placeholder=" 영문, 숫자 포함 5-12자리" required="required" id="userpassword" >
							<span class="errorMsg">영문, 숫자 포함 5-12자리를 넣어주세요</span>
						</p>
						<p>
							<label>비밀번호 확인</label>
							<input type="password" name="userpass2" required="required" id="userpassword2" ><br>
							<span class="errorMsg">영문, 숫자 포함 5-12자리를 넣어주세요</span><br>
							<span class="errorMsg">비밀번호가 일치하지 않습니다.</span>
						</p>
						<p>
							<label>고객 이름</label>
							<input type="text" name="username" required="required" placeholder=" 한글 2-5자리" required="required" ><br>
							<span class="errorMsg">이름을 한글 2자리에서 5자리로 입력해주세요.</span>
						</p>
						<p>
							<label>생년월일</label>
							<input type="text" name="userbirth" required="required"  placeholder=" 2000-02-02" required="required"  ><br>
							<span class="errorMsg">생년월일 형식에 맞게 넣어주세요. 예시: 2000-02-02</span>
						</p>
						<p style="margin-bottom:10px; height: 170px;" id="pAddr">
							<label>주소</label><br>
							<input type="hidden" name="useraddr" class="inputAddr"><br>
							<input type="text" id="sample6_postcode" placeholder="우편번호" class="inputAddr">
							<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" style="background:steelblue; border:inherit; color:white;" class="inputAddr">
							<input type="text" id="sample6_address" placeholder="주소" class="inputAddr"><br>
							<input type="text" id="sample6_detailAddress" placeholder="상세주소" class="inputAddr">
							<!-- <input type="text" id="sample6_extraAddress" placeholder="참고항목" class="inputAddr"> -->
						</p>
						<p>
							<label>전화번호</label>
							<input type="text" name="usertel" required="required"  placeholder=" 예) 010-4334-4321" required="required" ><br>
							<span class="errorMsg">형식에 맞게 넣어주세요 예시: 010-4334-4321</span>
						</p>
						<!-- <p>	
							<label><span class="red">* </span>여권번호</label>
							<input type="text" name="passport" value="M70689098">
						</p> -->
						<!-- <p id="btns">
							<button  style="cursor:pointer">아이디/비밀번호 변경</button>
							<button id="withdraw"  style="cursor:pointer">투어랜드 탈퇴</button>
						</p> -->
						
						<p id="inputs">
							<input type="submit" id="submit" value="가입하기"  style="cursor:pointer">
							<input type="button" id="btnRegisterCancel" value="취소"  style="cursor:pointer">
						</p>
					</form>
				</div>
			</section>
				<%@ include file="../include/userFooter.jsp"%>