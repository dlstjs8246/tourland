<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
	.table th,td {
		text-align: center;
	}
	.pagination {
		margin-left : 650px;
	}
	.pagination li:hover {
		cursor: pointer;
	}
	.active {
		background-color : lightblue;
		color : white;  
	}
</style>
<!-- <div id="opa">dummy</div> -->
<div class="content">	
	<div class="row">
		<div class="col-sm-12">    
			<div class="box box-primary">      
				<div class="box-header">
					<h2 class="box-title">FAQ 관리</h2>
				</div>
				<div class="box-body">
				<!-- 검색 작업에서 유지될 데이터 
					1. 현재 페이지의 번호     
					2. 페이지당 보여지는 데이터의 수
					3. 검색의 종류
					4. 검색의 키워드
				 -->
					<select name="searchType" id="searchType">
						<option value="N">전체</option>
						<option value="D">국내패키지상품</option>
						<option value="I">해외패키지상품</option>
						<option value="R">상품 예약 및 결제</option>
						<option value="U">회원혜택안내</option>
					</select>
					<select name="searchType2" id="searchType2">
						<option value="N">전체</option>
					</select>
					<input type="text" name="keyword" id="keywordInput">
					<button id="btnSearch">Search</button>
				</div>
				<div class="box-body">
					<button>추가</button>
				</div>
				<div class="box-body">
					<table class="table table-bordered">
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>대분류</th>
							<th>분류</th>
						</tr>
						<c:forEach var="faq" items="${list}">
						<tr>
							<td>${faq.no}</td>
							<td>${faq.title}</td>
							<td>${faq.lcate eq 'D'?'국내패키지상품':faq.lcate eq 'I'?'해외패키지상품':faq.lcate eq 'R'?'상품 예약 및 결제':'회원혜택안내'}</td>
							<td>${faq.mcate eq 'P'?'여행상품':faq.mcate eq 'V'?'여권 및 비자':faq.mcate eq 'T'?'환율':faq.mcate eq 'J'?'제주여행':faq.mcate eq 'B'?'예약 및 취소':faq.mcate eq 'R'?'결제 및 환불':faq.mcate eq 'C'?'쿠폰 및 이벤트':'기타'}</td>
						</tr>
						</c:forEach>     
					</table>      
				</div>
				<div class="box-footer">
					<ul class="pagination"></ul>
				</div>
			</div>         
		</div>
	</div>
</div>

<script>
	var curPage = ${page};
	var makePage = function(curPage) {
		var endPage = ${pageMaker.endPage};
		for(var i=1;i<endPage;i++) {
			var li = $("<li>").html(i).css("float","left").css("list-style","none").css("padding","8px").css("border","1px solid grey").css("margin-right","5px");
			$(".pagination").append(li);
		}
	};
	var pageActive = function(curPage) {
		$(".pagination li").each(function(i, obj) {
			$(obj).removeClass("active");
		})
		$(".pagination li").each(function(i, obj) {
			if($(obj).text()==curPage) {
				$(obj).addClass("active");
			}
		})
	};
	$("#btnSearch").click(function(){
		var searchType = $("#searchType").val();
		var searchType2 = $("#searchType2").val();
		var keyword = $("#keywordInput").val();
		location.href = "listPage?searchType="+searchType+"&searchType2="+searchType2+"&keyword="+keyword;
		//searchBoardController의 listPage GET 으로 받음 
		
	})
	$("#btnRegister").click(function(){
		location.href = "register";
	})
	makePage(curPage);
	$(".pagination li").click(function() {
		curPage = $(this).text();
		location.href = "${pageContext.request.contextPath}/FAQMngList?page="+curPage;
	})
	pageActive(curPage);
	$("#searchType").change(function() {
		switch($("#searchType option:selected").val()) {
		case "국내패키지상품":
			var option = $("<option>").html("제주여행");
			$("#searchType2").append(option);
			break;
		case "해외패키지상품":
			var option1 = $("<option>").html("여행상품");
			var option2 = $("<option>").html("여권 및 비자");
			var option3 = $("<option>").html("환율");
			$("#searchType2").append(option1).append(option2).append(option3);
			break;
		case "상품 예약 및 결제":
			var option1 = $("<option>").html("예약 및 취소");
			var option2 = $("<option>").html("결제 및 환불");
			$("#searchType2").append(option1).append(option2);
			break;
		case "회원혜택안내":
			break;
		default :
			break;
		}
	})
</script>

<%@ include file="../../include/footer.jsp"%>