<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/paging.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/resources/css/boardStyle.css" rel="stylesheet" type="text/css" />
</head>
<style>
  .FAQContent{
    width: 100%;
    height: auto;
    display:none; 
    margin-bottom:10px;
  }

  section nav ul li:nth-child(2) {
	background: mistyrose;
}

</style>
<body>   
	<%@ include file="../../include/userHeader.jsp"%>
		<section>
		<%@ include file="../../include/userBoardMenu.jsp"%>   
				<div id="myreserv">
				<h1>자주 묻는 질문</h1>
				<div id="searchDiv">
					<select name="searchType" id="searchType">
						<option value="">전체</option>
						<option value="D">국내패키지상품</option>
						<option value="I">해외패키지상품</option>
						<option value="R">상품 예약 및 결제</option>
						<option value="U">회원혜택안내</option>
					</select>
					<select name="searchType2" id="searchType2" style="width:150px; height:30px;" >
						<option value="N">-----------</option>
					</select>
					<input type="text" name="keyword" id="keywordInput" placeholder="검색어를 입력해주세요">
					<button id="btnSearch">검색</button>
				</div>
					<table id="reserv">
						<tr>
							<th class="nono">번호</th>
							<th class="thTitle">제목</th>
							<th>대분류</th>
							<th>분류</th>
							<th class="lastTh">펼쳐보기</th>
						</tr>
						<c:forEach var="faq" items="${list}">
						<tr class="faqList" data-no="${faq.no}">
							<td class="nono">${faq.no}</td>
							<td class="thTitle" style="margin-top:15px;"><i class="fab fa-quora"></i>  ${faq.title}
									<div class="FAQContent">
									<br><br>
										<i class="fas fa-bullhorn"></i>   ${faq.content }
									</div>
							</td>
							<td>${faq.lcate eq 'D'?'국내패키지상품':faq.lcate eq 'I'?'해외패키지상품':faq.lcate eq 'R'?'상품 예약 및 결제':'회원혜택안내'}</td>
							<td>${faq.mcate eq 'P'?'여행상품':faq.mcate eq 'V'?'여권 및 비자':faq.mcate eq 'T'?'환율':faq.mcate eq 'J'?'제주여행':faq.mcate eq 'B'?'예약 및 취소':faq.mcate eq 'R'?'결제 및 환불':faq.mcate eq 'C'?'쿠폰 및 이벤트':'기타'}</td>
						    <td><i class="fas fa-angle-down"></i></td> 
						    
						</tr>
						
						</c:forEach>   
					</table>
					 <div class='text-center'>
		                <ul class="pagination">
			                <c:if test="${pageMaker.prev == true}">
						        <li><a href="${pageContext.request.contextPath}/customer/tourlandBoardFAQ?page=${pageMaker.startPage-1}&searchType=${cri.searchType}&searchType2=${cri.searchType2}&keyword=${cri.keyword}">&laquo;</a></li>
							</c:if>
							<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
								<li class="${cri.page==idx?'active':''}"><a href="${pageContext.request.contextPath}/customer/tourlandBoardFAQ?page=${idx}&searchType=${cri.searchType}&searchType2=${cri.searchType2}&keyword=${cri.keyword}">${idx}</a></li>
							</c:forEach>
							<c:if test="${pageMaker.next == true}">
								<li><a href="${pageContext.request.contextPath}/customer/tourlandBoardFAQ?page=${pageMaker.endPage+1}&searchType=${cri.searchType}&searchType2=${cri.searchType2}&keyword=${cri.keyword}">&raquo;</a></li>
							</c:if>
	                   </ul>
	               </div>
				</div>
		    
		</section>
		<script>
	var makeOption = function(searchType) {
		switch(searchType) {
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
			$("#searchType2").append(option).append(option1).append(option2).append(option3).append(option4);
			break;
		case "R":
			var option = $("<option value=''>").html("전체");
			var option1 = $("<option value='B'>").html("예약 및 취소");
			var option2 = $("<option value='R'>").html("결제 및 환불");
			$("#searchType2").append(option).append(option1).append(option2);
			break;
		case "U":
			var option = $("<option value='C'>").html("쿠폰,이벤트");
			$("#searchType2").append(option);
			break;
		default :
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
			if(value==searchType) {
				$(this).prop("selected",true);
				return;
			}
		})
		$("#searchType2 option").each(function(i, obj) {
			var value = $(this).val();
			if(value==searchType2) {
				$(this).prop("selected",true);
				return;
			}
		})
		$("#keywordInput").val(keyword);
	};
	$(document).on("click",".faqList",function(){
		$(".FAQContent").css("display","none");
		var no = $(this).attr("data-no");
		$(this).children().children(".FAQContent").css("display","block");
		
	})
	$(document).on("click",".FAQContent",function(){
		$(this).css("display","none");
		return false;
	})
	
	$("#searchType").change(function() {
		$("#searchType2").empty();
		makeOption($("#searchType option:selected").val());
		$("#keywordInput").val("");
	})
	$("#btnSearch").click(function(){
		var searchType = $("#searchType option:selected").val();
		var searchType2 = $("#searchType2 option:selected").val();
		var keyword = $("#keywordInput").val();
		location.href = "tourlandBoardFAQ?searchType="+searchType+"&searchType2="+searchType2+"&keyword="+keyword;
		//searchBoardController의 listPage GET 으로 받음 	
	})

	fixSearchTypeAndKeyword();
</script>
		
		<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>