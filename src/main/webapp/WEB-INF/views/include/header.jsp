<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<script src="https://kit.fontawesome.com/6f2f0f2d95.js"></script>

<script
	src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>



<meta charset="UTF-8">
<title>AdminLTE 2 | Dashboard</title>
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<!-- Bootstrap 3.3.4 -->
<link
	href="${pageContext.request.contextPath }/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<!-- Font Awesome Icons -->
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />
<!-- Ionicons -->
<link
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"
	rel="stylesheet" type="text/css" />
<!-- Theme style -->
<link
	href="${pageContext.request.contextPath }/resources/dist/css/AdminLTE.min.css"
	rel="stylesheet" type="text/css" />
<!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
<link
	href="${pageContext.request.contextPath }/resources/dist/css/skins/_all-skins.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/plugins/datepicker/datepicker3.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/plugins/datepicker/bootstrap-datepicker.js"></script>
<script src="//cdn.ckeditor.com/4.14.0/standard/ckeditor.js"></script>
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<!-- jQuery 2.1.4 -->
<script
	src="${pageContext.request.contextPath }/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<script>
	$(function() {
		$(".dropdown").click(function() {
			$(".dropdown-menu").css("display", "none");
			$(this).find(".dropdown-menu").css("display", "block");
		})
		$(".dropdown-menu").mouseover(function() {
			$(this).css("display", "block");
		})
 		$(".dropdown-menu").mouseout(function() {
			$(this).css("display", "none");
		})

	})
</script>
<style>
#goToCustomer {
	height: 50px;
}

