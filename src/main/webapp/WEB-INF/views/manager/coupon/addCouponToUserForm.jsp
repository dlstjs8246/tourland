<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>          
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/locale/ko.js"></script>
​<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap-datetimepicker.js">
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/datetimepickerstyle.css" />
</head>
<style>
	h2 { font-weight: bold;
		 padding-bottom: 10px;       
		 border-bottom: 1px solid gray; }       
	.form-group { width: 200px; margin: 20px; float: left; }
	.group { width: 100%;  height:300px; }
	#guide { text-indent: 10px; }
	.info { color: maroon; font-weight: bold; }
	.box-primary { height: 900px; }  
	h3 { font-weight: bold; text-indent: 10px; }  	
	table th, td {text-align: center; }     
	#toAllUSers { margin: 10px 0;}  
	
</style>  
<script>
$(document).ready(function(){      
		 $(".cpTd").mouseover(function(){
			$(this).css("background", "#b0c4de");
		})
		$(".cpTd").mouseout(function(){
			$(this).css("background", "#fff");
		})    
		 $(".cpTd").click(function(){    
			$(".cpTd").off("mouseover");
			$(".cpTd").off("mouseout");
			$(".cpTd").css("background", "#fff");
			$(this).css("background", "#b0c4de");
			var cno = $(this).find(".cno").html();
			$("#couponno").val(cno);
		})   
		
		 $(".urTd").mouseover(function(){
				$(this).css("background", "#b0c4de");
			})
			$(".urTd").mouseout(function(){
				$(this).css("background", "#fff");
			})    
			 $(".urTd").click(function(){    
				$(".urTd").off("mouseover");
				$(".urTd").off("mouseout");
				$(".urTd").css("background", "#fff");
				$(this).css("background", "#b0c4de");
				var uno = $(this).find(".uno").html();
				$("#userno").val(uno);
		})   
		//일단 allUsers input 에 name 삭제 (모든 고객에게 지급하기 클릭 했을 때만 name 생김)
		$("#allUsers").removeAttr("name");
		 $("#toAllUSers").click(function(){ //모든 고객에게 지급 하기 클릭했을 때
			 $("#allUsers").attr("name", "allUsers");//allUsers input에 name 붙여서 String으로 컨트롤러에 들고가기(모든 고객 클릭했는지 아닌지 구별하기 위해서)
			 $(".urTd").css("background", "#fff"); //고객 리스트에서 고객 선택했다면 색깔 없앰
			 
			 
			 alert("모든 고객에게 해당 쿠폰을 지급하시겠습니까?");
		 })
	                 
	});   
	
</script>  
<body>      
<c:if test="${hasCoupon != null }">
	<script>
		alert("고객이 이미 해당 쿠폰을 가지고 있습니다.");
	</script>
</c:if>
	<div class="container">         
		<div class="row">   
		<div class="col-sm-12">
			<div class="box box-primary">
				<div class="box-header">
		 			 <h2>쿠폰 지급</h2>      
		 		 </div>     
		  <p id="guide">쿠폰과 쿠폰을 지급할 고객을 클릭하고 지급 버튼을 클릭하세요.</p>
		  <form class="form-inline" action="${pageContext.request.contextPath }/manager/addCouponToUserForm" method="post">
		  <div class="group">
			      <h3>쿠폰</h3>
				    <div class="box-body">  
				<span class="info"><i class="fas fa-exclamation-circle"></i> 만료된 쿠폰은 표시되지 않습니다.</span>
					<table class="table table-bordered" id="coupon">
						<tr>
							<th>번호</th>
							<th>이름</th>
							<th>발행일자</th>
							<th>만료일자</th>       
							<th>쿠폰내용</th>     
							<th>할인율</th>
						</tr>    
					<c:forEach items="${available }" var="c">
						<tr class="cpTd">
							<td class="cno">${c.cno }</td>
							<td>${c.cname }</td>
							<td><fmt:formatDate value="${c.pdate }" pattern="yyyy-MM-dd"/></td>
							<td><fmt:formatDate value="${c.edate }" pattern="yyyy-MM-dd"/></td>
							<td>${c.ccontent }</td>  
							<td>${c.mrate }%</td>
						</tr>   
					</c:forEach> 
					
					</table>  
				</div>      
		    </div>
		 		  <div class="group">
			      <h3>고객</h3>
				    <div class="box-body">
				    <button id="toAllUSers">모든 고객에게 지급</button>
				    <input type="hidden" id="allUsers" value="allUsers">
					<table class="table table-bordered">
						<tr>
							<th>번호</th>
							<th>이름</th>
							<th>전화번호</th>
							<th>아이디</th>    
						</tr>    
					<c:forEach items="${userList }" var="u">
						<tr class="urTd">
							<td class="uno">${u.userno}</td>
							<td>${u.username }</td>
							<td>${u.usertel }</td>   
							<td>${u.userid }</td>
						</tr>
					</c:forEach> 
					
					</table>
					<input type="hidden" id="couponno" name="cno">
					<input type="hidden" id="userno" name="userno" value="1">  
				</div>      
		    </div>
		     <div class="form-group">   
			      	  <button class="btn btn-primary">지급</button> 
			    </div>  
		  
		    </form>
		    </div>
			</div>                     
		</div>     
	</div>               
</body>
</html>
<%@ include file="../../include/footer.jsp"%>