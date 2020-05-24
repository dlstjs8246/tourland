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
div#mainBox {
	width: 1200px;
	margin: 0 auto;
}

/* 메인1 (사진 3개 있는 부분) */
section#section1 {
	width: 1200px;
}

section#section1 div#imgBox {
	width: 1200px;
	height: 400px;
	margin-top: 30px;
}

section#section1 div#imgBox .box1 {
	width: 810px;
	height: 400px;
	float: left;
	position: relative;
}

section#section1 div#imgBox .box1 div {
	position: absolute;
	top: 0;
	left: 0;
}

section#section1 div#imgBox .box1 img {
	width: 810px;
	height: 400px;
	position: absolute;
}
section#section1 div#imgBox #weatherWrap { 
	width: 380px;
	height: 195px; float: right;
	margin-bottom: 10px;
}
section#section1 div#imgBox #weatherWrap .box2 { 
	position: absolute;
}


section#section1 div#imgBox .box2 {
	width: 380px;
	height: 195px;
	float: right;
	background: seagreen; /* #0067a3; */

}
   

section#section1 div#imgBox .marg {
	margin-bottom: 10px;   
}

section#section1 div#imgBox .box2 img {
	width: 100%;
	height: 100%;
}

/* 메인2 (검색 박스 있는 부분) */
section#section2 {
	background: #bcbcbc;
	height: 180px;
	margin-top: 30px;   
}

section#section2 h2 {
	height: 40px;
	border-bottom: 1px solid #696969;
	margin-bottom: 10px;
}

section#section2 .divBox {
	width: 200px;
	float: left;
	padding: 15px 0;
	margin-left: 15px;
}

.divBox select {
	width: 200px;
	height: 34px;
	margin-top: 20px;
}

#datePick {
	margin-top: 30px;
}

.datepicker {
	width: 180px;
}

section#section2 #inOutDiv {
	margin-left: 40px;
}

section#section2 #dateDiv {
	width: 220px;
}

section#section2 #searchDivBtn {
	text-align: center;
	line-height: 130px;
	margin-left: 70px;
	margin-top: 20px;
}

section#section2 #searchDivBtn button {
	width: 150px;
	height: 30px;
	background: #ff7f00;
	border: none;
}

/* 메인3 (특가 상품들 있는 부분) */
section#section3 {
	height: 600px;
	margin-top: 30px;
}

section#section3 a {
	text-decoration: none;
}

section#section3 #first {
	width: 580px;
	height: 270px;
}

section#section3 #first img {
	width: 100%;
	height: 100%;
}

section#section3 .popular {
	width: 280px;
	height: 270px;
	float: left;
	padding: 10px;
	position: relative;
}

section#section3 .popular img {
	width: 100%;
	height: 100%;
}

section#section3 .popular h3 {
	position: absolute;
	top: 20px;
	left: 30px;
	color: #ff7f00;
	text-shadow: 1px 1px 1px #000;
}

section#section3 .popular p {
	position: absolute;
	top: 50px;
	left: 30px;
	color: #fff;
}

section#section3 #popInfo {
	width: 580px;
	height: 60px;
	background: rgba(0, 0, 0, 0.7);
	position: absolute;
	top: 220px;
	text-align: center;
	font-size: 20px;
	color: #fff;
	line-height: 60px;
}

section#section3 .popInfo2 {
	width: 280px;
	height: 60px;
	background: rgba(0, 0, 0, 0.7);
	position: absolute;
	top: 220px;
	text-align: center;
	font-size: 15px;
	color: #fff;
	line-height: 60px;
}

/* 메인4 (배너 있는 부분) */
section#section4 {
	margin-top: 30px;
	height: 200px;
}

section#section4 .bannerBox {
	width: 560px;
	height: 200px;
	float: left;
	position: relative;
}

section#section4 .bannerBox img {
	width: 100%;
	height: 100%;
}

section#section4 .bannerBox h3 {
	position: absolute;
	top: 20px;
	left: 20px;
	font-size: 25px;
	color: gold;
	text-shadow: 3px 4px 4px black;
}

