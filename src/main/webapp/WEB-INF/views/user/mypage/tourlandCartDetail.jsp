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
	div#imgBox { width: 500px; height: 800px;float: left;  }
	div#bigImgBox { width: 500px; height: 400px;}  
	div#bigImgBox img { height : 400px; width: 100%; } 
	div#smallImgBox { width: 500px; height:100px;}
	div#smallImgBox img { width:23%; height: 100px; float: left; margin:5px;}   
	
	div#infoBox { width: 460px; height: 900px; overflow: hidden; padding-left:20px;}  
	
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
		var uno = 0;
		var price = 0; 
		var bookCapacity = 0;
		function calDateDiff(checkin,checkout) {
			checkinArr = checkin.split(" ");
			checkoutArr = checkout.split(" ");
			checkin = checkinArr[1]+" "+checkinArr[2]+", "+checkinArr[5]+" "+checkinArr[3]; 
			checkout = checkoutArr[1]+" "+checkoutArr[2]+", "+checkoutArr[5]+" "+checkoutArr[3]; 
			var checkinDate = new Date(Date.parse(checkin));
			var checkoutDate = new Date(Date.parse(checkout));  
			var date = new Date();
			date.setDate(checkoutDate.getDate() - checkinDate.getDate());
			return date.getDate();
		}
		function replaceAll(str, searchStr, replaceStr) {
		   return str.split(searchStr).join(replaceStr);
		}
		$(function(){
			$("#smallImgBox li").each(function(i,obj){
				$(this).find("img").attr("src",$("#proDetail img").eq(i).attr("src"));
			})
			$(document).on("click","#smallImgBox li img",function(){
				$("#bigImgBox img").attr("src",$(this).attr("src"));
			})
			for(var i=1;i<=45;i++) {
				var option = $("<option>").html(i+"명");
				$("#capacity").append(option);
			}
		});
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
						<style>
							#optionInfo { border-collapse: collapse; width: 480px;margin-left: 10px; margin-top: 50px;}
							#optionInfo th { height: 50px; background: gainsboro;border-top: 1px solid #929292; border-bottom: 1px solid #929292; font-size: 18px; }
							#optionInfo td { height: 30px; }
							#optionInfo #include { color:forestgreen; }
							#optionInfo #exclude { color:maroon; } 		  
						</style>
						<table id="optionInfo">
							<tr>   
								<th colspan="3"><span id="include">O </span> 포함 사항</th>
							</tr>
							<tr>
								<td>- 인천공항 공항세, 현지 공항세, 관광진흥 개발 기금</td>
							</tr>
							<tr>     
								<td>- 유류할증료</td>
							</tr>
							<tr>
								<td>- 최대 1억원 해외여행자 보험</td>
							</tr>
							<tr>
								<th colspan="3"><span id="exclude">X </span> 불포함 사항</th>
							</tr>
							<tr>
								<td>- 여권발급비용</td>
							</tr>
							<tr>
								<td>- 개인경비</td>
							</tr>
							<tr>
								<td>- 1일 자유일정시 중,석식 및 교통비, 개인경비</td>
							</tr>
						</table>
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
							<li class="selOption">
								<p>
									예약인원
									<select id="capacity">
									</select>
								</p>
							</li>
							<li class="selOption">
								<p class="airOption">
									항공기옵션1
									<select class="selAir">
										<option value="">선택</option>
										<option value="F" data-dano="${vo.air[0].no}" data-rano="${vo.air[1].no}">First-Class</option>
										<option value="B" data-dano="${vo.air[2].no}" data-rano="${vo.air[3].no}">Business</option>
										<option value="E" data-dano="${vo.air[4].no}" data-rano="${vo.air[5].no}">Economy</option>   
									</select>
								</p>
							</li>
							<li class="selOption">
								<p class="airOption">
									항공기옵션2
									<select class="selAir">
										<option value="">선택</option>
										<option value="F" data-dano="${vo.air[0].no}" data-rano="${vo.air[1].no}">First-Class</option>
										<option value="B" data-dano="${vo.air[2].no}" data-rano="${vo.air[3].no}">Business</option>
										<option value="E" data-dano="${vo.air[4].no}" data-rano="${vo.air[5].no}">Economy</option>   
									</select>
								</p>
							</li>
							<li class="selOption">
								<p class="airOption">
									항공기옵션3 
									<select class="selAir">
										<option value="">선택</option>
										<option value="F" data-dano="${vo.air[0].no}" data-rano="${vo.air[1].no}">First-Class</option>
										<option value="B" data-dano="${vo.air[2].no}" data-rano="${vo.air[3].no}">Business</option>
										<option value="E" data-dano="${vo.air[4].no}" data-rano="${vo.air[5].no}">Economy</option>   
									</select>
								</p>
							</li>
							<li class="selOption">
								<p class="hotelOption">
									호텔옵션1 
									<select class="selHotel">
										<option value="">선택</option>
										<option value="S" data-hno="${vo.hotel[0].no}">스위트룸</option>
										<option value="D" data-hno="${vo.hotel[1].no}">디럭스룸</option>
										<option value="N" data-hno="${vo.hotel[2].no}">일반룸</option>
										<option value="DS">선택안함</option>
									</select>
								</p>
							</li>
							<li class="selOption">
								<p class="hotelOption">
									호텔옵션2 
									<select class="selHotel">
										<option value="">선택</option>
										<option value="S" data-hno="${vo.hotel[0].no}">스위트룸</option>
										<option value="D" data-hno="${vo.hotel[1].no}">디럭스룸</option>
										<option value="N" data-hno="${vo.hotel[2].no}">일반룸</option>
										<option value="DS">선택안함</option>
									</select>
								</p>
							</li>
							<li class="selOption">
								<p class="hotelOption">
									호텔옵션3
									<select class="selHotel">
										<option value="">선택</option>
										<option value="S" data-hno="${vo.hotel[0].no}">스위트룸</option>
										<option value="D" data-hno="${vo.hotel[1].no}">디럭스룸</option>
										<option value="N" data-hno="${vo.hotel[2].no}">일반룸</option>
										<option value="DS">선택안함</option>
									</select>
								</p>
							</li>
							<li class="selOption">
								<p>
								투어옵션<br>
									<c:forEach var="tour" items="${vo.tour}">
										<input type="checkbox" name="tourChk" value="${tour.no}" class="selTour" data-price="${tour.tprice}"> <span>${tour.tname}</span><br>
									</c:forEach>
								</p>
							</li>
							<li class="selOption">
								<p>
									렌터카옵션
									<select id="selRentcar">
										<option value="">선택</option>
										<option value="S" data-rentno="${vo.rentcar[0].no}">선택함</option>
										<option value="DS">선택안함</option>
									</select>   
								</p>
							</li>
							<li id="infoPrice" style="clear : both;">가격 : <span id="price"><fmt:formatNumber value="${price}" pattern="###,###"/></span>원</li>
						</ul>
						<div id="btnsBox">
						<button id="doReserv">예약하기</button>
						<button id="doWish">장바구니</button>
					</div>
				</div>					
				</div>
				<div id="proDetail">        
						<div id="proDetailBtns">   
							<a id="detail">여행 세부 내용 보기</a>
							<a id="review">리뷰</a>
						</div>
					
				<h2>여행 세부 내용</h2>
					${vo.pcontent}
				</div>
			</section>
	<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>