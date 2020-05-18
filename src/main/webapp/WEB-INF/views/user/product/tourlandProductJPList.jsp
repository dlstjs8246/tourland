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
/* 본문 */
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

div.pkgListBox {
	width: 90%;
	height: 210px;
	padding: 20px;
	border: 1px solid #ededed;
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
	width: 320px;
	height: 180px;
	overflow: hidden;
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
	padding : 10px;
	float : left;
	border : 1px solid lightgrey;
}
.pagination .active {
	background-color : grey;    
}
   
#listAll { margin-left: 420px; background: steelblue; color: #fff;}   
</style>
<script>

/* yyyy-MM-dd 형식으로 변경하는 메서드  */
function getFormatDate(date){
	var date = new Date(date);
    var year = date.getFullYear()+"-";              //yyyy
    var month = (date.getMonth()+1)+"-";          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '' + month + '' + day;
}

/* 리스트 좌측 검색 박스에서 검색했을 때 데이터를 불러오는 Ajax */
function getSearchResult(){
	var ddate = $(".datepicker").val();//출발일 선택
	var tourDays = $("#rdate").val();//여행일 선택
	var cnt = $("#cnt").val(); //인원
	$.ajax({
		url : "tourlandProductJapanSearchList",
		type : "get",
		dataType : "json",
		data : {ddate : ddate, tourDays : tourDays, cnt : cnt},
		success : function(rs){
			 $(".pkgListBox").remove();
			 $(".pagination").empty();
			 $("#totalCount").html(rs.list.length);
			 $(rs.list).each(function(i, obj) {
				 
				 var $input1 = $("<input>").attr("type", "hidden").attr("value", obj.pno).attr("id", "pno");
				 
				 var $div1 = $("<div>").addClass("pkgImg");
				
				 var $img1 = $("<img>").attr("src", "displayFile/product?filename="+obj.pic);
				 
				 var $div2 = $("<div>").addClass("pkgInfoBox");
				 var $p1 = $("<p>").addClass("pkgTitle").html(obj.pname);
				 var price = Math.ceil(obj.pprice/obj.tour[0].capacity).toLocaleString();
				 var $p2 = $("<p>").addClass("pkgPrice").html(price+"원 부터~").css("text-align","right");
				 var $p3 = $("<p>").addClass("pkgDate").html("~ "+getFormatDate(obj.pexpire)+"까지");
				 
				 var $p4 = $("<p>").addClass("pkgReserv");
				 var $btn = $("<button>").addClass("pkgReservBtn").html("지금 바로 예약");
				 
				 $div1.append($img1);
				 $div2.append($p1);
				 $div2.append($p2);
				 $div2.append($p3);
				 
				 $p4.append($btn);
				 var $pkgListBox = $("<div class='pkgListBox'>").append($div1).append($div2).append($p4);
				 /* $(".pkgListBox").append($div1);
				 $(".pkgListBox").append($div2);
				 $(".pkgListBox").append($p4); */
				 $("#pkgOrderBy").after($pkgListBox);
				 return false;
			 })
		}
	})
}

