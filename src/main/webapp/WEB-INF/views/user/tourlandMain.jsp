<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Nanum+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/6f2f0f2d95.js"></script>

<style>
	/* 본문 */
	div#mainBox { width: 1200px;
				  margin: 0 auto; }    
	
	
	/* 메인1 (사진 3개 있는 부분) */
	section#section1 { width: 1200px;}
	section#section1 div#imgBox { width: 1200px;
								  height: 400px;
							      margin-top: 30px;  }
	section#section1 div#imgBox .box1 { width: 810px; height:400px; float: left;}
	section#section1 div#imgBox .box1 img { width: 100%; height: 100%;} 
	section#section1 div#imgBox .box2 { width:380px; height: 195px; float: right;}
	section#section1 div#imgBox .marg { margin-bottom: 10px;}
	section#section1 div#imgBox .box2 img { width: 100%; height: 100%; }
	
	/* 메인2 (검색 박스 있는 부분) */
	section#section2 { background: #bcbcbc; 
					   height: 180px;
					   margin-top: 30px; }
	section#section2 h2 { height: 40px;
						  border-bottom: 1px solid #696969; 
						  margin-bottom: 10px; }					   
	section#section2 .divBox { width:200px;	
							   float: left; 
							   padding: 15px 0;
							   margin-left: 15px;}
	.divBox select { width: 200px; height: 34px; margin-top: 20px;}	
	#datePick { margin-top: 30px;}		
	.datepicker { width: 180px;  }			       
	section#section2 #inOutDiv { margin-left: 40px; }						   
	section#section2 #dateDiv { width: 220px; }
	section#section2 #searchDivBtn { text-align: center;
								     line-height: 130px;
								     margin-left: 70px;
								     margin-top:20px;  }
	section#section2 #searchDivBtn button { width: 150px;
											height: 30px; 
											background: #ff7f00;
											border: none; 
											 }								     
								     
	/* 메인3 (특가 상품들 있는 부분) */
	section#section3 { height: 600px;  margin-top: 30px; }
	section#section3 a { text-decoration: none;  }					   
	section#section3 #first { width: 580px; height: 270px;  } 
	section#section3 #first img { width: 100%; height: 100%; }
	section#section3 .popular { width: 280px; 
							    height: 270px; 
							    float: left; 
							    padding:10px; 
							    position: relative; }
	section#section3 .popular img { width: 100%; height: 100%; }
	section#section3 .popular h3 { position: absolute; 
								   top: 20px; left: 30px;
								   color: #ff7f00; 
								   text-shadow: 1px 1px 1px #000;}
	section#section3 .popular p { position: absolute; 
								  top: 50px; left: 30px;
								  color: #fff;}
	section#section3 #popInfo { width: 580px; height: 60px; 
						        background: rgba(0,0,0,0.7); 
						        position: absolute; top: 220px;
						        text-align: center;
							    font-size: 20px;
							    color: #fff;
								line-height: 60px; 							     					     
						       }
	section#section3 .popInfo2 { width: 280px; height: 60px; background: rgba(0,0,0,0.7); 
						        position: absolute; top: 220px;
						        text-align: center;
							    font-size: 15px;
							    color: #fff;
								line-height: 60px; }	
	
	/* 메인4 (배너 있는 부분) */							
	section#section4 { margin-top:30px;  height:200px;  }	
	section#section4 .bannerBox { width: 560px; height: 200px; 
								  float: left; 
								  position: relative;
								  }											       	 
	section#section4 .bannerBox img { width: 100%; height: 100%; }
	
	section#section4 .bannerBox h3 { position: absolute; 
								     top: 20px; left: 20px; 
								     font-size: 25px; 
								     color: gold; 
								   	 text-shadow: 3px 4px 4px black; }
	section#section4 .bannerBox p { position: absolute; top: 60px; left: 20px; color: #fff; font-weight: bolder; text-shadow: 3px 4px 4px black;}	
	section#section4 #banner1 { margin-right: 60px; margin-left:10px;}  
	
	
	/* 메인5 (상담 시간, 업무시간, Q&A 버튼들 있는 부분) */
	section#section5 { margin-top: 30px; width: 100%;  height: 300px; margin-left:10px;}
	section#section5 .infoBox {  height: 200px; float: left; border: 1px solid #c8c8c8; }
	section#section5 div#counsel { width: 360px; }
	section#section5 .infoBox h3 { font-size: 20px; margin: 10px; }
	section#section5 .infoBox p { text-align: center; height: 60px; line-height: 60px;}
	section#section5 .big { font-size: 50px; font-weight: bold;}
	section#section5 div#workTime {  width: 198px; border-left:none;}
	section#section5 div#workTime .bold { font-weight: bold; } 
	section#section5 div#shortcutBtns {  width: 560px; margin-left: 70px; border: none;  }
	section#section5 div#shortcutBtns a { display: block; 
									      text-decoration: none; 
									      width: 250px; 
									      height: 60px;
									      background: tan;
									      line-height: 60px;
									      color: #fff;
									      text-align: center;
									      border: 1px solid #c8c8c8;
									      float: left; 
									      margin: 20px 10px 10px 10px; }
									      
	/*팝업스타일 */
	 #popup1{
      margin-left:100px;
      float:left;
      text-align:center;
      width:560px;
      height: 600px;
      position: relative;
      position: absolute;
      top: 150px;
       display: none;
    }
    
    #popup2{
      margin-left:100px;
      float:left;
      text-align:center;
      width:560px;
      position: relative;
      position: absolute;
      top: 250px;
      left:100px;
      display: none;
    }
    
    #previewPopup1{
    width:400px;
    box-shadow: 0 0 8px black;
    position: absolute;
    left:85px;
    top:50px;
  }
  
   #previewPopup2{
    width:400px;
    box-shadow: 0 0 8px black;
    position: absolute;
    left:85px;
    top:50px;
  }
  
   p.popupClose{
     width:400px;
     position: absolute;
     top:400px;
     left:0;
     padding-bottom: 10px;
     box-shadow: 0 0 8px black;
   }
   input.expireCK{
     margin-right:10px;
     margin-top:13px;
   }
   
   input.expireCK2{
     margin-right:10px;
     margin-top:13px;
   }
   button.popupBtnClose{
     margin-left:20px;
     width:30px;
   }
   button.popupBtnClose2{
     margin-left:20px;
     width:30px;
   }
   
   /* 슬라이드 박스 */
   #slideBoxMain{
     background:linen;
     position: absolute;
     width:110px;
     height: 350px;
     top:300px;
     right:0;
     padding: 5px 5px;
     border:0.5px solid gainsboro;
   }
   #slSpan{
    width:120px; text-align:center;  position: absolute; bottom: 0; margin-bottom:10px; margin-right:10px; color:silver;
   }
   #slideBoxMain ul{
   
   }
   #slideBoxMain ul li{
     height: 30px;
     line-height:30px;
     font-size: smaller;
     padding:5px;
   }
   #slideBoxMain ul li:first-child:hover {
	background: tan;
	font-weight: bold;
} 
   
									      
</style>
<body>
	<div id="container">
	<%@ include file="../include/userHeader.jsp"%>