#goToCustomer a {
	width: 75px;
	height: 20px;
	border: none;
	background: maroon;
	margin: 15px 30px;
	color: #fff;
	font-size: 12px;
	border-radius: 3px;
	padding: 0;
	text-align: center;
}
</style>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">

		<header class="main-header">
			<!-- Logo -->
			<c:if test="${Manager.right==1 }">
				<a href="${pageContext.request.contextPath }/manager/empMngList/0"
					class="logo"> <!-- mini logo for sidebar mini 50x50 pixels --> <span
					class="logo-mini"><b>A</b>LT</span> <!-- logo for regular state and mobile devices -->
				<span class="logo-lg" id="logoTourLand"><b>TourLand</b></span>
			</a>
			</c:if>
			<c:if test="${Manager.right==0 }">
				<a href="${pageContext.request.contextPath }/manager/userMngList/0"
					class="logo"> <!-- mini logo for sidebar mini 50x50 pixels --> <span
					class="logo-mini"><b>A</b>LT</span> <!-- logo for regular state and mobile devices -->
				<span class="logo-lg" id="logoTourLand"><b>TourLand</b></span>
			</a>
			</c:if>

			<nav class="navbar navbar-static-top" role="navigation">
				<!-- Sidebar toggle button-->
				<a href="#" class="sidebar-toggle" data-toggle="offcanvas"
					role="button"> <span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
				</a>
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<!-- Messages: style can be found in dropdown.less-->
						<li id="goToCustomer"><a
							href="${pageContext.request.contextPath }/customer/tourlandMain">고객
								페이지</a></li>
						<li class="dropdown messages-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <i
								class="fa fa-envelope-o"></i> <span class="label label-success">4</span>
						</a>
							<ul class="dropdown-menu">
								<li class="header">You have 4 messages</li>
								<li>
									<!-- inner menu: contains the actual data -->
									<ul class="menu">
										<li>
											<!-- start message --> <a href="#">
												<div class="pull-left">
													<img
														src="${pageContext.request.contextPath }/resources/dist/img/user7-128x128.jpg"
														class="img-circle" alt="User Image" />
												</div>
												<h4>
													Support Team <small><i class="fa fa-clock-o"></i> 5
														mins</small>
												</h4>
												<p>Why not buy a new awesome theme?</p>
										</a>
										</li>
										<!-- end message -->
										<li><a href="#">
												<div class="pull-left">
													<img
														src="${pageContext.request.contextPath }/resources/dist/img/user3-128x128.jpg"
														class="img-circle" alt="user image" />
												</div>
												<h4>
													AdminLTE Design Team <small><i
														class="fa fa-clock-o"></i> 2 hours</small>
												</h4>
												<p>Why not buy a new awesome theme?</p>
										</a></li>
										<li><a href="#">
												<div class="pull-left">
													<img
														src="${pageContext.request.contextPath }/resources/dist/img/user4-128x128.jpg"
														class="img-circle" alt="user image" />
												</div>
												<h4>
													Developers <small><i class="fa fa-clock-o"></i>
														Today</small>
												</h4>
												<p>Why not buy a new awesome theme?</p>
										</a></li>
										<li><a href="#">
												<div class="pull-left">
													<img
														src="${pageContext.request.contextPath }/resources/dist/img/user3-128x128.jpg"
														class="img-circle" alt="user image" />
												</div>
												<h4>
													Sales Department <small><i class="fa fa-clock-o"></i>
														Yesterday</small>
												</h4>
												<p>Why not buy a new awesome theme?</p>
										</a></li>
										<li><a href="#">
												<div class="pull-left">
													<img
														src="${pageContext.request.contextPath }/resources/dist/img/user4-128x128.jpg"
														class="img-circle" alt="user image" />
												</div>
												<h4>
													Reviewers <small><i class="fa fa-clock-o"></i> 2
														days</small>
												</h4>
												<p>Why not buy a new awesome theme?</p>
										</a></li>
									</ul>
								</li>
								<li class="footer"><a href="#">See All Messages</a></li>
							</ul></li>
						<!-- Notifications: style can be found in dropdown.less -->
						<li class="dropdown notifications-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <i
								class="fa fa-bell-o"></i> <span class="label label-warning">10</span>
						</a>
							<ul class="dropdown-menu">
								<li class="header">You have 10 notifications</li>
								<li>
									<!-- inner menu: contains the actual data -->
									<ul class="menu">
										<li><a href="#"> <i class="fa fa-users text-aqua"></i>
												5 new members joined today
										</a></li>
										<li><a href="#"> <i class="fa fa-warning text-yellow"></i>
												Very long description here that may not fit into the page
												and may cause design problems
										</a></li>
										<li><a href="#"> <i class="fa fa-users text-red"></i>
												5 new members joined
										</a></li>

										<li><a href="#"> <i
												class="fa fa-shopping-cart text-green"></i> 25 sales made
										</a></li>
										<li><a href="#"> <i class="fa fa-user text-red"></i>
												You changed your username
										</a></li>
									</ul>
								</li>
								<li class="footer"><a href="#">View all</a></li>
							</ul></li>
						<!-- Tasks: style can be found in dropdown.less -->
						<li class="dropdown tasks-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <i
								class="fa fa-flag-o"></i> <span class="label label-danger">9</span>
						</a>
							<ul class="dropdown-menu">
								<li class="header">You have 9 tasks</li>
								<li>
									<!-- inner menu: contains the actual data -->
									<ul class="menu">
										<li>
											<!-- Task item --> <a href="#">
												<h3>
													Design some buttons <small class="pull-right">20%</small>
												</h3>
												<div class="progress xs">
													<div class="progress-bar progress-bar-aqua"
														style="width: 20%" role="progressbar" aria-valuenow="20"
														aria-valuemin="0" aria-valuemax="100">
														<span class="sr-only">20% Complete</span>
													</div>
												</div>
										</a>
										</li>
										<!-- end task item -->
										<li>
											<!-- Task item --> <a href="#">
												<h3>
													Create a nice theme <small class="pull-right">40%</small>
												</h3>
												<div class="progress xs">
													<div class="progress-bar progress-bar-green"
														style="width: 40%" role="progressbar" aria-valuenow="20"
														aria-valuemin="0" aria-valuemax="100">
														<span class="sr-only">40% Complete</span>
													</div>
												</div>
										</a>
										</li>
										<!-- end task item -->
										<li>
											<!-- Task item --> <a href="#">
												<h3>
													Some task I need to do <small class="pull-right">60%</small>
												</h3>
												<div class="progress xs">
													<div class="progress-bar progress-bar-red"
														style="width: 60%" role="progressbar" aria-valuenow="20"
														aria-valuemin="0" aria-valuemax="100">
														<span class="sr-only">60% Complete</span>
													</div>
												</div>
										</a>
										</li>
										<!-- end task item -->
										<li>
											<!-- Task item --> <a href="#">
												<h3>
													Make beautiful transitions <small class="pull-right">80%</small>
												</h3>
												<div class="progress xs">
													<div class="progress-bar progress-bar-yellow"
														style="width: 80%" role="progressbar" aria-valuenow="20"
														aria-valuemin="0" aria-valuemax="100">
														<span class="sr-only">80% Complete</span>
													</div>
												</div>
										</a>
										</li>
										<!-- end task item -->
									</ul>
								</li>
								<li class="footer"><a href="#">View all tasks</a></li>
							</ul></li>
						<!-- User Account: style can be found in dropdown.less -->
						<li class="dropdown user user-menu">
							<!-- 오른쪽 상단 작은 프로필 부분 --> <a href="#" class="dropdown-toggle"
							data-toggle="dropdown"> <img
								src="${pageContext.request.contextPath }/resources/dist/img/hs.jpg"
								class="user-image" alt="User Image" /> <span class="hidden-xs">${Manager.name }</span>
						</a>
							<ul class="dropdown-menu">
								<!-- User image -->
								<li class="user-header"><img
									src="${pageContext.request.contextPath }/resources/dist/img/user2-160x160.jpg"
									class="img-circle" alt="User Image" /> <c:if
										test="${Manager.right == 0 }">
										<p>${Manager.name }- Web Developer</p>
									</c:if> <c:if test="${Manager.right == 1 }">
										<p>${Manager.name }- administrator</p>
									</c:if></li>
								<!-- Menu Body -->
								<!-- Menu Footer-->
								<li class="user-footer">
									<div class="pull-left">
										<a href="${pageContext.request.contextPath }/manager/employeeDetail/0?empno=${Auth.empno}" class="btn btn-default btn-flat">프로필</a>
									</div>
									<div class="pull-right">
										<a href="${pageContext.request.contextPath}/logout"
											class="btn btn-default btn-flat">로그아웃</a>
									</div>
								</li>
							</ul>
						</li>
						<!-- Control Sidebar Toggle Button -->
						<li><a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a></li>
					</ul>
				</div>
			</nav>
		</header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<!-- 왼쪽 메인 메뉴 내 프로필 부분 -->
				<div class="user-panel">
					<div class="pull-left image">
						<img
							src="${pageContext.request.contextPath }/resources/dist/img/hs.jpg"
							class="img-circle" alt="User Image" />
					</div>
					<div class="pull-left info">
						<p>${Manager.name }</p>
						<a href="#"><i class="fa fa-circle text-success"></i> 내 프로필</a>
					</div>
				</div>
				<!-- 왼쪽 메인 메뉴 검색 부분 -->
				<form action="#" method="get" class="sidebar-form">
					<div class="input-group">
						<input type="text" name="q" class="form-control"
							placeholder="Search..." /> <span class="input-group-btn">
							<button type='submit' name='search' id='search-btn'
								class="btn btn-flat">
								<i class="fa fa-search"></i>
							</button>
						</span>
					</div>
				</form>
				<!-- /.search form -->
				<!-- sidebar menu: : style can be found in sidebar.less -->
				<ul class="sidebar-menu">
					<li class="header">MAIN NAVIGATION</li>
					<li class="treeview"><c:if test="${Manager.right == 1 }">
							<a href="${pageContext.request.contextPath }/manager/empMngList/0"> <i
								class="fa fa-dashboard"></i> <span>직원 관리</span>
							<!--  <i class="fa fa-angle-left pull-right"></i> -->
							</a>
						</c:if> <%-- <ul class="treeview-menu">
                <li><a href="${pageContext.request.contextPath }/resources/index.html"><i class="fa fa-circle-o"></i> Dashboard v1</a></li>
                <li><a href="${pageContext.request.contextPath }/resources/index2.html"><i class="fa fa-circle-o"></i> Dashboard v2</a></li>
              </ul> --%></li>
					<li class="treeview"><a
						href="${pageContext.request.contextPath }/manager/userMngList/0"> <i
							class="fa fa-files-o"></i> <span>고객 관리</span> <!--  <span class="label label-primary pull-right">4</span>    -->
							<!-- new인 갯수 뜨는거 -->
					</a> <!-- <ul class="treeview-menu">
                <li><a href="../layout/top-nav.html"><i class="fa fa-circle-o"></i> Top Navigation</a></li>
                <li><a href="../layout/boxed.html"><i class="fa fa-circle-o"></i> Boxed</a></li>
                <li><a href="../layout/fixed.html"><i class="fa fa-circle-o"></i> Fixed</a></li>
                <li><a href="../layout/collapsed-sidebar.html"><i class="fa fa-circle-o"></i> Collapsed Sidebar</a></li>
              </ul> --></li>
					
            <li>
              <a href="${pageContext.request.contextPath }/manager/reservationMgnList">
                <i class="fa fa-th"></i> <span>예약 관리</span> <!-- <small class="label pull-right bg-green">new</small> --> <!-- new 글자뜨는거 -->
              </a>
            </li>
            <li class="treeview">  
              <a href="#">
                <i class="fa fa-pie-chart"></i>     
                <span>상품 관리</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
              
                <li><a href="${pageContext.request.contextPath }/manager/flightMngList"><i class="fa fa-circle-o"></i>항공 관리</a></li>
                <%-- <li><a href="${pageContext.request.contextPath }/addFlightForm"><i class="fa fa-circle-o"></i>항공 관리</a></li> --%>
                <li><a href="${pageContext.request.contextPath }/manager/hotelMngList"><i class="fa fa-circle-o"></i>호텔 관리</a></li>
                <li><a href="${pageContext.request.contextPath }/manager/tourMngList"><i class="fa fa-circle-o"></i>현지 투어 관리</a></li>
                <li><a href="${pageContext.request.contextPath }/manager/rentcarMngList"><i class="fa fa-circle-o"></i> 렌트카 관리</a></li>
                 <li><a href="${pageContext.request.contextPath }/manager/productMngList"><i class="fa fa-circle-o text-red"></i>상품 목록</a></li>
              </ul>
            </li>  
            <li class="treeview">   
              <a href="${pageContext.request.contextPath }/manager/eventMngList">
                <i class="fa fa-laptop"></i>    
                <span>이벤트 관리</span>
               <!--  <i class="fa fa-angle-left pull-right"></i> -->
              </a>   
           <!--    <ul class="treeview-menu">  
