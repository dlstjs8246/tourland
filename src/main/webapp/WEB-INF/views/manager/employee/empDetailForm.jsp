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
	var empno = ${empVO.empno };
	var searchType = "${cri.searchType}";
	var keyword = "${cri.keyword}";
	
	var empretired = ${empretired};
	 
	$(function(){
		//근무사원 정보인지 퇴사 사원 정보인지에 따라 폼 스타일 다르게 하기 
		if(empretired==1){
			$("#detaiLForm input").css("background","lavender");
			$("input").attr("readonly","readonly");
		}
		
     //정규 표현식 ,빈칸인 경우는 부트 스트랩의 기본 설정으로 이미 설정되어있음 
		$("form").submit(function(e){
			$(this).attr("onsubmit","");
			$(".errorMsg").css("display", "none");
			var empname = $("input[name='empname']").val();
			var empbirth = $("input[name='empbirth']").val();
			var emptel = $("input[name='emptel']").val();
			var empaddr = $("input[name='empaddr']").val();
			var empauth = $("input[name='empauth']").val();
			var empid = $("input[name='empid']").val();
			var emppass = $("input[name='emppass']").val();
	//		var forCheckId = $("#forCheckId").val

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
			 
/* 			 if(forCheckId =="exist"){
				 return false;
			 } */
			 
			

		})
		
		$("#btnCheck").click(function(){
			var empid = $("input[name='empid']").val();
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
		
		//삭제 버튼을 눌렀을 경우 퇴사사원 처리 - 논리삭제
		$("#btnDel").click(function(){
			//먼저 확인창으로 물어볼 것
			
		    //근무사원리스트에서 접속한 것인지 퇴사사원 리스트에서 접속한 것인지에 따라 분리 
			if(empretired == 0){
		    var youSure = confirm("퇴사 사원 처리 하시겠습니까?");
		    }else{
		     var youSure = confirm("해당 사원의 정보를 완전 삭제 처리 하시겠습니까?");	
		    }
			if(youSure){
				
				location.href="${pageContext.request.contextPath}/manager/employeeDelete/${empretired}/"+empno+"?searchType="+searchType+"&keyword="+keyword;
			}
			
		})
		
		
		
     
        //리스트로 버튼 눌렀을 때 리스트로 돌아가기 
		$("#btnReturnToList").click(function(){
			location.href="${pageContext.request.contextPath}/manager/empMngList/${empretired}/?searchType="+searchType+"&keyword="+keyword;
		})
		
	})
	
</script>
<div class="content">
	<div class="row">
		<div class="col-sm-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">사원 정보 조회</h3> 
				</div>
				<form role="form" action="${pageContext.request.contextPath}/manager/employeeUpdate/${empretired}" method="post" id="detaiLForm" autocomplete="off">
					<div class="box-body">
					    <!-- <input type="hidden" value="" id="forSubmit"> -->
					    <%-- <input type="hidden" value="${empretired }" name="empretired"> --%>
						<div class="form-group">
							<label>사원 번호</label>
							<input type="text" name="empno" value="${empVO.empno }" readonly="readonly" style="background:lavender;" >
						</div>
						<div class="form-group">
							<label>사원 이름</label>
							<input type="text" name="empname" required="required" placeholder=" 한글 2-5자리" value="${empVO.empname}">
							<span class="errorMsg">이름을 한글 2자리에서 5자리로 입력해주세요.</span>
						</div>
						<div class="form-group">
							<label>생년월일</label>
							<input type="text" name="empbirth" required="required"  placeholder=" 2000-02-02" value="<fmt:formatDate value='${empVO.empbirth}' pattern="yyyy-MM-dd"/>">
							<span class="errorMsg">생년월일 형식에 맞게 넣어주세요. 예시: 2000-02-02</span>
						</div>
						<div class="form-group">
							<label>전화번호</label>
							<input type="text" name="emptel" required="required"  placeholder=" 010-4334-4321" value="${empVO.emptel}">
							<span class="errorMsg">형식에 맞게 넣어주세요 예시: 010-4334-4321</span>
						</div>
						<div class="form-group">
							<label>주소</label>
							<input type="text" name="empaddr" required="required" value="${empVO.empaddr}" >
						</div>
						<c:if test="${Auth.empauth==1}">
							<div class="form-group">
								<label>권한</label>
								<input type="text" name="empauth" required="required"  placeholder=" 일반사원은 0" value="${empVO.empauth}">
								<span class="errorMsg">0또는 1을 넣어주세요 일반 사원은 0</span>
							</div>
						</c:if>
						<c:if test="${Auth.empauth==0}">
							<div class="form-group">
								<label>권한</label>
								<input type="text" name="empauth" required="required"  placeholder=" 일반사원은 0" value="${empVO.empauth}" readonly="readonly" style="background:lavender;">
								<span class="errorMsg">0또는 1을 넣어주세요 일반 사원은 0</span>
							</div>
						</c:if>
						
						<div class="form-group">
							<label>아이디</label> 
							<input type="text" name="empid" readonly="readonly"  placeholder=" 영문,숫자 포함 5-12자리" value="${empVO.empid}" style="background:lavender;">
					
							<span class="errorMsg">영문, 숫자 포함 5-12자리를 넣어주세요</span>
							<span class="errorMsg">중복되는 아이디 입니다. 다른 아이디를 입력해주세요.</span>
						</div>
						<div class="form-group">
							<label>비밀번호</label>
							<input type="text" name="emppass" placeholder="기존 비밀번호 입력 필요" >
							<span class="errorMsg">비밀번호가 일치하지 않습니다.</span> <!-- 관리자일 경우 프리패스로 만들 것  -->
						</div>
						<c:if test="${Auth.empauth==1}">
							<div class="box-footer">
						    	<button type="button" class="btn btn-primary" style="background:red;" id="btnDel">${empretired =='0'?'퇴사사원처리':'삭제' }</button> <!-- 관리자일때만 활성화 -->
								<button type="submit" class="btn btn-primary" style="${empretired== 0?'visibility:visible;':'visibility:hidden;'}">수정</button>
								<br>
								<button type="button" class="btn btn-primary" style="margin-top:10px;" id="btnReturnToList">리스트로 돌아가기</button>
							</div>
						</c:if>
						<c:if test="${Auth.empauth==0}">
							<div class="box-footer">
								<button type="submit" class="btn btn-primary" style="${empretired== 0?'visibility:visible;':'visibility:hidden;'}">수정</button>
							</div>
						</c:if>
					<c:if test="${success!=null }">
						<script>
							alert("${success}");
						</script>
					</c:if>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<%@ include file="../../include/footer.jsp"%>