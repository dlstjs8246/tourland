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
				$(this).find("img").attr("src",$("#content img").eq(i).attr("src"));
			})
			$("#detail").click(function() {
				location.href = "tourlandProductDetail?pno=${vo.pno}&price=${price}"; 
			})
		})
	</script>
		<section>
				<div id="proBox">
					<h1>${vo.pname}</h1>
					<div id="imgBox">
						<div id="bigImgBox">
							<img src="displayFile/product?filename=${vo.pic}&price=${price}">
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
							<li id="infoPrice">가격 : <span id="price"><fmt:formatNumber value="${price}" pattern="###,###"/></span>원</li>
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
    
					<h2>상품 리뷰 <span id="reviewCnt">${fn:length(list)}</span></h2>
					<div id="reviewWrap">
						<ul>
							<c:forEach var="review" items="${list}" varStatus="s">
							<li class="realReview"><span class="reviewNo">${s.index+1}</span>
								<span class="reviewTitle">${review.reviewTitle}</span>
								<span class="reviewDate"><fmt:formatDate value="${review.regdate}" pattern="yyyy-MM-dd"/></span>
								<span class="userId">${users[s.index].userid}</span>
								<span class="userStar">
									<c:if test="${review.starpoint==0}">
										<i class="far fa-star"></i>
										<i class="far fa-star"></i>
										<i class="far fa-star"></i>
										<i class="far fa-star"></i>
										<i class="far fa-star"></i>
									</c:if>
									<c:if test="${review.starpoint==1}">
										<i class="fas fa-star"></i>
										<i class="far fa-star"></i>
										<i class="far fa-star"></i>
										<i class="far fa-star"></i>
										<i class="far fa-star"></i>
									</c:if>
									<c:if test="${review.starpoint==2}">
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<i class="far fa-star"></i>
										<i class="far fa-star"></i>
										<i class="far fa-star"></i>
									</c:if>
									<c:if test="${review.starpoint==3}">
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<i class="far fa-star"></i>
										<i class="far fa-star"></i>
									</c:if>
									<c:if test="${review.starpoint==4}">
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<i class="far fa-star"></i>
									</c:if>
									<c:if test="${review.starpoint==5}">
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>
										<i class="fas fa-star"></i>  
									</c:if>
								</span>
								<li class="innerReview"><span class="reviewContent">${review.reviewContent}</span></li> 
							</c:forEach>
						</ul>
					</div>
				</div>
				<div style="display : none;" id="content">
					${vo.pcontent}
				</div>
			</section>
	<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>