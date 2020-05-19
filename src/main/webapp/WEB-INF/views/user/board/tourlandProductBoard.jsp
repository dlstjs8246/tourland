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
  section nav ul li:nth-child(4) {
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
				<div id="myreserv" >
				<h1>상품 문의 사항</h1>
				<div id="searchDiv">
					<select name="searchType" id="searchType">
						<option value="">전체</option>
						<option value="D">국내패키지상품</option>
						<option value="I">해외패키지상품</option>
						<option value="R">상품 예약 및 결제</option>
						<option value="U">회원혜택안내</option>
					</select>
					<select name="searchType2" id="searchType2" style="width:150px; height:30px;">
						<option value="N">-----------</option>
					</select>
					<input type="text" name="keyword" id="keywordInput" placeholder="검색어를 입력해주세요">
					<button id="btnSearch">검색</button>
				</div>
				<button id="btnWrite">글쓰기</button>
					<table id="reserv" style="margin-top:15px;">
						<tr>
							<th class="nono">번호</th>
							<th style="width:400px;">제목</th>
							<th>대분류</th>
							<th>중분류</th>
							<th>작성자</th>
							<th>작성일자</th>
							<th class="lastTh">답변상태</th>
						</tr>
						<c:forEach var="planBoard" items="${list}">
						<tr class="planBoardList" data-no="${planBoard.no}">
							<td class="nono">${planBoard.no}</td>
							<td style="width:400px;">${planBoard.title}</td>
							<td>${planBoard.lcate eq 'D'?'국내패키지상품':planBoard.lcate eq 'I'?'해외패키지상품':planBoard.lcate eq 'R'?'상품 예약 및 결제':'회원혜택안내'}</td>
							<td>${planBoard.mcate eq 'P'?'여행상품':planBoard.mcate eq 'V'?'여권 및 비자':planBoard.mcate eq 'T'?'환율':planBoard.mcate eq 'J'?'제주여행':faq.mcate eq 'B'?'예약 및 취소':planBoard.mcate eq 'R'?'결제 및 환불':planBoard.mcate eq 'C'?'쿠폰 및 이벤트':'기타'}</td>
							<td>${planBoard.writer}</td>
							<td><fmt:formatDate value="${planBoard.regdate}" pattern="yyyy-MM-dd"/></td>
							<c:if test="${planBoard.answer==0 }">
								<td><span class="badge bg-orange">답변미완료</span></td>
							</c:if>
							<c:if test="${planBoard.answer==1 }">
								<td><span class="badge bg-blue">답변완료</span></td>
							</c:if>
						</tr>
						</c:forEach>  
					</table>
					   <div class='text-center'>
	                   <ul class="pagination">
	                      <c:if test="${pageMaker.prev == true }">
	                          <li><a href="${pageContext.request.contextPath}/customer/tourlandProductBoard?page=${pageMaker.startPage -1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&laquo;</a></li>
	                       </c:if>
	                      <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
	                         <li class="${pageMaker.cri.page == idx?'active':''}"><a href="${pageContext.request.contextPath}/customer/tourlandProductBoard?page=${idx}&searchType=${cri.searchType}&keyword=${cri.keyword}"> ${idx }</a></li>
	                       </c:forEach>
	                       <!--  언제나 나오는 게 아니니까  -->
	                       <c:if test="${pageMaker.next == true }">
	                          <li><a href="${pageContext.request.contextPath}/customer/tourlandProductBoard?page=${pageMaker.endPage +1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&raquo;</a></li>
	                       </c:if>
	                   </ul>
	               </div>
				</div>
		    
		</section>
		<script>

			var makeDetailOption = function(searchType) {
				switch (searchType) {
				case "D":
					var option = $("<option value='J'>").html("제주여행");
					$("#searchType2").append(option);
					break;
				case "I":
					var option = $("<option value=''>").html("전체");
					var option1 = $("<option value='P'>").html("여행상품");
					var option2 = $("<option value='V'>").html("여권 및 비자");
					var option3 = $("<option value='T'>").html("환율");
					var option4 = $("<option value='E'>").html("기타");
					$("#searchType2").append(option).append(option1).append(
							option2).append(option3).append(option4);
					break;
				case "R":
					var option = $("<option value=''>").html("전체");
					var option1 = $("<option value='B'>").html("예약 및 취소");
					var option2 = $("<option value='R'>").html("결제 및 환불");
					$("#searchType2").append(option).append(option1).append(
							option2);
					break;
				case "U":
					var option = $("<option value='C'>").html("쿠폰,이벤트");
					$("#searchType2").append(option);
					break;
				default:
					var option = $("<option value=''>").html("-----------");
					$("#searchType2").append(option);
				}
			}
			var fixSearchTypeAndKeyword = function() {
				var searchType = "${cri.searchType}";
				var searchType2 = "${cri.searchType2}";
				var keyword = "${cri.keyword}";
				$("#searchType2").empty();
				makeOption(searchType);
				$("#searchType option").each(function(i, obj) {
					var value = $(this).val();
					if (value == searchType) {
						$(this).prop("selected", true);
						return;
					}
				})
				$("#searchType2 option").each(function(i, obj) {
					var value = $(this).val();
					if (value == searchType2) {
						$(this).prop("selected", true);
						return;
					}
				})
				$("#keywordInput").val(keyword);
			};

			$("#searchType").change(function() {
				$("#searchType2").empty();
				makeDetailOption($("#searchType option:selected").val());
				$("#keywordInput").val("");
			})

			$(".planBoardList").click(
					function() {
						var no = $(this).attr("data-no");
						var searchType = "${cri.searchType}";
						var searchType2 = "${cri.searchType2}";
						var keyword = "${cri.keyword}";
						location.href = "tourlandProductBoardDetail?no=" + no
								+ "&page=${pageMaker.cri.page}&searchType="
								+ searchType + "&searchType2=" + searchType2
								+ "&keyword=" + keyword;
					})
			$("#btnSearch")
					.click(
							function() {
								var searchType = $(
										"#searchType option:selected").val();
								var searchType2 = $(
										"#searchType2 option:selected").val();
								var keyword = $("#keywordInput").val();
								location.href = "planBoardList?searchType="
										+ searchType + "&searchType2="
										+ searchType2 + "&keyword=" + keyword;
							})
		//글쓰기 버튼 누르면
	$("#btnWrite").click(function(){
		location.href="tourlandProductBoardRegister";
	})
							
</script>
		<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>