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
	div#bigImgBox { width: 500px; height: 300px;}
	div#bigImgBox img { height : 300px; width: 100%; }
	div#smallImgBox { width: 500px; height:90px;}
	div#smallImgBox img { width:23%; height: 70px; float: left; margin:5px;}
	
	div#infoBox { width: 460px; height: 400px; overflow: hidden; padding-left:20px;}
	
	#proDetailBtns { height: 50px; text-align: center;}
	#proDetailBtns a {display: block; width: 200px; height: 30px; border: none;line-height:30px; text-decoration: none;font-size: 14px; float: left; margin:10px;}
	#proDetailBtns #review { background: #828282; color: #fff; }
	#proDetailBtns #detail { background: gainsboro; }

	/* 리뷰  */
	.realReview { height: 50px; background: #F4F4F4; line-height: 50px; }
	.realReview span { display: block; float: left; }
	.reviewNo { width: 50px; text-align: center;}
	.reviewTitle { width: 600px; }
	.reviewDate { width:100px; }
	.userId { width: 80px; }
	.userStar{ width: 150px; }
	.innerReview { height: 300px; padding: 30px; }	
	div#infoBox ul li { height: 40px; }
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
		$(function(){
			$("#smallImgBox li").each(function(i,obj){
				$(this).find("img").attr("src",$("#proDetail img").eq(i).attr("src"));
			})
			$("#detail").click(function() {
			location.href = "tourlandProductDetail?pno=90";
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
    
					<h2>상품 리뷰 <span id="reviewCnt">(13)</span></h2>
					<div id="reviewWrap">
						<ul>
							<li class="realReview"><span class="reviewNo">2</span>
								<span class="reviewTitle">가족여행으로 잘 다녀왔어요!</span>
								<span class="reviewDate">2020.05.15</span>
								<span class="userId">hn****</span>
								<span class="userStar">
									<i class="fas fa-star"></i>
									<i class="fas fa-star"></i>
									<i class="fas fa-star"></i>
									<i class="fas fa-star"></i>
									<i class="far fa-star"></i>
								</span>
							</li>
							<li class="innerReview"><span class="reviewContent">처음
									가는 곳이라 좀 걱정 했는데, 즐겁게 잘 다녀왔습니다. 저가 항공도 처음 이용해봤는데, 단거리는 괜찮았어요.
									온천호텔로 예약하려다가 짧은 일정이라 이 호텔로 예약했는데 대만족이었습니다. 담당자님이 주신 쿠폰도 알차게 썼고,
									여러모로 신경써주셔서 감사했습니다. 투어랜드 다음에도 또 이용할게요!</span>
							</li>
														<li class="realReview"><span class="reviewNo">1</span>
								<span class="reviewTitle">가족여행으로 잘 다녀왔어요!</span>
								<span class="reviewDate">2020.05.15</span>
								<span class="userId">hn****</span>
								<span class="userStar">
									<i class="fas fa-star"></i>
									<i class="fas fa-star"></i>
									<i class="fas fa-star"></i>
									<i class="fas fa-star"></i>
									<i class="far fa-star"></i>
								</span>
							</li>
							<li class="innerReview"><span class="reviewContent">처음
									가는 곳이라 좀 걱정 했는데, 즐겁게 잘 다녀왔습니다. 저가 항공도 처음 이용해봤는데, 단거리는 괜찮았어요.
									온천호텔로 예약하려다가 짧은 일정이라 이 호텔로 예약했는데 대만족이었습니다. 담당자님이 주신 쿠폰도 알차게 썼고,
									여러모로 신경써주셔서 감사했습니다. 투어랜드 다음에도 또 이용할게요!</span>
							</li>
						</ul>
					</div>
				</div>
			</section>
	<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>