<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	/* 본문 */
	section { width: 1000px; margin: 0 auto; }
	div#proBox { border-bottom : 1px solid #929292; }
	div#proBox h1 { height: 100px; line-height: 100px;}
	div#imgBox { width: 500px; height: 800px;float: left;  }
	div#bigImgBox { width: 500px; height: 400px;}  
	div#bigImgBox img { height : 400px; width: 100%; } 
	div#smallImgBox { width: 500px; height:100px;}
	div#smallImgBox img { width:23%; height: 100px; float: left; margin:5px;}   
	
	div#infoBox { width: 460px; height: 900px; overflow: hidden; padding-left:20px;}  
	
	#proDetailBtns { height: 50px; text-align: center;}
	#proDetailBtns a {display: block; width: 200px; height: 30px; border: none;line-height:30px; text-decoration: none;font-size: 14px; float: left; margin:10px;}
	#proDetailBtns #detail { background: #828282; color: #fff; }
	#proDetailBtns #review { background: gainsboro; }
	
	div#infoBox ul li { height: 40px;}
	div#infoBox ul li p {float : left; margin-right : 10px;}
	div#infoBox #infoName { height: 100px; }
	div#infoBox #infoName span { font-size: 20px; font-weight: bold;}
	div#infoBox #infoPrice span { font-size: 30px; font-weight: bold;}
	
	div#btnsBox { height: 100px; text-align: center; line-height: 150px;}
	div#btnsBox button { width: 200px; height: 30px; border: none;  }
	button#update { background: maroon; color: #fff; }
	button#return { background: steelblue; color: #fff; }
	
	#proDetail h2 { height: 80px; line-height: 60px;}
	#proDetail .detailTitle { height: 30px; font-size: 20px; font-weight: bold; }
	#proDetail .detailInfo { height: 100px; }
	#proDetail img { width: 100%; margin-bottom: 30px; }
</style>

