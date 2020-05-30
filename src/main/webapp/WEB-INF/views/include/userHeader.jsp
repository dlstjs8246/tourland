<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Nanum+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/6f2f0f2d95.js"></script>    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script> 
<script src="https://kit.fontawesome.com/6f2f0f2d95.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>

<style>
@font-face { font-family: 'Recipekorea'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/Recipekorea.woff') format('woff'); font-weight: normal; font-style: normal; }
 /* 전체 */
	* { margin:0; 
		padding:0; 
		font-family: 'Noto Sans KR', sans-serif;
		color: #434343;}
	li { list-style: none; }
	li a { text-decoration: none; color: #000; }
	
	/* 로그인 메뉴 부분 */
	nav#nav1 { width: 100%;
			   height: 50px; 
			   background: tan; 
			   overflow: hidden;}
	nav#nav1 ul { width: 1200px;
				  height: 50px;
				  margin: 0 auto; }
	nav#nav1 li { margin-right: 23px;
   				  line-height: 50px;
    			  float: right;
    			  font-size: 14px; }
	.balance{
		padding-left:12px;
	}
	nav#nav1 #manager a { border-radius: 3px; 
						  background: maroon; color: #fff; 
						  padding: 0 3px;
						  font-size: 13px;}				  
	
	/* 헤더 */
	#main { width: 1200px; height: 150px;
			margin: 0 auto;}
	#main div.ls, #main div#weatherWrap { width: 30%; 
				text-align: center; 
				float: left;
				
				 }
	
	#main div#search { margin-top: 50px; }
	#main div#logo { margin-top: 30px;}  
	#main div#logo span { font-weight: bold;}
	#main div#logo, #main div#search { margin-left: 50px;}						  
	#main div#logo h1 a { color: #ff7f00; font-size: 50px; 
					    font-family:'Recipekorea', sans-serif; 
					      text-decoration: none;}
	#main #search { line-height: 80px; }
	#main div#search input { width:200px;padding:10px; border: none; border-bottom: 1px solid gray; }
	#main div#search input::placeholder { font-size: 17px;}
	
	div#nav2 { clear: both; }  
	div#nav2 { height: 50px; 
			   background: #545454; 
			   overflow: hidden; }
	div#nav2 ul { width: 1200px; height: 50px; margin: 0 auto;}
	div#nav2 ul li { width: 10%; 
					 height: 50px;  
				     float: left; 
				     margin-right:20px; }
	div#nav2 ul li a { display: block;    
					   text-align: center;
					   line-height: 50px;
					   color: #fff;}
	div#nav2 ul li#orange { width: 50px; background: #ff7f00;}
	div#nav2 ul li.short { width: 50px;} 
 	#userAuth, #managerAuth{
   	 width: 250px; line-height: 50px;
	}
	
	/* 날씨 박스 */
#weatherWrap { position: relative;}
#weatherWrap h4 { height: 40px; 
				  line-height: 50px;
				  text-indent: -80px;
				  margin-top: 20px;}
#weatherBoxWrap {width : 450px; height: 50px; overflow: hidden;}		   		  
.box2 {
	width : 350px; 
	overflow: hidden;     
	height: 50px;     
	   
	background: gold;   
	border-radius: 10px;
	
}  

.weatherImgBox {  
	width: 40px;
	height: 50px;  
	text-align: right;
	line-height:50px;   
	float: left;
}  

.cloud {
	font-size: 20px;
}

.weatherInfoBox {
	height: 50px;
	overflow: hidden;
	margin-top: 3px;
}

.weatherInfoBox p {  
	width: 100px; 
	height: 50px; 
	text-align: center;
	text-indent: 10px;  
	overflow: hidden;
	float:left; 
}

 .weatherInfoBox .temp {
 	
	font-size: 25px;
	text-align: center;
	font-weight: bold;
	
}

.weatherInfoBox .cloudSunny {
	line-height: 40px; 
}

.weatherInfoBox .weatherLoca {
	line-height: 40px; 
	font-style: italic;
} 
</style>
<script>
	$(function(){
		$("#nav2 li").mouseover(function(){
			$(this).find("a").css("color", "#ff7f00");
		})
		$("#nav2 li").mouseout(function(){
			$(this).find("a").css("color", "#fff");
		})
	})    
