<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
.box-body {
	height: 600px;
}
</style>
<script>
	/*  스크립트 들어올 부분 */
</script>
<div class="content">
	<div class="row">
		<div class="col-sm-12">
			<div class="box box-primary">
				<div class="box-header">
					<h2 class="box-title">통계</h2>
				</div>
				<div class="box-body" id="chart1"></div>
				<div class="box-body" id="chart2"></div>
				<script type="text/javascript"
					src="https://www.gstatic.com/charts/loader.js"></script>
				<script type="text/javascript">
					var jeju = [];
					var beijing = [];
					var dokyo = [];
					for (var i = 0; i < 12; i++) {
						jeju[i] = Math.floor(Math.random() * 1000000);
						beijing[i] = Math.floor(Math.random() * 10000000);
						dokyo[i] = Math.floor(Math.random() * 10000000);
					}
					google.charts.load('current', {
						'packages' : [ 'bar' ]
					});
					google.charts.setOnLoadCallback(drawChart);
					google.charts.load('current', {
						'packages' : [ 'coreChart' ]
					});
					google.charts.setOnLoadCallback(drawChart2);
					function drawChart() {
						var data = google.visualization.arrayToDataTable([
								[ '월', '제주', '베이징', '도쿄' ],
								[ '1월', jeju[0], beijing[0], dokyo[0] ],
								[ '2월', jeju[1], beijing[1], dokyo[1] ],
								[ '3월', ${jeju[0].totalprice!=null?jeju[0].totalprice:0}, ${beijing[0].totalprice!=null?beijing[0].totalprice:0}, ${dokyo[0].totalprice!=null?dokyo[0].totalprice:0} ],
								[ '4월', ${jeju[1].totalprice!=null?jeju[1].totalprice:0}, ${beijing[1].totalprice!=null?beijing[1].totalprice:0}, ${dokyo[1].totalprice!=null?dokyo[1].totalprice:0} ],
								[ '5월', ${jeju[2].totalprice!=null?jeju[2].totalprice:0}, ${beijing[2].totalprice!=null?beijing[2].totalprice:0}, ${dokyo[2].totalprice!=null?dokyo[2].totalprice:0} ],
								[ '6월', ${jeju[3].totalprice!=null?jeju[3].totalprice:0}, ${beijing[3].totalprice!=null?beijing[3].totalprice:0}, ${dokyo[3].totalprice!=null?dokyo[3].totalprice:0} ],
								[ '7월', jeju[6], beijing[6], dokyo[6] ],
								[ '8월', jeju[7], beijing[7], dokyo[7] ],
								[ '9월', jeju[8], beijing[8], dokyo[8] ],
								[ '10월', jeju[9], beijing[9], dokyo[9] ],
								[ '11월', jeju[10], beijing[10], dokyo[10] ],
								[ '12월', jeju[11], beijing[11], dokyo[11] ] ]);

						var options = {
							chart : {
								title : '월별 여행상품 매출 현황',
								subtitle : '2020년'
							}
						};

						var chart = new google.charts.Bar(document
								.getElementById('chart1'));
						chart.draw(data, google.charts.Bar
								.convertOptions(options));
					}
					function drawChart2() {
						var data = google.visualization.arrayToDataTable([
					          ['상품명', '예약확정건수'],
					          ['${list2[0].pname}',  ${list2[0].count}],
					          ['${list2[1].pname}',  ${list2[1].count}],
					          ['${list2[2].pname}',  ${list2[2].count}],
					          ['${list2[3].pname}',  ${list2[3].count}],
					          ['${list2[4].pname}',  ${list2[4].count}]
					        ]);

					        var options = {
					          title : '투어랜드 인기 상품',
					          vAxis: {title: '예약확정건수'},
					          hAxis: {title: '상품명'},
					          seriesType: 'bars'};

					        var chart = new google.visualization.ComboChart(document.getElementById('chart2'));
					        chart.draw(data, options);
					}
				</script>
			</div>

		</div>
	</div>
</div>

<%@ include file="../../include/footer.jsp"%>