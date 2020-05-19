<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/boardStyle.css" rel="stylesheet" type="text/css" />
<style>
  section nav ul li:nth-child(3) {
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
</style>
</head>
<body>   
	<%@ include file="../../include/userHeader.jsp"%>
		<section>
		<%@ include file="../../include/userBoardMenu.jsp"%>   
		    <div id="detailDiv">
				<div>
				  <br>
				  <p>고객님들의 소중한 의견을 들려주세요. </p>
				  <br>
				  <br><br>
				</div>
				<div id="detailContent">
				   <form action="tourlandCustBoardRegister" method="post" id="custBoardForm">
							  <p>
								<label>번호</label> ${autoNo} <br>
								<input type="hidden" name="no" class="form-control" value="${autoNo}" readonly="readonly">
							  </p>
							  <p>
								<label>작성자</label> 
							
								   <c:if test="${mypage == 'mypageuser'}" > <!-- 유저일때 -->
								      ${Auth.username}<br>
								     <input type="hidden" name="writer"  value="${Auth.username}" readonly="readonly">
								   </c:if>
								  
								   <c:if test="${mypage == 'mypageemp'}" >
								   ${Auth.empname}
								      <input type="hidden" name="writer"  value="${Auth.empname}" readonly="readonly">
							       </c:if>
							  </p>
							  <p>
								<label>제목</label>
								<input type="text" name="title" class="form-control" required="required" style="border:none; border-bottom:1px solid black; width:400px;"> 
						      </p>
							  <p>
								<label>내용</label>
								<textarea rows="15" cols="100" style="margin-top:10px;" placeholder="  내용을 입력하세요" name="content" class="form-control" required="required">${custBoardVO.content}</textarea>
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
	$("#btnReturnToList").click(function(){
		location.href = "tourlandProductBoard";
	})
	
	$("#boardRegister").click(function(){
		location.href = "tourlandProductBoardRegister";
	})
</script>
		<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>