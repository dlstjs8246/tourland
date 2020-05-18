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
	section { width: 1000px; margin: 0 auto; }
	div#proBox { border-bottom : 1px solid #929292; }
	div#proBox h1 { height: 100px; line-height: 100px;}
	div#imgBox { width: 500px; height: 400px;float: left;  }
	div#bigImgBox { width: 500px; height: 500px;}
	div#bigImgBox img { height : 500px; width: 100%; } 
	div#smallImgBox { width: 500px; height:90px;}
	div#smallImgBox img { width:23%; height: 70px; float: left; margin:5px;}
	
	div#infoBox { width: 460px; height: 600px; overflow: hidden; padding-left:20px;} 
	
	#proDetailBtns { height: 50px; text-align: center;}
	#proDetailBtns a {display: block; width: 200px; height: 30px; border: none;line-height:30px; text-decoration: none;font-size: 14px; float: left; margin:10px;}
	#proDetailBtns #detail { background: #828282; color: #fff; }
	#proDetailBtns #review { background: gainsboro; }
	
	div#infoBox ul li { height: 40px;}
	div#infoBox ul li p {float : left; margin-right : 10px;}
	div#infoBox #infoName { height: 100px; }
	div#infoBox #infoName span { font-size: 20px; font-weight: bold;}
	div#infoBox #infoPrice span { font-size: 30px; font-weight: bold;}
	
	div#btnsBox { height: 100px; text-align: center; line-height: 150px;}
	div#btnsBox button { width: 200px; height: 30px; border: none;  }
	button#doReserv { background: maroon; color: #fff; }
	button#doWish { background: steelblue; color: #fff; }
	
	#proDetail h2 { height: 80px; line-height: 60px;}
	#proDetail .detailTitle { height: 30px; font-size: 20px; font-weight: bold; }
	#proDetail .detailInfo { height: 100px; }
	#proDetail img { width: 100%; margin-bottom: 30px; }
</style>

