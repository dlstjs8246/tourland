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
	section div#myreserv { width:1000px; height: 100%; 
							  margin-left: 200px;
							 }
	section div#myreserv h1 { width: 200px;
								 height: 30px;  
							     padding: 20px;
							     border-bottom: 1px solid #929292; }							  
		
	#info { font-size: 13px; color: #929292; 
			margin-left: 10px;  }	
			
	table#reserv { width: 1090px;  
				   border-collapse: collapse; 
				   margin: 40px; 
				   font-size: 13px; }
	table#reserv th, tr, td { border-top: 1px solid gray;
							  border-bottom: 1px solid gray;
						     text-align: center;
						     padding: 3px; }
	table#reserv th { background: #F2F2F2; height: 40px; }						     		
	table#reserv img { width: 100px; height: 70px; padding: 5px; }
	.red { font-weight: bold;  color: maroon; }
	.blue button { width: 80px; height: 25px; border: none; margin-top: 10px; color: #fff; }
	#btns{ width: 100px;}
	.reservBtns { background: goldenrod;  }
	.delBtns { background: steelblue;  }		    
</style>
<body>   
	<%@ include file="../../include/userHeader.jsp"%>
		<section>
		<%@ include file="../../include/userMyPageMenu.jsp"%>   
				<div id="myreserv">
				<h1>장바구니</h1>
					<span id="info">장바구니에서 상품을 바로 예약하고 떠나보세요!</span>
					
					<table id="reserv">
						<tr>
							<th>번호</th>
							<th>유효기간</th>
							<th colspan="2">상품</th>
							<th>출발일</th>
							<th>도착일</th>
							<th>예약 상태</th>
							<th id="btns">관리</th>
						</tr>
						<c:forEach var="cart" items="${list}">
						<tr>
							<td class="pno">P${cart.product.pno}</td>
							<td><fmt:formatDate value="${cart.product.pexpire}" pattern="yyyy-MM-dd"/></td>
							<td><img src="displayFile/product?filename=${cart.product.pic}"></td>
							<td>${cart.product.pname}</td>
							<c:forEach var="f" items="${cart.product.air}" begin="1" end="1">
								<fmt:formatDate var="startdate" value="${f.ddate}" pattern="yyyy-MM-dd"/>
							</c:forEach>
							<c:forEach var="f" items="${cart.product.air}" begin="0" end="0">
								<fmt:formatDate var="enddate" value="${f.rdate}" pattern="yyyy-MM-dd"/>
							</c:forEach>
							<td>${startdate}</td>
							<td>${enddate}</td>
							<td class="${cart.rstatus=='0'?'red':''}">${cart.rstatus=='0'?'예약가능':'예약완료'}</td>
							<td class="blue"><button class="reservBtns">예약하기</button><button class="delBtns">삭제하기</button></td>    
						</tr>
						</c:forEach>
						<c:if test="${success!=null }">
							<script>
								alert("삭제가 완료 되었습니다.");
							</script>
						</c:if>
					</table>
				</div>
		</section>
		<script>
			$(".delBtns").click(function(){
				var pnoStr = $(this).parent().parent().find(".pno").html();
				var pno = pnoStr.substring(1);
				var del = confirm("삭제하시겠습니까?");
				if(del){
					location.href = "${pageContext.request.contextPath}/customer/tourlandMyWishesDelete?pno="+pno;
				}
			})
			
			$(".reservBtns").click(function(){
				var res = confirm("예약하시겠습니까?");
				if(res){
				}
				
			})
		</script>
		<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>