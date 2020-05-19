<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/paging.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/resources/css/boardStyle.css" rel="stylesheet" type="text/css" />
<style>
  section nav ul li:nth-child(3) {
	background: mistyrose;
}

  #btnWrite{
     width: 100px;
     padding:5px;
     background:mistyrose;
     border:none;
     margin-left:40px;
  }
</style>
</head>

<body>   
	<%@ include file="../../include/userHeader.jsp"%>
		<section>
		<%@ include file="../../include/userBoardMenu.jsp"%>   
				<div id="myreserv">
				<h1>고객의 소리</h1>
				<div id="searchDiv">
					 <select name="searchType" id="searchType"  >
						<option value="N" ${cri.searchType ==null?'selected':''}>----------</option>
						<option value="custBoardContent" ${cri.searchType =='custBoardContent'?'selected':''}>내용</option>
						<option value="custBoardWriter" ${cri.searchType =='custBoardWriter'?'selected':''}>글쓴이</option>
						<option value="custBoardRegdate" ${cri.searchType =='custBoardRegdate'?'selected':''}>등록날짜</option>
					</select>
					<input type="text" name="keyword" id="keywordInput" placeholder="검색어를 입력해주세요">
					<button id="btnSearch">검색</button>
				</div>
				<button id="btnWrite">글쓰기</button>
					<table id="reserv" style="margin-top:15px;">
						<tr>
							<th class="nono">번호</th>
							<th class="thTitle">제목</th>
							<th>작성자</th>
							<th class="lastTh">작성 일자</th>

						</tr>
						<c:forEach var="custBoardList" items="${list}">
						<tr class="custBoardList" data-click="${custBoardList.no}">
							<td class="nono">${custBoardList.no}</td>
							<td class="thTitle">${custBoardList.title}</td>
							<td>${custBoardList.writer}</td>
							<td><fmt:formatDate value="${custBoardList.regdate}" pattern="yyyy-MM-dd "/></td>
						</tr>
						</c:forEach>    
					</table>
					   <div class='text-center'>
	                   <ul class="pagination">
	                      <c:if test="${pageMaker.prev == true }">
	                          <li><a href="${pageContext.request.contextPath}/customer/tourlandCustBoard?page=${pageMaker.startPage -1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&laquo;</a></li>
	                       </c:if>
	                      <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
	                         <li class="${pageMaker.cri.page == idx?'active':''}"><a href="${pageContext.request.contextPath}/customer/tourlandCustBoard?page=${idx}&searchType=${cri.searchType}&keyword=${cri.keyword}"> ${idx }</a></li>
	                       </c:forEach>
	                       <!--  언제나 나오는 게 아니니까  -->
	                       <c:if test="${pageMaker.next == true }">
	                          <li><a href="${pageContext.request.contextPath}/customer/tourlandCustBoard?page=${pageMaker.endPage +1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&raquo;</a></li>
	                       </c:if>
	                   </ul>
	               </div>
				</div>
		    
		</section>
		<script>
	$("#btnSearch").click(function(){
		var searchType = $("#searchType").val();
		var keyword = $("#keywordInput").val();
		location.href = "${pageContext.request.contextPath}/customer/tourlandCustBoard?searchType="+searchType+"&keyword="+keyword;
		//searchBoardController의 listPage GET 으로 받음 
		
	  })
	
	//각 리스트를 클릭했을 때 디테일로 넘어가는 부분
	$(".custBoardList").click(function(){
		var no = $(this).attr("data-click");
		var searchType = "${cri.searchType}";
		var keyword = "${cri.keyword}";
		location.href = "${pageContext.request.contextPath}/customer/tourlandCustBoardDetail?no="+no+"&page=${pageMaker.cri.page}&searchType="+searchType+"&keyword="+keyword;
		
	})
	
	//글쓰기 버튼 누르면
	$("#btnWrite").click(function(){
		location.href="tourlandCustBoardRegister";
	})
</script>
		<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>