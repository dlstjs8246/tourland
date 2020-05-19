<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
	table th, td { text-align: center;}
</style>
<script>
$(function(){
    
	$("#addCoupon").click(function(){
		location.href ="${pageContext.request.contextPath}/addCouponForm";
	})
})
</script>
<div class="content">	
	<div class="row">
		<div class="col-sm-12">    
			<div class="box box-primary">      
				<div class="box-header">
					<h2 class="box-title">쿠폰 관리</h2>
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
						<option value="cno" ${cri.searchType =='cno'?'selected':''}>번호</option>
						<option value="cncc" ${cri.searchType =='cncc'?'selected':''}>이름/내용<option>
					</select>
					<input type="text" name="keyword" id="keywordInput">
					<button id="btnSearch">Search</button>
				</div>
				<div class="box-body">
					<button id="addCoupon">추가</button>
				</div>
				<div class="box-body">
					<table class="table table-bordered">
						<tr>
							<th>번호</th>
							<th>이름</th>
							<th>발행일자</th>
							<th>만료일자</th>
							<th>쿠폰내용</th>
							<th>할인율</th>
						</tr>    
					<c:forEach items="${couponList }" var="c">
						<tr>
							<td>${c.cno }</td>
							<td><a href="${pageContext.request.contextPath }/manager/couponDetail?cno=${c.cno }&page=${cri.page}">${c.cname } </a></td>
							<td><fmt:formatDate value="${c.pdate }" pattern="yyyy-MM-dd"/></td>
							<td><fmt:formatDate value="${c.edate }" pattern="yyyy-MM-dd"/></td>
							<td>${c.ccontent }</td>
							<td>${c.mrate }</td>
						</tr>
					</c:forEach> 
					</table>      
				</div>
				<div class="box-footer">
					<div class="text-center">
						<ul class="pagination">
							<c:if test="${pageMaker.prev == true }">
								<li><a href="couponMngList?page=${pageMaker.endPage -1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&laquo;</a></li>
							</c:if>
							<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
								<li class="${pageMaker.cri.page == idx ?'active':''}"><a href="couponMngList?page=${idx}&searchType=${cri.searchType}&keyword=${cri.keyword}">${idx }</a></li>
								<!-- 주소의 시작이 /로 시작하지 않고 localhost:8080..으로 시작하면 맨 마지막 것만 바꿔주면됨 -->
							</c:forEach>
							<c:if test="${pageMaker.next == true }">
								<li><a href="couponMngList?page=${pageMaker.endPage +1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&raquo;</a></li>
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
		location.href = "couponMngList?searchType="+searchType+"&keyword="+keyword;
		//searchBoardController의 listPage GET 으로 받음 
		
	})
	
	$("#btnRegister").click(function(){
		location.href = "register";
	})
</script>

<%@ include file="../../include/footer.jsp"%>