<body>
	<%@ include file="../../include/userHeader.jsp"%>
	<script>
		function replaceAll(str, searchStr, replaceStr) {
		   return str.split(searchStr).join(replaceStr);
		}
		$(function(){
			var price = 0;
			var selCapacity = 0;
			var airCapacity = 0;
			$("#smallImgBox li").each(function(i,obj){
				$(this).find("img").attr("src",$("#proDetail img").eq(i).attr("src"));
			})
			$("#review").click(function() {
				location.href = "tourlandProductReview?pno=${vo.pno}";
			})
			for(var i=1;i<=45;i++) {
				var option = $("<option>").html(i+"명");
				$("#capacity").append(option);
			}
			$("#capacity").change(function(){
				price = 0;
				selCapacity = Number($(this).find("option:selected").val().substring(0,$(this).find("option:selected").val().length-1));
				price = Number("${vo.pprice/vo.tour[0].capacity}");
				price *= selCapacity;
				price = Math.ceil(price);
				$("#price").html("<span>"+price.toLocaleString()+"</span>"); 
			})
			$("#selAir").change(function(){
				var selOption = $(this).find("option:selected").val();
				selCapacity = $("#capacity option:selected").val().substring(0,$("#capacity option:selected").val().length-1);
				var airSelect = $("<select id='airSelect'>").html(" ");
				var p = $("<p>").html("탑승인원 ");
				$(".selOption").eq(1).find("p").eq(1).remove();
				switch(selOption) {
				case "F":
					for(var i=1;i<=${vo.air[0].capacity};i++) {
						var option = $("<option>").html(i+"명");
						airSelect.append(option);	
					}
					p.append(airSelect);
					$(".selOption").eq(1).find("p").after(p);
					break;
				case "B":
					for(var i=1;i<=${vo.air[3].capacity};i++) { 
						var option = $("<option>").html(i+"명");
						airSelect.append(option);	
					}
					p.append(airSelect);
					$(".selOption").eq(1).find("p").after(p);
					break;
				case "E":
					for(var i=1;i<=${vo.air[5].capacity};i++) {
						var option = $("<option>").html(i+"명");
						airSelect.append(option);	
					}
					p.append(airSelect);
					$(".selOption").eq(1).find("p").after(p);
					break;
				}
			})
			$(document).on("change","#airSelect",function(e){
				airCapacity = Number($(this).find("option:selected").val().substring(0,$(this).find("option:selected").val().length-1)); 
				if(selCapacity<airCapacity) {
					alert("현재 예약인원보다 항공기 탑승인원이 더 많을 수 없습니다");
					$(this).find("option").eq(0).prop("selected",true); 
				}
			})
		})
	</script>
		<section>
				<div id="proBox">
					<h1>${vo.pname}</h1>
					<div id="imgBox">
						<div id="bigImgBox">
							<img src="displayFile/product?filename=${vo.pic}">
						</div>
						<div id="smallImgBox">
							<ul>
								<li><img src="${pageContext.request.contextPath}/resources/images/dokyo1.jpg"></li>
								<li><img src="${pageContext.request.contextPath}/resources/images/dokyo1.jpg"></li>
								<li><img src="${pageContext.request.contextPath}/resources/images/dokyo1.jpg"></li>
								<li><img src="${pageContext.request.contextPath}/resources/images/dokyo1.jpg"></li>
							</ul>
						</div>
					</div>
					
					<div id="infoBox">
						<ul>
							<li id="infoNo">상품 번호 : <span id="pno">P${vo.pno}</span></li>
							<li id="infoName"><span id="pname">${vo.pname}</span></li>
							<c:forEach var="air" items="${vo.air}" begin="0" end="0">
								<fmt:formatDate var="ddate" value="${air.ddate}" pattern="yyyy-MM-dd"/>
							</c:forEach>
							<li id="infoDate">출발일 : <span id="ddate">${ddate}</span></li>
							<li id="infoDays">여행 기간 : <span id="tourDays">${(fn:substring(vo.pname,fn:indexOf(vo.pname,']')-2,fn:indexOf(vo.pname,']')-1)-1)}박${fn:substring(vo.pname,fn:indexOf(vo.pname,']')-2,fn:indexOf(vo.pname,']')-1)}일</span></li>
							<c:forEach var="t" items="${vo.tour}" begin="0" end="0">
								<c:set var="capacity" value="${t.capacity}"/>
							</c:forEach>
							<c:set var="N" value="${vo.pprice/capacity}"/>
							<fmt:formatNumber var="price" value="${N+(1-(N%1))%1}" type="number"/>
							<li class="selOption">
								<p>
									예약인원
									<select id="capacity">
									</select>
								</p>
							</li>
							<li class="selOption">
								<p>
									항공기옵션
									<select id="selAir">
										<option value="">선택</option>
										<option value="F">First-Class</option>
										<option value="B">Business</option>
										<option value="E">Economy</option>   
									</select>
								</p>
							</li>
							<li class="selOption">
								<p>
									호텔옵션
									<select id="selHotel">
										<option value="">선택</option>
										<option value="">스위트룸</option>
										<option value="">디럭스룸</option>
										<option value="">일반룸</option>
										<option value="">선택하지않음</option>
									</select>
								</p>
							</li>
							<li class="selOption">
								<p>
									투어옵션
									<select id="selTour">
										<option>선택</option>
										<option>선택하지않음</option>
									</select>
								</p>
							</li>
							<li class="selOption">
								<p>
									렌터카옵션
									<select id="selRentcar">
										<option>선택</option>
										<option>선택하지않음</option>
									</select>
								</p>
							</li>
							<li id="infoPrice">가격 : <span id="price">${price}</span>원</li>
						</ul>
						<div id="btnsBox">
						<button id="doReserv">예약하기</button>
						<button id="doWish">장바구니</button>
					</div>
				</div>					
				</div>
				<div id="proDetail">        
						<div id="proDetailBtns">   
							<a href="#" id="detail">여행 세부 내용 보기</a>
							<a href="#" id="review">리뷰</a>
						</div>
					
				<h2>여행 세부 내용</h2>
					${vo.pcontent}
				</div>
			</section>
	<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>