<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	#eventSection{
	  width: 1000px;
	  margin: 0 auto;
	  height: auto;
	}
	#eventPageDiv{
	  position: relative;
	}
	#eventPageP{
	  position: absolute;
	  top:430px;
	  left:470px;
	  font-size: 60px;
	  font-weight:bold;
	  color:white;
	  letter-spacing: 0.35em;
	}
	div.eventBox{
	  width:330px;
	  float:left;
	  margin: 30px 0 70px 0;
	  text-align: center;
	  font-weight: bolder;
	}
	div.eventBox img{
	  width:200px;
	  height: 200px;
	}
	#eventMainDiv{
	 clear:both;
	}
	.event3{
	cursor: pointer;
	float:left;
	margin:30px 0 50px 100px;
	width:200px; text-align: center; height: 40px; line-height: 40px; margin-left:100px; border-radius: 20px;
	}
	
</style>
<body>
	<%@ include file="../../include/userHeader.jsp"%>
	   <div id="eventPageDiv">
			<img src="${pageContext.request.contextPath }/resources/images/eventPage.jpg" style="width:100%; height:550px;">
			<p id="eventPageP">TOURLAND BIG EVENT</p>
	   </div>
	   
			<section id="eventSection">
			<p class="event3" id="inging">진행중 이벤트</p>
			<p class="event3" id="comecome">다가올 이벤트</p>	
			<p class="event3" id="donedone">종료된 이벤트</p>
			<div id="eventMainDiv"> 
				<c:forEach var="eventList" items="${eventList }">
				<div class="eventBox" data-click="${eventList.no }">
					<img src="${pageContext.request.contextPath}/customer/displayFile/event?filename=${eventList.pic}" class="eventImgs">
					<p>${eventList.title }</p>
			    </div>
			    </c:forEach>
			</div>    
	  </section>
	<%@ include file="../../include/userFooter.jsp"%>
</body>

<script>
	$(function(){
		
		$('html, body').animate({ scrollTop : 700 }, 200); //이벤트 사진 전까지 이동 스르륵
		//보내는 값에 따라 css변경
		var eventSentence = "${mistyrose}";
		if(eventSentence == "inging"){
			$("#inging").css("background","mistyrose");
		}
		
		if(eventSentence == "comecome"){
			$("#comecome").css("background","mistyrose");
		}
		
		if(eventSentence == "donedone"){
			$("#donedone").css("background","mistyrose");
		}

		$(".pkgReservBtn").click(function(){
			location.href="${pageContext.request.contextPath}/customer/tourlandProductDetail";
		}) 
		
     //진행중 이벤트 = 새로고침 느낌
	 $(".event3").eq(0).click(function(){
		 location.href="${pageContext.request.contextPath}/customer/tourlandEventList/ingEvent";
	 })	
	 // 다가올 이벤트
	 $(".event3").eq(1).click(function(){
		 location.href="${pageContext.request.contextPath}/customer/tourlandEventList/commingEvent";
	 })
	 
	 //지난 이벤트 
	 $(".event3").eq(2).click(function(){
		 location.href="${pageContext.request.contextPath}/customer/tourlandEventList/expiredEvent";
	  })
	  
	  //각각의 이벤트를 클릭할 때 상세페이지로 이동
	  $(".eventBox").click(function(){
		  var no = $(this).attr("data-click");
		  location.href="${pageContext.request.contextPath}/customer/eventDetailPage?no="+no;
	  })
	})
</script>   
</html>