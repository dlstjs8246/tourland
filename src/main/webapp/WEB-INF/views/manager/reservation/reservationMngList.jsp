<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
	table th, td { text-align: center;}    
	.modalbtn { width: 80px; height: 30px; font-size: 14px; line-height: 0px; text-align: center; padding: 5px;}
	.red { color: red;font-weight: bold; }
	.blue { color: steelblue; font-weight: bold;}   
	.yellow { color: goldenrod;font-weight: bold;}
	h4 { font-weight: bold;}
	.hiddenuserno { display: none;}
	.hiddenrno { display: none;}
</style>     
<script>
	
	function reservationDetail(userno, pno, rno){
		
	
		$.ajax({
			url : "reservationDetail",
			type : "get",
			dataType : "json",
			data : {userno:userno, pno:pno},
			success : function(rs){
				console.log(rs);
				$(".remove").remove();
				 $(rs.list).each(function(i, obj) {
					 $(".hiddenrno").html(rno);
					 //고객정보
					 // 생년월일 (밀리세컨드)받아와서 날짜 객체로 세팅 
					 var userbirth = new Date(obj.userno.userbirth);
					 
					 var $uttr = $("<tr>");
					 var $uttd1 = $("<td>").html(obj.userno.userno);
					 var $uttd2 = $("<td>").html(obj.userno.username);
					 //yyyy-MM-dd 형태로 포맷
					 var $uttd3 = $("<td>").html(getFormatDate(userbirth));
					 if(obj.userno.userpassport==null){
						 var $uttd4 = $("<td>").addClass("red").html("여권 미등록");
					 }else{
						 var $uttd4 = $("<td>").addClass("red").html(obj.userno.userpassport);
					 }
					
					 var $uttd5 = $("<td>").html(obj.userno.userid);
						 
					 $uttr.addClass("remove").append($uttd1).append($uttd2).append($uttd3).append($uttd4).append($uttd5);
					 
					 $("#userTable").append($uttr);
					 
					 //항공 정보
					 
					
					 
					
					 
					 for(var i =0; i<obj.product.air.length; i++){
						 var addate = new Date(obj.product.air[i].ddate);
						 var ardate = new Date(obj.product.air[i].rdate); 
						 var addate_r = new Date(obj.product.air[i].ddate);
						 var ardate_r = new Date(obj.product.air[i].rdate);
						 
							 if(obj.product.air[i].dlocation == "ICN"){//출발편일 경우
							 var $adttd1 = $("<td>").html(obj.product.air[i].no);
							 var $adttd2 = $("<td>").html(obj.product.air[i].ano);
							 var $adttd3 = $("<td>").html(obj.product.air[i].dlocation);
							 var $adttd4 = $("<td>").html(obj.product.air[i].rlocation);
							 var $adttd5 = $("<td>").html(getFormatDate(addate));
							 var $adttd6 = $("<td>").html(getFormatDate(ardate));
							 var $adttd7 = $("<td>").html(obj.product.air[i].capacity);
							 var $adttd8 = $("<td>").html(obj.product.air[i].seat);
							 var $adttd9 = $("<td>").html(obj.product.air[i].price);
							 
							 var $adttr = $("<tr>").addClass("remove").append($adttd1).append($adttd2).append($adttd3).append($adttd4).append($adttd5).append($adttd6).append($adttd7).append($adttd8).append($adttd9);
							 $("#airdTable").append($adttr);
							 
						 }else{//도착편일 경우
							 var $adttd1 = $("<td>").html(obj.product.air[i].no);
							 var $adttd2 = $("<td>").html(obj.product.air[i].ano);
							 var $adttd3 = $("<td>").html(obj.product.air[i].dlocation);
							 var $adttd4 = $("<td>").html(obj.product.air[i].rlocation);
							 var $adttd5 = $("<td>").html(getFormatDate(addate_r));
							 var $adttd6 = $("<td>").html(getFormatDate(ardate_r));
							 var $adttd7 = $("<td>").html(obj.product.air[i].capacity);
							 var $adttd8 = $("<td>").html(obj.product.air[i].seat);
							 var $adttd9 = $("<td>").html(obj.product.air[i].price);
							 
							 var $adttr = $("<tr>").addClass("remove").append($adttd1).append($adttd2).append($adttd3).append($adttd4).append($adttd5).append($adttd6).append($adttd7).append($adttd8).append($adttd9);
							 $("#airrTable").append($adttr);
						 }
					 }
					 
					 
					 //호텔
					 for(var i =0; i<obj.product.hotel.length; i++){
						 var chkin = new Date(obj.product.hotel[i].checkin);
						 var chkout = new Date(obj.product.hotel[i].checkout);
						 
						 var $htd1 = $("<td>").html(obj.product.hotel[i].no);
						 var $htd2 = $("<td>").html(obj.product.hotel[i].hname);
						 var $htd3 = $("<td>").html(obj.product.hotel[i].haddr);
						 var $htd4 = $("<td>").html(getFormatDate(chkin));
						 var $htd5 = $("<td>").html(getFormatDate(chkout));
						 var $htd6 = $("<td>").html(obj.product.hotel[i].capacity);
						 var $htd7 = $("<td>").html(obj.product.hotel[i].price);
						 var $htd8 = $("<td>").html(obj.product.hotel[i].roomcapacity);
						 var $htd9 = $("<td>").html(obj.product.hotel[i].roomtype);
						 
						 var $htr = $("<tr>").addClass("remove").append($htd1).append($htd2).append($htd3).append($htd4).append($htd5).append($htd6).append($htd7).append($htd8).append($htd9);
						 	 $("#hotelTable").append($htr);
					 }
					
					 //투어
					 for(var i =0; i<obj.product.tour.length; i++){
						 var startDate = new Date(obj.product.tour[i].startDate);
						 var endDate = new Date(obj.product.tour[i].endDate);
						 console.log(obj.product.tour[i].etime);
						 var $ttd1 = $("<td>").html(obj.product.tour[i].no);
						 var $ttd2 = $("<td>").html(obj.product.tour[i].tname);
						 var $ttd3 = $("<td>").html(obj.product.tour[i].tlocation);
						 var $ttd4 = $("<td>").html(getFormatDate(startDate));
						 var $ttd5 = $("<td>").html(getFormatDate(endDate));
						 var $ttd6 = $("<td>").html(obj.product.tour[i].taddr);
						 var $ttd7 = $("<td>").html(msToTime(obj.product.tour[i].etime));
						 var $ttd8 = $("<td>").html(obj.product.tour[i].capacity);
						 var $ttd9 = $("<td>").html(obj.product.tour[i].tprice);
						 
						 var $ttr = $("<tr>").addClass("remove").append($ttd1).append($ttd2).append($ttd3).append($ttd4).append($ttd5).append($ttd6).append($ttd7).append($ttd8).append($ttd9);
						 	 $("#tourTable").append($ttr);
					 }
					 
					 //렌트카
					 if(obj.product.rentcar[0].cdiv==null){
						 var $td1 = $("<td>").attr("colspan","10").addClass("red").html("선택한 렌트카가 없습니다.");
						
						 
						 var $rtr = $("<tr>").addClass("remove").append($td1);
						 $("#rentTable").append($rtr);
					 }else{
						 for(var i =0; i<obj.product.rentcar.length; i++){
							 var rentdate = new Date(obj.product.rentcar[i].rentddate);
							 var returndate = new Date(obj.product.rentcar[i].returndate);
							
							 var $rtd1 = $("<td>").html(obj.product.rentcar[i].no);
							 var $rtd2 = $("<td>").html(obj.product.rentcar[i].cdiv);
							 var $rtd3 = $("<td>").html(obj.product.rentcar[i].cno);
							 var $rtd4 = $("<td>").html(getFormatDate(rentdate));
							 var $rtd5 = $("<td>").html(getFormatDate(returndate));
							 var $rtd6 = $("<td>").html(obj.product.rentcar[i].rentaddr);
							 var $rtd7 = $("<td>").html(obj.product.rentcar[i].returnaddr);
							 var $rtd8 = $("<td>").html(obj.product.rentcar[i].price);
							 var $rtd9 = $("<td>").html(obj.product.rentcar[i].capacity);
							 var $rtd10= $("<td>").html(obj.product.rentcar[i].insurance);
							 
							 var $rtr = $("<tr>").addClass("remove").append($rtd1).append($rtd2).append($rtd3).append($rtd4).append($rtd5).append($rtd6).append($rtd7).append($rtd8).append($rtd9).append($rtd10);
 						 	 $("#rentTable").append($rtr);
						 }
					 }
					 
					 //결제 완료 여부 (예약상태)
					 if(obj.rstatus == "1"){
						 $("#rstatus").addClass("red").html("미결제");
						 $("#reservConfirm").css("display", "none");
					 }else if(obj.rstatus=="2"){
						 $("#rstatus").addClass("blue").html("결제 완료");
						 $("#reservConfirm").css("display", "block");
					 }else if(obj.rstatus=="3"){
						 $("#rstatus").addClass("yellow").html("예약 확정");
						 $("#reservConfirm").css("display", "none");
					 }
					 
					 
				
				 })
			}
		})
	}
	
	function getFormatDate(date){
	    var year = date.getFullYear();              //yyyy
	    var month = (date.getMonth()+1);   		//M
	    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
	    var day = date.getDate();                   //d
	    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	    return  year + '-' + month + '-' + day;
	}
	
	function msToTime(duration) {
        var milliseconds = parseInt((duration%1000)/100)
            , seconds = parseInt((duration/1000)%60)
            , minutes = parseInt((duration/(1000*60))%60)
            , hours = parseInt((duration/(1000*60*60))%24);

        hours = (hours < 10) ? "0" + hours : hours;
        minutes = (minutes < 10) ? "0" + minutes : minutes;
        seconds = (seconds < 10) ? "0" + seconds : seconds;

        return hours + ":" + minutes + ":" + seconds + "." + milliseconds;
    }
	
	$(function(){
		
		//예약 상세 버튼
		$(".modalbtn").click(function(){
			var userno = $(this).parent().parent().find(".hiddenuserno").html();
			var pno = $(this).parent().parent().find(".hidden").html();
			var rno = $(this).parent().parent().find(".rno").html();
			reservationDetail(userno, pno, rno);		
		})
		
		$("#reservConfirm").click(function(){
			var rno = $(".hiddenrno").html();
			location.href="reservationConfirm?rno="+rno;
		})
	})
