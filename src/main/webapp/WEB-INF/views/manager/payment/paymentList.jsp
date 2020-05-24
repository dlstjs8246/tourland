<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
table th, td {
	text-align: center;
}

.modalbtn {
	width: 80px;
	height: 30px;
	font-size: 14px;
	line-height: 0px;
	text-align: center;
	padding: 5px;
}

.red {
	color: red;
}

.blue {
	color: steelblue;
	font-weight: bold;
}

h4 {
	font-weight: bold;
}
#btnSearch{
	margin-left:20px;
}
</style>
<div class="content">
	<div class="row">
		<div class="col-sm-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">결제 관리</h3>
				</div>
				<div class="box-body">
					<select name="searchType" id="searchType">
						<option value="total" ${cri.searchType == 'total'? 'selected':'' }>전체</option>
						<option value="username" ${cri.searchType == 'username'? 'selected':'' }>고객명</option>
						<option value="pname" ${cri.searchType == 'pname'? 'selected':'' }>상품명</option>
						<option value="rdate" ${cri.searchType == 'rdate'? 'selected':'' }>결제일</option>
						<option value="ano" ${cri.searchType == 'ano'? 'selected':'' }>항공편</option>
					</select>
					<input type="text" name="keyword" id="keyword" value="${cri.keyword }">
					<button id="btnSearch">검색</button>
				</div>
				<div class="box-body">
			<p id="datePick">
				<span><i class="far fa-calendar-alt"></i> 출발일 </span> 
				<span class="picker"><input type="date" class="datepicker" name="startDate" placeholder="날짜를 선택하려면 클릭." style="height:30px;" value="${cri.keyword2 }"></span>
				<span><i class="far fa-calendar-alt"></i> ~  도착일 </span> 
				<span class="picker"><input type="date" class="datepicker" name="endDate" placeholder="날짜를 선택하려면 클릭." style="height:30px;" value="${cri.keyword3}"></span>
				<span id="pickSearch"><a href="#"><i class="fas fa-search"></i></a></span>
			</p>
					<table class="table table-bordered" id="listTable">
						<tr>
							<th>고객명</th>
							<th>상품명</th>
							<th>항공편</th>
							<th>출발날짜</th>
							<th>도착날짜</th>
							<th>결제일</th>
							<th>예약상태</th>
						</tr>	
							<c:forEach var="payment" items="${list}">
								<tr>
									<td>${payment.username}</td>
									<td>${payment.pname }</td>
									<td>${payment.ano }</td>
									<td><fmt:formatDate value="${payment.checkin}" pattern="yyyy-MM-dd"/></td>
									<td><fmt:formatDate value="${payment.checkout}" pattern="yyyy-MM-dd"/></td>
									<td>${payment.rdate }</td>
									<c:choose>
										<c:when test="${payment.rstatus ==2}">
											<td><span class="badge bg-orange">결제완료</span></td>
										</c:when>
									</c:choose>
								</tr>
							</c:forEach>
					</table>
				</div>
				<div class="text-center">
					<ul class="pagination">
						<c:if test="${pageMaker.prev ==true }">
							<li><a href="paymentList?page=${pageMaker.startPage-1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&laquo;</a></li>
						</c:if>
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage }" var="idx">
							<li class="${pageMaker.cri.page == idx? 'active':'' }"><a href="paymentList?page=${idx }&searchType=${cri.searchType}&keyword=${cri.keyword}">${idx }</a></li>
						</c:forEach>
						<c:if test="${pageMaker.next == true }">
							<li><a href="paymentList?page=${pageMaker.endPage+1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&raquo;</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
$("#btnSearch").click(function() {
	var searchType= $("#searchType option:selected").val();
	var keyword = $("#keyword").val();
	location.href = "paymentList?searchType="+searchType+"&keyword="+ keyword;
})
</script>

<%@ include file="../../include/footer.jsp"%>