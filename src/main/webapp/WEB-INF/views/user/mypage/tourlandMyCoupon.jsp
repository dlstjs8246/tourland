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
			
	table.reserv { width: 950px;  
				   border-collapse: collapse; 
				   margin: 0 40px 40px 40px; 
				   font-size: 14px; }
	table.reserv th, tr, td { border-top: 1px solid gray;
							  border-bottom: 1px solid gray;
						     text-align: center;     
						     height: 30px; }
	table.reserv th { background: #F2F2F2; height: 30px; }
	
	 h3 { height: 30px; text-indent: 5px; margin-top: 50px;  color: #525252; }    
	 .circle { display: block; width: 10px; height: 10px;
	 		  float: left; 
	 		  border-radius: 100px; margin-top: 10px;
	 		  margin-left:30px;  }
	 #green { background: forestgreen;  }
	 #red { background: maroon; }
	 #expired td { background: gainsboro; }
	.warning { margin: 40px 0 10px 40px; font-size: 14px; color: maroon; font-weight: bold; }	
				     	        
</style>
<body>   
	<%@ include file="../../include/userHeader.jsp"%>
		<section>
		<%@ include file="../../include/userMyPageMenu.jsp"%>   
				<div id="myreserv">
				<h1>쿠폰</h1>
					<span id="info">쿠폰을 활용해서 멀리 떠나보세요! </span>
					<h3><span id="green" class="circle"></span>사용 가능한 쿠폰</h3>
					<p class="warning">* 쿠폰은 만료일자가 가까운 순서로 정렬 됩니다.</p>
					
					<table class="reserv">
					
						<tr>
							<th>쿠폰 번호</th>
							<th>쿠폰 명</th>
							<th>쿠폰 내용</th>
							<th>만료 일자</th>
							<th>할인율</th>
						</tr>
						
						<c:forEach items="${available }" var="c">
							<tr>
								<td>${c.cno }</td>
								<td>${c.cname }</td>
								<td>${c.ccontent }</td>
								<td>
								<!-- 가입 축하 할인 쿠폰 (소멸되지 않는) 일 경우 -->
									<c:choose>
										<c:when test="${c.cno==1 }">
											~
										</c:when>
										<c:otherwise>
											<fmt:formatDate value="${c.edate }" pattern="yyyy-MM-dd"/>
										</c:otherwise>
									</c:choose>
								</td>	  
								<td>${c.mrate }%</td>  
							</tr>
						</c:forEach>
						<%-- <c:if test="${noListChk == 0 }">
							<c:forEach items="${list }" var="c">
							<tr>
								<td>${c.cno }</td>
								<td>${c.cname }</td>
								<td>${c.ccontent }</td>
								<td>
								<!-- 가입 축하 할인 쿠폰 (소멸되지 않는) 일 경우 -->
									<c:choose>
										<c:when test="${c.cno==1 }">
											~
										</c:when>
										<c:otherwise>
											<fmt:formatDate value="${c.edate }" pattern="yyyy-MM-dd"/>
										</c:otherwise>
									</c:choose>
								</td>	  
								<td>${c.mrate }%</td>  
							</tr>
							</c:forEach>
						</c:if> --%>
						<c:if test="${noListChk == 1 }">
							<script>
								alert("발급된 쿠폰이 없습니다.");
							</script>
						</c:if>
						<c:if test="${noListChk == 2 }">
							<script>
								alert("관리자 모드에서는 쿠폰이 표시되지 않습니다.");
							</script>  
						</c:if>
					</table>   
					
					<%-- <div id="expiredCoupon"> 
						<h3><span id="red" class="circle"></span>만료된 쿠폰</h3>
						<p class="warning">* 이미 만료된 쿠폰 입니다.</p>
						<table class="reserv" id="expired">
							<tr>
								<th>쿠폰 번호</th>
								<th>쿠폰 명</th>
								<th>쿠폰 내용</th>
								<th>만료 일자</th>
								<th>할인율</th>
							</tr>
							<c:forEach items="${expired }" var="ce">
							<tr>
								<td>${ce.cno }</td>
								<td>${ce.cname }</td>
								<td>${ce.ccontent }</td>
								<td><fmt:formatDate value="${ce.edate }" pattern="yyyy-MM-dd"/></td>	  
								<td>${ce.mrate }%</td>  
							</tr>
						</c:forEach>
						</table>
					</div> --%>
				</div>      
		
		</section>
		
		<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>