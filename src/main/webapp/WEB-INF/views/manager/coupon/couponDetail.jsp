<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/locale/ko.js"></script>
​<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap-datetimepicker.js">
</script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap/css/datetimepickerstyle.css" />
<script>
	$(function(){
		$("#mod").click(function(){
			var cno = "${coupon.cno}";
			var page =	"${cri.page}";
			var searchType = "${cri.searchType}"==""?"N":"${cri.searchType}";
			var searchType2 = "${cri.searchType2}"==""?"N":"${cri.searchType2}";
			var keyword = "${cri.keyword}";
			/* location.href = "editNotice?no="+no+"&page="+page+"&searchType="+searchType+"&searchType2="+searchType2+"&keyword="+keyword; */
			location.href = "editCoupon?cno="+cno;
		})
		$("#del").click(function(){
			if(!confirm("삭제하시겠습니까?")) {
				return false;
			}
			var cno = "${coupon.cno}";
			var page =	"${cri.page}";
			var searchType = "${cri.searchType}"==""?"N":"${cri.searchType}";
			var searchType2 = "${cri.searchType2}"==""?"N":"${cri.searchType2}";
			var keyword = "${cri.keyword}";
			location.href = "removeCoupon?cno="+cno+"&page="+page+"&searchType="+searchType+"&searchType2="+searchType2+"&keyword="+keyword;
		})
		$("#return").click(function() {
			var page =	"${cri.page}";
			var searchType = "${cri.searchType}"==""?"N":"${cri.searchType}";
			var searchType2 = "${cri.searchType2}"==""?"N":"${cri.searchType2}";
			var keyword = "${cri.keyword}";
			location.href = "couponMngList?page="+page+"&searchType="+searchType+"&searchType2="+searchType2+"&keyword="+keyword;
		})
	})
</script>
<script>
function getFormatDate(pdate) {
	var year = pdate.getFullYear() + "-"; //yyyy
	var month = (pdate.getMonth()) + "-"; //M
	month = month >= 10 ? month : '0' + month; //month 두자리로 저장
	var day = pdate.getDate(); //d
	day = day >= 10 ? day : '0' + day; //day 두자리로 저장
	return year + '' + month + '' + day;
}
$(document).ready(function(){   
	 $('.dateTimePicker').datetimepicker({format:"YYYY-MM-DD"});
	       /*  $('#datepicker1').datetimepicker({
	            useCurrent: false
	        });
	        $('#datepicker2').datetimepicker({
	            useCurrent: false
	        });
	       
	       // 함수 호출 순서가 4,3,2 순서이다.
	       // 4가 바뀌어야 3이 바뀌고 3이 바뀌어야 2가 바뀐다.
	        $("#datepicker1").on("dp.change", function (e) {
	            $('#datepicker4').data("DateTimePicker").minDate(e.date);
	        });
	        $("#datepicker1").on("dp.change", function (e) {
	            $('#datepicker3').data("DateTimePicker").minDate(e.date);
	        });
	        $("#datepicker1").on("dp.change", function (e) {
	            $('#datepicker2').data("DateTimePicker").minDate(e.date);
	        });
	        
	        
	         */
     
		var pdate = "${pdate}";
		/* console.log(pdate);
		$("input[name='pdate']").val(pdate); */
	});
</script> 
<div class="content">
	<div class="row">
		<div class="col-sm-12">
			<div class="box box-primary">
				<div class="box-header">
				
					<h3 class="box-title">쿠폰</h3>
				</div>
				<div class="box-body">
				<c:if test="${expired != null}">
				<script>
					alert("해당 쿠폰은 만료된 쿠폰입니다.");
				</script>
				</c:if>
					<div class="form-group">
						<label>번호</label>
						<input type="text" name="no" class="form-control" value="${coupon.cno}" readonly="readonly">
					</div>
					<div class="form-group">
						<label>쿠폰 명</label>
						<input type="text" name="title" class="form-control" value="${coupon.cname}" readonly="readonly">
					</div>
					<div class="form-group">
						<label>시작 일자</label>
						<div class='input-group date dateTimePicker' id='datetimepicker1'>
						<fmt:formatDate value="${pdate }" pattern="yyyy-MM-dd" var="fmtpdate"/>
					    <input type='text' class="form-control" name="pdate" value='${fmtpdate }'/>
					       <span class="input-group-addon">
					         <span class="glyphicon glyphicon-calendar"></span>
                  				</span>
						</div>
						<label>종료 일자</label>
						<div class='input-group date dateTimePicker' id='datetimepicker2'>
						<fmt:formatDate value="${edate }" pattern="yyyy-MM-dd" var="fmtedate"/>
					    <input type='text' class="form-control" name="edate" value=${fmtedate }/>
					       <span class="input-group-addon">
					         <span class="glyphicon glyphicon-calendar"></span>
                  				</span>
					</div>
					 <script type="text/javascript">

		          $(function () {
		            $('#datetimepicker1').datetimepicker();
		            $('#datetimepicker2').datetimepicker();
		          });

       		 </script>
					<div class="form-group">
						<label>쿠폰 내용</label>
						<textarea rows="15" cols="30" name="content" class="form-control" readonly="readonly">${coupon.ccontent }</textarea>
					</div>
					<div class="form-group">
						<label>쿠폰 할인율</label>
						<input type="text" name="mrate" class="form-control" value="${coupon.mrate}" readonly="readonly">
					</div>
				<div class="box-footer">
					<button class="btn btn-warning" id="mod">수정</button>
					<button class="btn btn-danger" id="del">삭제</button>
					<button class="btn btn-primary" id="return">돌아가기</button>
				</div>
				</div>
				</div>
		</div>
	</div>
</div>
</div>
<%@ include file="../../include/footer.jsp"%>