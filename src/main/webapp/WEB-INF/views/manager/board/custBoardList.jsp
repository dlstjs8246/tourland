<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
	table .table table-bordered th,td,th{
       text-align: center;
    }
    .custBoardList:hover {
    	background-color : lightgrey;
    }
</style>
<!-- <div id="opa">dummy</div> -->
<div class="content">	
	<div class="row">
		<div class="col-sm-12">    
			<div class="box box-primary">      
				<div class="box-header">
					<h2 class="box-title">고객의 소리</h2>
				</div>
				<div class="box-body">

					<select name="searchType" id="searchType" style="width:200px; height: 25px;">
						<option value="N" ${cri.searchType ==null?'selected':''}>----------</option>
						<option value="custBoardContent" ${cri.searchType =='custBoardContent'?'selected':''}>내용</option>
						<option value="custBoardWriter" ${cri.searchType =='custBoardWriter'?'selected':''}>글쓴이</option>
						<option value="custBoardRegdate" ${cri.searchType =='custBoardRegdate'?'selected':''}>등록날짜</option>
					</select>
					<input type="text" name="keyword" id="keywordInput">
					<button id="btnSearch">Search</button>
				</div>
				<div class="box-body">
				<!-- 	<button id="btnRegister">추가 - 테스트용</button> -->
				</div>
				<div class="box-body">
					<table class="table table-bordered">
						<tr>
							<th>번호</th>
							<th>제목</th>   
							<th>작성자</th>
							<th>작성 일자</th>

						</tr>
						<c:forEach var="custBoardList" items="${list}">
						<tr class="custBoardList" data-click="${custBoardList.no}">
							<td>${custBoardList.no}</td>
							<td>${custBoardList.title}</td>
							<td>${custBoardList.writer}</td>
							<td><fmt:formatDate value="${custBoardList.regdate}" pattern="yyyy-MM-dd "/></td>
						</tr>
						</c:forEach>     
					</table>      
				</div>
				<div class="box-footer">
					<div class='text-center'>
	                   <ul class="pagination">
	                      <c:if test="${pageMaker.prev == true }">
	                          <li><a href="${pageContext.request.contextPath}/manager/custBoardMngList?page=${pageMaker.startPage -1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&laquo;</a></li>
	                       </c:if>
	                      <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
	                         <li class="${pageMaker.cri.page == idx?'active':''}"><a href="${pageContext.request.contextPath}/manager/custBoardMngList?page=${idx}&searchType=${cri.searchType}&keyword=${cri.keyword}"> ${idx }</a></li>
	                       </c:forEach>
	                       <!--  언제나 나오는 게 아니니까  -->
	                       <c:if test="${pageMaker.next == true }">
	                          <li><a href="${pageContext.request.contextPath}/manager/custBoardMngList?page=${pageMaker.endPage +1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&raquo;</a></li>
	                       </c:if>
	                   </ul>
	               </div>
				</div>
			</div>         
		</div>
	</div>
<!-- 열람을 위한 비밀번호 확인 모달  -->
 <!-- <div id="readModal" class="modal modal-primary fade" role="dialog">
	   <div class="modal-dialog">
	      <div class="modal-content">
	        <div class="modal-header">
	           <button type="button" class="close" data-dismiss="modal">×</button>
	           <h4 class="modal-title">22</h4>
	        </div>
	        <div class="modal-body">
	           <p>
	             <input type="text" id="confirmpw" class="form-control">
	           </p>
	        </div>
	        <div class="modal-footer">
	           <button type="button" class="btn btn-info" id="btnOK">비밀번호 확인</button>
	        </div>
	      </div>
	     </div>
	  </div>
  -->	
</div>

<script>
	$("#btnSearch").click(function(){
		var searchType = $("#searchType").val();
		var keyword = $("#keywordInput").val();
		location.href = "${pageContext.request.contextPath}/manager/custBoardMngList?searchType="+searchType+"&keyword="+keyword;
		//searchBoardController의 listPage GET 으로 받음 
		
	  })
	
	$("#btnRegister").click(function(){
		location.href = "${pageContext.request.contextPath}/manager/custBoardRegister";
	  })
	
	//각 리스트를 클릭했을 때 디테일로 넘어가는 부분
	$(".custBoardList").click(function(){
		var no = $(this).attr("data-click");
		var searchType = "${cri.searchType}";
		var keyword = "${cri.keyword}";
		location.href = "${pageContext.request.contextPath}/manager/custBoardDetail?no="+no+"&page=${pageMaker.cri.page}&searchType="+searchType+"&keyword="+keyword;
		
	})
</script>

<%@ include file="../../include/footer.jsp"%>