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
  section nav ul li:first-child {
	background: mistyrose;
}
.fixedTop { display:block;  height: 20px; background: maroon; color: #fff; }
</style>
</head>

<body>   
	<%@ include file="../../include/userHeader.jsp"%>
		<section>
		<%@ include file="../../include/userBoardMenu.jsp"%>   
				<div id="myreserv">
				<h1>공지사항</h1>
				<div id="searchDiv">
					 <select name="searchType" id="searchType">
						<option value="n" ${cri.searchType ==null?'selected':''}>-----</option>
						<option value="no" ${cri.searchType =='no'?'selected':''}>번호</option>
						<option value="title" ${cri.searchType =='title'?'selected':''}>제목</option>
					</select>
					<input type="text" name="keyword" id="keywordInput" placeholder="검색어를 입력해주세요">
					<button id="btnSearch">검색</button>
				</div>
					<table id="reserv">
						<tr>
							<th></th>
							<th class="nono">번호</th>
							<th class="thTitle">제목</th>
							<th>작성자</th>
							<th class="lastTh">작성일자</th>
						</tr>  
						<c:forEach items="${noticeFixedList}" var="n">   
							<tr>
								<td><span class="fixedTop">공지</span></td>
								<td class="nono">${n.no }</td>
								<td class="thTitle"><a href="${pageContext.request.contextPath }/customer/tourlandBoardNoticeDetail?no=${n.no}&page=${cri.page}" style="text-decoration: none;">${n.title }</a></td>
								<td>${n.writer }</td>
								<td><fmt:formatDate value="${n.regdate }" pattern ="yyyy-MM-dd"/></td>
							</tr>
						</c:forEach>  
						<c:forEach items="${noticeNoFixedList}" var="n">   
							<tr>
								<td></td>
								<td class="nono">${n.no }</td>
								<td class="thTitle"><a href="${pageContext.request.contextPath }/customer/tourlandBoardNoticeDetail?no=${n.no}&page=${cri.page}" style="text-decoration: none;">${n.title }</a></td>
								<td>${n.writer }</td>
								<td><fmt:formatDate value="${n.regdate }" pattern ="yyyy-MM-dd"/></td>
							</tr>
						</c:forEach>  
					</table>
					<div class='text-center'>
	                   <ul class="pagination">
	                      <c:if test="${pageMaker.prev == true }">
	                          <li><a href="${pageContext.request.contextPath}/customer/tourlandBoardNotice?page=${pageMaker.startPage -1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&laquo;</a></li>
	                       </c:if>
	                      <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
	                         <li class="${pageMaker.cri.page == idx?'active':''}"><a href="${pageContext.request.contextPath}/customer/tourlandBoardNotice?page=${idx}&searchType=${cri.searchType}&keyword=${cri.keyword}"> ${idx }</a></li>
	                       </c:forEach>
	                       <!--  언제나 나오는 게 아니니까  -->
	                       <c:if test="${pageMaker.next == true }">
	                          <li><a href="${pageContext.request.contextPath}/customer/tourlandBoardNotice?page=${pageMaker.endPage +1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&raquo;</a></li>
	                       </c:if>
	                   </ul>
	               </div>
				</div>
		     
		</section>
		<script>
	$("#btnSearch").click(function(){
		var searchType = $("#searchType").val();
		var keyword = $("#keywordInput").val();
		location.href = "tourlandBoardNotice?searchType="+searchType+"&keyword="+keyword;
		//searchBoardController의 listPage GET 으로 받음 
		
	})
</script>
		<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>