<body>
	<%@ include file="../../include/userHeader.jsp"%>
	<script>
		var uno = 0;
		var price = 0;
		var ano = [];
		var bookCapacity = 0;
		function calDateDiff(checkin,checkout) {
			checkinArr = checkin.split(" ");
			checkoutArr = checkout.split(" ");
			checkin = checkinArr[1]+" "+checkinArr[2]+", "+checkinArr[5]+" "+checkinArr[3]; 
			checkout = checkoutArr[1]+" "+checkoutArr[2]+", "+checkoutArr[5]+" "+checkoutArr[3]; 
			var checkinDate = new Date(Date.parse(checkin));
			var checkoutDate = new Date(Date.parse(checkout));  
			var date = new Date();
			date.setDate(checkoutDate.getDate() - checkinDate.getDate());
			return date.getDate();
		}
		function calPrice() {
			price = 0;
			bookCapacity = Number($("#capacity option:selected").val().substring(0,$("#capacity option:selected").val().indexOf("명")));
			$(".selAir").each(function(i,obj){
				switch($(obj).find("option:selected").val()) {
				case "F":
					var airprice = ${vo.air[0].price} * 2 * Number($(".airSelect").eq(i).find("option:selected").attr("data-capacity")); 
					price += airprice;
					break;
				case "B":
					var airprice = ${vo.air[2].price} * 2 * Number($(".airSelect").eq(i).find("option:selected").attr("data-capacity"));
					price += airprice;
					break;
				case "E":
					var airprice = ${vo.air[4].price} * 2 * Number($(".airSelect").eq(i).find("option:selected").attr("data-capacity"));
					price += airprice;
					break;
				}
			})
			$(".selHotel").each(function(i,obj){
				switch($(obj).find("option:selected").val()) {
				case "S":
					var hotelPrice = ${vo.hotel[0].price};
					var dateDiff = Number(calDateDiff("${vo.hotel[0].checkin}","${vo.hotel[0].checkout}"));
					price += (hotelPrice * dateDiff * Number($(".hotelSelect").eq(i).find("option:selected").attr("data-capacity"))); 
					break;
				case "D":
					var hotelPrice = ${vo.hotel[1].price};
					var dateDiff = Number(calDateDiff("${vo.hotel[1].checkin}","${vo.hotel[1].checkout}"));
					price += (hotelPrice * dateDiff * Number($(".hotelSelect").eq(i).find("option:selected").attr("data-capacity")));
					break;
				case "N":
					var hotelPrice = ${vo.hotel[2].price};
					var dateDiff = Number(calDateDiff("${vo.hotel[2].checkin}","${vo.hotel[2].checkout}"));
					price += (hotelPrice * dateDiff * Number($(".hotelSelect").eq(i).find("option:selected").attr("data-capacity")));
					break;
				}
			})
			$(".selTour:checked").each(function(i,obj){
				var tourprice = Number($(this).attr("data-price")) * bookCapacity;
				price += tourprice; 
			})
			if($("#selRentcar option:selected").val()=='S') {
				price += Math.ceil(${vo.rentcar[0].price/vo.rentcar[0].capacity}*bookCapacity); 
			}
			$("#price").text(price.toLocaleString());
		}
		function replaceAll(str, searchStr, replaceStr) {
		   return str.split(searchStr).join(replaceStr);
		}
		$(function(){
			$("#smallImgBox li").each(function(i,obj){
				$(this).find("img").attr("src",$("#proDetail img").eq(i).attr("src"));
			})
			$(document).on("click","#smallImgBox li img",function(){
				$("#bigImgBox img").attr("src",$(this).attr("src"));
			})
			for(var i=1;i<=45;i++) {
				var option = $("<option>").html(i+"명");
				$("#capacity").append(option);
			}
			$(".selAir").change(function(){
				if($(".selAir").eq(0).find("option:selected").val()=="" && ($(".selAir").index($(this))==1 || $(".selAir").index($(this))==2)) {
					alert("항공옵션1을 먼저 채워주세요"); 
					$(this).find("option").eq(0).prop("selected",true);
					return false;
				}
				var selOption = $(this).find("option:selected").val();
				$(this).parent().next().remove();
				var airSelect = $("<select class='airSelect'>").html(" ");
				var p = $("<p>").html("탑승인원 ");
				switch(selOption) {
				case "F":
					for(var i=1;i<=${vo.air[0].capacity};i++) {
						var option = $("<option data-capacity='"+i+"'>").html(i+"명");
						airSelect.append(option);	
					}
					p.append(airSelect);
					$(this).parent().after(p);
					break;
				case "B":
					for(var i=1;i<=${vo.air[3].capacity};i++) { 
						var option = $("<option data-capacity='"+i+"'>").html(i+"명");
						airSelect.append(option);	
					}
					p.append(airSelect);
					$(this).parent().after(p);
					break;
				case "E":
					for(var i=1;i<=${vo.air[5].capacity};i++) {
						var option =$("<option data-capacity='"+i+"'>").html(i+"명");
						airSelect.append(option);	
					}
					p.append(airSelect);
					$(this).parent().after(p); 
					break;
				}
				calPrice();
				var airCapacity = 0;
				$(".airSelect").each(function(i,obj){ 
					airCapacity += Number($(obj).find("option:selected").val().substring(0,$(this).find("option:selected").val().length-1));
				})
				if(bookCapacity<airCapacity) {
					alert("현재 예약인원보다 항공기 탑승인원이 더 많을 수 없습니다");
					$(this).find("option").eq(0).prop("selected",true);
					$(this).parent().next().remove();
					calPrice();  
				}
			})
			$(document).on("change",".airSelect",function(){
				var airCapacity = 0;
				$(".airSelect").each(function(i,obj){
					airCapacity += Number($(obj).find("option:selected").val().substring(0,$(this).find("option:selected").val().length-1));
				})
				if(bookCapacity<airCapacity) {
					alert("현재 예약인원보다 항공기 탑승인원이 더 많을 수 없습니다");
					$(this).find("option").eq(0).prop("selected",true);  
					return false;
				}
				calPrice();
			})
			$(".selHotel").change(function(){
				if($(".selHotel").eq(0).find("option:selected").val()=="" && ($(".selHotel").index($(this))==1 || $(".selHotel").index($(this))==2)) {
					alert("호텔옵션1을 먼저 채워주세요"); 
					$(this).find("option").eq(0).prop("selected",true);
					return false;
				}
				var selOption = $(this).find("option:selected").val();
				$(this).parent().next().remove(); 
				var hotelSelect = $("<select class='hotelSelect'>").html(" ");
				var p = $("<p>").html("투숙인원 ");
				switch(selOption) {
				case "S":
					for(var i=1;i<=${vo.hotel[0].capacity}*${vo.hotel[0].roomcapacity};i++) {
						var option = $("<option data-capacity='"+i+"'>").html(i+"명");
						hotelSelect.append(option);	
					}
					p.append(hotelSelect);
					$(this).parent().after(p);
					break;
				case "D":
					for(var i=1;i<=${vo.hotel[1].capacity}*${vo.hotel[1].roomcapacity};i++) { 
						var option = $("<option data-capacity='"+i+"'>").html(i+"명");
						hotelSelect.append(option);	
					}
					p.append(hotelSelect);
					$(this).parent().after(p);
					break;
				case "N":
					for(var i=1;i<=${vo.hotel[2].capacity}*${vo.hotel[2].roomcapacity};i++) {
						var option = $("<option data-capacity='"+i+"'>").html(i+"명");
						hotelSelect.append(option);	
					}
					p.append(hotelSelect);  
					$(this).parent().after(p); 
					break;
				}
				calPrice();
				var hotelCapacity = 0; 
				$(".hotelSelect").each(function(i,obj){
					hotelCapacity += Number($(obj).find("option:selected").val().substring(0,$(this).find("option:selected").val().length-1));
				})
				if(bookCapacity<hotelCapacity) {
					alert("현재 예약인원보다 호텔 투숙 인원이 더 많을 수 없습니다");
					$(this).find("option").eq(0).prop("selected",true);
					$(this).parent().next().remove();
					calPrice();
				}
			}) 
			$(document).on("change",".hotelSelect",function(){
				var hotelCapacity = 0;
				$(".hotelSelect").each(function(i,obj){
					hotelCapacity += Number($(obj).find("option:selected").val().substring(0,$(this).find("option:selected").val().length-1));
				})
				if(bookCapacity<hotelCapacity) {
					alert("현재 예약인원보다 호텔 투숙 인원이 더 많을 수 없습니다");
					$(this).find("option").eq(0).prop("selected",true);  
				}
				calPrice();
			})
			$(".selTour").change(function(){
				calPrice();
			})
			$("#selRentcar").change(function(){
				calPrice();
			})
			//선택된 장바구니 상품의 옵션에 따라 미리 선택되어 있게 함
			var uacapacity = [];
			var calacapacity = 0;
			$(".selAir").each(function(i,obj){
				if($(obj).find("option").eq(0).attr("data-capacity")!="") {
					uacapacity[i] = Number($(obj).find("option").eq(0).attr("data-capacity"));
					calacapacity += Number($(obj).find("option").eq(0).attr("data-capacity"));
				}
			})
			$("#capacity option").each(function(i,obj){
				if($(obj).val().substring(0,$(obj).val().length-1)==calacapacity) { 
					$(obj).prop("selected",true);
					$(obj).change();
				}
			}) 
			var useat = [];
			$(".selAir").each(function(i,obj){
				if($(obj).find("option").eq(0).attr("data-seat")!="") {
					useat[i] = $(obj).find("option").eq(0).attr("data-seat");
				}
			})
			switch(useat.length-1) { 
			case 0:
				$(".selAir").eq(0).find("option").each(function(i,obj){
					if($(obj).val()==useat[0]) {
						$(obj).prop("selected",true);
						$(obj).change();
						$(".airSelect").eq(0).find("option").eq(uacapacity[0]-1).prop("selected",true);
						$(".airSelect").change();
					}
				})
				break;
			case 1:
				$(".selAir").eq(0).find("option").each(function(i,obj){
					if($(obj).val()==useat[0]) {
						$(obj).prop("selected",true);
						$(obj).change();
						$(".airSelect").eq(0).find("option").eq(uacapacity[0]-1).prop("selected",true);
						$(".airSelect").change();
					}
				})
				$(".selAir").eq(1).find("option").each(function(i,obj){
					if($(obj).val()==useat[1]) {
						$(obj).prop("selected",true);
						$(obj).change();
						$(".airSelect").eq(1).find("option").eq(uacapacity[1]-1).prop("selected",true);
						$(".airSelect").change();
					}
				})
				break;
			case 2:
				$(".selAir").eq(0).find("option").each(function(i,obj){
					if($(obj).val()==useat[0]) {
						$(obj).prop("selected",true);
						$(obj).change();
						$(".airSelect").eq(0).find("option").eq(uacapacity[0]-1).prop("selected",true);
						$(".airSelect").change();
					}
				})
				$(".selAir").eq(1).find("option").each(function(i,obj){
					if($(obj).val()==useat[1]) {
						$(obj).prop("selected",true);
						$(obj).change();
						$(".airSelect").eq(1).find("option").eq(uacapacity[1]-1).prop("selected",true);
						$(".airSelect").change();
					}
				})
				$(".selAir").eq(2).find("option").each(function(i,obj){
					if($(obj).val()==useat[2]) {
						$(obj).prop("selected",true);
						$(obj).change();
						$(".airSelect").eq(2).find("option").eq(uacapacity[2]-1).prop("selected",true);
						$(".airSelect").change();
					}
				})
				break;
			}
			var uhcapacity = [];
			$(".selHotel").each(function(i,obj){
				if($(obj).find("option").eq(0).attr("data-capacity")!="") {
					uhcapacity[i] = Number($(obj).find("option").eq(0).attr("data-capacity"));
				}
			})
			var uroomtype = [];
			$(".selHotel").each(function(i,obj){
				if($(obj).find("option").eq(0).attr("data-roomtype")!="") {
					uroomtype[i] = $(obj).find("option").eq(0).attr("data-roomtype");
				}
			})
			switch(uroomtype.length-1) { 
			case 0:
				$(".selHotel").eq(0).find("option").each(function(i,obj){
					if($(obj).val()==uroomtype[0]) {
						$(obj).prop("selected",true);
						$(obj).change();
						$(".hotelSelect").eq(0).find("option").eq(uhcapacity[0]-1).prop("selected",true);
						$(".hotelSelect").change();
					}
				})
				break;
			case 1:
				$(".selHotel").eq(0).find("option").each(function(i,obj){
					if($(obj).val()==uroomtype[0]) {
						$(obj).prop("selected",true);
						$(obj).change();
						$(".hotelSelect").eq(0).find("option").eq(uhcapacity[0]-1).prop("selected",true);
						$(".hotelSelect").change();
					}
				})
				$(".selHotel").eq(1).find("option").each(function(i,obj){
					if($(obj).val()==uroomtype[1]) {
						$(obj).prop("selected",true);
						$(obj).change();
						$(".hotelSelect").eq(1).find("option").eq(uhcapacity[1]-1).prop("selected",true);
						$(".hotelSelect").change();
					}
				})
				break;
			case 2:
				$(".selHotel").eq(0).find("option").each(function(i,obj){
					if($(obj).val()==uroomtype[0]) {
						$(obj).prop("selected",true);
						$(obj).change();
					}
				})
				$(".selHotel").eq(1).find("option").each(function(i,obj){
					if($(obj).val()==uroomtype[1]) {
						$(obj).prop("selected",true);
						$(obj).change();
						$(".hotelSelect").eq(1).find("option").eq(uhcapacity[1]-1).prop("selected",true);
						$(".hotelSelect").change();
					}
				})
				$(".selHotel").eq(2).find("option").each(function(i,obj){
					if($(obj).val()==uroomtype[2]) {
						$(obj).prop("selected",true);
						$(obj).change(); 
						$(".hotelSelect").eq(2).find("option").eq(uhcapacity[2]-1).prop("selected",true);
						$(".hotelSelect").change();
					}
				})
				break;
			}
			var utno = [];
			$(".utour").each(function(i,obj){
				utno[i] = $(obj).val();
			})
			$(".selTour").each(function(i,obj){
				if($(obj).val()==utno[i]) {
					$(obj).prop("checked",true);
					$(obj).change();
				}
			})
			var rno = $("#selRentcar").find("option").eq(0).attr("data-rno");
			if($("#selRentcar").find("option").eq(1).attr("data-rentno")==rno) {   
				$("#selRentcar").find("option").eq(1).prop("selected",true);
				$("#selRentcar").change();
			}
			$("#capacity").change(function(){
				bookCapacity = Number($("#capacity option:selected").val().substring(0,$("#capacity option:selected").val().indexOf("명")));
				$(".selAir").eq(0).val("E");
				$(".selAir").eq(1).val("");
				$(".selAir").eq(2).val("");
				$(".airSelect").eq(0).find("option").eq(bookCapacity-1).prop("selected",true);
				$(".airOption").eq(1).next().remove();
				$(".airOption").eq(2).next().remove();
				$(".selAir").eq(1).change();
				$(".selAir").eq(2).change();
				$(".selHotel").eq(0).val("N");
				$(".selHotel").eq(1).val("");
				$(".selHotel").eq(2).val("");
				$(".hotelSelect").eq(0).find("option").eq(bookCapacity-1).prop("selected",true);
				$(".hotelOption").eq(1).next().remove();
				$(".hotelOption").eq(2).next().remove();
				$(".selHotel").eq(1).change();
				$(".selHotel").eq(2).change();
				$(".selTour").prop("checked",true);
				$(".selTour").change();
				$("#selRentcar").change();
				calPrice();
			})
			$("#return").click(function(){
				location.href = "tourlandMyWishes";
			})
			$("#update").click(function(){
				if(confirm("수정하시겠습니까?")) {
					var userno = ${userno};
					var rno = ${rno};
					var upno = ${uvo.pno};
					var price = replaceAll($("#price").text(),",","");
					var ano = [];
					var acapacity = [];
					var hno = [];
					var hcapacity = [];
					var tno = [];
					var tcapacity = bookCapacity;
					var rentno = [];
					var rcapacity = bookCapacity;
					$(".selAir option:selected").each(function(i,obj){
						if($(this).val()!="") {
							var dno = $(this).attr("data-dano");
							ano[i] = dno;
						}
					})
					$(".airSelect option:selected").each(function(i,obj){
						acapacity[i] = $(this).attr("data-capacity"); 
					})
					$(".selHotel option:selected").each(function(i,obj){
						if($(this).val()!="" || $(this).val=="DS") {
							var no = $(this).attr("data-hno");
							hno[i] = no;
						}
					})
					$(".hotelSelect option:selected").each(function(i,obj){
						hcapacity[i] = $(this).attr("data-capacity"); 
					})
					$(".selTour:checked").each(function(i,obj){
						tno[i] = $(this).val();
					})
					if($("#selRentcar option:selected").val()=="S") {
						rentno[0] = $(this).attr("data-rentno");
					}
					$.ajax({
						url : "tourlandMyWishesDetail/update", 
						method : "get",
						traditional : true,
						data : {
							userno:userno,
							rno:rno,
							upno:upno,
							price:price,
							ano:ano,
							acapacity:acapacity,
							hno:hno,
							hcapacity:hcapacity,
							tno:tno,
							tcapacity:tcapacity,
							rno:rno,
							rcapacity:rcapacity
						},
						dataType : "text", 
						success : function(res) {
							alert("수정이 완료되었습니다");
							location.href = "tourlandMyWishes";
						},
						error : function(res) {
							console.log(res);
						}
					})
				}
			})
		}); 