section#section4 .bannerBox p {
	position: absolute;
	top: 60px;
	left: 20px;
	color: #fff;
	font-weight: bolder;
	text-shadow: 3px 4px 4px black;
}

section#section4 #banner1 {
	margin-right: 60px;
	margin-left: 10px;
}

/* 메인5 (상담 시간, 업무시간, Q&A 버튼들 있는 부분) */
section#section5 {
	margin-top: 30px;
	width: 100%;
	height: 300px;
	margin-left: 10px;
}

section#section5 .infoBox {
	height: 200px;
	float: left;
	border: 1px solid #c8c8c8;
}

section#section5 div#counsel {
	width: 360px;
}

section#section5 .infoBox h3 {
	font-size: 20px;
	margin: 10px;
}

section#section5 .infoBox p {
	text-align: center;
	height: 60px;
	line-height: 60px;
}

section#section5 .big {
	font-size: 50px;
	font-weight: bold;
}

section#section5 div#workTime {
	width: 198px;
	border-left: none;
}

section#section5 div#workTime .bold {
	font-weight: bold;
}

section#section5 div#shortcutBtns {
	width: 560px;
	margin-left: 70px;
	border: none;
}

section#section5 div#shortcutBtns a {
	display: block;
	text-decoration: none;
	width: 250px;
	height: 60px;
	background: tan;
	line-height: 60px;
	color: #fff;
	text-align: center;
	border: 1px solid #c8c8c8;
	float: left;
	margin: 20px 10px 10px 10px;
}

/*팝업스타일 */
#popup1 {
	margin-left: 100px;
	float: left;
	text-align: center;
	width: 560px;
	height: 600px;
	position: relative;
	position: absolute;
	top: 150px;
	z-index: 3;
	display: none;
}

#popup2 {
	margin-left: 100px;
	float: left;
	text-align: center;
	width: 560px;
	position: relative;
	position: absolute;
	top: 250px;
	left: 100px;
	z-index: 3;
	display: none;
}

#previewPopup1 {
	width: 400px;
	box-shadow: 0 0 8px black;
	position: absolute;
	left: 85px;
	top: 50px;
}

#previewPopup2 {
	width: 400px;
	box-shadow: 0 0 8px black;
	position: absolute;
	left: 85px;
	top: 50px;
}

p.popupClose {
	width: 400px;
	position: absolute;
	top: 400px;
	left: 0;
	padding-bottom: 10px;
	box-shadow: 0 0 8px black;
}

input.expireCK {
	margin-right: 10px;
	margin-top: 13px;
}

input.expireCK2 {
	margin-right: 10px;
	margin-top: 13px;
}

button.popupBtnClose {
	margin-left: 20px;
	width: 30px;
}

button.popupBtnClose2 {
	margin-left: 20px;
	width: 30px;
}

/* 슬라이드 박스 */
#slideBoxMain {
	background: linen;
	position: absolute;
	width: 110px;
	height: 410px;
	top: 300px;
	right: -4px;
	padding: 5px 5px;
	border: 0.5px solid gainsboro;
}

#slSpan {
	width: 120px;
	text-align: center;
	position: absolute;
	bottom: 0;
	margin-bottom: 10px;
	margin-right: 10px;
	color: silver;
}

#slideBoxMain ul {
	
}

#slideBoxMain ul li {
	height: 30px;
	line-height: 30px;
	font-size: smaller;
	padding: 5px;
}

#slideBoxMain ul li:first-child:hover {
	background: tan;
	font-weight: bold;
}


/* 날씨 박스 */
.box2 {
	overflow: hidden;
}

.weatherImgBox {
	width: 230px;
	height: 190px;
	text-align: center;
	line-height: 200px;
	float: left;
}

.cloud {
	font-size: 60px;
	color: #fff;
}

.weatherInfoBox {
	width: 140px;
	height: 190px;
	overflow: hidden;
	margin-top: 3px;
}