</script>
<c:if test="${confirmSuccess!=null }">
	<script>
		alert("예약이 확정되었습니다.");
	</script>
</c:if>
<div class="content">	
	<div class="row">    
		<div class="col-sm-12">       
			<div class="box box-primary">      
				<div class="box-header">
					<h2 class="box-title">예약 관리</h2>
				</div>   
				<div class="box-body">
				<!-- 검색 작업에서 유지될 데이터 
					1. 현재 페이지의 번호     
					2. 페이지당 보여지는 데이터의 수
					3. 검색의 종류
					4. 검색의 키워드
				 -->
					<select name="searchType" id="searchType">
						<option value="n">-----</option>
						<option value="no">번호</option>    
						<option value="name">고객명</option>
						<option value="pname">상품명</option>  
						<option value="ano">항공편</option>
					</select>
					<input type="text" name="keyword" id="keywordInput">
					<button id="btnSearch">Search</button>
				</div>
				<div class="box-body">
				
				</div>
				<div class="box-body">
					<table class="table table-bordered">
						<tr>
							<th>번호</th>
							<th>고객명</th>
							<th>상품명</th>
							<th>항공편</th>
							<th>출발 날짜</th>
							<th>도착 날짜</th>
							<th>예약 상태</th>
							<th>예약 관리</th>
						</tr>  
					<c:forEach items="${list }" var="r">
						<tr>
								<td class="rno">${r.no}</td>
								<td>${r.userno.username } <span class="hiddenuserno">${r.userno.userno }</span></td>
								<td>${r.product.pname } <span class="hidden">${r.product.pno }</span></td>
								<c:forEach var="f" items="${r.product.air}" begin="0" end="0">
								<td>${f.ano }</td>
								</c:forEach>
								<c:forEach var="f" items="${r.product.air}" begin="0" end="0">
								<fmt:formatDate var="startdate" value="${f.ddate}" pattern="yyyy-MM-dd"/>
								</c:forEach>
							<c:forEach var="f" items="${r.product.air}" begin="1" end="1">
								<fmt:formatDate var="enddate" value="${f.rdate}" pattern="yyyy-MM-dd"/>
							</c:forEach>
								
								<td>${startdate }</td>	
								<td>${enddate }</td>
								<c:if test="${r.rstatus=='1' }">
									<td class="red">미결제</td>
								</c:if>
								<c:if test="${r.rstatus=='2' }">
									<td class="blue">결제 완료</td>
								</c:if>
								<c:if test="${r.rstatus=='3' }">
									<td class="yellow">예약 확정</td>
								</c:if>
								<td><button type="button" class="btn btn-info btn-lg modalbtn" data-toggle="modal" data-target="#myModal">예약 상세</button></td>
							</tr>
					</c:forEach>
					</table>  
					
				</div>    
			<div class="box-footer">
					<div class="text-center">
						<ul class="pagination">
							<c:if test="${pageMaker.prev == true }">
								<li><a href="noticeMngList?page=${pageMaker.endPage -1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&laquo;</a></li>
							</c:if>
							<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
								<li class="${pageMaker.cri.page == idx ?'active':''}"><a href="noticeMngList?page=${idx}&searchType=${cri.searchType}&keyword=${cri.keyword}">${idx }</a></li>
								<!-- 주소의 시작이 /로 시작하지 않고 localhost:8080..으로 시작하면 맨 마지막 것만 바꿔주면됨 -->
							</c:forEach>
							<c:if test="${pageMaker.next == true }">
								<li><a href="noticeMngList?page=${pageMaker.endPage +1 }&searchType=${cri.searchType}&keyword=${cri.keyword}">&raquo;</a></li>
							</c:if>
						</ul>
					</div>
				</div> 
				<div id="myModal" class="modal fade" role="dialog">
					<div class="modal-dialog" id="modalBox">

						<!-- Modal content-->
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">테스트 고객 님의 예약 정보</h4>
							</div>
							<div class="modal-body">
							<h4>고객 정보</h4>
								<table class="table table-bordered" id="userTable"
									style="width: 100%;">
									<tr>
										<th style="width: 100px;">유저번호</th>
										<th>유저명</th>
										<th>생년월일</th>
										<th>여권등록여부</th>
										<th>유저아이디</th>
									</tr>
								</table>
								<span class="hiddenrno"></span>
								<h4>항공편</h4>
							<h5>출발 항공편</h5>
							<table class="table table-bordered" id="airdTable" style="width : 100%;">
							<tr>
								<th>번호</th>
								<th>항공기 번호</th>
								<th>출발 지역</th>
								<th>도착 지역</th>
								<th>출발 일시</th>
								<th>도착 일시</th>
								<th>허용 인원</th>
								<th>좌석</th>
								<th>가격</th>
							</tr>
							</table>
							<h5>도착 항공편</h5>
							<table class="table table-bordered" id="airrTable" style="width : 100%;">
							<tr>
								<th>번호</th>
								<th>항공기 번호</th>
								<th>출발 지역</th>
								<th>도착 지역</th>
								<th>출발 일시</th>
								<th>도착 일시</th>
								<th>허용 인원</th>
								<th>좌석</th>
								<th>가격</th>
							</tr>
							</table>
							
							<h4>호텔</h4>
							<table class="table table-bordered" id="hotelTable">
								<tr>
									<th>번호</th>
									<th>호텔이름</th>
									<th>호텔주소</th>
									<th>체크인날짜</th>
									<th>체크아웃날짜</th>
									<th>허용인원수</th>
									<th>가격(1박)</th>
									<th>객실 수</th>
									<th>객실타입</th>
								</tr>
							</table>
							<h4>현지 투어</h4>
							<table class="table table-bordered" id="tourTable">
								<tr>
									<th>번호</th>
									<th>투어제목</th>
									<th>투어장소</th>
									<th>시작일자</th>
									<th>종료일자</th>
									<th>주소</th>
									<th>소요시간</th>
									<th>허용인원</th>
									<th>가격</th>
								</tr>
								
							</table>
							<h4>렌트카</h4>
							<table class="table table-bordered" id="rentTable">
								<tr>
									<th>번호</th>
									<th>차 종류</th>
									<th>차 번호</th>
									<th>대여 일자</th>
									<th>반납 일자</th>
									<th>대여 장소</th>
									<th>반납 장소</th>
									<th>가격</th>
									<th>허용인원</th>
									<th>보험여부</th>	
								</tr>
								
							</table>
							<h4>결제 여부</h4>
							<p id="rstatus"></p>
							<button type="button" class="btn btn-danger" data-dismiss="modal" id="reservConfirm">예약 확정</button>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
							</div>
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
		location.href = "listPage?searchType="+searchType+"&keyword="+keyword;
		//searchBoardController의 listPage GET 으로 받음 
		
	})
	
	$("#btnRegister").click(function(){
		location.href = "register";
	})
</script>

<%@ include file="../../include/footer.jsp"%>