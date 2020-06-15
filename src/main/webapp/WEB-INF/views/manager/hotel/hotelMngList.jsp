<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
#btnRegister{
	margin-left: 40px;
}
#n, #s, #d{
	font-weight: bold;
}
#listTable th, td{
	text-align: center;
}
#listTable td{
	line-height: 28px;
}

</style>
<div class="content">
	<div class="row">
		<div class="col-sm-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">호텔 관리</h3>
				</div>
				<div class="box-body">
					<select name="searchType" id="searchType">
						<option value="total" ${cri.searchType == 'total'? 'selected':'' }>전체</option>
						<option value="hname" ${cri.searchType == 'hname'? 'selected':'' }>호텔이름</option>
						<option value="haddr" ${cri.searchType == 'haddr'? 'selected':'' }>호텔주소</option>
						<option value="bookedup" ${cri.searchType == 'bookedup'? 'selected':'' }>객실체크여부</option>
					</select>
					<input type="text" name="keyword" id="keyword" value="${cri.keyword }">
					<button id="btnSearch">검색</button>
					<button id="btnRegister">호텔상품 추가</button>
				</div>
				<div class="box-body">
			<p id="datePick">
				<span><i class="far fa-calendar-alt"></i> 체크인 </span> 
				<span class="picker"><input type="date" class="datepicker" name="checkin" placeholder="날짜를 선택하려면 클릭." style="height:30px;" value="${cri.keyword2 }"></span>
				<span><i class="far fa-calendar-alt"></i> ~  체크아웃 </span> 
				<span class="picker"><input type="date" class="datepicker" name="checkout" placeholder="날짜를 선택하려면 클릭." style="height:30px;" value="${cri.keyword3}"></span>
				<span id="pickSearch"><a href="#"><i class="fas fa-search"></i></a></span>
			</p>
					<table class="table table-bordered" id="listTable">
						<tr>
							<th>번호</th>
							<th>호텔이름</th>
							<th>호텔주소</th>
							<th>체크인날짜</th>
							<th>체크아웃날짜</th>
							<th>허용인원수</th>
							<th>가격(1박)</th>
							<th>객실 수</th>
							<th>객실타입</th>
							<th>장소구분</th>
							<th>예약 가능 여부</th>
							<th>전체인원</th>
							<th>관리</th>
						</tr>	
							<c:forEach var="hotel" items="${list}">
								<tr>
									<td class="firstNo">${hotel.no }</td>
									<td>${hotel.hname }</td>
									<td>${hotel.haddr }</td>
									<td><fmt:formatDate value="${hotel.checkin}" pattern="yyyy-MM-dd"/></td>
									<td><fmt:formatDate value="${hotel.checkout}" pattern="yyyy-MM-dd"/></td>
									<td>${hotel.capacity }<span>인</span></td>
									<td>${hotel.price }</td>
									<td>${hotel.roomcapacity }<span>실</span></td>

									<c:choose>
										<c:when test="${hotel.roomtype=='N'}">
											<td style="color:#5D5D5D;" id="n">노말</td>
										</c:when>
										<c:when test="${hotel.roomtype=='D'}">
											<td style="color:#F29661;" id="d">디럭스</td>
										</c:when>
										<c:otherwise>
											<td style="color:#D941C5;" id="s">스위트</td>
										</c:otherwise>
									</c:choose>
									
									<c:if test="${hotel.ldiv==0}">
										<td>해외</td>
									</c:if>
									<c:if test="${hotel.ldiv == 1}">
										<td>국내</td>
									</c:if>
									
									<c:choose>
										<c:when test="${hotel.bookedup == 0}">
											<td><span class="badge bg-orange">예약가능</span></td>
										</c:when>
										<c:when test="${hotel.bookedup == 1}">
											<td><span class="badge bg-blue">예약불가능</span></td>
										</c:when>
									</c:choose>
									<td>${hotel.totalcapacity}</td>
									<td>
										<button type="button" class="btn btn-primary active btn-sm btnModify" data-no="${hotel.no }">수정</button>
										<button type="button" class="btn btn-primary btn-danger btn-sm btnDelete" data-no="${hotel.no }">삭제</button>
									</td>
								</tr>
							</c:forEach>
					</table>
				</div>
				<div class="text-center">
					<ul class="pagination">
						<c:if test="${pageMaker.prev ==true }">
							<li><a href="hotelMngList?page=${pageMaker.startPage-1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&laquo;</a></li>
						</c:if>
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage }" var="idx">
							<li class="${pageMaker.cri.page == idx? 'active':'' }"><a href="hotelMngList?page=${idx }&searchType=${cri.searchType}&keyword=${cri.keyword}">${idx }</a></li>
						</c:forEach>
						<c:if test="${pageMaker.next == true }">
							<li><a href="hotelMngList?page=${pageMaker.endPage+1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&raquo;</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
$("i.fas.fa-search").click(function(){
	var checkin = $("input[name='checkin']").val();
	var checkout = $("input[name='checkout']").val();
	location.href = "${pageContext.request.contextPath}/manager/hotelMngList?searchType=checkDate"+"&keyword2="+checkin+"&keyword3="+checkout;
	
 })
 
var keywordChange = function() {
	
	var searchType = "${cri.searchType}";
	var keyword = "${cri.keyword}";
	
	$("#searchType option").each(function(i, obj) {
			var value = $(this).val();
				if(value==searchType) {
					$(this).prop("selected",true);
					
				return;
		}
	})
	$("#keyword").val(keyword);
};

		$("#btnSearch").click(function() {
			var searchType= $("#searchType option:selected").val();
			var keyword = $("#keyword").val();
			location.href = "hotelMngList?searchType="+searchType+"&keyword="+ keyword;
		})
		
		$("#btnRegister").click(function(){
			location.href = "hotelRegister";
		})	      
		
		$(".btnModify").click(function(){
			var no = $(this).attr("data-no");
			var page =	"${cri.page}";
			var searchType = "${cri.searchType}";
			var keyword = "${cri.keyword}";
			
			location.href = "hotelModify?no="+no+"&page="+page+"&searchType="+searchType+"&keyword="+keyword;
		})	
		
		$(".btnDelete").click(function(){
			var no = $(this).attr("data-no");
			var page =	"${cri.page}";
			var searchType = "${cri.searchType}";
			var keyword = "${cri.keyword}";
			var res = confirm("삭제하시겠습니까?");
			if(res){
				alert("삭제되었습니다.");
				location.href = "hotelDelete?no="+no+"&page="+page+"&searchType="+searchType+"&keyword="+keyword;
			}
		})		
</script>
<%@ include file="../../include/footer.jsp"%>