.weatherInfoBox p {
	height: 38px;
	color: #fff;
	line-height: 38px;
	text-align: center;
	text-indent: 10px;
}

.weatherInfoBox .temp {
	height: 110px;
	line-height: 110px;
	font-size: 40px;
	text-align: center;
	font-weight: bold;
}

.weatherInfoBox .temp .tempNum {
	color: #fff;
}

.weatherInfoBox .weatherLoca {
	font-style: italic;
}
</style>
<body>
	<div id="container">
	<%@ include file="../include/userHeader.jsp"%>


<script>
//날씨 API Ajax
	function getKRWeather() {
		$.ajax({
				url : "http://api.openweathermap.org/data/2.5/forecast?q=Jeju&appid=a791f39f5b8894495048828df8c2a988",
				type : "get",
				dataType : "json",
				success : function(rs) {
					var $img1 = $("<i>").addClass("fas fa-cloud cloud");
					var $img2 = $("<i>").addClass("fas fa-sun cloud");
					
					var cloudSunny = rs.list[1].weather[0].description;
					if(cloudSunny =="scattered clouds" || cloudSunny =="few clouds" || cloudSunny =="overcast clouds"|| cloudSunny =="broken clouds"){
						cloudSunny = "구름 조금";
						$("#krw").find(".weatherImgBox").append($img1);
					}else if(cloudSunny =="clear sky"){
						cloudSunny = "맑음";
						$("#krw").find(".weatherImgBox").append($img2);
					}else if(cloudSunny =="light rain"){
						cloudSunny = "비 조금";
						$("#krw").find(".weatherImgBox").append($img3);
						
					}
					/* 섭씨 온도 : 273.15를 빼줌 */
						$("#krw").find(".tempNum").html(Math.ceil((rs.list[1].main.temp - 273.15)));
						$("#krw").find(".cloudSunny").html(cloudSunny);
					}
				})
	}
	function getJPWeather() {
		$.ajax({
				url : "http://api.openweathermap.org/data/2.5/forecast?q=Japan&appid=a791f39f5b8894495048828df8c2a988",
				type : "get",
				dataType : "json",
				success : function(rs) {
					var $img1 = $("<i>").addClass("fas fa-cloud cloud");
					var $img2 = $("<i>").addClass("fas fa-sun cloud");
					var $img3 = $("<i>").addClass("fas fa-umbrella cloud");
					
					var cloudSunny = rs.list[1].weather[0].description;
					if(cloudSunny =="scattered clouds" || cloudSunny =="few clouds" || cloudSunny =="overcast clouds"|| cloudSunny =="broken clouds"){
						cloudSunny = "구름 조금";
						$("#jpw").find(".weatherImgBox").append($img1);
					}else if(cloudSunny =="clear sky"){
						cloudSunny = "맑음";
						$("#jpw").find(".weatherImgBox").append($img2);
					}else if(cloudSunny =="light rain"){
						cloudSunny = "비 조금";
						$("#jpw").find(".weatherImgBox").append($img3);
						
					}
					/* 섭씨 온도 : 273.15를 빼줌 */
						$("#jpw").find(".tempNum").html(Math.ceil((rs.list[1].main.temp - 273.15)));
						$("#jpw").find(".cloudSunny").html(cloudSunny);
					}
				})
	}
	function getCNWeather() {
		$.ajax({
				url : "http://api.openweathermap.org/data/2.5/forecast?q=china&appid=a791f39f5b8894495048828df8c2a988",
				type : "get",
				dataType : "json",
				success : function(rs) {
					var $img1 = $("<i>").addClass("fas fa-cloud cloud");
					var $img2 = $("<i>").addClass("fas fa-sun cloud");
					var $img3 = $("<i>").addClass("fas fa-umbrella cloud");
					
					var cloudSunny = rs.list[1].weather[0].description;
					if(cloudSunny =="scattered clouds" || cloudSunny =="few clouds" || cloudSunny =="overcast clouds"|| cloudSunny =="broken clouds"){
						cloudSunny = "구름 조금";
						$("#cnw").find(".weatherImgBox").append($img1);
					}else if(cloudSunny =="clear sky"){
						cloudSunny = "맑음";
						$("#cnw").find(".weatherImgBox").append($img2);
					}else if(cloudSunny =="light rain"){
						cloudSunny = "비 조금";
						$("#cnw").find(".weatherImgBox").append($img3);
						
					}
					/* 섭씨 온도 : 273.15를 빼줌 */
						$("#cnw").find(".tempNum").html(Math.ceil((rs.list[1].main.temp - 273.15)));
						$("#cnw").find(".cloudSunny").html(cloudSunny);
					}
				})
	}
	window.onload = function() {
		getKRWeather();
		getJPWeather();
		getCNWeather();
	}
	
	//날씨 박스 setInteval
	setInterval(function() {
		$('#weatherWrap > div:first').hide(1000).next().show(1000).end().appendTo('#weatherWrap');
	}, 3000);
	
	//메인 배너 슬라이드
	/* $(".box1 > div:gt(0)").hide(); */

	setInterval(function() {
		$('.box1 > div:first').fadeOut(1000).next().fadeIn(1000).end()
				.appendTo('.box1');
	}, 3000);

	$(function() {
		
		if ($.cookie("popup1") != null) {
			$("#popup1").css("display", "block");
		}

		if ($.cookie("popup2") != null) {
			$("#popup2").css("display", "block");
		}
		// alert($.cookie("exeptFor3days"));
		if ($.cookie("exeptFor3days") == "none") {
			$("#popup1").css("display", "none");
		}
		if ($.cookie("exeptFor3days2") == "none") {
			$("#popup2").css("display", "none");
		}
		//팝업 버튼 누르면 팝업창 사라지기 popup1
		$(".popupBtnClose").click(function() {
			if ($(".expireCK").prop("checked") == true) {
				$.cookie("exeptFor3days", "none", {
					expires : 3,
					path : "/"
				});
			}
			$(this).parent().parent().parent().css("display", "none");
		})
		$(".popupBtnClose2").click(function() {
			if ($(".expireCK2").prop("checked") == true) {
				$.cookie("exeptFor3days2", "none", {
					expires : 3,
					path : "/"
				});
			}
			$(this).parent().parent().parent().css("display", "none");
		})

		$("#popup1img")
				.click(
						function() {
							if ("${popup1.link}" == "") {
								location.href = "${pageContext.request.contextPath}/customer/tourlandEventList/ingEvent";
							} else {
								location.href = "${popup1.link}";
							}

						})
		$("#popup2img")
				.click(
						function() {
							if ("${popup2.link}" == "") {
								location.href = "${pageContext.request.contextPath}/customer/tourlandEventList/ingEvent";
							} else {
								location.href = "${popup2.link}";
							}
						})

		$(".label3").click(function() {
			$(this).prev().attr("checked", true);
		})

		var currentP = parseInt($("#slideBoxMain").css('top'));
		$(window).scroll(function() {
			var positions = $(window).scrollTop();
			$("#slideBoxMain").stop().animate({
				"top" : positions + currentP + "px"
			}, 500);
		})

		$('#slSpan').click(function() {
			$('html, body').animate({
				scrollTop : 0
			}, 600); // 이동 스르륵
			return false;
		});
		//닫기화살표 누르면
		$(document)
				.on(
						"click",
						"#arrows",
						function() {

							$("#slideBoxMain").css("margin-right", "-118px");
							$("#arrowSide")
									.html(
											'<i class="fas fa-caret-left" style="margin-left:4px;" id="arrowsBack"></i>');

						})
		$(document)
				.on(
						"click",
						"#arrowsBack",
						function() {

							$("#slideBoxMain").css("margin-right", "0");
							$("#arrowSide")
									.html(
											'<i class="fas fa-caret-right" style=" margin-left:7px; display:block; width:18px; height:22px; line-height:22px;" id="arrows"></i>');

						})

		//메인 중앙 검색 박스
		$("#searchDivBtn button")
				.click(
						function() {
							var tourDays = $("#tourDays select").val();
							var to = $("#toDiv select").val();
							var capa = $("#capa select").val();
							var date = $(".datepicker").val();

							if (tourDays == "선택" || to == "선택" || capa == "선택"
									|| date == "") {
								alert("모든 항목을 선택해주세요.");
								return false;
							} else {
								location.href = "${pageContext.request.contextPath}/customer/tourlandProductMainSearchList?tourDays="
										+ tourDays
										+ "&to="
										+ to
										+ "&capa="
										+ capa + "&date=" + date;
							}

						})					
	})
