<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
table th, td {
	text-align: center;
}

.modalbtn {
	width: 80px;
	height: 30px;
	font-size: 14px;
	line-height: 0px;
	text-align: center;
	padding: 5px;
}

.red {
	color: red;
}

.blue {
	color: steelblue;
	font-weight: bold;
}

h4 {
	font-weight: bold;
}
#btnSearch{
	margin-left:20px;
}
</style>
<div class="content">
	<div class="row">
		<div class="col-sm-12">
			<div class="box box-primary">
				<div class="box-header">
					<h2 class="box-title">결제 관리</h2>
				</div>
				<div class="box-body">
					<select name="searchType" id="searchType">
						<option value="n">-----</option>
						<option value="no">번호</option>
						<option value="name">고객명</option>
						<option value="pname">상품명</option>
					</select> <input type="text" name="keyword" id="keywordInput">
					<button id="btnSearch">검색</button>
				</div>
				<div class="box-body">
					<table class="table table-bordered">
						<tr>
							<th>번호</th>
							<th>고객명</th>
							<th>상품명</th>
							<th>항공편</th>
							<th>출발날짜</th>
							<th>도착날짜</th>
							<th>예약 관리</th>
						</tr>
						<tr>
							<td>1</td>
							<td><a href="#">테스트 고객</a></td>
							<td>상품1</td>
							<td>AK001</td>
							<td>2020/04/25</td>
							<td>2020/04/26</td>
							<td><button type="button"
									class="btn btn-info btn-lg modalbtn" data-toggle="modal"
									data-target="#myModal">예약 상세</button></td>
						</tr>
						<tr>
							<td>2</td>
							<td><a href="#">테스트 고객</a></td>
							<td>상품1</td>
							<td>AK001</td>
							<td>2020/04/25</td>
							<td>2020/04/26</td>
							<td><button type="button"
									class="btn btn-info btn-lg modalbtn" data-toggle="modal"
									data-target="#myModal">예약 상세</button></td>
						</tr>
						<tr>
							<td>3</td>
							<td><a href="#">테스트 고객</a></td>
							<td>상품1</td>
							<td>AK001</td>
							<td>2020/04/25</td>
							<td>2020/04/26</td>
							<td><button type="button"
									class="btn btn-info btn-lg modalbtn" data-toggle="modal"
									data-target="#myModal">예약 상세</button></td>
						</tr>
						<tr>
							<td>4</td>
							<td><a href="#">테스트 고객</a></td>
							<td>상품1</td>
							<td>AK001</td>
							<td>2020/04/25</td>
							<td>2020/04/26</td>
							<td><button type="button"
									class="btn btn-info btn-lg modalbtn" data-toggle="modal"
									data-target="#myModal">예약 상세</button></td>
						</tr>
					</table>
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
								<table class="table table-bordered" id="airTable"
									style="width: 100%;">
									<tr>
										<th style="width: 100px;">유저번호</th>
										<th>유저명</th>
										<th>생년월일</th>
										<th>여권등록여부</th>
										<th>유저아이디</th>
									</tr>
									<tr>
										<td>6</td>
										<td>테스트</td>
										<td>1991-12-18</td>
										<td class="red">등록 필요</td>
										<td>user</td>
									</tr>
								</table>
								<h4>항공편</h4>
								<h5>출발 항공편</h5>
								<table class="table table-bordered" id="airTable"
									style="width: 100%;">
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
									<tr>
										<td>2483</td>
										<td>JA121</td>
										<td>ICN</td>
										<td>NRT</td>
										<td>2020-05-16</td>
										<td>2020-05-16</td>
										<td>10</td>
										<td>Economy-Class</td>
										<td>150000</td>
									</tr>
								</table>
								<h5>도착 항공편</h5>
								<table class="table table-bordered" id="airTable"
									style="width: 100%;">
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
									<tr>
										<td>2484</td>
										<td>JA122</td>
										<td>NRT</td>
										<td>ICN</td>
										<td>2020-05-22</td>
										<td>2020-05-22</td>
										<td>10</td>
										<td>Economy-Class</td>
										<td>150000</td>
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
									<tr>
										<td>420</td>
										<td>Shinagawa Prince Hotel</td>
										<td>4-10-30 Takanawa Minato Tokyo 108-8612 도쿄 일본</td>
										<td>2020-05-16</td>
										<td>2020-05-22</td>
										<td>4인</td>
										<td>340000</td>
										<td>3</td>
										<td>디럭스</td>
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
									<tr>
										<td>2970</td>
										<td>또 다른 신사, 하나조노 신사</td>
										<td>도쿄</td>
										<td>2020-05-16</td>
										<td>2020-05-16</td>
										<td>5 Chome-17-3 Shinjuku, Shinjuku City, Tokyo 160-0022</td>
										<td>01:00:00</td>
										<td>40</td>
										<td>5,000</td>
									</tr>
									<tr>
										<td>2969</td>
										<td>놀이공원,아이스스케이팅,롤러코스터,워터파크및 공원,토시마엔</td>
										<td>도쿄</td>
										<td>2020-05-18</td>
										<td>2020-05-18</td>
										<td>3 Chome-25-1 Koyama, Nerima City, Tokyo 176-0022</td>
										<td>03:00:00</td>
										<td>40</td>
										<td>10,000</td>
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
									<tr>
										<td>2850</td>
										<td>V</td>
										<td>足立215-13</td>
										<td>2020-05-16</td>
										<td>2020-05-22</td>
										<td>나리타 공항</td>
										<td>나리타 공항</td>
										<td>350000</td>
										<td>10</td>
										<td>yes</td>
									</tr>
								</table>
								<h4>결제 여부</h4>
								<p class="blue">결제 완료</p>
								<button type="button" class="btn btn-danger"
									data-dismiss="modal">예약 확정</button>
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
	$("#btnSearch").click(
			function() {
				var searchType = $("#searchType").val();
				var keyword = $("#keywordInput").val();
				location.href = "listPage?searchType=" + searchType
						+ "&keyword=" + keyword;
				//searchBoardController의 listPage GET 으로 받음 
			})

	$("#btnRegister").click(function() {
		location.href = "register";
	})
</script>

<%@ include file="../../include/footer.jsp"%>