<!-- 쿠키 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>

<script>

	  $(function(){
		  
		  if($.cookie("popup1") != null ){ 
		         $("#popup1").css("display","block"); 
		      }
		  
		  if($.cookie("popup2") != null ){ 
		         $("#popup2").css("display","block"); 
		      }
		 // alert($.cookie("exeptFor3days"));
		  if($.cookie("exeptFor3days") == "none"){ 
		         $("#popup1").css("display","none"); 
		      }
		  if($.cookie("exeptFor3days2") == "none"){ 
		         $("#popup2").css("display","none"); 
		      }
		  //팝업 버튼 누르면 팝업창 사라지기 popup1
		  $(".popupBtnClose").click(function(){
			  if($(".expireCK").prop("checked") ==true ){
	              $.cookie("exeptFor3days","none",{expires:3, path:"/"});
		   }
			 $(this).parent().parent().parent().css("display","none");
	      })
	     $(".popupBtnClose2").click(function(){
			  if($(".expireCK2").prop("checked") ==true ){
	              $.cookie("exeptFor3days2","none",{expires:3, path:"/"});
		   }
			 $(this).parent().parent().parent().css("display","none");
	  })
	  
	  $("#popup1img").click(function(){
		  if("${popup1.link}" == ""){
		  location.href="${pageContext.request.contextPath}/customer/tourlandEventList/ingEvent";
		  }else{
			  location.href="${popup1.link}";	  
		  }
		  
	  })
	   $("#popup2img").click(function(){
		  if("${popup2.link}" == ""){
		  location.href="${pageContext.request.contextPath}/customer/tourlandEventList/ingEvent";
		  }else{
			  location.href="${popup2.link}";	  
		  }
	  })
	  
	  $(".label3").click(function(){
		  $(this).prev().attr("checked",true);
	  })
	  
	  var currentP = parseInt($("#slideBoxMain").css('top'));
	  $(window).scroll(function(){
		  var positions = $(window).scrollTop();
		  $("#slideBoxMain").stop().animate({"top":positions+currentP+"px"},500);
	  })
	  
	  $('#slSpan').click( function() {
			$('html, body').animate({ scrollTop : 0 }, 600); // 이동 스르륵
			return false;
		} );
	  $("#slExit").click(function(){
		  $("#slideBoxMain").css("margin-right","-120px");
	  })
	  
	  
	  //최근 본 상품의 이미지를 누르면 링크로 이동 
	  $("#currentP1").click(function(){
		  location.href= "tourlandProductDetail?pno="+${currentProduct.pno};
	  })
	  $("#currentP2").click(function(){
		  location.href= "tourlandProductDetail?pno="+${currentProduct2.pno};
	  })
	  
  })
	  
