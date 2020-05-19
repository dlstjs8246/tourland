<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath }/resources/css/boardStyle.css" rel="stylesheet" type="text/css" />
<style>
  section nav ul li:nth-child(3) {
	background: mistyrose;
}
 #datailRealContent{
   height: 550px;
 }
 #btnReturnToList{
    width:100px;
    height:30px;
    border:none;
    background: mistyrose;
    margin-bottom:10px; 
   
  }
</style>
</head>
<body>   
	<%@ include file="../../include/userHeader.jsp"%>
		<section>
		<%@ include file="../../include/userBoardMenu.jsp"%>   
		    <div id="detailDiv">
				<div>
				  <br>
				  <p>고객님들의 소중한 의견입니다. </p>
				</div>
				<div id="detailContent">
				   <ul id="datailUl">
				   <li> ${custBoardVO.no } </li>
				   <li class="detailLi"> ${custBoardVO.title } </li>
				   <li> ${custBoardVO.writer }</li>
				   <li> <fmt:formatDate value='${custBoardVO.regdate }' pattern="yyyy-MM-dd"/> </li>
				   </ul>
				   <div id="datailRealContent">
				       ${custBoardVO.content}
				   </div>
				   
				</div>
				<div class="box-footer">
							 <button type="button" class="btn btn-primary" id="btnReturnToList">목록으로</button>
				</div>
				
		     </div>
		     
		</section>
<script>
	$("#btnReturnToList").click(function(){
		location.href = "tourlandCustBoard";
	 })
	
</script>
		<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>