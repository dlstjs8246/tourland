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
@font-face { font-family: 'GmarketSansBold'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansBold.woff') format('woff'); font-weight: normal; font-style: normal; }
/* 본문 */
div#mainBox {
	width: 1200px;
	margin: 0 auto;
	position: relative;
}
div#couponTitleWrap { width: 100%; height: 350px; }
div#couponTitle { background-image:url("${pageContext.request.contextPath}/resources/images/coupon/couponTitle.jpg");
				  background-position: center center; 
				  background-repeat: no-repeat;
				  height: 200px; 
				  font-size: 30px; text-align: center;
				  }
div#couponTitle h1 { font-size: 70px; padding-top: 20px; text-shadow: 4px 4px 4px gray; }
div#couponTitle h2 { font-size: 25px; text-shadow: 4px 4px 4px gray;}
div#couponTitle h1, div#couponTitle h2 { font-family: 'GmarketSansBold';  }

div.couponBox { width: 400px; height: 450px; float: left; text-align: center; }
div.couponBox button { width: 200px; height: 30px; background: skyblue; border:none; font-size: 17px; border-radius: 10px; font-weight: bold;}
</style>
<body> 
	<div id="container">
	<%@ include file="../../include/userHeader.jsp"%>  
		<section>  
<div id="couponTitleWrap">
				<div id="couponTitle">
					<h1>Coupon & Discount</h1>
					<h2>쿠폰 다운 받고 여행 가자!</h2>
				</div>
			</div>
			<div id="mainBox">
			
			<div id="coupons">
				<div class="couponBox">
					<img src="${pageContext.request.contextPath}/resources/images/coupon/coupon1.jpg">
					<button>쿠폰 다운받기</button>
				</div>
				<div class="couponBox">
					<img src="${pageContext.request.contextPath}/resources/images/coupon/coupon1.jpg">
					<button>쿠폰 다운받기</button>
				</div>
				<div class="couponBox">
					<img src="${pageContext.request.contextPath}/resources/images/coupon/coupon1.jpg">
					<button>쿠폰 다운받기</button>
				</div>
				<div class="couponBox">
					<img src="${pageContext.request.contextPath}/resources/images/coupon/coupon1.jpg">
					<button>쿠폰 다운받기</button>
				</div>
				<div class="couponBox">
					<img src="${pageContext.request.contextPath}/resources/images/coupon/coupon1.jpg">
					<button>쿠폰 다운받기</button>
				</div>
				<div class="couponBox">
					<img src="${pageContext.request.contextPath}/resources/images/coupon/coupon1.jpg">
					<button>쿠폰 다운받기</button>
				</div>
			</div>
				
			</div>
		</section>

		<%@ include file="../../include/userFooter.jsp"%> 
	</div>
</body>
</html>