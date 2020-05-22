<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
	/* #opa { width: 100%; height: 100%; background: gray; opacity: 0.2; } */
	
	table .table table-bordered th,td,th{
       text-align: center;
    }
    .popupList:hover {
    	background-color : lightgrey;
    }

    #formTable td{
       height: 95px;
       vertical-align: middle;
    }
    
    #popup1{
      margin-left:100px;
      float:left;
      text-align:center;
      width:560px;
      height: 600px;
      position: relative;
    }
    
    #popup2{
      margin-left:100px;
      float:left;
      text-align:center;
      width:560px;
      position: relative;
    }
    
    #previewPopup1{
    width:400px;
    box-shadow: 0 0 8px black;
    position: absolute;
    left:85px;
    top:50px;
  }
  
   #previewPopup2{
    width:400px;
    box-shadow: 0 0 8px black;
    position: absolute;
    left:85px;
    top:50px;
  }
  
   p.popupClose{
     width:400px;
     position: absolute;
     top:400px;
     left:0;
     padding:5px;
     box-shadow: 0 0 8px black;
   }
   input.expireCK{
     margin-right:10px;
     margin-top:13px;
   }
   button.popupBtnClose{
     margin-left:20px;
   }


</style>
<!-- <div id="opa">dummy</div> -->
<div class="content">	
	<div class="row">
		<div class="col-sm-12" style="heigth:800px;">    
			<div class="box box-primary">      
				<div class="box-header">
					<h2 class="box-title">팝업  관리</h2>
				</div>
				<div class="box-body">
					<select name="searchType" id="searchType" style="width:200px; height: 25px;">
						<option value="n" ${cri.searchType ==null?'selected':''}>-----</option>
						<option value="popupTitle" ${cri.searchType =='popupTitle'?'selected':''}>팝업 타이틀</option>
						<option value="popupContent" ${cri.searchType =='popupContent'?'selected':''}>팝업 설명</option>

					</select>
					<input type="text" name="keyword" id="keywordInput">
					<button id="btnSearch">Search</button>
				</div>
				<div class="box-body">
					<button id="btnRegister">추가</button>
				</div>
				<div class="box-body">
					<table class="table table-bordered" id="formTable">
						<tr>
							<th style="width:100px;">팝업 번호</th>
							<th>썸네일</th>
							<th style="width:15%">팝업명</th>
							<th style="width:35%">팝업 설명</th>
							<th style="width:8%">시작 날짜</th>
							<th style="width:8%">종료 날짜</th>
					        <th>상세보기</th>
					        <th>1번 팝업 미리보기</th>
					        <th>2번 팝업 미리보기</th>
						</tr>     
						<!-- 반복 돌면서 list가져오기 -->
						<c:forEach var="popupList" items="${list}">
						    <tr data-click="${popupList.no }" class="popupList"> 
						    <td>${popupList.no }</td>
						    <td><img src="displayFile/popup?filename=${popupList.pic }" style="width:95px; height:95px;" ></td>
						    <td>${popupList.title }</td>
						    <td>${popupList.content }</td>
						    <td><fmt:formatDate value="${popupList.startdate}" pattern="yyyy-MM-dd"/></td>
						    <td><fmt:formatDate value="${popupList.enddate}" pattern="yyyy-MM-dd"/></td>
						    <td><button style="background:lightskyblue; border:none;" class="toPopupDetail" data-click="${popupList.no }">상세보기</button></td>
						    <td><input type="checkbox" class="popup1Checkbox" value="${popupList.no }" ><button style="margin-left:25px; height: 23px;" class="setPopup1" value="${popupList.no }">설정</button></td>
						    <td><input type="checkbox" class="popup2Checkbox" value="${popupList.no }" ><button style="margin-left:25px; height: 23px;" class="setPopup2" value="${popupList.no }">설정</button></td>
						    </tr>
						</c:forEach>	
					</table>      
				</div>
		        <div class="box-footer">
	             <%--   --%>
	              <!--  부트 스트랩으로 사용  -->
	              <div class='text-center'>
	                   <ul class="pagination">
	                      <c:if test="${pageMaker.prev == true }">
	                          <li><a href="${pageContext.request.contextPath}/manager/popupMngList?page=${pageMaker.startPage -1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&laquo;</a></li>
	                       </c:if>
	                      <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
	                         <li class="${pageMaker.cri.page == idx?'active':''}"><a href="${pageContext.request.contextPath}/manager/popupMngList?page=${idx}&searchType=${cri.searchType}&keyword=${cri.keyword}"> ${idx }</a></li>
	                       </c:forEach>
	                       <!--  언제나 나오는 게 아니니까  -->
	                       <c:if test="${pageMaker.next == true }">
	                          <li><a href="${pageContext.request.contextPath}/manager/popupMngList?page=${pageMaker.endPage +1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&raquo;</a></li>
	                       </c:if>
	                   </ul>
	               </div>
	               <div class="box-body" id="mainPopupPreview" >
	                   <!-- 팝업 미리보기 -->
	                   <div id="popup1" style=" margin-left:10%;">
	                        <p>1번 팝업</p>
	                        <c:if test="${popup1 == null }">
	                            <div id="previewPopup1">
	                              <img src="${pageContext.request.contextPath}/resources/images/event1.jpg" style="width:400px; height:400px;" id="popup1img">
	                              <p class="popupClose" style="background:black;">
						          <input type="checkbox" class="expireCK">
						          <label id="expireCK" style="color:white">3일동안 이 창열지 않기</label> <!-- for -->
						          <button class="popupBtnClose">닫기</button>
						          </p>
	                            </div>
	                        </c:if>
	                        <c:if test="${popup1 != null }">
	                        <div id="previewPopup1">
	                        <img src="displayFile/popup?filename=${popup1}" style="width:400px; height:400px;" id="popup1img">
	                             <p class="popupClose" style="background:black;">
						          <input type="checkbox" class="expireCK">
						          <label id="expireCK" style="color:white">3일동안 이 창열지 않기</label> <!-- for -->
						          <button class="popupBtnClose">닫기</button>
						         </p>
	                        </div>
	                        </c:if>
	                   </div>
	                    <div id="popup2">
		                   <p>2번 팝업</p>
		                   <c:if test="${popup2 == null }">
		                     <div id="previewPopup2">
	                            <img src="${pageContext.request.contextPath}/resources/images/event2.jpg" style="width:400px; height:400px;" id="popup2img">
	                              <p class="popupClose" style="background:black;">
						          <input type="checkbox" class="expireCK">
						          <label id="expireCK" style="color:white">3일동안 이 창열지 않기</label> <!-- for -->
						          <button class="popupBtnClose">닫기</button>
						          </p>
						      </div>
	                        </c:if>
	                        <c:if test="${popup2 != null }">
	                        <div id="previewPopup2">
		                     <img src="displayFile/popup?filename=${popup2}" style="width:400px; height:400px;" id="popup2img">
		                      <p class="popupClose" style="background:black;">
						          <input type="checkbox" class="expireCK">
						          <label id="expireCK" style="color:white">3일동안 이 창열지 않기</label> <!-- for -->
						          <button class="popupBtnClose">닫기</button>
						       </p>
		                    </div>
		                   </c:if>
	            		</div>
	            		
				   </div>
	           </div>
			</div>         
		</div>
	</div>
