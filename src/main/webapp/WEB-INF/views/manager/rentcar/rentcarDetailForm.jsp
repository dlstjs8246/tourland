<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
	label{
		padding-bottom:6px;
	}
	.form-group{
		float:left;
		width: 300px;
		margin: 20px 50px 20px 0px;
	}
	input[name='no']{
		background: lightGray;
		width:200px;
	}
	.noNameAddr{
		height:105px;
	}
	.red{
		color:red;
	}
	input[name='checkin'], input[name='checkout'], input[name='price'] {
		width:262px;
	}
	[type="date"] {
	background: #fff
		url(https://cdn1.iconfinder.com/data/icons/cc_mono_icon_set/blacks/16x16/calendar_2.png)
		97% 50% no-repeat;
	}

	[type="date"]::-webkit-inner-spin-button {
		display: none;
	}

	[type="date"]::-webkit-calendar-picker-indicator {
		opacity: 0;
	}
	
	 #rentcarForm input, select{
      width: 300px;
      margin-left:10px;
    }


</style>
<script>
$(function(){
	$(function() {
		//달력을 오늘 이후로만 선택할 수 있게
		var now = new Date();
		var day = now.getDate();
		var month = (now.getMonth() + 1);
		var year = now.getFullYear();
		if (day < 10) {
			day = '0' + day;
		}
		if (month < 10) {
			month = '0' + month;
		}
		today = year + '-' + month + '-' + day;
		document.getElementById("checkin").setAttribute("min", today);
	})
	
	$(function(){
		$("#checkin").change(function() {
			//체크인 날짜가 선택되면 체크아웃은 체크인날짜 다음날부터 선택할 수 있게
			var checkIn = document.getElementById("checkin").value;
			var day = parseInt(checkIn.substr(8,10))+1;
			if (day < 10) {
				day = '0' + day;
			}
			var result = checkIn.substr(0,7)+ '-' + day;
			document.getElementById("checkout").setAttribute("min",result);
		})
	})
	
	//리스트로 버튼 눌렀을 때 리스트로 돌아가기 
		$("#btnReturnToList").click(function(){
			location.href="${pageContext.request.contextPath}/manager/rentcarMngList";
		})
		
		$("form").submit(function(){
			alert("수정 되었습니다");
		})

  // alert("${rentcarVO.rentddate }");
})
</script>
<div class="content">
	<div class="row">
		<div class="col-sm-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">렌트카 상품 상세페이지</h3>
				</div>
				<form role="form" action="rentcarDetailFormUpdate" method="post" id="rentcarForm">
					<div class="box-body">
						<div class="noNameAddr">
							<label><span class="red">*</span>번호</label>
							<input type="text" name="no" class="form-control" value="${rentcarVO.no}" readonly>
						</div>
						<div class="noNameAddr">
							<label><span class="red">*</span>차 종류</label>
							<select name="cdiv" class="form-control" required="required" style="width:300px;">
							   <option value="L" ${rentcarVO.cdiv=='L'?'selected':''}>경차</option>
							   <option value="S" ${rentcarVO.cdiv=='S'?'selected':''}>세단</option>
							   <option value="U" ${rentcarVO.cdiv=='U'?'selected':''}>SUV</option>
							   <option value="V" ${rentcarVO.cdiv=='V'?'selected':''}>밴</option>
							   <option value="B" ${rentcarVO.cdiv=='B'?'selected':''}>버스</option>
							</select>
						</div>
						<div class="noNameAddr">
							<label><span class="red">*</span>차번호</label>
							<input type="text" name="cno" class="form-control" required="required" value="${rentcarVO.cno }">					<!-- 리스트 불러오도록 할 것  -->		
						</div>
						<div class="form-group">
							<label><span class="red">*</span>대여 날짜</label>
							<input type="date" name="rentddate" class="form-control"  required="required" id="checkin" value="<fmt:formatDate value="${rentcarVO.rentddate}" pattern='yyyy-MM-dd'/>">	
						</div>
						<div class="form-group">
							<label><span class="red">*</span>반납 날짜</label>
							<input type="date" name="returndate" class="form-control" required="required" id="checkout" value="<fmt:formatDate value="${rentcarVO.returndate}" pattern='yyyy-MM-dd'/>">
						</div>
						<div class="form-group">
							<label><span class="red">*</span>대여장소</label>
							<input type="text" name="rentaddr" class="form-control" required="required" value="${rentcarVO.rentaddr }">							
						</div>
						<div class="form-group">
							<label><span class="red">*</span>반납장소</label>
							<input type="text" name="returnaddr" class="form-control" required="required" value="${rentcarVO.returnaddr }">					
						</div>
						<div class="form-group">
							<label><span class="red">*</span>가격</label>
							<input type="text" name="price" class="form-control" required="required" value="${rentcarVO.price }">					
						</div>
						<div class="form-group">
							<label><span class="red">*</span>허용인원 수</label>
							<select name="capacity" class="form-control"  required="required">
								<option value="4"  ${rentcarVO.capacity=='4'?'selected':''}>4명</option>
								<option value="6"  ${rentcarVO.capacity=='6'?'selected':''}>6명</option>
								<option value="10" ${rentcarVO.capacity=='10'?'selected':''}>10명</option>
								<option value="30" ${rentcarVO.capacity=='30'?'selected':''}>30명</option>
							</select> 
						</div>
						<div class="form-group">
							<label><span class="red">*</span>보험여부</label>
							<select name="insurance" class="form-control" id="ldiv" required="required">
								<option value="0" ${rentcarVO.insurance=='0'?'selected':''}>선택안함</option>
								<option value="1" ${rentcarVO.insurance=='1'?'selected':''}>포함</option>
							</select> 	
						</div>
						<div class="form-group">
							<label>장소구분</label>
							<select name="ldiv" class="form-control" id="ldiv" required="required">
								<option value="0" ${rentcarVO.ldiv=='0'?'selected':''}>해외</option>
								<option value="1" ${rentcarVO.ldiv=='0'?'selected':''}>국내</option>
							</select> 
						</div>
					
						<div class="box-footer" style="clear:both;">
							<button type="submit" class="btn btn-primary">수정</button> <br>
						    <button type="button" class="btn btn-primary" id="btnReturnToList" style="margin-top:10px;">목록으로</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<%@ include file="../../include/footer.jsp"%>