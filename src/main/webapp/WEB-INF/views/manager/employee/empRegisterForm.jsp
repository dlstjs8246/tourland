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

    var didUcheckId = false;
    var validId = true;


	$(function(){
     //정규 표현식 ,빈칸인 경우는 부트 스트랩의 기본 설정으로 이미 설정되어있음 
		$("form").submit(function(e){
	//	    alert("아이디중복체크했니"+didUcheckId);
    //       alert("유효한 아이디니"+validId);
          

			$(this).attr("onsubmit","");
			$(".errorMsg").css("display", "none");
			var empname = $("input[name='empname']").val();
			var empbirth = $("input[name='empbirth']").val();
			var emptel = $("input[name='emptel']").val();
			var empaddr = $("input[name='empaddr']").val();
			var empauth = $("input[name='empauth']").val();
			var empid = $("input[name='empid']").val();
			var emppass = $("input[name='emppass']").val();
			var forCheckId = $("#forCheckId").val

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
			
			//권한 정규 표현식
			var authReg = /^(0|1)$/;
			if(authReg.test(empauth) == false){
				$("input[name='empauth']").next().css("display", "inline");
				  return false;
			  }
			
		    //사원 아이디 정규 표현식, 회원 아이디 규칙과 동일
		    var idReg = /^[a-z0-9]{5,12}$/i; //영어, 숫자 6-15
		    if (idReg.test(empid) == false) {
				$("input[name='empid']").next().css("display", "inline");
				  return false;
			  }
		   
		    //사원 비밀번호 정규 표현식, 회원 비밀번호 규칙과 동일함
		    var pwdReg = /^[a-zA-Z0-9!@#%^&*]{4,15}/;
			 if(pwdReg.test(emppass) == false){
				 $("input[name='emppass']").next().css("display","inline");
				 return false;
		     }
			 
			 if(didUcheckId == false){
				 alert("아이디 중복 체크 해주세요");
				 return false;
			 }
			 
			 if(validId == false){
				 return false;
			 }
			 if(!chkId) return false;
			

		})
		
		$("#btnCheck").click(function(){
			$(".errorMsg").css("display","none");
			var empid = $("input[name='empid']").val();
			 //아이디 중복 ajax로 처리하기
			 $.ajax({
				url:"empIdCheck/"+empid,
				type:"get",
				dataType:"text",
				success:function(res){
					console.log(res);
					didUcheckId = true;
					if(res=="exist"){
						$("input[name='empid']").next().next().next().css("display", "inline");

						validId = false;
						

					}else{
						alert("사용할 수 있는 아이디입니다. 등록을 진행해주세요");
					}
				}
				 
		    })
			
		})
		  //리스트로 버튼 눌렀을 때 리스트로 돌아가기 
		$("#btnReturnToList").click(function(){
			location.href="${pageContext.request.contextPath}/manager/empMngList/0";
		})
		
		//아이디 입력값이 달라질 때 마다 아이디 체크 여부를 초기화 
		$("#empId").change(function(){
			didUcheckId = false;
		    validId = true;
		})
		
	})
	
</script>
<div class="content">
	<div class="row">
		<div class="col-sm-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">사원 추가</h3>
				</div>
				<form role="form" action="employeeRegister" method="post">
					<div class="box-body">
					    <input type="hidden" value="" id="forSubmit">
						<div class="form-group">
							<label>사원 번호</label>
							<input type="text" name="empno" value="${autoNo }" readonly="readonly" style="background:lavender;" >
						</div>
						<div class="form-group">
							<label>사원 이름</label>
							<input type="text" name="empname" required="required" placeholder=" 한글 2-5자리">
							<span class="errorMsg">이름을 한글 2자리에서 5자리로 입력해주세요.</span>
						</div>
						<div class="form-group">
							<label>생년월일</label>
							<input type="text" name="empbirth" required="required"  placeholder=" 2000-02-02">
							<span class="errorMsg">생년월일 형식에 맞게 넣어주세요. 예시: 2000-02-02</span>
						</div>
						<div class="form-group">
							<label>전화번호</label>
							<input type="text" name="emptel" required="required"  placeholder=" 010-4334-4321">
							<span class="errorMsg">형식에 맞게 넣어주세요 예시: 010-4334-4321</span>
						</div>
						<div class="form-group">
							<label>주소</label>
							<input type="text" name="empaddr" required="required" >
						</div>
						<div class="form-group">
							<label>권한</label>
							<input type="text" name="empauth" required="required"  placeholder=" 일반사원은 0">
							<span class="errorMsg">0또는 1을 넣어주세요 일반 사원은 0</span>
						</div>
						<div class="form-group">
							<label>아이디</label> 
							<input type="text" name="empid" required="required"  placeholder=" 영문,숫자 포함 5-12자리" id="empId">
							<button id="btnCheck" type="button">중복확인</button>
							<span class="errorMsg">영문, 숫자 포함 5-12자리를 넣어주세요</span>
							<span class="errorMsg">중복되는 아이디 입니다. 다른 아이디를 입력해주세요.</span>
						</div>
						<div class="form-group">
							<label>비밀번호</label>
							<input type="password" name="emppass" placeholder=" 영문, 숫자 포함 5-12자리">
							<span class="errorMsg">영문, 숫자 포함 5-12자리를 넣어주세요</span>
						</div>
						<div class="box-footer">
							<button type="submit" class="btn btn-primary">등록</button>
							<button type="button" class="btn btn-primary" id="btnReturnToList">목록으로</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<%@ include file="../../include/footer.jsp"%>