</div>

<script>
	$("#btnSearch").click(function(){
		var searchType = $("#searchType").val();
		var keyword = $("#keywordInput").val();
		location.href = "${pageContext.request.contextPath}/manager/popupMngList?searchType="+searchType+"&keyword="+keyword;
		//searchBoardController의 listPage GET 으로 받음 
		
	})
	
	$("#btnRegister").click(function(){
		location.href = "${pageContext.request.contextPath}/manager/popupRegister";
	})

	
	$(".toPopupDetail").click(function(){
		var no = $(this).attr("data-click");
		var searchType = "${cri.searchType}";
		var keyword = "${cri.keyword}";
		location.href = "${pageContext.request.contextPath}/manager/popupDetailForm?no="+no+"&page=${pageMaker.cri.page}&searchType="+searchType+"&keyword="+keyword;
	})
	
	//팝업1 체크박스 체크를 하면 
	$(".popup1Checkbox").change(function(){

		if($(this).is(":checked")){

		   var popupno = $(this).val();  //alert(popupno);	
		 //ajax로 이미지 경로 받아오기 
		 $.ajax({
			url:"getPopupPicPath/"+popupno,
			type:"get",
			dataType:"text",
			success:function(res){
				console.log(res);
				//alert(res);
				if(res != "fail"){
				     $("#popup1img").attr("src","displayFile/popup?filename="+res);
				  }
					
				}
			})
		}
	})
	//팝업2 체크박스 체크를 하면 
	$(".popup2Checkbox").change(function(){

		if($(this).is(":checked")){
		   var popupno = $(this).val();  //alert(popupno);	
		 //ajax로 이미지 경로 받아오기 
		 $.ajax({
			url:"getPopupPicPath/"+popupno,
			type:"get",
			dataType:"text",
			success:function(res){
				console.log(res);
				if(res != "fail"){
				     $("#popup2img").attr("src","displayFile/popup?filename="+res);
				  }
					
				}
			})
		}
	})
	

	
	//설정 버튼을 누르면
	$(".setPopup1").click(function(){
		var no = $(this).val(); //alert(no);
		$.ajax({
			url:"setPopup/"+no+"/popup1",
			type:"get",
			dataType:"text",
			success:function(res){
				console.log(res);
				
				if(res == "success"){
					alert("팝업설정이 완료되었습니다.");
				}
					
			}
		})

	})
	$(".setPopup2").click(function(){
		var no = $(this).val(); //alert(no);
		$.ajax({
			url:"setPopup/"+no+"/popup2",
			type:"get",
			dataType:"text",
			success:function(res){
				console.log(res);
				
				if(res == "success"){
					alert("팝업설정이 완료되었습니다.");
				}
					
			}
		})

	})


	
</script>

<%@ include file="../../include/footer.jsp"%>