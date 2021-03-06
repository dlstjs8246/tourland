<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%@ include file="../../include/userHeader.jsp"%>
<style>
section {
	width: 1000px;
	margin: 0 auto;
}

div#pkgTitleBox {
	height: 230px;
	border-bottom: 1px solid #ededed;
}

div#pkgTitleBox h1 {
	height: 80px;
	line-height: 80px;
}

div#pkgContentBox {
	padding-top: 50px;
}

div#pkgSearch {
	width: 300px;
	background: #ededed;
	float: left;
}

div#pkgSearch h3 {
	background: goldenrod;
	height: 50px;
	line-height: 50px;
	text-indent: 10px;
}

div#pkgSearch p {
	height: 50px;
	line-height: 50px;
	text-indent: 10px;
}

div#pkgSearch input {
	width: 90%;
	margin-left: 10px;
}

div#pkgSearch select {
	width: 90%;
	margin-left: 10px;
}

#pkgBtnBox {
	text-align: center;
}

button#pkgSearchBtn {
	border: none;
	width: 150px;
	height: 30px;
	background: #929292;
}

div#pkgListWrap {
	width: 650px;
	padding: 0 20px 20px 30px;
	overflow: hidden;
}

#totalCnt {
	font-weight: bold;
}

div#pkgOrderBy {
	height: 80px;
	line-height: 80px;
}

div#pkgOrderBy button {
	border: none;
	width: 100px;
	height: 30px;
} 

div.pkgImg {
	width: 250px;
	height: 180px;
	margin-right: 10px;
	float: left;
}

div.pkgImg img {
	width: 100%;
	height : 200px;
}

div.pkgInfoBox {
	width: 90%;
	height: 210px; 
	padding: 20px;
	border: 1px solid #ededed; 
}

div.pkgInfoBox p {
	height: 40px;
}

div.pkgInfoBox .pkgTitle {
	height: 80px;
	font-size: 20px;
	font-weight: bold;
}

.pkgPrice {
	text-indent: 5px;
	font-size: 19px;
	color: maroon;
	text-align: right;
}

.pkgDate {
	text-align: right;
	font-size: 16px;
	font-weight: bold;
}

.pkgReserv {
	text-align: right;
}

.pkgReservBtn {
	border: none;
	width: 100px;
	height: 30px;
}
.pagination {
	list-style : none;
	margin-left : 150px; 
	margin-top : 10px;
}
.pagination li {
	width: 30px;
	height: 30px;
	text-align: center;
	float : left;
	border : 1px solid lightgrey;
}
.pagination .active {
	background-color : grey;
}   

#listAll { margin-left: 420px; background: steelblue; color: #fff;}   
.pagination li .pageNumA { display: block; height: 100%;}
</style>
<%@include file="tourlandProductList_script.jsp"%>
<script>
$(function(){
	/* 페이지 좌측 검색 박스 검색 버튼 클릭  */
	$("#pkgSearchBtn").click(function(){
		getSearchResult("Japan");
	})
	/* 리스트 우측 전체 리스트 보기 버튼 클릭 */
	$("#listAll").click(function(){
		getList(1,"Japan");
	})
	/* 낮은 가격 순 정렬 */
	$("#byPrice").click(function(){
		getLowPriceList(1,"JP");
	})
	/* AJAX 페이징 */
	/* 낮은 가격순 리스트 페이지 번호 클릭 시 페이지 번호가 넘어가고 해당 번호의 리스트 출력 */
	$(document).on("click", ".lowPriceListPage", function(){
	    $('html, body').animate({scrollTop: 0}, 200);
		var page = $(this).html();
		getLowPriceList(page,"JP");
	})
	/* 전체 리스트 페이지 번호 클릭 시 페이지 번호가 넘어가고 해당 페이지 번호의 리스트 출력 */
	$(document).on("click", ".listAll", function(){
	    $('html, body').animate({scrollTop: 0}, 200);
		var page = $(this).html();
		getList(page,"Japan");
	})

	/* AJAX 리스트에 동적으로 생성된 '지금 바로 예약하기' 버튼  */
	$(document).on("click", ".pkgReservBtn", function(){
		var pno = $(this).attr("data-pno");
		var price = replaceAll($(this).attr("data-price"),",","");
		if($.cookie('currentProduct') != null && $.cookie('currentProductPrice') != null ){	
			if($.cookie('currentProduct') != pno){
			 $.cookie("currentProduct2",$.cookie('currentProduct'),{expires:1, path:"/"});
			 $.cookie("currentProductPrice2",$.cookie('currentProductPrice'),{expires:1, path:"/"});
			 $.removeCookie('currentProduct');
			 $.removeCookie('currentProductPrice');
			 $.cookie("currentProduct",pno,{expires:1, path:"/"});
			 $.cookie("currentProductPrice",price,{expires:1, path:"/"});
			}
		 }else{
			 $.cookie("currentProduct",pno,{expires:1, path:"/"});
			 $.cookie("currentProductPrice",price,{expires:1, path:"/"});
		 }
		location.href = "${pageContext.request.contextPath}/customer/tourlandProductDetail?pno="+pno+"&price="+price;
	})
})
</script> 
<body>
<!-- 메인 검색 박스에서 검색한 내용을 들고와서 자동 검색 후 페이지 출력 -->
<c:if test="${tourDays!=null }">
	<script>
	$(function(){
		$(".datepicker").val("${date }");
		$("#rdate option[value='${tourDays}']").attr("selected", "selected");
		$("#cnt option[value='${capa}']").attr("selected", "selected");
		$("#pkgSearchBtn").trigger("click");
	})
	
	</script>
	
