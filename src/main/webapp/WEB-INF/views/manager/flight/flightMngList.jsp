<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
	table th, td { text-align: center;}
	.first { color: maroon; font-weight: bold;}
	.bus { color: steelblue; font-weight: bold;}
	.eco { color: goldenrod; font-weight: bold;}
	#info { display: block;
		    width: 500px;
		    font-size: 12px; 
		    text-indent: 15px; 
		    color: maroon;
		    font-weight: bold; }
	#datepicker { width: 200px; }    
	#searchType { width: 155px; height: 26px; }    
	#dateSearch { display: block; width: 210px; float: left; }
	#btnDateSearch { margin-top: 23px; }
	#detailInfo { color: red;  font-size: 13px; }    
</style>
<link
	href="${pageContext.request.contextPath}/resources/plugins/datepicker/datepicker3.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/datepicker/bootstrap-datepicker.js"></script>        
<script>

function getFormatDate(date){
    var year = date.getFullYear()+"-";              //yyyy
    var month = (date.getMonth()+1)+"-";          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '' + month + '' + day;
}

//국내 항공편만 검색하는 ajax
//page를 넣으면 해당 페이지 출력
function getDomList(page){
	var searchType = "${cri.searchType}";
	var keyword = "${cri.keyword}";
	$.ajax({   
		url : "flightDomList/"+page,
		type : "get", 
		dataType : "json",
		data : {searchType : searchType, keyword : keyword},
		success: function(rs){                  
			console.log(rs);
			$(rs.list).each(function(i, obj){
				console.log(obj);
			})
			 $(".forEachTr").remove();
			 $(rs.list).each(function(i, obj) {
				 var date1 = new Date(obj.ddate);
				 var date2 = new Date(obj.rdate);
				 
				 var ddate = getFormatDate(date1);
				 var rdate = getFormatDate(date2);
				 
				 $tr = $("<tr>").addClass("forEachTr");
				 
				 $td1 = $("<td>").html(obj.no);
				 $td2 = $("<td>");
				 $td3 = $("<td>").html(obj.dlocation);
				 $td4 = $("<td>").html(obj.rlocation);
				 $td5 = $("<td>").html(ddate);
				 $td6 = $("<td>").html(rdate);
				 if(obj.ldiv==0){
					 $td7 = $("<td>해외</td>");
				 }else {
					 $td7 = $("<td>국내</td>");
				 }
				 $td8 = $("<td>").html(obj.capacity);
				 if(obj.seat=='F'){
					 $td9 = $("<td>").html("First-Class").addClass("first");
				 }else if(obj.seat=='B'){
					 $td9 = $("<td>").html("Business-Class").addClass("bus");
				 }else {
					 $td9 = $("<td>").html("Economy-Class").addClass("eco");
				 }
				 $td10 = $("<td>").html(obj.price);
				 
				 $a = $("<a>").attr("href", "${pageContext.request.contextPath }/manager/flightDetail?no="+obj.no).html(obj.ano);
				 
				 $td2.append($a);
				 $tr.append($td1);
				 $tr.append($td2);
				 $tr.append($td3);
				 $tr.append($td4);
				 $tr.append($td5);
				 $tr.append($td6);
				 $tr.append($td7);
				 $tr.append($td8);
				 $tr.append($td9);
				 $tr.append($td10);
				 
				 $("table").append($tr);
				 
			}) 
		 	$(".pagination").empty();
				
				if(rs.pageMaker.prev==true){
					var $li1 = $("<li>");
					var $a1 = $("<a>").attr("href", "flightMngList?page=${pageMaker.startPage -1 }&searchType=${cri.searchType}&keyword=${cri.keyword}" ).html("&laquo");
					$li1.append($a1);
				}
				
				
				if(rs.pageMaker.next==true){
					var $li3 = $("<li>");
					var $a3 = $("<a>").attr("href", "flightMngList?page=${pageMaker.startPage -1 }&searchType=${cri.searchType}&keyword=${cri.keyword}" ).html("&laquo");

					$li3.append($a3);
				}
				
				for(var j = rs.pageMaker.startPage; j<= rs.pageMaker.endPage; j++){
					$li2 = $("<li>");
					$a2 = $("<a>").html(j).addClass("domList");
					if(j==rs.pageMaker.cri.page) {
						$li2.addClass("active");
					}
					$li2.append($a2);
					
				
				$(".pagination").append($li1);
				$(".pagination").append($li2);
				$(".pagination").append($li3);
			}   
		}   
	})   
}

