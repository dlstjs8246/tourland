<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<script>
	$(function(){
		$("#fixed").change(function(){
			if($(this).is(":checked")){
				$("#hiddenInfo").val("1");
			}
		})
		
		$("#mod").click(function(){
			var no = "${notice.no}";
			var page =	"${cri.page}";
			var searchType = "${cri.searchType}"==""?"N":"${cri.searchType}";
			var searchType2 = "${cri.searchType2}"==""?"N":"${cri.searchType2}";
			var keyword = "${cri.keyword}";
			/* location.href = "editNotice?no="+no+"&page="+page+"&searchType="+searchType+"&searchType2="+searchType2+"&keyword="+keyword; */
			location.href = "editNotice?no="+no;
		})
		
	})
</script>
<div class="content">
	<div class="row">
		<div class="col-sm-12">
			<div class="box box-primary">
				<div class="box-header">
				
					<h3 class="box-title">공지사항</h3>
				</div>
				<form action="editNotice" method="POST">
				<div class="box-body">
					<div class="form-group">
						<label>번호</label>
						<input type="text" name="no" class="form-control" value="${notice.no}" readonly="readonly">
					</div>
						<div class="group">
							<div class="form-group">
								<label>상단 고정 여부</label>
								<c:if test="${notice.fixed==1 }">
									<p>	<input type="checkbox" class="form-check-input" id="fixed" checked="checked"> 상단 고정하기</p>
								</c:if>
								 <c:if test="${notice.fixed==0 }">
									<p>	<input type="checkbox" class="form-check-input" id="fixed"> 상단 고정하기</p>
								</c:if>
									<input type="hidden" id="hiddenInfo" name="fixed" value="0">
								
							</div>
						</div>
						<div class="form-group">
						<label>제목</label>
						<input type="text" name="title" class="form-control" value="${notice.title}">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea rows="15" cols="30" name="content" class="form-control">${notice.content }</textarea>
					</div>
				<div class="box-footer">
					<button class="btn btn-warning" id="mod">수정</button>
				</div>
				</div>
				</form>
		</div>
	</div>
</div>
</div>
<%@ include file="../../include/footer.jsp"%>