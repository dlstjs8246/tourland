<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/paging.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/resources/css/boardStyle.css" rel="stylesheet" type="text/css" />
</head>
<style>
   div#pkgListWrap {
	width: 100%;
	height: auto;
	padding: 0 20px 20px 50px;
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
	width: 100px;
	height: 80px;
	margin-right: 10px;
	float: left;
}

div.pkgImg img {
	width: 100%;
	height : 100px;
}

div.pkgInfoBox {
	width: 90%;
	height: 110px; 
	padding: 10px;
	border: 1px solid #ededed; 
}

div.pkgInfoBox p {
	height: 30px;
}

div.pkgInfoBox .pkgTitle {
	height: 28px;
	font-size: 17px;
	font-weight: bold;
}

.pkgPrice {
	text-indent: 5px;
	font-size: 16px;
	color: maroon;
	margin-left: 100px;
}

.pkgDate {
	margin-left: 100px;
	font-size: 13px;
	font-weight: bold;
}

.pkgReserv {
	margin-left: 100px;
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


  .searchContent{
    width: 100%;
    height: auto;
    display:none; 
    margin-bottom:10px;
  }

  section nav ul li:nth-child(2) {
	background: mistyrose;
}

  #searchResultCounting{
     width:100%;
     padding:10px;
     margin-top:15px;
     margin-bottom:25px;
     border-top:1px solid mistyrose;
     border-bottom:1px solid mistyrose;
     text-align: center;
  }
  #serachResultAgain{
     margin-top:5px;
     text-align: center;
  }
  #searchUlDiv{
    margin-top:20px;
    width:100%;
    height: 50px;
  }
  #searchUlDiv ul{
    margin-left:10px;
    margin-bottom:5px;
    width:100%;
    float: left;
  }
  #searchUlDiv ul li{
     text-align:center;
     width: 25%;
     height:50px;
     line-height:50px;
     background: mistyrose;
     float: left;
     display: block;
  }
/*   #searchUlDiv ul li:hover{
    background: tan;
    font-weight: bold;
  } */
   #searchInnerDiv{
     width:100%;
     height:1000px;
   }
  #searchInnerDiv div{
    margin-top:10px;
  }
  #searchInnerDiv div h3{
    margin-left:10px;
    width:150px;
    border-bottom: 2px solid gray;
  }
  
  #searchWhere{
    margin-top:5px;
    width: 400px;
    float: left;
  }
  
  #searchWhere li{
    float: left;
    width:100px;
    text-align: center;
    height: 30px;
  }
  
  #searchProductTable tr td:first-child img{
	width:100px;
	height: 100px;
}

  .FAQContent{
    width: 100%;
    height: auto;
    display:none; 
    margin-bottom:10px;
  }


 .searchEventImgs{
   width:50px;
   height: 50px;
 }
 
 .whereLi{
    cursor:pointer; 
 }
 .eventBox:hover{
  cursor: pointer;
  background-color: lightyellow; 
  height:60px;
 }
 
