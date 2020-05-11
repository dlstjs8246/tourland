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
			
	table#reserv { width: 950px;  
				   border-collapse: collapse; 
				   margin: 40px; 
				   font-size: 14px; }
	table#reserv th, tr, td { border: 1px solid gray;
						     text-align: center; }
	table#reserv th { background: #b5ae87; height: 40px; }						     		
	table#reserv img { width: 100px; height: 70px; padding: 5px; }
	.red { font-weight: bold;  color: maroon; }
	.blue button { width: 80px; height: 25px; border: none; background: steelblue; color: #fff;   }		
</style>
<body>   
	<%@ include file="../../include/userHeader.jsp"%>
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
						</tr>
						<tr>
							<td>RE15487200</td>
							<td>2020/04/27</td>
							<td><img src="images/osaka.jpg"></td>
							<td>진짜 오사카를 만나다, 오사카 3박 4일</td>
							<td>2020/05/03</td>
							<td>2020/05/20</td>
							<td class="red">예약 미확정</td>
							<td class="blue"><button>결제하기</button></td>    
						</tr>
						<tr>
							<td>RE15487200</td>
							<td>2020/04/27</td>
							<td><img src="images/osaka.jpg"></td>
							<td>진짜 오사카를 만나다, 오사카 3박 4일</td>
							<td>2020/05/03</td>
							<td>2020/05/20</td>
							<td class="red">예약 미확정</td>
							<td class="blue"><button>결제하기</button></td>  
						</tr>
					</table>
				</div>
		
		</section>
		
		<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>