</c:if>
	<section>
		<div id="pkgTitleBox">
			<h1>도쿄</h1>
			<div id="pkgInfo">
				<p>일본은 최첨단 전자제품 매장과 로봇 레스토랑 바로 옆에 신사를 찾아볼 수 있을 만큼 옛 전통과 현대 문화가
					절묘한 조화를 이루는 인기 여행지입니다. 벚꽃이 만발하는 봄을 비롯해 사계절 내내 즐길 거리로 가득한 일본은 언제
					방문해도 만족스러운 여행 경험을 선사합니다. 일본 전역에서 사용 가능한 JR 패스만 있으면 다양한 도시를 자유롭게 여행할 수 있어요.
					 하루나 이틀 정도는 도쿄를 대표하는 최고의 관광 명소, 도쿄 디즈니랜드에서 어트랙션을 즐기고, 일본 최고층 전망대도 방문해보세요.</p>
			</div> 
			<div id="pkgMap"></div>

		</div>
		<div id="pkgContentBox">   
			<div id="pkgSearch">
				<h3>검색</h3>
				<p>출발일 선택</p>
				<input type="date" class="datepicker" name="ddate">
				<p>여행일 선택</p>
				<select id="rdate">
					<option value='3일'>3일</option>
					<option value='5일'>5일</option>
					<option value='7일'>7일</option>
				</select>
				<p>인원</p>
				<select id="cnt">
					<option value='2명'>2명</option>
					<option value='3명'>3명</option>
					<option value='4명'>4명</option>
					<option value='5명'>5명</option>
					<option value='6명'>6명</option>
					<option value='7명'>7명</option>
					<option value='8명'>8명</option>
					<option value='9명'>9명</option>
					<option value='10명'>10명</option>
					<option value='11명'>11명</option>
					<option value='12명'>12명</option>
					<option value='13명'>13명</option>
					<option value='14명'>14명</option>
					<option value='15명'>15명</option>
					<option value='16명'>16명</option>
					<option value='17명'>17명</option>
					<option value='18명'>18명</option>
					<option value='19명'>19명</option>
					<option value='20명'>20명</option>
				</select>
				<p id="pkgBtnBox">
					<button id="pkgSearchBtn">검색</button>
				</p>
			</div>

			<div id="pkgListWrap">
				<p id="totalCnt">
					도쿄 : 검색된 상품 <span id="totalCount">${count}</span>건
				</p>
				<div id="pkgOrderBy">
					<button id="byPrice">낮은 가격 순</button>
					<button id="listAll">전체 리스트 보기</button>
				</div>
				<div id ="pkgListBoxWrap">
					<input type="hidden" value="${product.pno}" id="pno">
					<c:forEach var="product" items="${list}">
					<div class="pkgInfoBox">
						<div class="pkgImg">
							<img src="displayFile/product?filename=${product.pic}">
						</div>
						<p class="pkgTitle">${product.pname}</p>
						<!-- 1인 기준 default 가격 계산(항공 : economy, 호텔 : normal, 투어 : 1번째, 렌터가 : 없음) -->
						<c:set var="airPrice" value="0"/>
						<c:set var="hotelPrice" value="0"/>
						<c:set var="tourPrice" value="0"/>
						<c:forEach var="f" items="${product.air}" begin="${fn:length(product.air)-2}" end="${fn:length(product.air)-1}">
							<c:set var="airPrice" value="${airPrice+f.price}"/>
						</c:forEach>
						<c:forEach var="h" items="${product.hotel}" begin="${fn:length(product.hotel)-1}" end="${fn:length(product.hotel)-1}">
							<fmt:formatDate value="${h.checkin}" pattern="yyyyMMdd" var="checkin"/>
							<fmt:formatDate value="${h.checkout}" pattern="yyyyMMdd" var="checkout"/>
							<fmt:parseDate value="${checkin}" pattern="yyyyMMdd" var="checkinDate"/>
							<fmt:parseDate value="${checkout}" pattern="yyyyMMdd" var="checkoutDate"/>
							<fmt:parseNumber value="${checkinDate.time / (1000*60*60*24)}" integerOnly="true" var="checkinTime"/>
							<fmt:parseNumber value="${checkoutDate.time / (1000*60*60*24)}" integerOnly="true" var="checkoutTime"/>
							<c:set var="dateDiff" value="${checkoutTime-checkinTime}"/>
							<c:set var="hotelPrice" value="${h.price * dateDiff}"/>
						</c:forEach>
						<c:forEach var="t" items="${product.tour}">
							<c:set var="tourPrice" value="${tourPrice+t.tprice}"/>
						</c:forEach>
						<c:set var="N" value="${airPrice + hotelPrice + tourPrice}"/>
						<fmt:formatNumber var="price" value="${N+(1-(N%1))%1}" type="number"/>
						<fmt:formatDate var="expire" value="${product.pexpire}" pattern="yyyy/MM/dd"/>
						<p class="pkgPrice">${price}원 부터~</p>
						<p class="pkgDate">~ ${expire}까지 예약 가능</p>
						<p class="pkgReserv">
							<button class="pkgReservBtn" data-price="${price}" data-pno="${product.pno}">지금 바로 예약</button>
						</p>
					</div>
					</c:forEach>
				</div>
				<c:if test="${keyword3 == null }">
				<ul class="pagination">
					<c:if test="${pageMaker.prev == true}">
						<li><a href="${pageContext.request.contextPath}/customer/tourlandProductJPList?page=${pageMaker.startPage-1}">&laquo;</a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						<li class="${cri.page==idx?'active':''}"><a href="${pageContext.request.contextPath}/customer/tourlandProductJPList?page=${idx}" class="pageNumA">${idx}</a></li>
					</c:forEach>
					<c:if test="${pageMaker.next == true}">
						<li><a href="${pageContext.request.contextPath}/customer/tourlandProductJPList?page=${pageMaker.endPage+1}">&raquo;</a></li>
					</c:if>
				</ul>
				</c:if>
				<c:if test="${keyword3 != null }">
				<ul class="pagination">
					<c:if test="${pageMaker.prev == true}">
						<li><a href="${pageContext.request.contextPath}/customer/tourlandProductJPList?searchType=&keyword=${keyword }&keyword2=${keyword2 }&keyword3=forsearchjapan&page=${pageMaker.startPage-1}">&laquo;</a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						<li class="${cri.page==idx?'active':''}"><a href="${pageContext.request.contextPath}/customer/tourlandProductJPList?searchType=&keyword=${keyword }&keyword2=${keyword2 }&keyword3=forsearchjapan&page=${idx}" class="pageNumA">${idx}</a></li>
					</c:forEach>
					<c:if test="${pageMaker.next == true}">
						<li><a href="${pageContext.request.contextPath}/customer/tourlandProductJPList?searchType=&keyword=${keyword }&keyword2=${keyword2 }&keyword3=forsearchjapan&page=${pageMaker.endPage+1}">&raquo;</a></li>
					</c:if>
				</ul>
				</c:if>
			</div>
		</div>
	</section>
	<%@ include file="../../include/userFooter.jsp"%>
</body>

</html>