</style>
<body>   
	<%@ include file="../include/userHeader.jsp"%>
		<section style=" width:1200px; height: 1800px; margin-bottom:20px;">
				<div id="myreserv" style="width:1200px;margin-left:25%;">
				<h1>투어랜드 검색 결과</h1>
				<div id="searchResultCounting">고객님의 키워드로 ${totalSearchCount }건이 검색되었습니다.</div>
				<div id="serachResultAgain">결과내 재검색 
				<c:if test="${searchkeyword2 !=null }">
				 <input type="text" style="width:250px; height: 30px; margin-left:15px;" id="secondSearchKeyword" value="${searchkeyword2 }">
				</c:if> 
				<c:if test="${searchkeyword2 ==null }">
				 <input type="text" style="width:250px; height: 30px; margin-left:15px;" id="secondSearchKeyword">
				</c:if> 
				 <i class="fas fa-search" id="secondSearchIcon" style="margin-left:5px;"></i></div>
				<div id="searchUlDiv">
				   <ul>
				     <li>전체검색결과(${totalSearchCount }건)</li>
				     <li>여행상품(${totalProductCount }건)</li>
				     <li>FAQ(${faqlistCount }건)</li>
				     <li>이벤트(${eventlistCount }건)</li>
				   </ul>
				</div>

			<div id="searchInnerDiv">
				 <div style="height: 550px;" >
				    <h3>여행상품</h3> 
					    <ul id="searchWhere" style="margin-left:10px;">
						    <li class="whereLi">중국(${chinalistCount }건)</li>
						    <li class="whereLi">일본(${japancount }건)</li>
						    <li class="whereLi">제주(${jejucount }건)</li>
					    </ul>
					    
					    <br><br>
		      <div id="pkgListWrap">

				<div id="pkgListBoxWrap">
					<input type="hidden" value="${product.pno}" id="pno">
				  <c:forEach var="product" items="${list}">
					<div class="pkgInfoBox">
						<div class="pkgImg">
							<img src="${pageContext.request.contextPath }/customer/displayFile/product?filename=${product.pic}">
						</div>
						<p class="pkgTitle">${product.pname}</p>
						<!-- 1인 기준 default 가격 계산(항공 : economy, 호텔 : normal, 투어,렌터카 : 없음) -->
						<c:set var="airPrice" value="0"/>
						<c:set var="hotelPrice" value="0"/>
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
						<c:set var="N" value="${airPrice + hotelPrice}"/>
						<fmt:formatNumber var="price" value="${N+(1-(N%1))%1}" type="number"/>
						<fmt:formatDate var="expire" value="${product.pexpire}" pattern="yyyy/MM/dd"/>
						<p class="pkgPrice">${price}원 부터~</p>
						<p class="pkgDate">~ ${expire}까지</p>
						<p class="pkgReserv">
							<button class="pkgReservBtn" data-price="${price}" data-pno="${product.pno}">지금 바로 예약</button>
						</p>
						
					</div>
					</c:forEach> 
					
				  <c:if test="${listCount ==3 }"> <!-- 3개만 일단 불러오도록 했기 때문에  -->
				  <a href="#" style="text-decoration: none;" class="toProductList">더 보기</a>
				  </c:if>
				  <c:if test="${listCount ==0 }">
				     <p style="margin-left:20px; margin-top:200px;">여행 상품에 해당 검색어가 포함된 게시물이 없습니다.</p>
				  </c:if>
				</div>
			<!--  <ul class="pagination"> 컨트롤러에서 이름 바꿨음
					<c:if test="${pageMaker.prev == true}">
						<li><a href="${pageContext.request.contextPath}/customer/tourlandProductChinaList?page=${pageMaker.startPage-1}">&laquo;</a></li>
					</c:if>
					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						<li class="${cri.page==idx?'active':''}"><a href="${pageContext.request.contextPath}/customer/tourlandProductChinaList?page=${idx}" class="pageNumA">${idx}</a></li>
					</c:forEach>
					<c:if test="${pageMaker.next == true}">
						<li><a href="${pageContext.request.contextPath}/customer/tourlandProductChinaList?page=${pageMaker.endPage+1}">&raquo;</a></li>
					</c:if>
				</ul> -->	
			</div> 
				      
 
				 </div>  
				 <div style="margin-top:10px; width:100%; height: 300px;">
				   <h3>FAQ</h3> 
				   <table id="reserv" style="margin:40px 10px 10px 40px; width:100%;">
						<c:forEach var="faq" items="${faqlist}">
						<tr class="faqList" data-no="${faq.no}">
							<td class="nono">${faq.no}</td>
							<td class="thTitle" style="margin-top:15px;"><i class="fab fa-quora"></i>  ${faq.title}
									<div class="FAQContent">
									<br><br>
										<i class="fas fa-bullhorn"></i>   ${faq.content }
									</div>
							</td>
							<td>${faq.lcate eq 'D'?'국내패키지상품':faq.lcate eq 'I'?'해외패키지상품':faq.lcate eq 'R'?'상품 예약 및 결제':'회원혜택안내'}</td>
							<td>${faq.mcate eq 'P'?'여행상품':faq.mcate eq 'V'?'여권 및 비자':faq.mcate eq 'T'?'환율':faq.mcate eq 'J'?'제주여행':faq.mcate eq 'B'?'예약 및 취소':faq.mcate eq 'R'?'결제 및 환불':faq.mcate eq 'C'?'쿠폰 및 이벤트':'기타'}</td>
						    <td><i class="fas fa-angle-down"></i></td> 
						    
						</tr>
						
						</c:forEach>  
						 
					</table>
				  <c:if test="${faqlistCount > 3 }">
				     <a href="#" style="margin-left:50px;">더 보기</a>
				  </c:if>
				  <c:if test="${faqlistCount ==0 }">
				     <p style="margin-left:70px;">FAQ에 해당 검색어가 포함된 게시물이 없습니다.</p>
				  </c:if>
				 </div>
				 <div style="margin-top:10px; width:100%; height: 400px;">
				   <h3> 이벤트 </h3> 
				   
				 <table style="width:100%; margin-top:40px; border-collapse: collapse;">
				  <c:forEach var="eventList" items="${eventList }">
				     <tr data-click="${eventList.no }" class="eventBox">
				       <td>${eventList.no }</td>
				       <td><img src="${pageContext.request.contextPath}/customer/displayFile/event?filename=${eventList.pic}" class="searchEventImgs"></td>
				       <td>${eventList.title }</td>
				     </tr>
				   </c:forEach>  
				  </table>
				  <c:if test="${eventlistCount ==0 }">
				     <p style="margin-left:70px;">이벤트에 해당 검색어가 포함된 게시물이 없습니다.</p>
				  </c:if>
				 </div>
			 </div>

			     
