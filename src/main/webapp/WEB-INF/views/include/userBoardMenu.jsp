<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	
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

</style>    
<nav>
	<ul>
		<li><a href="${pageContext.request.contextPath }/customer/tourlandBoardNotice">공지사항</a></li>
		<li><a href="${pageContext.request.contextPath }/customer/tourlandBoardFAQ">FAQ</a></li>
		<li><a href="${pageContext.request.contextPath }/customer/tourlandCustBoard">고객의 소리</a></li>
		<li><a href="${pageContext.request.contextPath }/customer/tourlandPlanBoard">상품 문의 사항</a></li>
	</ul>
</nav>