</script>
	        <!-- 팝업 -->   
	         <div id="popup1" style=" margin-left:10%;">  <!-- 1번 팝업 -->
	                        <c:if test="${popup1 == null }">
	                            <div id="previewPopup1">
	                              <img src="${pageContext.request.contextPath}/resources/images/event1.jpg" style="width:400px; height:400px;" id="popup1img">
	                              <p class="popupClose" style="background:black;">
							          <input type="checkbox" class="expireCK">
							          <label for="expireCK" style="color:white" class="label3">3일동안 이 창 열지 않기</label> <!-- for -->
							          <button class="popupBtnClose"> 닫기 </button>
						          </p>
	                            </div>
	                        </c:if>
	                        <c:if test="${popup1 != null }">
	                        <div id="previewPopup1">
	                             <img src="displayFile/popup?filename=${popup1.pic}" style="width:400px; height:400px;" id="popup1img">
	                             <p class="popupClose" style="background:black;">
							          <input type="checkbox" class="expireCK">
							          <label for="expireCK" style="color:white" class="label3">3일동안 이 창 열지 않기</label> <!-- for -->
							          <button class="popupBtnClose"> 닫기 </button>
						         </p>
	                        </div>
	                        </c:if>
	          </div>
	           <div id="popup2" style=" margin-left:10%;"> <!-- 2번팝업  -->
	                        <c:if test="${popup2 == null }">
	                            <div id="previewPopup2">
	                              <img src="${pageContext.request.contextPath}/resources/images/event2.jpg" style="width:400px; height:400px;" id="popup2img">
	                              <p class="popupClose" style="background:black;">
							          <input type="checkbox" class="expireCK2">
							          <label for="expireCK" style="color:white" class="label3">3일동안 이 창 열지 않기</label> <!-- for -->
							          <button class="popupBtnClose2"> 닫기 </button>
						          </p>
	                            </div>
	                        </c:if>
	                        <c:if test="${popup2 != null }">
	                        <div id="previewPopup2">
	                             <img src="displayFile/popup?filename=${popup2.pic}" style="width:400px; height:400px;" id="popup2img">
	                             <p class="popupClose" style="background:black;">
							          <input type="checkbox" class="expireCK2">
							          <label for="expireCK" style="color:white" class="label3">3일동안 이 창 열지 않기</label> <!-- for -->
							          <button class="popupBtnClose2"> 닫기 </button>
						         </p>
	                        </div>
	                        </c:if>
	          </div>
	          
			<div id="mainBox">  
				<section id="section1">
					<div id="imgBox">
						<div class="box1">
							<img src="${pageContext.request.contextPath}/images/cancun.jpg">
						</div>
						<div class="box2 marg">
							<img src="${pageContext.request.contextPath}/images/hotel.jpg">
						</div>
						<div class="box2">
							<img src="${pageContext.request.contextPath}/images/jeju.jpg">
						</div>
					</div>
				</section>
				
				<section id="section2">
					<!-- <div id="inOutDiv" class="divBox">
						<h2>구분</h2>
						<p><input type="radio" name="out" >해외</p>
						<p><input type="radio" name="in" >국내</p>
					</div>
					<div id="tourDiv" class="divBox">
						<h2>상세 구분</h2>
						<p><input type="radio" name="out" >항공</p>
						<p><input type="radio" name="in" >호텔</p>
						<p><input type="radio" name="in" >현지 투어</p>
						<p><input type="radio" name="in" >렌트카</p>
					</div> -->
					<div id="fromDiv" class="divBox">
						<h2>출발지</h2>
						<select>
							<option>선택</option>
							<option>인천</option>
						</select>
					</div>
					<div id="toDiv" class="divBox">
						<h2>도착지</h2>
						<select>
							<option>선택</option>
							<option>제주</option>
							<option>일본</option>
							<option>중국</option>
						</select>
					</div>
					<div id="toDiv" class="divBox">
						<h2>인원</h2>
						<select>
							<option>선택</option>
							<option>성인 2명</option>
							<option>성인 3명</option>
							<option>성인 4명</option>
							<option>성인 5명</option>
							<option>성인 6명</option>
							<option>성인 7명</option>
							<option>성인 8명</option>
							<option>성인 9명</option>
							<option>성인 10명</option>
							<option>성인 11명</option>
							<option>성인 12명</option>
							<option>성인 13명</option>
							<option>성인 14명</option>
							<option>성인 15명</option>
							<option>성인 16명</option>
							<option>성인 17명</option>
							<option>성인 18명</option>
							<option>성인 19명</option>
							<option>성인 20명</option>
						</select>
					</div>
					<div id="dateDiv" class="divBox">
						<h2>출발 날짜</h2>
						<p id="datePick">
							<!-- <span><i class="far fa-calendar-alt"></i> 날짜별 검색</span>  -->
							<span id="picker"><input type="date" class="datepicker" name="rentddate" placeholder="날짜를 선택하려면 클릭." style="height:30px;"></span>
							<span id="pickSearch"><a href="#"><i class="fas fa-search"></i></a></span>
						</p>
					</div>
					<div id="searchDivBtn" class="divBox">
						<button>검색</button>
					</div>
				</section>
				
				<section id="section3">
					<div class="popular" id="first">
						<a href="#">
							<h3>특가 상품</h3>
							<p>친구와 같이 떠나는 상품</p>
							<img alt="" src="${pageContext.request.contextPath}/images/camping.jpg">
							<div id="popInfo">
								~ 4/30일 까지 단독 할인
							</div>
						</a>
					</div>
					<div class="popular">
						<a href="#">
							<h3>여름 휴가 랭킹 1위</h3>
							<p>서울 출발</p>
							<img alt="" src="${pageContext.request.contextPath}/images/polynesia.jpg">
							<div class="popInfo2">
								~ 4/30일 까지 단독 할인
							</div>
						</a>
					</div>
					<div class="popular">
						<a href="#">
							<h3>특가 상품</h3>
							<p>친구와 같이 떠나는 상품</p>
							<img alt="" src="${pageContext.request.contextPath}/images/flowers.jpg">
							<div class="popInfo2">
								~ 4/30일 까지 단독 할인
							</div>
						</a>
					</div>
					<div class="popular">
						<a href="#">
							<h3>특가 상품</h3>
							<p>친구와 같이 떠나는 상품</p>
							<img alt="" src="${pageContext.request.contextPath}/images/flowers.jpg">
							<div class="popInfo2">
								~ 4/30일 까지 단독 할인
							</div>
						</a>
					</div>
					<div class="popular">
						<a href="#">
							<h3>특가 상품</h3>
							<p>친구와 같이 떠나는 상품</p>
							<img alt="" src="${pageContext.request.contextPath}/images/flowers.jpg">
							<div class="popInfo2">
								~ 4/30일 까지 단독 할인
							</div>
						</a>
					</div>
					<div class="popular">
						<a href="#">
							<h3>특가 상품</h3>
							<p>친구와 같이 떠나는 상품</p>
							<img alt="" src="${pageContext.request.contextPath}/images/flowers.jpg">
							<div class="popInfo2">
								~ 4/30일 까지 단독 할인
							</div>
						</a>
					</div>
					<div class="popular">
						<a href="#">
							<h3>특가 상품</h3>
							<p>친구와 같이 떠나는 상품</p>
							<img alt="" src="${pageContext.request.contextPath}/images/flowers.jpg">
							<div class="popInfo2">
								~ 4/30일 까지 단독 할인
							</div>
						</a>
					</div>
				
				</section>
				<section id="section4">
				<c:if test="${banner1 ==null }">
					<div class="bannerBox" id="banner1">
						<h3>그리스 + 산토리니 5박 6일</h3>
						<p>마지막 찬스, 서울 출발</p>
						<img alt="" src="${pageContext.request.contextPath}/images/santo.jpg">
					</div>
				</c:if>
				<c:if test="${banner1 !=null }">
					<div class="bannerBox" id="banner1">
						<h3>${banner1.title }</h3>
						<p>${banner1.content }</p>
						<img alt="" src="displayFile/banner?filename=${banner1.pic}">
					</div>
				</c:if>
				<c:if test="${banner2 ==null }">
					<div class="bannerBox">
						<h3>진짜 오사카를 만나다</h3>
						<p>간사이 미니 패스, 대구 출발</p>
						<img alt="" src="${pageContext.request.contextPath}/images/osaka.jpg">
					</div>
				</c:if>
				<c:if test="${banner2 !=null }">
					<div class="bannerBox">
						<h3>${banner2.title }</h3>
						<p>${banner2.content }</p>
						<img alt="" src="displayFile/banner?filename=${banner2.pic}">
					</div>
				</c:if>
				</section>
				
				<section id="section5">
					<div id="counsel" class="infoBox">
						<h3>여행 상담</h3>
						<p>고객 센터</p>
						<p class="big" style="letter-spacing: 0.15em;">1588-0000</p>
					</div>
					
					<div id="workTime" class="infoBox">
						<h3>업무 시간</h3>
						<p><span class="bold">평일 </span>09:00 ~ 18:00</p>
						<p><span class="bold">주말/공휴일 </span>휴무</p>
					</div>
					
					<div id="shortcutBtns" class="infoBox">
						<a href="${pageContext.request.contextPath }/customer/tourlandBoardNotice">공지사항</a>
						<a href="${pageContext.request.contextPath }/customer/tourlandBoardFAQ">FAQ</a>
						<a href="${pageContext.request.contextPath }/customer/tourlandCustBoard">고객의 소리</a>
						<a href="${pageContext.request.contextPath }/customer/tourlandProductBoard">상품 문의사항</a>
					</div>
					
					<div id="slideBoxMain">
					 <div id="slExit" style="position: absolute; left:-19px; top:170px; background:mistyrose; width:18px;" ><i class="fas fa-caret-right" style="margin-left:8px;" id="arrows"></i></div>
					   <ul>
					     <li style="background: mistyrose;"><a href="${pageContext.request.contextPath }/customer/tourlandMyReserv" style="display:block;">예약확인/결제</a></li>
					     <li>최근 본 상품</li>
					     <li style="margin-bottom:80px;">
					     <c:if test="${currentProduct.pic == null }"><span>최근 본 상품이 없습니다.</span>
					     </c:if>
					     <c:if test="${currentProduct.pic != null }">
					       <img src="displayFile/product?filename=${currentProduct.pic}" style="width:100px; height: 100px;" id="currentP1">
					     </c:if>
					     </li>
					     <li>
					      <c:if test="${currentProduct2.pic == null }">
					     </c:if>
					     <c:if test="${currentProduct2.pic != null }">
					     <img src="displayFile/product?filename=${currentProduct2.pic}" style="width:100px; height: 100px; " id="currentP2">
					     </c:if>
					     </li>
					   </ul>
					   <span id="slSpan"><i class="fas fa-angle-up" style="color:silver;"></i> Top</span>
					</div>
				</section>
				
			</div>
		<%@ include file="../include/userFooter.jsp"%> 
	</div>
</body>
</html>