<%-- 					<table id="reserv">
						<tr>
							<th class="nono">번호</th>
							<th class="thTitle">제목</th>
							<th>대분류</th>
							<th>분류</th>
							<th class="lastTh">펼쳐보기</th>
						</tr>
						<c:forEach var="faq" items="${list}">
						<tr class="faqList" data-no="${faq.no}">
							<td class="nono">${faq.no}</td>
							<td class="thTitle" style="margin-top:15px;"><i class="fab fa-quora"></i>  ${faq.title}
									<div class="searchContent">
									<br><br>
										<i class="fas fa-bullhorn"></i>   ${faq.content }
									</div>
							</td>
							<td>${faq.lcate eq 'D'?'국내패키지상품':faq.lcate eq 'I'?'해외패키지상품':faq.lcate eq 'R'?'상품 예약 및 결제':'회원혜택안내'}</td>
							<td>${faq.mcate eq 'P'?'여행상품':faq.mcate eq 'V'?'여권 및 비자':faq.mcate eq 'T'?'환율':faq.mcate eq 'J'?'제주여행':faq.mcate eq 'B'?'예약 및 취소':faq.mcate eq 'R'?'결제 및 환불':faq.mcate eq 'C'?'쿠폰 및 이벤트':'기타'}</td>
						    <td><i class="fas fa-angle-down"></i></td> 
						    
						</tr>
						
						</c:forEach>   
					</table>
					 <div class='text-center'>
		                <ul class="pagination">
			                <c:if test="${pageMaker.prev == true}">
						        <li><a href="${pageContext.request.contextPath}/customer/tourlandBoardFAQ?page=${pageMaker.startPage-1}&searchType=${cri.searchType}&searchType2=${cri.searchType2}&keyword=${cri.keyword}">&laquo;</a></li>
							</c:if>
							<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
								<li class="${cri.page==idx?'active':''}"><a href="${pageContext.request.contextPath}/customer/tourlandBoardFAQ?page=${idx}&searchType=${cri.searchType}&searchType2=${cri.searchType2}&keyword=${cri.keyword}">${idx}</a></li>
							</c:forEach>
							<c:if test="${pageMaker.next == true}">
								<li><a href="${pageContext.request.contextPath}/customer/tourlandBoardFAQ?page=${pageMaker.endPage+1}&searchType=${cri.searchType}&searchType2=${cri.searchType2}&keyword=${cri.keyword}">&raquo;</a></li>
							</c:if>
	                   </ul>
	               </div> --%>
				</div>
		    
		</section>
