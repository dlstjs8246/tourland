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
					<h3 class="box-title">고객의 소리 조회</h3>
				</div>
				<form role="form" action="custBoardUpdate" method="post" id="bannerForm">
					<div class="box-body">
						<div class="form-group">
							<label>번호</label>
							<input type="text" name="no" class="form-control" value="${custBoardVO.no }" readonly="readonly">
						</div>
						<div class="form-group">
							<label>작성자</label>
							<input type="text" name="writer" style="background: azure;" class="form-control" value="${custBoardVO.writer }" readonly="readonly">
						</div>
						<div class="form-group">
							<label>작성일자</label> <!-- 작성일은 수정되지 않게 설정했기 때문에 form에서 보내지 않기로함  -->
							<input type="text" style="background: azure;" class="form-control" value="<fmt:formatDate value='${custBoardVO.regdate }' pattern='yyyy-MM-dd'/>" readonly="readonly">
						</div>
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="title" class="form-control" value="${custBoardVO.title }"> 
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea rows="15" cols="30" placeholder="내용을 입력하세요" name="content" class="form-control" required="required">${custBoardVO.content}</textarea>
						</div>
					<!-- 	<div class="form-group">
							<label>열람 비밀번호</label>
							<input type="text" name="passwd" class="form-control">
						</div> -->
						<div class="box-footer">
							<!-- <button type="submit" class="btn btn-primary">수정-테스트</button> -->
							 <button type="button" class="btn btn-primary" style="background:red;" id="btnDel">삭제</button><br>
							 <button type="button" class="btn btn-primary" id="btnReturnToList" style="margin-top:10px;">목록으로</button>
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
		
	   //삭제 누르면 삭제 되기
	   $("button#btnDel").click(function(){
		   var custno = ${custBoardVO.no };
		   var cc = confirm("삭제하시겠습니까?");
		   if(cc){
		   location.href="${pageContext.request.contextPath }/manager/removeCustBoard?no="+custno+"&page=${cri.page}&searchType=${cri.searchType}&keyword=${cri.keyword}";
		   }
	   })
	   
   
  </script>
<%@ include file="../../include/footer.jsp"%>