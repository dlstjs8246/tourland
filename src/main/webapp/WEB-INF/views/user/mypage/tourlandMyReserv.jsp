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
	.blue button { width: 80px; height: 25px; border: none; background: steelblue; color: #fff;   }		
	.grey button { width: 80px; height: 25px; border: none; background: #828282; color: #fff; }
</style>
<body>   
	<%@ include file="../../include/userHeader.jsp"%>
<script>
	$(function(){
		$(".goReview").click(function(){
			location.href= "tourlandMyReview";
		})
	})
</script>	
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
							<th>결제 관리</th>
							<th>리뷰 관리</th>
						</tr>
						<c:forEach var="reserv" items="${list}">
						<tr>
							<td>RERV${reserv.no}</td>
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
							<td class="${reserv.rstatus=='1'?'red':''}">${reserv.rstatus=='1'?'결제가능':'결제됨'}</td>
							<td class="blue"><button>결제하기</button></td> 
							<td class="grey"><button>리뷰쓰기</button></td>
						</tr>
						</c:forEach>
					</table>
				</div>
		
		</section>
		
		<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>