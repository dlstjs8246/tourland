<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
  #previewDiv{
    height: 250px;
  }
  .previewImg{
    width: 560px;
    height: 200px;
  }
</style>

<div class="content">
	<div class="row">
		<div class="col-sm-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">고객의 소리 등록</h3>
				</div>
				<form role="form" action="custBoardRegister" method="post" id="bannerForm">
					<div class="box-body">
						<div class="form-group">
							<label>번호</label>
							<input type="text" name="no" class="form-control" value="${autoNo}" readonly="readonly">
						</div>
						<div class="form-group">
							<label>작성자</label> <!-- 고객페이지라면 로그인한 사람의 정보를 value로 설정하고 readonly로 바꾸기 -->
							<input type="text" name="writer" style="background: azure;" class="form-control" >
						</div>
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="title" class="form-control" required="required"> 
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea rows="15" cols="30" placeholder="내용을 입력하세요" name="content" class="form-control" required="required">${custBoardVO.content}</textarea>
						</div>
						<div class="form-group">
							<label>열람 비밀번호 설정</label>
							<input type="text" name="passwd" class="form-control" required="required">
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
<script>

      
       //리스트로 버튼 눌렀을 때 리스트로 돌아가기 
		$("#btnReturnToList").click(function(){
			location.href="${pageContext.request.contextPath}/manager/custBoardMngList";
		})
   
  </script>
<%@ include file="../../include/footer.jsp"%>