</script>
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
				var $img3 = $("<i>").addClass("fas fa-umbrella cloud");
				var cloudSunny = rs.list[1].weather[0].description;
				
				if(cloudSunny =="scattered clouds" || cloudSunny =="few clouds" || cloudSunny =="overcast clouds"|| cloudSunny =="broken clouds"){
					cloudSunny = "구름 조금";
					$("#krw").find(".weatherImgBox").append($img1);
				}else if(cloudSunny =="clear sky"){
					cloudSunny = "맑음";
					$("#krw").find(".weatherImgBox").append($img2);
				}else if(cloudSunny =="light rain" || cloudSunny == "moderate rain"){
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
				}else if(cloudSunny =="light rain" || cloudSunny == "moderate rain"){
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
				}else if(cloudSunny =="light rain" || cloudSunny == "moderate rain"){
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
 		 $('#weatherBoxWrap .box2:first').animate({
 			 marginTop : -50
 		 }, 1000 )
 		
 		 $('#weatherBoxWrap .box2:eq(1)').delay(1000).animate({
 			 marginTop : -50
 		 }, 1000 , function(){
 			 $('#weatherBoxWrap .box2:first').css("margin-top", "0px");
 			 $('#weatherBoxWrap .box2:eq(2)').css("margin-top", "0px");
 			
 			 $('#weatherBoxWrap .box2:eq(1)').css("margin-top", "0px");
 		 })
 		
 	 },3000)
		 
		
	  
</script>


<header>
			<nav id="nav1">
				<ul>
				<c:if test="${Auth==null}">
					<li><a href="${pageContext.request.contextPath }/customer/tourlandBoardNotice">고객센터</a></li>
					<li><a href="${pageContext.request.contextPath }/customer/tourlandRegister">회원가입</a></li>
					<li><a href="${pageContext.request.contextPath }/loginForm" class="balance">로그인</a></li>
				</c:if>
				<c:if test="${Auth!=null}">
					<li><a href="${pageContext.request.contextPath}/logout" class="balance">로그아웃</a></li>
					<li><a href="${pageContext.request.contextPath}/customer/tourlandBoardNotice">고객센터</a></li>
					<c:if test="${login=='user'}">
						<li><a href="${pageContext.request.contextPath }/customer/EditPassword">마이페이지</a></li>
					</c:if>
					<c:if test="${login=='user'}">
						<p id="userAuth">[ ${User} ]님! 반갑습니다.</p>
					</c:if>
					<c:if test="${login=='manager' && Manager.right==1}">
						<li id="manager" style="margin-left: -15px;"><a href="${pageContext.request.contextPath}/manager/empMngList/0">관리자</a></li>
						<p id="managerAuth">[ ${Manager.name} ]님! 반갑습니다.</p>
					</c:if>
					<c:if test="${login=='manager' && Manager.right==0}">
						<li id="manager" style="margin-left: -15px;"><a href="${pageContext.request.contextPath}/manager/userMngList/0">관리자</a></li>
						<p id="managerAuth">[ ${Manager.name} ]님! 반갑습니다.</p>
					</c:if>
				</c:if>
				</ul>
			</nav>
					<div id="main">
							<%-- <a href="${pageContext.request.contextPath }/customer/tourlandEventList/ingEvent"><img src="${pageContext.request.contextPath }/resources/images/reward.png"></a> --%>
						<div id="weatherWrap">
						<!-- 날씨 API -->
						<h4>여행지의 현재 날씨를 확인하세요!</h4>
						<div id="weatherBoxWrap">
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
						</div>
						<div id="logo" class="ls">
							<span>패키지 전문 여행사 <i class="fas fa-plane-departure"></i></span>
							<h1><a href="${pageContext.request.contextPath }/customer/tourlandMain">투어 랜드</a></h1>    
						</div>
						<div id="search" class="ls">
						    <c:if test="${searchkeyword !=null }">
							<input type="text" placeholder="검색어를 입력하세요." id="mainSearchKeyword" value="${searchkeyword }"><i class="fas fa-search" id="mainSearchIcon"></i>
							</c:if>
							<c:if test="${searchkeyword ==null }">
							<input type="text" placeholder="검색어를 입력하세요." id="mainSearchKeyword"><i class="fas fa-search" style="font-size:25px;" id="mainSearchIcon"></i>
							</c:if>
							<!-- <button>찾기</button> -->
						</div>
					</div>
					
					<div id="nav2">
						<ul>
							<li><a href="${pageContext.request.contextPath }/customer/tourlandProductKRList">제주 패키지</a></li>
							<li><a href="${pageContext.request.contextPath }/customer/tourlandProductJPList">일본 패키지</a></li>
							<li><a href="${pageContext.request.contextPath }/customer/tourlandProductChinaList">중국 패키지</a></li>
							<li class="short"><a href="${pageContext.request.contextPath }/customer/tourlandEventList/ingEvent">이벤트</a></li>
						</ul>
					</div>
			</header>
			
<script>
    $(function(){
    	$("#mainSearchIcon").click(function(){
            var mainKeyword = $("#mainSearchKeyword").val();
            
            if(mainKeyword == ""){
            	alert("검색어를 입력해주세요");
            	return false;
            }
    		location.href="${pageContext.request.contextPath }/customer/tourlandSearch/default?searchType=&keyword="+mainKeyword+"&keyword2=";
    	})
    })
</script>