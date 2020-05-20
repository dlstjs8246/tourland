<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/boardStyle.css" rel="stylesheet" type="text/css" />
<style>
  section nav ul li:nth-child(4) {
	background: mistyrose;
}

  #custBoardForm p{
     margin-bottom:10px;
  }
  #custBoardForm input{
    height: 30px;
  }
  #custBoardForm label{
    float:left;
    width: 100px;
  }
  #boardRegister, #btnReturnToList{
    width:100px;
    height:30px;
    border:none;
    background: mistyrose;
  }
  #ptag{
  	padding:20px 20px;
  	color:gray;
  }
  #writerP{
  	padding-bottom: 10px;
  }
  #titleP{
  	padding-top:15px;
  }
</style>
</head>
<body>   
	<%@ include file="../../include/userHeader.jsp"%>
		<section>
		<%@ include file="../../include/userBoardMenu.jsp"%>   
		    <div id="detailDiv">
				<div style="width: 315px; height:115px;">
				  <br>
				  <p id="ptag">고객님들의 소중한 의견을 들려주세요.</p>
				  <br>
				</div>
				<div id="detailContent">
				   <form action="tourlandPlanBoardRegister" method="post" id="planBoardForm" autocomplete="off">
							  <p id="writerP">
								<label>작성자</label> 
								   <c:if test="${mypage == 'mypageuser'}" > <!--유저일때 -->
								     <span>[ ${Auth.username} ]</span><br>
								     <input type="hidden" name="writer"  value="${Auth.username}">
								     <input type="hidden" name="userno" class="form-control" value="${Auth.userno}">
								   </c:if>
								   <c:if test="${mypage == 'mypageemp'}" >
								   	  <span>[ ${Auth.empname} ]</span><br>
								      <input type="hidden" name="writer"  value="${Auth.empname}">
								      <input type="hidden" name="empno" class="form-control" value="${Auth.empno}">
							       </c:if>
							  </p>
							  <p style="padding-bottom:10px;">
							  	 <label>대분류</label>
									<select name="lcate" id="lcate" required="required">
										<option value="D">국내패키지상품</option>
										<option value="I">해외패키지상품</option>
										<option value="R">상품 예약 및 결제</option>
										<option value="U">회원혜택안내</option>
									</select> 
							  </p>
							  <p style="padding-bottom:10px;">
							  	 <label>중분류</label>
									<select name="mcate" id="mcate" required="required">
										<option value="J">제주여행</option>
									</select>
							  </p>
							  <p id="titlaP">
								<label>제목</label>
								<input type="text" name="title" class="form-control" required="required" style="border:none; border-bottom:1px solid black; width:400px;"> 
						      </p>
							  <p>
								<textarea rows="15" cols="100" style="margin-top:10px;" placeholder="  내용을 입력하세요" name="content" class="form-control" required="required"></textarea>
							  </p>
						      <!-- <p>
								<label>비밀번호 설정</label>
								<input type="text" name="passwd" class="form-control" required="required">
							  </p> -->
							  <br><br>
							<div>
								 <button type="submit" class="btn btn-primary" id="boardRegister">등록</button>
								 <button type="button" class="btn btn-primary" id="btnReturnToList">목록으로</button>
						</div>
				   </form>
				</div>
		     </div>
		</section>
<script>
		$(function(){
			$("#lcate").change(function() {
				$("#mcate").empty();
				var val = $("#lcate option:selected").val();
				switch(val) {
				case "D":
					var option = $("<option value='J'>").html("제주여행");
					$("#mcate").append(option);
					break;
				case "I":
					var option1 = $("<option value='P'>").html("여행상품");
					var option2 = $("<option value='V'>").html("여권 및 비자");
					var option3 = $("<option value='T'>").html("환율");
					var option4 = $("<option value='E'>").html("기타");
					$("#mcate").append(option1).append(option2).append(option3).append(option4);
					break;
				case "R":
					var option1 = $("<option value='B'>").html("예약 및 취소");
					var option2 = $("<option value='R'>").html("결제 및 환불");
					$("#mcate").append(option1).append(option2);
					break;
				case "U":
					var option = $("<option value='C'>").html("쿠폰,이벤트");
					$("#mcate").append(option);
					break;
				}
			})
		})
		
		
	$("#btnReturnToList").click(function(){
		location.href = "tourlandPlanBoard";
	})
	
	$("#boardRegister").click(function(){
		location.href = "tourlandPlanBoardRegister";
	})
</script>
<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>