//국내 항공편 검색하는 버튼
	$(function(){
		$("#listAll").css("background", "goldenrod");
		//datePicker
		$("#datepicker").datepicker({   
			format : "yyyy-mm-dd",
			autoclose : true    
		}).datepicker("setDate", 'now');
		$("#dom").click(function(){
			$("#ab").css("background", "rgb(239,239,239)");
			$("#listAll").css("background", "rgb(239,239,239)");
		
			$(this).css("background", "goldenrod");
			alert("국내 항공편이 검색되었습니다.");
			 getDomList(1); 
		})
//국내 항공편 검색되었을 때 아래쪽에 있는 페이지 번호 a 태그 부분
		$(document).on("click", ".domList", function(){
			var page = $(this).html();
			getDomList(page);
		})
//해외 항공편 검색하는 버튼
		$("#ab").click(function(){
			$("#dom").css("background", "rgb(239,239,239)");
			$("#listAll").css("background", "rgb(239,239,239)");
		
			$(this).css("background", "goldenrod");
			alert("해외 항공편이 검색되었습니다.");
			getAbroadList(1); 
		})
//해외 항공편 검색되었을 때 아래쪽에 있는 페이지 번호 a 태그 부분
		$(document).on("click", ".abroadList", function(){
			var page = $(this).html();
			getAbroadList(page);
		})
//전체 리스트 보기
		$("#listAll").click(function(){      
			$("#ab").css("background", "rgb(239,239,239)");
			$("#dom").css("background", "rgb(239,239,239)");
		
			$(this).css("background", "goldenrod");
			alert("전체 리스트가 검색되었습니다.");
			location.href = "${pageContext.request.contextPath}/manager/flightMngList";
		})
//검색 버튼
		$("#btnSearch").click(function(){
			var searchType = $("#searchType").val();
			var keyword = $("#keywordInput").val();
			location.href = "flightMngList?searchType="+searchType+"&keyword="+keyword;
			//searchBoardController의 listPage GET 으로 받음 
			
		})
//날짜 검색 버튼
		$("#btnDateSearch").click(function(){
			alert("선택한 날짜로 검색 되었습니다");
			var searchType = "date";
			var keyword = $("#datepicker").val();
			location.href = "flightMngList?searchType="+searchType+"&keyword="+keyword;
			//searchBoardController의 listPage GET 으로 받음 
			
		})		
		
		
	})
	
//해외 항공편만 검색하는 ajax
//page를 넣으면 해당 페이지 출력
	function getAbroadList(page){
		var searchType = "${cri.searchType}";
		var keyword = "${cri.keyword}";
		$.ajax({   
			url : "flightAbroadList/"+page,
			type : "get", 
			dataType : "json",
			data : {searchType : searchType, keyword : keyword},
			success: function(rs){  
				 $(".forEachTr").remove();
				 $(rs.list).each(function(i, obj) {
					 var date1 = new Date(obj.ddate);
					 var date2 = new Date(obj.rdate);
					 
					 var ddate = getFormatDate(date1);
					 var rdate = getFormatDate(date2);
					 
					 $tr = $("<tr>").addClass("forEachTr");
					 
					 $td1 = $("<td>").html(obj.no);
					 $td2 = $("<td>");
					 $td3 = $("<td>").html(obj.dlocation);
					 $td4 = $("<td>").html(obj.rlocation);
					 $td5 = $("<td>").html(ddate);
					 $td6 = $("<td>").html(rdate);
					 if(obj.ldiv==0){
						 $td7 = $("<td>해외</td>");
					 }else {
						 $td7 = $("<td>국내</td>");
					 }
					 $td8 = $("<td>").html(obj.capacity);
					 if(obj.seat=='F'){
						 $td9 = $("<td>").html("First-Class").addClass("first");
					 }else if(obj.seat=='B'){
						 $td9 = $("<td>").html("Business-Class").addClass("bus");
					 }else {
						 $td9 = $("<td>").html("Economy-Class").addClass("eco");
					 }
					 $td10 = $("<td>").html(obj.price);
					 
					 $a = $("<a>").attr("href", "${pageContext.request.contextPath }/manager/flightDetail?no="+obj.no).html(obj.ano);
					 
					 $td2.append($a);
					 $tr.append($td1);
					 $tr.append($td2);
					 $tr.append($td3);
					 $tr.append($td4);
					 $tr.append($td5);
					 $tr.append($td6);
					 $tr.append($td7);
					 $tr.append($td8);
					 $tr.append($td9);
					 $tr.append($td10);
					 
					 $("table").append($tr);
					 
				}) 
			 	$(".pagination").empty();
					
					if(rs.pageMaker.prev==true){
						var $li1 = $("<li>");
						var $a1 = $("<a>").attr("href", "flightMngList?page=${pageMaker.startPage -1 }&searchType=${cri.searchType}&keyword=${cri.keyword}" ).html("&laquo");
						$li1.append($a1);
					}
					
					
					if(rs.pageMaker.next==true){
						var $li3 = $("<li>");
						var $a3 = $("<a>").attr("href", "flightMngList?page=${pageMaker.startPage -1 }&searchType=${cri.searchType}&keyword=${cri.keyword}" ).html("&laquo");

						$li3.append($a3);
					}
					
					for(var j = rs.pageMaker.startPage; j<= rs.pageMaker.endPage; j++){
						$li2 = $("<li>");
						$a2 = $("<a>").html(j).addClass("abroadList");
						if(j==rs.pageMaker.cri.page) {
							$li2.addClass("active");
						}
						$li2.append($a2);
						
					
					$(".pagination").append($li1);
					$(".pagination").append($li2);
					$(".pagination").append($li3);
				}   
			}   
		})   
	}	
	    
   

