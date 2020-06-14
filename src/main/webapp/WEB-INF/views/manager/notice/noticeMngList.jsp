<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
	table th, td { text-align: center;}
	.red { color : maroon; font-weight: bold; }
	.blue { color : steelblue; font-weight: bold;}
</style>
<script>
$(function(){
    
	$("#addNotice").click(function(){
		location.href ="${pageContext.request.contextPath}/manager/addNoticeForm";
	})
})
</script>
<div class="content">	    
	<div class="row">
		<div class="col-sm-12">        
			<div class="box box-primary">      
				<div class="box-header">
					<h2 class="box-title">공지사항 관리</h2>
				</div>
				<div class="box-body">
				<!-- 검색 작업에서 유지될 데이터 
					1. 현재 페이지의 번호     
					2. 페이지당 보여지는 데이터의 수
					3. 검색의 종류
					4. 검색의 키워드
				 -->
					<select name="searchType" id="searchType">
						<option value="n" ${cri.searchType ==null?'selected':''}>-----</option>
						<option value="no" ${cri.searchType =='no'?'selected':''}>번호</option>
						<option value="title" ${cri.searchType =='title'?'selected':''}>제목</option>
					</select>
					<input type="text" name="keyword" id="keywordInput">
					<button id="btnSearch">Search</button>
				</div>
				<div class="box-body">
					<button id="addNotice">추가</button>
				</div>
				<div class="box-body">
					<table class="table table-bordered">
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일자</th>
							<th>상단 고정 여부</th>
						</tr>  
						<c:forEach items="${noticeFixedList}" var="n">   
							<tr>
								<td>${n.no }</td>
								<td><a href="${pageContext.request.contextPath }/manager/noticeDetail?no=${n.no}&page=${cri.page}">${n.title }</a></td>
								<td>${n.writer }</td>
								<td><fmt:formatDate value="${n.regdate }" pattern ="yyyy-MM-dd"/></td>
								<td class="blue">상단 고정</td>
							</tr>
						</c:forEach>  
						<c:forEach items="${noticeNoFixedList}" var="n">   
							<tr>
								<td>${n.no }</td>
								<td><a href="${pageContext.request.contextPath }/manager/noticeDetail?no=${n.no}&page=${cri.page}">${n.title }</a></td>
								<td>${n.writer }</td>
								<td><fmt:formatDate value="${n.regdate }" pattern ="yyyy-MM-dd"/></td>
								<td class="red">상단 고정 안함</td>
							</tr>
						</c:forEach>  
					</table>      
				</div>  
			<div class="box-footer">
					<div class="text-center">
						<ul class="pagination">
							<c:if test="${pageMaker.prev == true }">
								<li><a href="noticeMngList?page=${pageMaker.endPage -1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&laquo;</a></li>
							</c:if>
							<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
								<li class="${pageMaker.cri.page == idx ?'active':''}"><a href="noticeMngList?page=${idx}&searchType=${cri.searchType}&keyword=${cri.keyword}">${idx }</a></li>
								<!-- 주소의 시작이 /로 시작하지 않고 localhost:8080..으로 시작하면 맨 마지막 것만 바꿔주면됨 -->
							</c:forEach>
							<c:if test="${pageMaker.next == true }">
								<li><a href="noticeMngList?page=${pageMaker.endPage +1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&raquo;</a></li>
							</c:if>
						</ul>
					</div>
				</div> 
			</div>         
		</div>
	</div>
</div>

<script>
	$("#btnSearch").click(function(){
		var searchType = $("#searchType").val();
		var keyword = $("#keywordInput").val();
		location.href = "noticeMngList?searchType="+searchType+"&keyword="+keyword;
		//searchBoardController의 listPage GET 으로 받음 
		
	})
	
	$("#btnRegister").click(function(){
		location.href = "register";
	})
</script>

<%@ include file="../../include/footer.jsp"%>