/* 리스트 우측 전체 리스트 보기 버튼을 클릭했을 때 모든 데이터를 불러오는 Ajax  */
function getList(){
	$.ajax({
		url : "tourlandProductJapanListAll",
		type : "get",
		dataType : "json",
		success : function(rs){
			 $(".pkgListBox").remove();
			 $("#totalCount").html(rs.count);
			 $(rs.list).each(function(i, obj) {
				 
				 var $input1 = $("<input>").attr("type", "hidden").attr("value", obj.pno).attr("id", "pno");
				 
				 var $div1 = $("<div>").addClass("pkgImg");
				
				 var $img1 = $("<img>").attr("src", "displayFile/product?filename="+obj.pic);
				 
				 var $div2 = $("<div>").addClass("pkgInfoBox");
				 var $p1 = $("<p>").addClass("pkgTitle").html(obj.pname);
				 var price = Math.ceil(obj.pprice/obj.tour[0].capacity).toLocaleString();
				 var $p2 = $("<p>").addClass("pkgPrice").html(price+"원 부터~").css("text-align","right");
				 var $p3 = $("<p>").addClass("pkgDate").html("~ "+getFormatDate(obj.pexpire)+"까지");
				 
				 var $p4 = $("<p>").addClass("pkgReserv");
				 var $btn = $("<button>").addClass("pkgReservBtn").html("지금 바로 예약");
				 
				 $div1.append($img1);
				 $div2.append($p1);
				 $div2.append($p2);
				 $div2.append($p3);
				 
				 $p4.append($btn);
				 var $pkgListBox = $("<div class='pkgListBox'>").append($div1).append($div2).append($p4);
				 $("#pkgOrderBy").after($pkgListBox);
				 
			 })
			 /* 페이징 부분 */
			 $(".pagination").empty();
			 if(rs.pageMaker.prev==true){
					var $li1 = $("<li>");
					var $a1 = $("<a>").attr("href", "${pageContext.request.contextPath}/customer/tourlandProductJPList?page=${pageMaker.startPage-1}" ).html("&laquo");
					$li1.append($a1);
				}
				
				
				if(rs.pageMaker.next==true){
					var $li3 = $("<li>");
					var $a3 = $("<a>").attr("href", "${pageContext.request.contextPath}/customer/tourlandProductJPList?page=${pageMaker.startPage+1}" ).html("&laquo");

					$li3.append($a3);
				}
				
				for(var j = rs.pageMaker.startPage; j<= rs.pageMaker.endPage; j++){
					$li2 = $("<li>").addClass("${cri.page==idx?'active':''}");
					$a2 = $("<a>").attr("href", "${pageContext.request.contextPath}/customer/tourlandProductJPList?page="+j).html(j);
					if(j==rs.pageMaker.cri.page) {
						$li2.addClass("active");
					}
					$li2.append($a2);
					
					$(".pagination").append($li1);
					$(".pagination").append($li2);
					$(".pagination").append($li3);
			} 
		}
	})
}
/* 낮은 가격 순 버튼을 클릭했을 때 모든 데이터를 불러오는 Ajax  */
function getLowPriceList(page){
	$.ajax({
		url : "tourlandProductJPSearchLowPirceList/"+page,
		type : "get",
		dataType : "json",
		success : function(rs){
			 $(".pkgListBox").remove();
			 $("#totalCount").html(rs.count);
			 $(rs.list).each(function(i, obj) {
				 
				 var $input1 = $("<input>").attr("type", "hidden").attr("value", obj.pno).attr("id", "pno");
				 
				 var $div1 = $("<div>").addClass("pkgImg");
				
				 var $img1 = $("<img>").attr("src", "displayFile/product?filename="+obj.pic);
				 
				 var $div2 = $("<div>").addClass("pkgInfoBox");
				 var $p1 = $("<p>").addClass("pkgTitle").html(obj.pname);
				 var price = Math.ceil(obj.pprice/obj.tour[0].capacity).toLocaleString();
				 var $p2 = $("<p>").addClass("pkgPrice").html(price+"원 부터~").css("text-align","right");
				 var $p3 = $("<p>").addClass("pkgDate").html("~ "+getFormatDate(obj.pexpire)+"까지");
				 
				 var $p4 = $("<p>").addClass("pkgReserv");
				 var $btn = $("<button>").addClass("pkgReservBtn").html("지금 바로 예약");
				 
				 $div1.append($img1);
				 $div2.append($p1);
				 $div2.append($p2);
				 $div2.append($p3);
				 
				 $p4.append($btn);
				 var $pkgListBox = $("<div class='pkgListBox'>").append($div1).append($div2).append($p4);
				 $("#pkgOrderBy").after($pkgListBox);
				 
			 })
			 /* 페이징 부분 */
			 $(".pagination").empty();
			 if(rs.pageMaker.prev==true){
					var $li1 = $("<li>");
					var $a1 = $("<a>").attr("href", "${pageContext.request.contextPath}/customer/tourlandProductJPSearchLowPriceList?page=${pageMaker.startPage-1}" ).html("&laquo");
					$li1.append($a1);
				}
				
				
				if(rs.pageMaker.next==true){
					var $li3 = $("<li>");
					var $a3 = $("<a>").attr("href", "${pageContext.request.contextPath}/customer/tourlandProductJPSearchLowPriceList?page=${pageMaker.startPage+1}" ).html("&laquo");

					$li3.append($a3);
				}
				
				for(var j = rs.pageMaker.startPage; j<= rs.pageMaker.endPage; j++){
					$li2 = $("<li>").addClass("${cri.page==idx?'active':''}");
					$a2 = $("<a>").addClass("lowPriceListPage").html(j);
					if(j==rs.pageMaker.cri.page) {
						$li2.addClass("active");
					}
					$li2.append($a2);
					
					$(".pagination").append($li1);
					$(".pagination").append($li2);
					$(".pagination").append($li3);
			} 
		}
	})
}
	$(function(){
		/* 페이지 좌측 검색 박스 검색 버튼 클릭  */
		$("#pkgSearchBtn").click(function(){
			getSearchResult();
		})
		/* 리스트 우측 전체 리스트 보기 버튼 클릭 */
		$("#listAll").click(function(){
			getList();
		})
		/* 낮은 가격 순 정렬 */
		$("#byPrice").click(function(){
			getLowPriceList(1);
		})
		/* 페이징 */
		$(document).on("click", ".lowPriceListPage", function(){
		    $('html, body').animate({scrollTop: 0}, 200);
			var page = $(this).html();
			getLowPriceList(page);
		})
	})
