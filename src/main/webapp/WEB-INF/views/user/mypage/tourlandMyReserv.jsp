<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>    
	/* 본문 */
	section div#myreserv { width:1300px; height: 100%; 
							  margin-left: 200px;
							 }
	section div#myreserv h1 { width: 200px;
								 height: 30px;  
							     padding: 20px;
							     border-bottom: 1px solid #929292; }							  
		
	#info { font-size: 13px; color: #929292; 
			margin-left: 10px;  }	
			
	table#reserv { width: 1300px;  
				   border-collapse: collapse; 
				   margin: 40px; 
				   font-size: 14px; }
	table#reserv th, tr, td { border-top: 1px solid gray;
							  border-bottom: 1px solid gray;
						     text-align: center; }
	table#reserv th { background: #F2F2F2; height: 40px; }			      			     		
	table#reserv img { width: 100px; height: 70px; padding: 5px; }
	.red { font-weight: bold;  color: maroon; }
	.payNow { width: 80px; height: 25px; border: none; background: steelblue; color: #fff; margin-bottom: 5px; }		
	.writeReview { width: 80px; height: 25px; border: none; background: #828282; color: #fff; }
	.cancel { width: 80px; height: 25px; border: none; background: maroon; color: #fff; }
	   
	.yellow  { font-weight: bold;  color: goldenrod; }
	.blue { font-weight: bold;  color: steelblue;}
	#manage { width: 100px; }
</style>
<body>   
	<%@ include file="../../include/userHeader.jsp"%>
<script>
	$(function(){
		$(".payNow").click(function(){
			
			var rnoString = $(this).parent().parent().find(".rno").html();
			var rno = rnoString.substring(4); 
			var cf = confirm(rno + " 번 상품을 결제하시겠습니까? ");
			
			if(cf){
				location.href="tourlandMyReservPayNow?rno="+rno;
			}
		})
		
		$(".cancel").click(function(){
			var rnoString = $(this).parent().parent().find(".rno").html();
			var rno = rnoString.substring(4); 
			var cf = confirm(rno + " 번 상품을 정말 취소하시겠습니까? ");
			
			if(cf){
				location.href="tourlandMyReservCancel?rno="+rno;
			}
		})
		
	})
</script>	
<c:if test="${paySuccess!=null }">
	<script>
		alert("결제가 완료 되었습니다.");
	</script>
</c:if>
<c:if test="${cancel!=null }">
	<script>
		alert("예약이 취소되었습니다.");
	</script>
</c:if>
		<section>
		<%@ include file="../../include/userMyPageMenu.jsp"%>   
				<div id="myreserv">
				<h1>내 예약 현황</h1>
					<span id="info">고객님의 현재 예약 현황을 확인 하실 수 있습니다.</span>
					
					<table id="reserv">
						<tr>
							<th>예약 번호</th>
							<th>예약일</th>
							<th colspan="2">상품</th>
							<th>출발일</th>
							<th>도착일</th>
							<th>예약 상태</th>
							<th id="manage">관리</th>
						</tr>
						<c:if test="${noList == null }">
								<c:forEach var="reserv" items="${list}">
							<tr>
								<td class="rno">RERV${reserv.no}</td>
								<td><fmt:formatDate value="${reserv.rdate}" pattern="yyyy-MM-dd"/></td>
								<td>${reserv.product.pname}</td>
								<td><img src="displayFile/product?filename=${reserv.product.pic}"></td>
								<c:forEach var="f" items="${reserv.product.air}" begin="0" end="0">
									<fmt:formatDate var="startdate" value="${f.ddate}" pattern="yyyy-MM-dd"/>
								</c:forEach>
								<c:forEach var="f" items="${reserv.product.air}" begin="1" end="1">
									<fmt:formatDate var="enddate" value="${f.rdate}" pattern="yyyy-MM-dd"/>
								</c:forEach>
								<td>${startdate}</td>
								<td>${enddate}</td>
								<c:if test="${reserv.rstatus=='1' }">
									<td class="red">결제 가능</td>	
								</c:if>
								<c:if test="${reserv.rstatus=='2' }">
									<td class="blue">결제 완료 <br>(예약 확정 대기 중)</td>	
								</c:if>
								<c:if test="${reserv.rstatus=='3' }">
									<td class="yellow">예약 확정</td>	
								</c:if>
								
								<td>
									<c:if test="${reserv.rstatus=='1' }">
										<button class="payNow">결제하기</button>
										<br>
									</c:if>
									
									<c:if test="${reserv.rstatus=='3' }">
										<button class="writeReview">리뷰쓰기</button>
									</c:if>
									<c:if test="${reserv.rstatus=='1' }">
										<button class="cancel">예약 취소</button>
									</c:if>
									<c:if test="${reserv.rstatus=='2' }">
										-
									</c:if>
								</td> 
							</tr>
							</c:forEach>
						</c:if>
						<c:if test="${noList != null }">
							<td colspan="8" class="red">표시될 예약이 없습니다.</td>
						</c:if>
					</table>
				</div>
		
		</section>
		
		<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>