>>>>>>> branch 'master' of https://github.com/dlstjs8246/tourland.git
                <li><a href="../UI/general.html"><i class="fa fa-circle-o"></i> General</a></li>   
                <li><a href="../UI/icons.html"><i class="fa fa-circle-o"></i> Icons</a></li>
                <li><a href="../UI/buttons.html"><i class="fa fa-circle-o"></i> Buttons</a></li>
                <li><a href="../UI/sliders.html"><i class="fa fa-circle-o"></i> Sliders</a></li>
                <li><a href="../UI/timeline.html"><i class="fa fa-circle-o"></i> Timeline</a></li>
                <li><a href="../UI/modals.html"><i class="fa fa-circle-o"></i> Modals</a></li>
              </ul> --></li>
					<li class="treeview"><a href="#"> <i
							class="fa fa-pie-chart"></i> <span>게시판 관리</span> <i
							class="fa fa-angle-left pull-right"></i>
					</a>
						<ul class="treeview-menu">
							<li><a href="${pageContext.request.contextPath}/manager/FAQMngList"><i
									class="fa fa-circle-o"></i>FAQ 관리</a></li>
							<li><a
								href="${pageContext.request.contextPath}/manager/custBoardMngList"><i
									class="fa fa-circle-o"></i>고객의 소리 관리</a></li>
							<li><a href="${pageContext.request.contextPath}/manager/planBoardList"><i
									class="fa fa-circle-o"></i>상품 문의사항 관리</a></li>
						</ul></li>
					<!-- <li class="treeview active">
              <a href="#">
                <i class="fa fa-edit"></i> <span>FAQ 관리</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li class="active"><a href="general.html"><i class="fa fa-circle-o"></i> General Elements</a></li>
                <li><a href="advanced.html"><i class="fa fa-circle-o"></i> Advanced Elements</a></li>
                <li><a href="editors.html"><i class="fa fa-circle-o"></i> Editors</a></li>
              </ul>
            </li>   -->
					<!-- <li class="treeview">
              <a href="#">
                <i class="fa fa-table"></i> <span>고객의 소리 관리</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li><a href="../tables/simple.html"><i class="fa fa-circle-o"></i> Simple tables</a></li>
                <li><a href="../tables/data.html"><i class="fa fa-circle-o"></i> Data tables</a></li>
              </ul>
            </li> -->
					<!-- <li>
              <a href="../calendar.html">
                <i class="fa fa-calendar"></i> <span>상품 문의사항 관리</span>
                <small class="label pull-right bg-red">3</small>
              </a>
            </li> -->
					<li class="treeview"><a href="#"> <i
							class="fa fa-pie-chart"></i> <span>디자인 관리</span> <i
							class="fa fa-angle-left pull-right"></i>
					</a>
						<ul class="treeview-menu">
							<li><a
								href="${pageContext.request.contextPath}/manager/popupMngList"><i
									class="fa fa-circle-o"></i>팝업 관리</a></li>
							<li><a
								href="${pageContext.request.contextPath}/manager/bannerMngList"><i
									class="fa fa-circle-o"></i>배너 관리</a></li>
						</ul></li>
					<!-- <li>
              <a href="../mailbox/mailbox.html">
                <i class="fa fa-envelope"></i> <span>팝업/배너 관리</span>
                <small class="label pull-right bg-yellow">12</small>
              </a>
            </li> -->
					<li class="treeview"><a
						href="${pageContext.request.contextPath }/manager/noticeMngList"> <i
							class="fa fa-folder"></i> <span>공지사항 관리</span> <!--   <i class="fa fa-angle-left pull-right"></i> -->
					</a> <!-- <ul class="treeview-menu">
                <li><a href="../examples/invoice.html"><i class="fa fa-circle-o"></i> Invoice</a></li>
                <li><a href="../examples/login.html"><i class="fa fa-circle-o"></i> Login</a></li>
                <li><a href="../examples/register.html"><i class="fa fa-circle-o"></i> Register</a></li>
                <li><a href="../examples/lockscreen.html"><i class="fa fa-circle-o"></i> Lockscreen</a></li>
                <li><a href="../examples/404.html"><i class="fa fa-circle-o"></i> 404 Error</a></li>
                <li><a href="../examples/500.html"><i class="fa fa-circle-o"></i> 500 Error</a></li>
                <li><a href="../examples/blank.html"><i class="fa fa-circle-o"></i> Blank Page</a></li>                
              </ul> --></li>
					<li class="treeview"><a
						href="${pageContext.request.contextPath }/manager/couponMngList"> <i
							class="fa fa-share"></i> <span>쿠폰 관리</span> <!--  <i class="fa fa-angle-left pull-right"></i> -->
					</a> <!--  <ul class="treeview-menu">    
                <li><a href="#"><i class="fa fa-circle-o"></i> Level One</a></li>
                <li>
                  <a href="#"><i class="fa fa-circle-o"></i> Level One <i class="fa fa-angle-left pull-right"></i></a>
                  <ul class="treeview-menu">
                    <li><a href="#"><i class="fa fa-circle-o"></i> Level Two</a></li>
                    <li>
                      <a href="#"><i class="fa fa-circle-o"></i> Level Two <i class="fa fa-angle-left pull-right"></i></a>
                      <ul class="treeview-menu">
                        <li><a href="#"><i class="fa fa-circle-o"></i> Level Three</a></li>
                        <li><a href="#"><i class="fa fa-circle-o"></i> Level Three</a></li>
                      </ul>
                    </li>
                  </ul>   
                </li>
                <li><a href="#"><i class="fa fa-circle-o"></i> Level One</a></li>
              </ul> --></li>
					<li><a
						href="${pageContext.request.contextPath }/manager/paymentList"><i
							class="fa fa-book"></i> <span>결제 관리</span></a></li>
					<li><a
						href="${pageContext.request.contextPath }/resources/documentation/index.html"><i
							class="fa fa-book"></i> <span>통계</span></a></li>
					<li class="header">LABELS</li>
					<li><a href="#"><i class="fa fa-circle-o text-red"></i> <span>Important</span></a></li>
					<li><a href="#"><i class="fa fa-circle-o text-yellow"></i>
							<span>Warning</span></a></li>
					<li><a href="#"><i class="fa fa-circle-o text-aqua"></i> <span>Information</span></a></li>
				</ul>
			</section>
			<!-- /.sidebar -->
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>Tour Management Program</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
					<li><a href="#">Forms</a></li>
					<li class="active">General Elements</li>
				</ol>
			</section>