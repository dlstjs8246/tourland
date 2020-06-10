<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
	.red { color: maroon; font-weight: bold;}
	.blue { color: steelblue; font-weight: bold;}
</style>
<script>
	$(function(){
		$("#mod").click(function(){
			var no = "${notice.no}";
			var page =	"${cri.page}";
			var searchType = "${cri.searchType}"==""?"N":"${cri.searchType}";
			var searchType2 = "${cri.searchType2}"==""?"N":"${cri.searchType2}";
			var keyword = "${cri.keyword}";
			/* location.href = "editNotice?no="+no+"&page="+page+"&searchType="+searchType+"&searchType2="+searchType2+"&keyword="+keyword; */
			location.href = "editNotice?no="+no;
		})
		$("#del").click(function(){
			if(!confirm("삭제하시겠습니까?")) {
				return false;
			}
			var no = "${notice.no}";
			var page =	"${cri.page}";
			var searchType = "${cri.searchType}"==""?"N":"${cri.searchType}";
			var searchType2 = "${cri.searchType2}"==""?"N":"${cri.searchType2}";
			var keyword = "${cri.keyword}";
			location.href = "removeNotice?no="+no+"&page="+page+"&searchType="+searchType+"&searchType2="+searchType2+"&keyword="+keyword;
		})
		$("#return").click(function() {
			var page =	"${cri.page}";
			var searchType = "${cri.searchType}"==""?"N":"${cri.searchType}";
			var searchType2 = "${cri.searchType2}"==""?"N":"${cri.searchType2}";
			var keyword = "${cri.keyword}";
			location.href = "noticeMngList?page="+page+"&searchType="+searchType+"&searchType2="+searchType2+"&keyword="+keyword;
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
				<div class="box-body">
					<div class="form-group">
						<label>번호</label>
						<input type="text" name="no" class="form-control" value="${notice.no}" readonly="readonly">
					</div>
					<div class="form-group">
						<label>상단 고정여부</label>
						<c:if test="${notice.fixed==1 }">
							<p class="blue">
								상단 고정됨
							</p>
						</c:if>
						<c:if test="${notice.fixed==0 }">
							<p class="red">
								상단 고정 안됨
							</p>
						</c:if>
					</div>
					<div class="form-group">
						<label>제목</label>
						<input type="text" name="title" class="form-control" value="${notice.title}" readonly="readonly">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea rows="15" cols="30" name="content" class="form-control" readonly="readonly">${notice.content }</textarea>
					</div>
				<div class="box-footer">
					<button class="btn btn-warning" id="mod">수정</button>
					<button class="btn btn-danger" id="del">삭제</button>
					<button class="btn btn-primary" id="return">돌아가기</button>
				</div>
				</div>
		</div>
	</div>
</div>
</div>
<%@ include file="../../include/footer.jsp"%>