</script>
 <c:if test="${currentProductPrice != null}">
    <script>
       //최근 본 상품의 이미지를 누르면 링크로 이동 이엘때문에 따로 처리, 동적 추가 docu on
       $(document).on("click",".currentP1",function(){
		  location.href= "tourlandProductDetail?pno="+${currentProduct.pno}+"&price="+${currentProductPrice};
	    })
    </script>
</c:if>
<c:if test="${currentProduct2 != null}">
    <script>
    $(document).on("click",".currentP2",function(){
		  location.href= "tourlandProductDetail?pno="+${currentProduct2.pno}+"&price="+${currentProductPrice2};
	    })
    </script>
</c:if> 
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
						<div class="box1"> <!-- 메인 슬라이드 박스  -->
							<div><a href="${pageContext.request.contextPath }/loginForm"><img src="${pageContext.request.contextPath}/images/maincoupon.jpg" style="z-index:2" title="로그인 페이지로 이동합니다."></a></div>
							<div><a href="${pageContext.request.contextPath }/customer/eventDetailPage?no=3"><img src="${pageContext.request.contextPath}/images/mainevent1.jpg" style="z-index:1" title="이벤트 상세 페이지로 이동합니다"></a></div>
							<div><img src="${pageContext.request.contextPath}/images/mainevent2.jpg"></div>
						</div>
						<div id="weatherWrap">
						<!-- 날씨 API -->
						<div class="box2 marg" class="weather" id="krw" style="z-index:2">                 
							<div class="weatherImgBox">   
								  
							</div>   
							<div class="weatherInfoBox">
								<p class="temp"><span class="tempNum"></span> ℃</p>
								<p class="cloudSunny"></p>
								<p class="weatherLoca">제주, 한국</p>
							</div>           
						</div> 
						<div class="box2 marg" class="weather" id="jpw" style="z-index:1">                 
							<div class="weatherImgBox">   
								  
							</div>   
							<div class="weatherInfoBox">
								<p class="temp"><span class="tempNum"></span> ℃</p>
								<p class="cloudSunny"></p>
								<p class="weatherLoca">도쿄, 일본</p>
							</div>           
						</div>    
						<div class="box2 marg" class="weather" id="cnw">                 
							<div class="weatherImgBox">   
								  
							</div>   
							<div class="weatherInfoBox">
								<p class="temp"><span class="tempNum"></span> ℃</p>
								<p class="cloudSunny"></p>
								<p class="weatherLoca">베이징, 중국</p>
							</div>           
						</div>      
						</div>
						<div class="box2">   
							<img src="${pageContext.request.contextPath}/images/jeju/tour26.jpg">
						</div>    
					</div>
				</section>
				
				<section id="section2">
					<div id="toDiv" class="divBox">
						<h2>도착지</h2>
						<select>
							<option>선택</option>
							<option>제주</option>
							<option>일본</option>
							<option>중국</option>
						</select>
					</div>
					<div id="tourDays" class="divBox">
						<h2>여행일</h2>
						<select>
							<option>선택</option>
							<option>3일</option>
							<option>5일</option>
							<option>7일</option>
						</select>
					</div>
					<div id="capa" class="divBox">
						<h2>인원</h2>
						<select>
							<option>선택</option>
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
							<h3>일본 특가 상품</h3>
							<p>신주쿠 교엔 / 파격적인 가격</p>
							<img alt="" src="${pageContext.request.contextPath}/images/japan/sinjuku.jpg">
							<div id="popInfo">   
								~ 6/30일 까지 단독 할인
							</div>   
						</a>        
					</div>
					<div class="popular">
						<a href="#">
							<h3>여름 휴가 랭킹 1위 /제주</h3>
							<p>떠나요 둘이서~</p>
							<img alt="" src="${pageContext.request.contextPath}/images/jeju/tour1.jpg">
							<div class="popInfo2">
								~ 7/30일 까지 단독 할인     
							</div>
						</a>  
					</div>
					<div class="popular">
						<a href="#">
							<h3>얼리버드 상품</h3>
							<p>제주 성산봉</p>   
							<img alt="" src="${pageContext.request.contextPath}/images/jeju/tour11.jpg">
							<div class="popInfo2">
								~ 4/30일 까지 단독 할인
							</div>
						</a>
					</div>
					<div class="popular">
						<a href="#">
							<h3>일본 땡처리 항공</h3>
							<p>친구와 같이 떠나는 도쿄 디즈니랜드</p>
							<img alt="" src="${pageContext.request.contextPath}/images/japan/land.jpg">
							<div class="popInfo2">
								~ 7/30일 까지 단독 할인    
							</div>
						</a>
					</div>      
					<div class="popular">
						<a href="#">   
							<h3>절호의 찬스</h3>
							<p>만리장성</p>
							<img alt="" src="${pageContext.request.contextPath}/images/china/manri2.jpg">
							<div class="popInfo2">
								~ 7/30일 까지 단독 할인
							</div>
						</a>
					</div>
					<div class="popular">
						<a href="#">
							<h3>특가 상품</h3>
							<p>청나라 시대의 궁, 원명원</p>
							<img alt="" src="${pageContext.request.contextPath}/images/china/wonmyung.jpg">
							<div class="popInfo2">
								~ 6/30일 까지 단독 할인
							</div>
						</a>
					</div>
					<div class="popular">
						<a href="#">
							<h3>테마 찬스 상품 / 제주 애월읍</h3>
							<p>효리네 민박의 그 곳</p>
							<img alt="" src="${pageContext.request.contextPath}/images/jeju/tour13.jpg">
							<div class="popInfo2">
								~ 8/30일 까지 단독 할인
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
						<a href="${pageContext.request.contextPath }/customer/tourlandPlanBoard">상품 문의사항</a>
					</div>
					
					<div id="slideBoxMain" style="cursor: pointer">
					 <div id="slExit" style="position: absolute; left:-18px; top:200px; background:mistyrose; width:18px;"><span id="arrowSide" style="width:18px; 25px;"><i class="fas fa-caret-right" style="margin-left:8px;" id="arrows"></i></span></div>
					   <ul>
					     <li style="background: mistyrose;"><a href="${pageContext.request.contextPath }/customer/tourlandMyReserv" style="display:block;">예약확인/결제</a></li>
					     <li>최근 본 상품</li>
					     <li style="margin-bottom:10px; height:130px;">
					          <c:if test="${currentProduct.pic == null }"><span>최근 본 상품이 없습니다.</span> </c:if>
					          <c:if test="${currentProduct.pic != null }">
					                  <img src="displayFile/product?filename=${currentProduct.pic}" style="width:100px; height: 100px;" class="currentP1">
					                  <span style="width:100px; white-space:nowrap; overflow: hidden; display: block;" class="currentP1">${currentProduct.pname }</span>
					          </c:if>
					     </li>
					     <li style="margin-bottom:10px; height:130px;">
						      <c:if test="${currentProduct2.pic == null }"></c:if>
						      <c:if test="${currentProduct2.pic != null }"> 
						              <img src="displayFile/product?filename=${currentProduct2.pic}" style="width:100px; height: 100px; " class="currentP2">
						              <span style="width:100px; white-space:nowrap; overflow: hidden; display: block;" class="currentP2">${currentProduct2.pname }</span>
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