<script>
     //지역 구분을 위한 변수 선언
     var wherewhere = "";
     var searchType = "";
     var keyword = $("#mainSearchKeyword").val();
     var keyword2= $("#secondSearchKeyword").val();
     var pathwhere = location.href;
 
     if(pathwhere.indexOf("/tourland/customer/tourlandSearch/default") != -1){
    	 $(".whereLi").eq(0).css("background-color","mistyrose");
    	 wherewhere ="china";
     }else if(pathwhere.indexOf("/tourland/customer/tourlandSearch/china") != -1){
    	 $(".whereLi").eq(0).css("background-color","mistyrose");
    	 wherewhere ="china";
     } 
     else if(pathwhere.indexOf("/tourland/customer/tourlandSearch/japan") != -1){
    	 $(".whereLi").eq(1).css("background-color","mistyrose");
    	 wherewhere ="japan";
     }
     else if(pathwhere.indexOf("/tourland/customer/tourlandSearch/jeju") != -1){
    	 $(".whereLi").eq(2).css("background-color","mistyrose");
    	 wherewhere ="jeju";
     }

      //공지사항
		$(document).on("click",".faqList",function(){
			$(".FAQContent").css("display","none");
			var no = $(this).attr("data-no");
			var nonOrWhat = $(this).children().children(".FAQContent").css("display");
			//alert(nonOrWhat);
			if(nonOrWhat == "none"){
			   $(this).children().children(".FAQContent").css("display","block");
			}/* else{
				$(this).children().children(".FAQContent").css("display","none");
			} */
			
		})
		
		$(document).on("click",".FAQContent",function(){
		$(this).css("display","none");
		return false;
	})
		
	//이벤트
	//각각의 이벤트를 클릭할 때 상세페이지로 이동
	  $(".eventBox").click(function(){
		  var no = $(this).attr("data-click");
		  location.href="${pageContext.request.contextPath}/customer/eventDetailPage?no="+no;
	  })
	  
	//두번째 검색
	 
    	$("#secondSearchIcon").click(function(){
    		var keyword = $("#mainSearchKeyword").val();
    	     var keyword2= $("#secondSearchKeyword").val();
            if(keyword2 == ""){
            	alert("검색어를 입력해주세요");
            	return false;
            }
    		location.href="${pageContext.request.contextPath }/customer/tourlandSearch/default?searchType=&keyword="+keyword+"&keyword2="+keyword2;
    	})
    	
    	//중국, 일본, 제주 클릭 시  정보 변경
    	$(".whereLi").click(function(){
    		//pkgListBoxWrap
    		$(".whereLi").css("background-color","white");
    		$(this).css("background","mistyrose");
  
    		
    		var whereString = $(this).text();
    		var extractedString = whereString.substring(0,2);
    		//alert(extractedString);
    		
    		if(whereString.indexOf("일본") != -1){
    			location.href="${pageContext.request.contextPath }/customer/tourlandSearch/japan?searchType=&keyword="+keyword+"&keyword2="+keyword2;
 
    		}else if(whereString.indexOf("제주") != -1){
    			location.href="${pageContext.request.contextPath }/customer/tourlandSearch/jeju?searchType=&keyword="+keyword+"&keyword2="+keyword2;
 
    		}else if(whereString.indexOf("중국") != -1){
    			location.href="${pageContext.request.contextPath }/customer/tourlandSearch/china?searchType=&keyword="+keyword+"&keyword2="+keyword2;
 
    		}
    		
    	})
    	//각각의 더 보기를 클릭했을 때 상품 페이지로 넘어가는 부분 
      $(document).on("click",".toProductList",function(){
    	 // alert(wherewhere);
    	 var keyword = $("#mainSearchKeyword").val();
 	     var keyword2= $("#secondSearchKeyword").val();
    	  if(wherewhere == "china"){
    	     location.href="${pageContext.request.contextPath }/customer/tourlandProductChinaList?searchType=&keyword="+keyword+"&keyword2="+keyword2+"&keyword3=forsearchchina";
    	  }else if(wherewhere == "japan"){
    	     location.href="${pageContext.request.contextPath }/customer/tourlandProductJPList?searchType=&keyword="+keyword+"&keyword2="+keyword2+"&keyword3=forsearchjapan";
    	  }else if(wherewhere == "jeju"){
    	     location.href="${pageContext.request.contextPath }/customer/tourlandProductKRList?searchType=&keyword="+keyword+"&keyword2="+keyword2+"&keyword3=forsearchjeju";
    	  }
      })
    	

	  
</script>
		
		<%@ include file="../include/userFooter.jsp"%>
</body>
</html>