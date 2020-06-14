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
@font-face { font-family: 'TmonMonsori'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/TmonMonsori.woff') format('woff'); font-weight: normal; font-style: normal; }
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

.couponBox { position: relative; }
.cTitle { width: 300px; position: absolute; top: 100px; left: 50px; font-size: 45px;
		 text-shadow: 2px 2px 2px #000;
		 font-family: 'TmonMonsori';}

div.couponBox { width: 400px; height: 500px; float: left; text-align: center; }
div.couponBox button { width: 200px; height: 30px; background: skyblue; border:none;
					   font-size: 17px; border-radius: 10px; font-weight: bold;}
</style>
<%@ include file="../../include/userHeader.jsp"%>  
<script>
	$(function(){
		$(".getCoupon").click(function(){
			var cno = $(this).parent().find("input").val();
			location.href = "getCoupon?cno="+cno;
		})
	})
</script>
<c:if test="${hasCoupon != null }">
	<script>
		alert("이미 해당 쿠폰을 가지고 있습니다.");
	</script>
</c:if>
<c:if test="${success != null }">
	<script>
		alert("쿠폰이 다운로드 되었습니다.");
	</script>
</c:if>
<c:if test="${fail != null}">
	<script>
		alert("로그인을 먼저 해주세요.");
	</script>
</c:if>
<body>
   
<div id="container">	
<section>  
<div id="couponTitleWrap">
				<div id="couponTitle">
					<h1>Coupon & Discount</h1>
					<h2>쿠폰 다운 받고 여행 가자!</h2>
				</div>
			</div>
			<div id="mainBox">
			
			<div id="coupons">
			<c:forEach items="${availableList }" var="c">
				<div class="couponBox">
						<img src="${pageContext.request.contextPath}/resources/images/coupon/coupon2.jpg">
						<p class="cTitle">${c.cname }</p>
						<p>~ <fmt:formatDate value="${c.edate }" pattern="yy/MM/dd"/> 까지 </p>
						<input type="hidden" name="cno" value="${c.cno}">
						<button class="getCoupon">쿠폰 다운받기</button>
				</div>
			</c:forEach>
				
				
			</div>
				
			</div>
		</section>

		<%@ include file="../../include/userFooter.jsp"%> 
	</div>
</body>
</html>