</script>
<body>
	
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
					<option>3일</option>
					<option>5일</option>
					<option>7일</option>
				</select>
				<p>인원</p>
				<select id="cnt">
					<option>2명</option>
					<option>3명</option>
					<option>4명</option>
					<option>5명</option>
					<option>6명</option>
					<option>7명</option>
					<option>8명</option>
					<option>9명</option>
					<option>10명</option>
					<option>11명</option>
					<option>12명</option>
					<option>13명</option>
					<option>14명</option>
					<option>15명</option>
					<option>16명</option>
					<option>17명</option>
					<option>18명</option>
					<option>19명</option>
					<option>20명</option>
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
				<c:forEach var="product" items="${list}">
				<div class="pkgListBox">
					<input type="hidden" value="${product.pno}" id="pno">
					<div class="pkgImg">
						<img src="displayFile/product?filename=${product.pic}">
					</div>
					<div class="pkgInfoBox">
						<p class="pkgTitle">${product.pname}</p>
						<c:forEach var="t" items="${product.tour}" begin="0" end="0">
							<c:set var="capacity" value="${t.capacity}"/>
						</c:forEach>
						<c:set var="N" value="${product.pprice/capacity}"/>
						<fmt:formatNumber var="price" value="${N+(1-(N%1))%1}" type="number"/>
						<fmt:formatDate var="expire" value="${product.pexpire}" pattern="yyyy/MM/dd"/>
						<p class="pkgPrice">${price}원 부터~</p>
						<p class="pkgDate">~ ${expire}까지</p>
					</div>
					<p class="pkgReserv">
						<button class="pkgReservBtn">지금 바로 예약</button>
					</p>
				</div>
				</c:forEach>
				<ul class="pagination">
					<c:if test="${pageMaker.prev == true}">
						<li><a href="${pageContext.request.contextPath}/customer/tourlandProductJPList?page=${pageMaker.startPage-1}">&laquo;</a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						<li class="${cri.page==idx?'active':''}"><a href="${pageContext.request.contextPath}/customer/tourlandProductJPList?page=${idx}">${idx}</a></li>
					</c:forEach>
					<c:if test="${pageMaker.next == true}">
						<li><a href="${pageContext.request.contextPath}/customer/tourlandProductJPList?page=${pageMaker.endPage+1}">&raquo;</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</section>
	<%@ include file="../../include/userFooter.jsp"%>
</body>

<script>
	$(function() {
		$(".pkgReservBtn").click(function() {
			var pno = $(this).parent().parent().find("#pno").val();
			location.href = "${pageContext.request.contextPath}/customer/tourlandProductDetail?pno="+pno;
		})
	})
</script>
</html>