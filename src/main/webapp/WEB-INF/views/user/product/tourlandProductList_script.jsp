<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>   
function replaceAll(str, searchStr, replaceStr) {
	return str.split(searchStr).join(replaceStr);
}
/* yyyy-MM-dd 형식으로 변경하는 메서드  */
function getFormatDate(date,seperater){
	var date = new Date(date);
    var year = date.getFullYear()+seperater;              //yyyy
    var month = (date.getMonth()+1)+seperater;          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '' + month + '' + day;
}
function calPrice(obj) {
	var price = 0;
	$(obj.air).each(function(i,obj){
		 if(obj.seat=='E') {
			 price += obj.price;
		 } 
	 })
	 $(obj.hotel).each(function(i,obj){
		 if(obj.roomtype=='N') {
			 var checkinDate = new Date(obj.checkin);
			 var checkoutDate = new Date(obj.checkout);
			 var dateDiffDate = new Date();
			 dateDiffDate.setDate(checkoutDate.getDate()-checkinDate.getDate());
			 price += (obj.price * dateDiffDate.getDate());
		 } 
	 }) 
	 $(obj.tour).each(function(i,obj){
		 price += obj.tprice;  
	 })
	 return price.toLocaleString();
}
function appendAjaxData(rs,url,classname) {
	 $(rs.list).each(function(i,obj){
		 var $input1 = $("<input>").attr("type", "hidden").attr("value", obj.pno).attr("id", "pno");
		 var $div1 = $("<div>").addClass("pkgImg");
		 var $img1 = $("<img>").attr("src", "displayFile/product?filename="+obj.pic);
		 var $div2 = $("<div>").addClass("pkgInfoBox");
		 var $p1 = $("<p>").addClass("pkgTitle").html(obj.pname);
		 var price = calPrice(obj);
		 var $p2 = $("<p>").addClass("pkgPrice").html(price+"원 부터~").css("text-align","right");
		 var $p3 = $("<p>").addClass("pkgDate").html("~ "+getFormatDate(obj.pexpire,"/")+"까지");
		 var $p4 = $("<p>").addClass("pkgReserv");
		 var $btn = $("<button data-price='"+price+"' data-pno='"+obj.pno+"'>").addClass("pkgReservBtn").html("지금 바로 예약");
		 
		 $div1.append($img1);
		 $div2.append($div1);
		 $div2.append($p1); 
		 $div2.append($p2);
		 $div2.append($p3);
		 $p4.append($btn);
		 $div2.append($p4);
		 var $pkgListBox = $("<div class='pkgListBox'>").append($div2);
		 $("#pkgListBoxWrap").append($pkgListBox);
	 })
	 /* 페이징 부분 */
	 if(rs.pageMaker.prev==true){
		var $li1 = $("<li>");
		var $a1 = $("<a>").attr("href", "${pageContext.request.contextPath}/customer/"+url+"?page=${pageMaker.startPage-1}" ).html("&laquo");
		$li1.append($a1);
	 }
	 if(rs.pageMaker.next==true){
		var $li3 = $("<li>");
		var $a3 = $("<a>").attr("href", "${pageContext.request.contextPath}/customer/"+url+"?page=${pageMaker.startPage+1}" ).html("&laquo");
		$li3.append($a3);
	 }
	 for(var j = rs.pageMaker.startPage; j<= rs.pageMaker.endPage; j++){
		$li2 = $("<li>").addClass("${cri.page==idx?'active':''}").addClass(classname).html(j).css("cursor", "pointer");
		if(j==rs.pageMaker.cri.page) {
			$li2.addClass("active");
		}
		$(".pagination").append($li1);
		$(".pagination").append($li2);
		$(".pagination").append($li3);
	 }
}
/* 리스트 좌측 검색 박스에서 검색했을 때 데이터를 불러오는 Ajax */
function getSearchResult(locale){
	var ddate = $(".datepicker").val();//출발일 선택
	var tourDays = $("#rdate").val();//여행일 선택
	var cnt = $("#cnt").val(); //인원
	$.ajax({
		url : "tourlandProduct"+locale+"SearchList",
		type : "get",
		dataType : "json",
		data : {ddate : ddate, tourDays : tourDays, cnt : cnt},
		success : function(rs){
			 $("#pkgListBoxWrap").empty();
			 $(".pagination").empty();
			 $("#totalCount").html(rs.list.length);
			 appendAjaxData(rs,"tourlandProduct"+locale+"SearchList","");
		}
	})
}

/* 리스트 우측 전체 리스트 보기 버튼을 클릭했을 때 모든 데이터를 불러오는 Ajax  */
function getList(page,locale){
	$.ajax({
		url : "tourlandProduct"+locale+"ListAll/"+page,
		type : "get",
		dataType : "json",
		success : function(rs){
			 $("#pkgListBoxWrap").empty();
			 $(".pagination").empty();
			 $("#totalCount").html(rs.count);
			 appendAjaxData(rs,"tourlandProduct"+locale+"ListAll","listAll");
		}
	})
}
/* 낮은 가격 순 버튼을 클릭했을 때 모든 데이터를 불러오는 Ajax  */
function getLowPriceList(page,locale){
	$.ajax({
		url : "tourlandProduct"+locale+"SearchLowPirceList/"+page,
		type : "get",
		dataType : "json",
		success : function(rs){
			 $("#pkgListBoxWrap").empty();
			 $(".pagination").empty();
			 $("#totalCount").html(rs.count);
			 appendAjaxData(rs,"tourlandProduct"+locale+"SearchLowPirceList","lowPriceListPage");
		}
	})
}
</script>