</script>
		<section>
				<div id="proBox">
					<h1>${vo.pname}</h1>
					<div id="imgBox">
						<div id="bigImgBox">
							<img src="displayFile/product?filename=${vo.pic}">
						</div>
						<div id="smallImgBox">
							<ul>
								<li><img src="${pageContext.request.contextPath}/resources/images/dokyo1.jpg"></li>
								<li><img src="${pageContext.request.contextPath}/resources/images/dokyo1.jpg"></li>
								<li><img src="${pageContext.request.contextPath}/resources/images/dokyo1.jpg"></li>
								<li><img src="${pageContext.request.contextPath}/resources/images/dokyo1.jpg"></li>
							</ul>
						</div>
						<style>
							#optionInfo { border-collapse: collapse; width: 480px;margin-left: 10px; margin-top: 50px;}
							#optionInfo th { height: 50px; background: gainsboro;border-top: 1px solid #929292; border-bottom: 1px solid #929292; font-size: 18px; }
							#optionInfo td { height: 30px; }
							#optionInfo #include { color:forestgreen; }
							#optionInfo #exclude { color:maroon; } 		  
						</style>
						<table id="optionInfo">
							<tr>   
								<th colspan="3"><span id="include">O </span> 포함 사항</th>
							</tr>
							<tr>
								<td>- 인천공항 공항세, 현지 공항세, 관광진흥 개발 기금</td>
							</tr>
							<tr>     
								<td>- 유류할증료</td>
							</tr>
							<tr>
								<td>- 최대 1억원 해외여행자 보험</td>
							</tr>
							<tr>
								<th colspan="3"><span id="exclude">X </span> 불포함 사항</th>
							</tr>
							<tr>
								<td>- 여권발급비용</td>
							</tr>
							<tr>
								<td>- 개인경비</td>
							</tr>
							<tr>
								<td>- 1일 자유일정시 중,석식 및 교통비, 개인경비</td>
							</tr>
						</table>
			</div>
					
					<div id="infoBox">
						<ul>
							<li id="infoNo">상품 번호 : <span id="pno">P${uvo.pno}</span></li>
							<li id="infoName"><span id="pname">${uvo.pname}</span></li>
							<c:forEach var="air" items="${vo.air}" begin="0" end="0">
								<fmt:formatDate var="ddate" value="${air.ddate}" pattern="yyyy-MM-dd"/>
							</c:forEach>
							<li id="infoDate">출발일 : <span id="ddate">${ddate}</span></li>
							<li id="infoDays">여행 기간 : <span id="tourDays">${(fn:substring(vo.pname,fn:indexOf(vo.pname,']')-2,fn:indexOf(vo.pname,']')-1)-1)}박${fn:substring(vo.pname,fn:indexOf(vo.pname,']')-2,fn:indexOf(vo.pname,']')-1)}일</span></li>
							<c:forEach var="t" items="${vo.tour}" begin="0" end="0">
								<c:set var="capacity" value="${t.capacity}"/>
							</c:forEach>
							<li class="selOption">
								<p>
									예약인원
									<select id="capacity">
									</select>
								</p>
							</li>
							<li class="selOption">
								<p class="airOption">
									항공기옵션1
									<select class="selAir">
										<option value="" data-seat="${uvo.air[0].seat}" data-capacity="${uvo.air[0].capacity}">선택</option>
										<option value="F" data-dano="${vo.air[0].no}" data-rano="${vo.air[1].no}" >First-Class</option>
										<option value="B" data-dano="${vo.air[2].no}" data-rano="${vo.air[3].no}">Business</option>
										<option value="E" data-dano="${vo.air[4].no}" data-rano="${vo.air[5].no}">Economy</option>   
									</select>
								</p>
							</li>
							<li class="selOption">
								<p class="airOption">
									항공기옵션2
									<select class="selAir">
										<option value="" data-seat="${uvo.air[2].seat}" data-capacity="${uvo.air[2].capacity}">선택</option>
										<option value="F" data-dano="${vo.air[0].no}" data-rano="${vo.air[1].no}">First-Class</option>
										<option value="B" data-dano="${vo.air[2].no}" data-rano="${vo.air[3].no}">Business</option>
										<option value="E" data-dano="${vo.air[4].no}" data-rano="${vo.air[5].no}">Economy</option>   
									</select>
								</p>
							</li>
							<li class="selOption">
								<p class="airOption"> 
									항공기옵션3 
									<select class="selAir"> 
										<option value="" data-seat="${uvo.air[4].seat}" data-capacity="${uvo.air[4].capacity}">선택</option>
										<option value="F" data-dano="${vo.air[0].no}" data-rano="${vo.air[1].no}">First-Class</option>
										<option value="B" data-dano="${vo.air[2].no}" data-rano="${vo.air[3].no}">Business</option>
										<option value="E" data-dano="${vo.air[4].no}" data-rano="${vo.air[5].no}">Economy</option>   
									</select>
								</p>
							</li>
							<li class="selOption">
								<p class="hotelOption">
									호텔옵션1 
									<select class="selHotel">
										<option value="" data-roomtype="${uvo.hotel[0].roomtype}" data-capacity="${uvo.hotel[0].totalcapacity}">선택</option>
										<option value="S" data-hno="${vo.hotel[0].no}">스위트룸</option>
										<option value="D" data-hno="${vo.hotel[1].no}">디럭스룸</option>
										<option value="N" data-hno="${vo.hotel[2].no}">일반룸</option>
										<option value="DS">선택안함</option>
									</select>
								</p>
							</li>
							<li class="selOption">
								<p class="hotelOption">
									호텔옵션2 
									<select class="selHotel">
										<option value="" data-roomtype="${uvo.hotel[1].roomtype}" data-capacity="${uvo.hotel[1].totalcapacity}">선택</option>
										<option value="S" data-hno="${vo.hotel[0].no}">스위트룸</option>
										<option value="D" data-hno="${vo.hotel[1].no}">디럭스룸</option>
										<option value="N" data-hno="${vo.hotel[2].no}">일반룸</option>
										<option value="DS">선택안함</option>
									</select>
								</p>
							</li>
							<li class="selOption">
								<p class="hotelOption">
									호텔옵션3
									<select class="selHotel">
										<option value="" data-roomtype="${uvo.hotel[2].roomtype}" data-capacity="${uvo.hotel[2].totalcapacity}">선택</option>
										<option value="S" data-hno="${vo.hotel[0].no}">스위트룸</option>
										<option value="D" data-hno="${vo.hotel[1].no}">디럭스룸</option>
										<option value="N" data-hno="${vo.hotel[2].no}">일반룸</option>
										<option value="DS">선택안함</option>
									</select>
								</p>
							</li>
							<li class="selOption">
								<p>
								투어옵션<br>
									<c:forEach var="tour" items="${vo.tour}">
										<input type="checkbox" name="tourChk" value="${tour.no}" class="selTour" data-price="${tour.tprice}"> <span>${tour.tname}</span><br>
									</c:forEach>
									<c:forEach var="utour" items="${uvo.tour}">
										<input type="hidden" value="${utour.no}" class="utour">
									</c:forEach>
								</p>
							</li>
							<li class="selOption">
								<p>
									렌터카옵션
									<select id="selRentcar">
										<option value="" data-rno="${uvo.rentcar[0].no}">선택</option>
										<option value="S" data-rentno="${vo.rentcar[0].no}">선택함</option>
										<option value="DS">선택안함</option>
									</select>    
								</p>
							</li>
							<li id="infoPrice" style="clear : both;">가격 : <span id="price"><fmt:formatNumber value="0" pattern="###,###"/></span>원</li>
						</ul>
						<div id="btnsBox">
						<button id="update">수정하기</button>
						<button id="return">돌아가기</button>
					</div>
				</div>					
				</div>
				<div id="proDetail">       		
				<h2>여행 세부 내용</h2>
					${vo.pcontent}
				</div>
			</section>
	<%@ include file="../../include/userFooter.jsp"%>
</body>
</html>