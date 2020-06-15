<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../../include/userHeader.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>    
	/* 본문 */
	section { width: 1200px; height: 800px; margin: 0 auto;}
	section nav { width: 200px;    
				  background: #f4f4f4;
				  height: 100%;
				  float: left; }			  
	section nav ul li { height: 30px;    
						padding: 10px; }							
	section nav ul li a { display: block;
						  text-indent: 10px; 
						  line-height: 30px; }
	section nav ul li:hover { background: #ff7f00; }						  				  	
	
	section div#writeReview { width:1000px; height: 100%; 
							  margin-left: 200px;
							 }
	section div#writeReview h1 { width: 200px;
								 height: 30px;  
							     padding: 20px;
							     border-bottom: 1px solid #929292; }							  
	section div#writeReview form { width: 500px; 
								   margin: 0 auto;
								  }
	section div#writeReview label { width: 120px;
								    float: left;   
								    font-weight: bold;}
	section div#writeReview p { height: 60px; }
	section div#writeReview input { width: 250px; height: 30px; 
									border: none; border-bottom: 1px solid #929292;}
	.red { color: red;}
	section div#writeReview #btns button { width: 200px; height: 30px; 
										   border: none; }

	section div#writeReview #withdraw { background: maroon; color: #fff; }
	
	section div#writeReview #inputs { height:30px; line-height: 30px;}
	section div#writeReview #inputs input { width: 200px; height: 30px; 
										    border: none; 
										    }
	#inputs input#submit { background: steelblue; color: #fff; margin-right: 30px; }		
	#info { font-size: 13px; color: #929292; 
			margin-left: 10px;  }
   
	/* 추가한 부분  */
	div#writeReview p#long { height:270px; }	
	div#writeReview textarea { overflow: scroll;}  		
	#proImgBox { height: 20px;}
	div#proImgBox #proTitle { height:30px; font-weight: bold; color: maroon;}   
</style>
<script>

	$(function(){
		$("#cancel").click(function(){
			location.href="tourlandMyReserv";
		})  
		switch($("#star").val()) {
		case "1":
			$(".s1").addClass("fas fa-star s1");
			break;
		case "2":
			$(".s1").addClass("fas fa-star s1");
			$(".s2").addClass("fas fa-star s2");
			break;
		case "3":
			$(".s1").addClass("fas fa-star s1");
			$(".s2").addClass("fas fa-star s2");
			$(".s3").addClass("fas fa-star s3");
			break;
		case "4":
			$(".s1").addClass("fas fa-star s1");
			$(".s2").addClass("fas fa-star s2");
			$(".s3").addClass("fas fa-star s3");
			$(".s4").addClass("fas fa-star s4");
			break;
		case "5":
			$(".s1").addClass("fas fa-star s1");
			$(".s2").addClass("fas fa-star s2");
			$(".s3").addClass("fas fa-star s3");
			$(".s4").addClass("fas fa-star s4");
			$(".s5").addClass("fas fa-star s5");
			break;
		}
	})   
</script> 
<body>    
	
		<section>
			<%@ include file="../../include/userMyPageMenu.jsp"%>   
			
				<div id="writeReview">
				<h1>리뷰 작성</h1>
				<span id="info">고객님의 소중한 리뷰를 작성해주세요.</span>
					<form action="tourlandAddMyReview" method="post">
						<p>
							<label>번호</label>     
							<span>RV00${review.rno}</span>  
						</p>
						<p>
							<label>고객명</label>
							<input type="text" value="${user.username}" readonly="readonly">
						</p>
						<p>
							<label>상품명</label>
							<div id="proImgBox">
							<p id="proTitle">${product.pname}</p>
							</div>
						</p>	
						<p>
							<label><span class="red">*</span> 리뷰 제목</label>
							<input type="text" readonly="readonly" name="reviewTitle" value="${review.reviewTitle}" >
						</p>
						<p id="long">
							<label><span class="red">*</span> 리뷰 내용</label>    
							<textarea rows="10" cols="60" readonly="readonly" name="reviewContent">${review.reviewContent}</textarea>
						</p>
						<p>
						<label><span class="red">*</span> 별점</label>
									<i class="far fa-star s1"></i>
									<i class="far fa-star s2"></i>
									<i class="far fa-star s3"></i>   
									<i class="far fa-star s4"></i>
									<i class="far fa-star s5"></i>
						</p>
						<input type="hidden" name="starpoint" id="star" value="${review.starpoint}">
						<p id="inputs">
							<input type="reset" id="cancel" value="돌아가기"  style="cursor:pointer">
						</p>
					</form>
				</div>
		
		</section>
		
		<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>