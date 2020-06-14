<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>          
<meta charset="UTF-8">
</head>
<style>
	h2 { font-weight: bold;
		 padding-bottom: 10px;       
		 border-bottom: 1px solid gray; }       
	.form-group { width: 200px; margin: 20px; float: left; }
	.group { width: 100%;  height: 100px; }
	#guide { text-indent: 10px; }
	.red { color: red; }
	.box-primary { height: 800px; } 
	h3 { text-indent: 10px; font-weight: bold;}	  
	#info { color: maroon; font-weight: bold;}  	              
</style> 
<script>
	$(function(){
		$("#fixed").change(function(){
			if($(this).is(":checked")){
				$("#hiddenInfo").val("1");
			}
		})
		
	})
	
</script>   
<body>      
	<div class="container">         
		<div class="row">     
		<div class="col-sm-12">
			<div class="box box-primary">
				<div class="box-header">
		 			 <h2>공지사항 추가</h2>      
		 		 </div>     
		  <p id="guide">아래의 폼을 작성하고 등록 버튼을 클릭하세요.</p>
		  <form class="form-inline" action="${pageContext.request.contextPath }/manager/addNoticeForm" method="post">
	
		  <div class="group">
			    <div class="form-group">   
			      <label>번호</label>
				     <div class="container">
				     	<input type="text" class="form-control" name="no" readonly="readonly" value="${totalCnt }">
					</div>        
			    </div>  
		    </div>
		      <div class="group">
			    <div class="form-group">   
			      <label><span class="red">*</span>상단 고정 여부</label>
				     <div class="container">
				     <p id="info"><i class="fas fa-question-circle"></i> 상단 고정 : 리스트 상단에 고정시켜 고객에게 더 중요한 공지사항을 먼저 보여줄 수 있습니다.</p>    
				     	 <input type="checkbox" class="form-check-input" id="fixed"> 상단 고정하기
				     	 <input type="hidden" id="hiddenInfo" name="fixed" value="0">
					</div>        
			    </div>  
		    </div>
		  <div class="group">
			    <div class="form-group">   
			      <label><span class="red">*</span>제목</label>
				     <div class="container">
				     	<input type="text" class="form-control" name="title" placeholder="제목을 입력하세요">
				     	<input type="hidden" class="form-control" name="writer" value="투어랜드">
					</div>        
			    </div>  
		    </div>
		    
		    <div class="group">
			    <div class="form-group">   
			      <label><span class="red">*</span>내용</label>
				     <div class="container">
				     	<textarea rows="10" cols="100" name="content" placeholder="내용을 입력하세요"></textarea>
					</div>        
			    </div> 
			<div class="group"></div> 
			<div class="group"></div> 
			<div class="group"></div> 
			   <div class="group">
			    <div class="form-group">   
			      	<button class="btn btn-primary">등록</button> 
			    </div>  
		    </div>
		    </div>
		    
		  </form>
		                       
		</div>     
	</div>      
	</div>  
	</div>              
</body>
</html>
<%@ include file="../../include/footer.jsp"%>