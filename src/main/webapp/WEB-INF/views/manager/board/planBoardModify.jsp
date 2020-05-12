<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
<style>
	.form-group input{
		background-color: lightgray;
	}
	#small div{
	float: left;
    margin: 30px 30px;
    width: 264px;
	}
	#goList{
    width: 100px;
    height: 32px;
    position: relative;
    top: -6px;
    right: -35px;
	}
	#btnDelete{
		margin-left:10px;
	}
</style>
<div class="content">
	<div class="row">
		<div class="col-sm-12">
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">상품 문의사항</h3>
					<button class="btn btn-warning active" id="goList">돌아가기</button>
				</div>
				<div class="box-body">
					<div class="form-group">
						<label>제목</label>
						<input type="text" name="title" class="form-control" value="${plan.title}" readonly="readonly">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea rows="15" cols="30" placeholder="내용을 입력하세요" name="content" class="form-control" readonly="readonly"><c:out value="${plan.content}"/></textarea>
					</div>
				<div id="small">	
					<div class="form-group">
						<label>대분류</label>
						<input type="text" readonly="readonly" value="${plan.lcate eq 'D'?'국내패키지상품':plan.lcate eq 'I'?'해외패키지상품':plan.lcate eq 'R'?'상품 예약 및 결제':'회원혜택안내'}" class="form-control" style="width:200px;">		 
					</div>
					<div class="form-group">
						<label>중분류</label>
						<input type="text" readonly="readonly" value="${plan.mcate eq 'P'?'여행상품':plan.mcate eq 'V'?'여권 및 비자':plan.mcate eq 'T'?'환율':plan.mcate eq 'J'?'제주여행':plan.mcate eq 'B'?'예약 및 취소':plan.mcate eq 'R'?'결제 및 환불':plan.mcate eq 'C'?'쿠폰 및 이벤트':'기타'}" class="form-control" style="width:200px;">
					</div>
					<div class="form-group">
						<label>작성자</label>
						<input type="text" readonly="readonly" value="${plan.writer }" class="form-control" style="width:200px;">
					</div>
					<div class="form-group">
						<label>작성일자</label>
						<input type="text" readonly="readonly" value="<fmt:formatDate value="${plan.regdate}" pattern="yyyy-MM-dd"/>" class="form-control" style="width:200px;">
					</div>
					<div class="form-group">
						<label>답변여부</label>
						<input type="text" readonly="readonly" value="${plan.answer=='0'? '답변미완료':'답변완료'}" class="form-control" style="width:200px;">
					</div>
				</div>
				</div>
				<div class="box-footer"></div>
			</div>
		</div>
	</div>
</div>

<div class="content" >
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-success parent">
				<div class="box-header point">
					<h3 class="box-title">답변</h3>
				</div>
				<div class="box-body point">
					<label>작성자</label>
					<input type="text" class="form-control" value="${vo.empname }" id="respondWriter" name="respondWriter" readonly="readonly">
					<label>답변</label>
					<textarea rows="5" cols="30" class="form-control" id="respond" name="respond" readonly="readonly">${vo.respond }</textarea>
				</div>
				<div class="box-footer point">
					<button class="btn btn-primary" id="btnUpdate">수정</button>
					<button class="btn btn-danger" id="btnDelete">삭제</button>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../../include/footer.jsp"%>