</script>

<div class="content">	
	<div class="row">
		<div class="col-sm-12">    
			<div class="box box-primary">      
				<div class="box-header">
					<h2 class="box-title">항공 관리</h2>
				</div>
				<div class="box-body">
				<!-- 검색 작업에서 유지될 데이터 
					1. 현재 페이지의 번호     
					2. 페이지당 보여지는 데이터의 수
					3. 검색의 종류
					4. 검색의 키워드
				 -->
					<select name="searchType" id="searchType">
						<option value="n" ${cri.searchType ==null?'selected':''}>선택하세요</option>
						<option value="no" ${cri.searchType =='no'?'selected':''}>번호</option>
						<option value="ano" ${cri.searchType =='ano'?'selected':''}>항공기 번호</option>
						<option value="rloca" ${cri.searchType =='rloca'?'selected':''}>도착 지역</option>
					</select>
					<input type="text" name="keyword" id="keywordInput" placeholder="검색어를 입력하세요">
					<button id="btnSearch">Search</button>
				</div>
				<p id="info"> <i class="fas fa-info-circle"> 도착 지역 : 제주(제주 공항), 베이징(베이징 공항), 도쿄(나리타 공항)</i></p>  
				<div class="box-body">
					<span id="dateSearch"><i class="far fa-calendar-alt"></i> 출발일 검색 <input type="text" class="form-control" id="datepicker"></span>
					 <button id="btnDateSearch">Search</button> 
				</div>
				<div class="box-body">
					<button type="button" class="btn btn-info">항공편 추가</button>
					<button type="button" class="btn" id="dom">국내</button>
					<button type="button" class="btn" id="ab">해외</button>
					<button type="button" class="btn" id="listAll">전체 리스트 보기</button>
				</div>
				
				<div class="box-body">
				<p><i class="fas fa-info-circle" id="detailInfo"> 항공편을 클릭하면 해당 항공편의 출발/도착편을 함께 확인하실 수 있습니다.</i></p>
					<table class="table table-bordered">
						<tr>
							<th>번호</th>
							<th>항공기 번호</th>
							<th>출발 지역</th>
							<th>도착 지역</th>
							<th>출발 일시</th>
							<th>도착 일시</th>
							<th>장소 구분</th>
							<th>허용 인원</th>
							<th>좌석</th>
							<th>가격</th>
						</tr> 
						<c:forEach items="${flightList }" var="f">   
							<tr class="forEachTr">
								<td>${f.no }</td>
								<td><a href="${pageContext.request.contextPath }/manager/flightDetail?no=${f.no}&page=${cri.page}">${f.ano }</a></td>
								<td>${f.dlocation }</td>
								<td>${f.rlocation }</td>
								<td><fmt:formatDate value="${f.ddate }" pattern ="yyyy-MM-dd"/></td>
								<td><fmt:formatDate value="${f.rdate }" pattern ="yyyy-MM-dd"/></td>
								<c:if test="${f.ldiv==0 }">
									<td>해외</td>
								</c:if>
								<c:if test="${f.ldiv==1 }">
									<td>국내</td>
								</c:if>
								<td>${f.capacity }</td>
								<c:if test="${f.seat =='F'}">
									<td class="first">First-Class</td>
								</c:if>
								<c:if test="${f.seat =='B'}">
									<td class="bus">Business-Class</td>
								</c:if>
								<c:if test="${f.seat =='E'}">
									<td class="eco">Economy-Class</td>
								</c:if>
								<td>${f.price }</td>
							</tr>
						</c:forEach>   
					</table>      
				</div>  
			<div class="box-footer">
					<div class="text-center">
						<ul class="pagination">
							<c:if test="${pageMaker.prev == true }">
								<li><a href="flightMngList?page=${pageMaker.startPage -1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&laquo;</a></li>
							</c:if>
							<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
								<li class="${pageMaker.cri.page == idx ?'active':''}"><a href="flightMngList?page=${idx}&searchType=${cri.searchType}&keyword=${cri.keyword}">${idx }</a></li>
								<!-- 주소의 시작이 /로 시작하지 않고 localhost:8080..으로 시작하면 맨 마지막 것만 바꿔주면됨 -->
							</c:forEach>
							<c:if test="${pageMaker.next == true }">
								<li><a href="flightMngList?page=${pageMaker.endPage +1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&raquo;</a></li>
							</c:if>
						</ul>
					</div>  
				</div> 
			</div>         
		</div>
	</div>
</div>

<script>
	
	$("#btnRegister").click(function(){
		location.href = "register";
	})
	
	$(".btn-info").click(function(){
		location.href = "addFlightForm";
	})
</script>

<%@ include file="../../include/footer.jsp"%>