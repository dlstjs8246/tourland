-- 여행사
DROP SCHEMA IF EXISTS tour;

-- 여행사
CREATE SCHEMA tour;

-- 직원
CREATE TABLE tour.employee (
	empno      INT          NOT NULL COMMENT '사번', -- 사번
	empname    varchar(5)   NULL     COMMENT '사원명', -- 사원명
	empbirth   DATE         NULL     COMMENT '생년월일', -- 생년월일
	emptel     char(13)     NULL     COMMENT '전화번호', -- 전화번호
	empaddr    VARCHAR(255) NULL     COMMENT '주소', -- 주소
	empauth    tinyint(1)   NULL     COMMENT '권한', -- 권한
	empid      varchar(12)  NULL     COMMENT '아이디', -- 아이디
	emppass    varchar(41)  NULL     COMMENT '비밀번호', -- 비밀번호
	empretired tinyint(1)   NULL     COMMENT '퇴사여부' -- 퇴사여부
)
COMMENT '직원';

-- 직원
ALTER TABLE tour.employee
	ADD CONSTRAINT PK_employee -- 직원 기본키
		PRIMARY KEY (
			empno -- 사번
		);

-- 회원
CREATE TABLE tour.user (
	userno       INT          NOT NULL COMMENT '유저번호', -- 유저번호
	username     varchar(5)   NULL     COMMENT '유저명', -- 유저명
	userbirth    DATE         NULL     COMMENT '생년월일', -- 생년월일
	usertel      char(13)     NULL     COMMENT '전화번호', -- 전화번호
	useraddr     VARCHAR(255) NULL     COMMENT '주소', -- 주소
	userpassport char(9)      NULL     COMMENT '여권번호', -- 여권번호
	userid       varchar(12)  NULL     COMMENT '유저아이디', -- 유저아이디
	userpass     varchar(41)  NULL     COMMENT '유저비밀번호', -- 유저비밀번호
	usersecess   TINYINT(1)   NULL     COMMENT '탈퇴여부' -- 탈퇴여부
)
COMMENT '회원';

-- 회원
ALTER TABLE tour.user
	ADD CONSTRAINT PK_user -- 회원 기본키
		PRIMARY KEY (
			userno -- 유저번호
		);

-- 공지사항
CREATE TABLE tour.notice (
	no      INT          NOT NULL COMMENT '번호', -- 번호
	title   varchar(255) NULL     COMMENT '제목', -- 제목
	writer  varchar(5)   NULL     COMMENT '작성자', -- 작성자
	content LONGTEXT     NULL     COMMENT '내용', -- 내용
	regdate TIMESTAMP    NULL     DEFAULT now() COMMENT '작성일자', -- 작성일자
	fixed   TINYINT(1)   NULL     DEFAULT 0 COMMENT '상단고정' -- 상단고정
)
COMMENT '공지사항';

-- 공지사항
ALTER TABLE tour.notice
	ADD CONSTRAINT PK_notice -- 공지사항 기본키
		PRIMARY KEY (
			no -- 번호
		);

ALTER TABLE tour.notice
	MODIFY COLUMN no INT NOT NULL AUTO_INCREMENT COMMENT '번호';

-- 이벤트
CREATE TABLE tour.event (
	no        INT          NOT NULL COMMENT '번호', -- 번호
	title     varchar(255) NULL     COMMENT '제목', -- 제목
	content   LONGTEXT     NULL     COMMENT '내용', -- 내용
	pic       varchar(255) NULL     COMMENT '사진', -- 사진
	startdate DATE         NULL     COMMENT '시작날짜', -- 시작날짜
	enddate   DATE         NULL     COMMENT '종료일자' -- 종료일자
)
COMMENT '이벤트';

-- 이벤트
ALTER TABLE tour.event
	ADD CONSTRAINT PK_event -- 이벤트 기본키
		PRIMARY KEY (
			no -- 번호
		);

ALTER TABLE tour.event
	MODIFY COLUMN no INT NOT NULL AUTO_INCREMENT COMMENT '번호';

-- 배너
CREATE TABLE tour.banner (
	no        INT          NOT NULL COMMENT '번호', -- 번호
	title     varchar(255) NULL     COMMENT '제목', -- 제목
	content   LONGTEXT     NULL     COMMENT '내용', -- 내용
	pic       varchar(255) NULL     COMMENT '사진', -- 사진
	isSetting TINYINT(1)   NULL     DEFAULT 0 COMMENT '설정여부', -- 설정여부
	position  CHAR(1)      NULL     COMMENT '배너위치' -- 배너위치
)
COMMENT '배너';

-- 배너
ALTER TABLE tour.banner
	ADD CONSTRAINT PK_banner -- 배너 기본키
		PRIMARY KEY (
			no -- 번호
		);

ALTER TABLE tour.banner
	MODIFY COLUMN no INT NOT NULL AUTO_INCREMENT COMMENT '번호';

-- FAQ
CREATE TABLE tour.FAQ (
	no      INT          NOT NULL COMMENT '번호', -- 번호
	title   varchar(255) NULL     COMMENT '제목', -- 제목
	content LONGTEXT     NULL     COMMENT '내용', -- 내용
	lcate   CHAR(1)      NULL     COMMENT '대분류', -- 대분류
	mcate   CHAR(1)      NULL     COMMENT '중분류' -- 중분류
)
COMMENT 'FAQ';

-- FAQ
ALTER TABLE tour.FAQ
	ADD CONSTRAINT PK_FAQ -- FAQ 기본키
		PRIMARY KEY (
			no -- 번호
		);

ALTER TABLE tour.FAQ
	MODIFY COLUMN no INT NOT NULL AUTO_INCREMENT COMMENT '번호';

-- 고객의소리
CREATE TABLE tour.custboard (
	no      INT          NOT NULL COMMENT '번호', -- 번호
	title   varchar(255) NULL     COMMENT '제목', -- 제목
	content LONGTEXT     NULL     COMMENT '내용', -- 내용
	writer  varchar(5)   NULL     COMMENT '작성자', -- 작성자
	regdate TIMESTAMP    NULL     DEFAULT now() COMMENT '작성일자', -- 작성일자
	passwd  varchar(50)  NULL     COMMENT '비밀번호' -- 비밀번호
)
COMMENT '고객의소리';

-- 고객의소리
ALTER TABLE tour.custboard
	ADD CONSTRAINT PK_custboard -- 고객의소리 기본키
		PRIMARY KEY (
			no -- 번호
		);

-- 상품문의사항
CREATE TABLE tour.planboard (
	no      INT          NOT NULL COMMENT '번호', -- 번호
	title   varchar(255) NULL     COMMENT '제목', -- 제목
	content LONGTEXT     NULL     COMMENT '내용', -- 내용
	writer  varchar(5)   NULL     COMMENT '작성자', -- 작성자
	regdate TIMESTAMP    NULL     DEFAULT now() COMMENT '작성일자', -- 작성일자
	lcate   CHAR(1)      NULL     COMMENT '대분류', -- 대분류
	mcate   CHAR(1)      NULL     COMMENT '중분류', -- 중분류
	answer  tinyint(1)   NULL     COMMENT '답변상태', -- 답변상태
	respond LONGTEXT     NULL     COMMENT '답변내용' -- 답변내용
)
COMMENT '상품문의사항';

-- 상품문의사항
ALTER TABLE tour.planboard
	ADD CONSTRAINT PK_planboard -- 상품문의사항 기본키
		PRIMARY KEY (
			no -- 번호
		);

ALTER TABLE tour.planboard
	MODIFY COLUMN no INT NOT NULL AUTO_INCREMENT COMMENT '번호';

-- 상품
CREATE TABLE tour.product (
	pno      INT          NOT NULL COMMENT '상품번호', -- 상품번호
	pname    varchar(100) NULL     COMMENT '상품이름', -- 상품이름
	pcontent LONGTEXT     NULL     COMMENT '상품설명', -- 상품설명
	pexpire  DATE         NULL     COMMENT '상품유효기간', -- 상품유효기간
	pprice   INT          NULL     COMMENT '상품가격', -- 상품가격
	ppic     varchar(255) NULL     COMMENT '상품사진', -- 상품사진
	pdiv     TINYINT(1)   NULL     COMMENT '상품구분' -- 상품구분
)
COMMENT '상품';

-- 상품
ALTER TABLE tour.product
	ADD CONSTRAINT PK_product -- 상품 기본키
		PRIMARY KEY (
			pno -- 상품번호
		);

-- 팝업
CREATE TABLE tour.popup (
	no        INT          NOT NULL COMMENT '번호', -- 번호
	title     varchar(255) NULL     COMMENT '제목', -- 제목
	content   LONGTEXT     NULL     COMMENT '내용', -- 내용
	pic       varchar(255) NULL     COMMENT '사진', -- 사진
	startdate DATE         NULL     COMMENT '시작날짜', -- 시작날짜
	enddate   DATE         NULL     COMMENT '종료날짜', -- 종료날짜
	position  CHAR(1)      NULL     COMMENT '팝업위치', -- 팝업위치
	link      VARCHAR(255) NULL     COMMENT '링크' -- 링크
)
COMMENT '팝업';

-- 팝업
ALTER TABLE tour.popup
	ADD CONSTRAINT PK_popup -- 팝업 기본키
		PRIMARY KEY (
			no -- 번호
		);

-- 항공
CREATE TABLE tour.airplane (
	no        INT         NOT NULL COMMENT '번호', -- 번호
	ano       CHAR(5)     NULL     COMMENT '항공기번호', -- 항공기번호
	dlocation varchar(30) NULL     COMMENT '출발지역', -- 출발지역
	rlocation VARCHAR(30) NULL     COMMENT '도착지역', -- 도착지역
	ddate     TIMESTAMP   NULL     COMMENT '출발시간', -- 출발시간
	rdate     TIMESTAMP   NULL     COMMENT '도착시간', -- 도착시간
	ldiv      TINYINT(1)  NULL     COMMENT '장소구분', -- 장소구분
	capacity  INT         NULL     COMMENT '인원', -- 인원
	seat      char(1)     NULL     COMMENT '좌석', -- 좌석
	price     INT         NULL     COMMENT '가격', -- 가격
	pdiv      TINYINT(1)  NULL     COMMENT '상품구분' -- 상품구분
)
COMMENT '항공';

-- 항공
ALTER TABLE tour.airplane
	ADD CONSTRAINT PK_airplane -- 항공 기본키
		PRIMARY KEY (
			no -- 번호
		);

-- 호텔
CREATE TABLE tour.hotel (
	no            INT          NOT NULL COMMENT '번호', -- 번호
	hname         VARCHAR(50)  NULL     COMMENT '호텔이름', -- 호텔이름
	haddr         VARCHAR(255) NULL     COMMENT '주소', -- 주소
	checkin       DATE         NULL     COMMENT '체크인', -- 체크인
	checkout      DATE         NULL     COMMENT '체크아웃', -- 체크아웃
	capacity      INT          NULL     COMMENT '인원', -- 인원
	price         INT          NULL     COMMENT '가격', -- 가격
	roomcapacity  INT          NULL     COMMENT '객실수', -- 객실수
	roomtype      CHAR(1)      NULL     COMMENT '객실타입', -- 객실타입
	ldiv          TINYINT(1)   NULL     COMMENT '장소구분', -- 장소구분
	bookedup      TINYINT(1)   NULL     COMMENT '객실허용여부', -- 객실허용여부
	totalcapacity INT          NULL     COMMENT '총인원', -- 총인원
	pdiv          TINYINT(1)   NULL     COMMENT '상품구분' -- 상품구분
)
COMMENT '호텔';

-- 호텔
ALTER TABLE tour.hotel
	ADD CONSTRAINT PK_hotel -- 호텔 기본키
		PRIMARY KEY (
			no -- 번호
		);

-- 투어
CREATE TABLE tour.tour (
	no        INT          NOT NULL COMMENT '번호', -- 번호
	tname     VARCHAR(50)  NULL     COMMENT '투어명', -- 투어명
	tlocation varchar(30)  NULL     COMMENT '투어지역', -- 투어지역
	startdate DATE         NULL     COMMENT '시작날짜', -- 시작날짜
	enddate   DATE         NULL     COMMENT '종료날짜', -- 종료날짜
	taddr     VARCHAR(255) NULL     COMMENT '주소', -- 주소
	etime     TIME         NULL     COMMENT '소요시간', -- 소요시간
	capacity  INT          NULL     COMMENT '인원', -- 인원
	tprice    INT          NULL     COMMENT '가격', -- 가격
	ldiv      TINYINT(1)   NULL     COMMENT '장소구분', -- 장소구분
	pdiv      TINYINT(1)   NULL     COMMENT '상품구분' -- 상품구분
)
COMMENT '투어';

-- 투어
ALTER TABLE tour.tour
	ADD CONSTRAINT PK_tour -- 투어 기본키
		PRIMARY KEY (
			no -- 번호
		);

-- 렌트카
CREATE TABLE tour.rentcar (
	no         INT          NOT NULL COMMENT '번호', -- 번호
	cdiv       char(1)      NULL     COMMENT '차종류', -- 차종류
	cno        char(8)      NULL     COMMENT '차번호', -- 차번호
	rentddate  DATE         NULL     COMMENT '대여날짜', -- 대여날짜
	returndate DATE         NULL     COMMENT '반납날짜', -- 반납날짜
	rentaddr   VARCHAR(255) NULL     COMMENT '대여장소', -- 대여장소
	returnaddr VARCHAR(255) NULL     COMMENT '반납장소', -- 반납장소
	price      INT          NULL     COMMENT '가격', -- 가격
	capacity   INT          NULL     COMMENT '인원', -- 인원
	insurance  TINYINT(1)   NULL     COMMENT '보험여부', -- 보험여부
	ldiv       TINYINT(1)   NULL     COMMENT '장소구분', -- 장소구분
	pdiv       TINYINT(1)   NULL     COMMENT '상품구분' -- 상품구분
)
COMMENT '렌트카';

-- 렌트카
ALTER TABLE tour.rentcar
	ADD CONSTRAINT PK_rentcar -- 렌트카 기본키
		PRIMARY KEY (
			no -- 번호
		);

-- 예약
CREATE TABLE tour.reservation (
	no      INT       NOT NULL COMMENT '예약번호', -- 예약번호
	userno  INT       NULL     COMMENT '유저번호', -- 유저번호
	rdate   TIMESTAMP NULL     DEFAULT now() COMMENT '예약날짜', -- 예약날짜
	rstatus char(1)   NULL     COMMENT '예약상태' -- 예약상태
)
COMMENT '예약';

-- 예약
ALTER TABLE tour.reservation
	ADD CONSTRAINT PK_reservation -- 예약 기본키
		PRIMARY KEY (
			no -- 예약번호
		);

-- 쿠폰
CREATE TABLE tour.coupon (
	cno      INT          NOT NULL COMMENT '쿠폰번호', -- 쿠폰번호
	cname    varchar(100) NULL     COMMENT '쿠폰이름', -- 쿠폰이름
	pdate    DATE         NULL     COMMENT '발행일자', -- 발행일자
	edate    DATE         NULL     COMMENT '만료일자', -- 만료일자
	ccontent LONGTEXT     NULL     COMMENT '쿠폰내용', -- 쿠폰내용
	mrate    FLOAT        NULL     COMMENT '할인율' -- 할인율
)
COMMENT '쿠폰';

-- 쿠폰
ALTER TABLE tour.coupon
	ADD CONSTRAINT PK_coupon -- 쿠폰 기본키
		PRIMARY KEY (
			cno -- 쿠폰번호
		);

-- 장바구니
CREATE TABLE tour.cart (
	cno    INT     NULL COMMENT '번호', -- 번호
	userno INT     NULL COMMENT '유저번호', -- 유저번호
	pno    INT     NULL COMMENT '상품번호', -- 상품번호
	count  INTEGER NULL COMMENT '개수', -- 개수
	price  INTEGER NULL COMMENT '가격' -- 가격
)
COMMENT '장바구니';

-- 상품항공현황황
CREATE TABLE tour.pairstatus (
	pno INT NOT NULL COMMENT '상품번호', -- 상품번호
	ano INT NOT NULL COMMENT '항공번호' -- 항공번호
)
COMMENT '상품항공현황황';

-- 상품항공현황황
ALTER TABLE tour.pairstatus
	ADD CONSTRAINT PK_pairstatus -- 상품항공현황황 기본키
		PRIMARY KEY (
			pno, -- 상품번호
			ano  -- 항공번호
		);

-- 유저상품현황
CREATE TABLE tour.userpstatus (
	no     INT NOT NULL COMMENT '예약번호', -- 예약번호
	userno INT NOT NULL COMMENT '유저번호', -- 유저번호
	pno    INT NOT NULL COMMENT '상품번호' -- 상품번호
)
COMMENT '유저상품현황';

-- 유저상품현황
ALTER TABLE tour.userpstatus
	ADD CONSTRAINT PK_userpstatus -- 유저상품현황 기본키
		PRIMARY KEY (
			no,     -- 예약번호
			userno, -- 유저번호
			pno     -- 상품번호
		);

-- 상품렌트카현황
CREATE TABLE tour.prentstatus (
	pno INT NOT NULL COMMENT '상품번호', -- 상품번호
	rno INT NOT NULL COMMENT '렌트카번호' -- 렌트카번호
)
COMMENT '상품렌트카현황';

-- 상품렌트카현황
ALTER TABLE tour.prentstatus
	ADD CONSTRAINT PK_prentstatus -- 상품렌트카현황 기본키
		PRIMARY KEY (
			pno, -- 상품번호
			rno  -- 렌트카번호
		);

-- 상품투어현황
CREATE TABLE tour.ptourstatus (
	pno INT NOT NULL COMMENT '상품번호', -- 상품번호
	tno INT NOT NULL COMMENT '번호' -- 번호
)
COMMENT '상품투어현황';

-- 상품투어현황
ALTER TABLE tour.ptourstatus
	ADD CONSTRAINT PK_ptourstatus -- 상품투어현황 기본키
		PRIMARY KEY (
			pno, -- 상품번호
			tno  -- 번호
		);

-- 상품호텔현황
CREATE TABLE tour.photelstatus (
	pno INT NOT NULL COMMENT '상품번호', -- 상품번호
	hno INT NOT NULL COMMENT '호텔번호' -- 호텔번호
)
COMMENT '상품호텔현황';

-- 상품호텔현황
ALTER TABLE tour.photelstatus
	ADD CONSTRAINT PK_photelstatus -- 상품호텔현황 기본키
		PRIMARY KEY (
			pno, -- 상품번호
			hno  -- 호텔번호
		);

-- 유저쿠폰현황
CREATE TABLE tour.usercoupon (
	userno INT NOT NULL COMMENT '유저번호', -- 유저번호
	cno    INT NOT NULL COMMENT '쿠폰번호' -- 쿠폰번호
)
COMMENT '유저쿠폰현황';

-- 유저쿠폰현황
ALTER TABLE tour.usercoupon
	ADD CONSTRAINT PK_usercoupon -- 유저쿠폰현황 기본키
		PRIMARY KEY (
			userno, -- 유저번호
			cno     -- 쿠폰번호
		);

-- 상품평
CREATE TABLE tour.review (
	no        INT       NOT NULL COMMENT '번호', -- 번호
	rno       INT       NOT NULL COMMENT '예약번호', -- 예약번호
	pno       INT       NULL     COMMENT '상품번호', -- 상품번호
	userno    INT       NULL     COMMENT '유저번호', -- 유저번호
	regdate   TIMESTAMP NULL     DEFAULT now() COMMENT '등록일', -- 등록일
	starpoint char(1)   NULL     COMMENT '별점', -- 별점
	reviewTitle   varchar(255) NOT NULL COMMENT '리뷰제목', -- 리뷰제목
	reviewContent LONGTEXT     NOT NULL COMMENT '리뷰내용' -- 리뷰내용
)
COMMENT '상품평';

-- 상품평
ALTER TABLE tour.review
	ADD CONSTRAINT PK_review -- 상품평 기본키
		PRIMARY KEY (
			no -- 번호
		);

-- 예약
ALTER TABLE tour.reservation
	ADD CONSTRAINT FK_user_TO_reservation -- 회원 -> 예약
		FOREIGN KEY (
			userno -- 유저번호
		)
		REFERENCES tour.user ( -- 회원
			userno -- 유저번호
		);

-- 장바구니
ALTER TABLE tour.cart
	ADD CONSTRAINT FK_user_TO_cart -- 회원 -> 장바구니
		FOREIGN KEY (
			userno -- 유저번호
		)
		REFERENCES tour.user ( -- 회원
			userno -- 유저번호
		);

-- 장바구니
ALTER TABLE tour.cart
	ADD CONSTRAINT FK_product_TO_cart -- 상품 -> 장바구니
		FOREIGN KEY (
			pno -- 상품번호
		)
		REFERENCES tour.product ( -- 상품
			pno -- 상품번호
		);

-- 상품항공현황황
ALTER TABLE tour.pairstatus
	ADD CONSTRAINT FK_airplane_TO_pairstatus2 -- 항공 -> 상품항공현황황2
		FOREIGN KEY (
			ano -- 항공번호
		)
		REFERENCES tour.airplane ( -- 항공
			no -- 번호
		);

-- 상품항공현황황
ALTER TABLE tour.pairstatus
	ADD CONSTRAINT FK_product_TO_pairstatus -- 상품 -> 상품항공현황황
		FOREIGN KEY (
			pno -- 상품번호
		)
		REFERENCES tour.product ( -- 상품
			pno -- 상품번호
		);

-- 유저상품현황
ALTER TABLE tour.userpstatus
	ADD CONSTRAINT FK_product_TO_userpstatus -- 상품 -> 유저상품현황
		FOREIGN KEY (
			pno -- 상품번호
		)
		REFERENCES tour.product ( -- 상품
			pno -- 상품번호
		);

-- 유저상품현황
ALTER TABLE tour.userpstatus
	ADD CONSTRAINT FK_user_TO_userpstatus -- 회원 -> 유저상품현황
		FOREIGN KEY (
			userno -- 유저번호
		)
		REFERENCES tour.user ( -- 회원
			userno -- 유저번호
		);

-- 유저상품현황
ALTER TABLE tour.userpstatus
	ADD CONSTRAINT FK_reservation_TO_userpstatus -- 예약 -> 유저상품현황
		FOREIGN KEY (
			no -- 예약번호
		)
		REFERENCES tour.reservation ( -- 예약
			no -- 예약번호
		);

-- 상품렌트카현황
ALTER TABLE tour.prentstatus
	ADD CONSTRAINT FK_product_TO_prentstatus -- 상품 -> 상품렌트카현황
		FOREIGN KEY (
			pno -- 상품번호
		)
		REFERENCES tour.product ( -- 상품
			pno -- 상품번호
		);

-- 상품렌트카현황
ALTER TABLE tour.prentstatus
	ADD CONSTRAINT FK_rentcar_TO_prentstatus -- 렌트카 -> 상품렌트카현황
		FOREIGN KEY (
			rno -- 렌트카번호
		)
		REFERENCES tour.rentcar ( -- 렌트카
			no -- 번호
		);

-- 상품투어현황
ALTER TABLE tour.ptourstatus
	ADD CONSTRAINT FK_product_TO_ptourstatus -- 상품 -> 상품투어현황
		FOREIGN KEY (
			pno -- 상품번호
		)
		REFERENCES tour.product ( -- 상품
			pno -- 상품번호
		);

-- 상품투어현황
ALTER TABLE tour.ptourstatus
	ADD CONSTRAINT FK_tour_TO_ptourstatus -- 투어 -> 상품투어현황
		FOREIGN KEY (
			tno -- 번호
		)
		REFERENCES tour.tour ( -- 투어
			no -- 번호
		);

-- 상품호텔현황
ALTER TABLE tour.photelstatus
	ADD CONSTRAINT FK_product_TO_photelstatus -- 상품 -> 상품호텔현황
		FOREIGN KEY (
			pno -- 상품번호
		)
		REFERENCES tour.product ( -- 상품
			pno -- 상품번호
		);

-- 상품호텔현황
ALTER TABLE tour.photelstatus
	ADD CONSTRAINT FK_hotel_TO_photelstatus -- 호텔 -> 상품호텔현황
		FOREIGN KEY (
			hno -- 호텔번호
		)
		REFERENCES tour.hotel ( -- 호텔
			no -- 번호
		);

-- 유저쿠폰현황
ALTER TABLE tour.usercoupon
	ADD CONSTRAINT FK_user_TO_usercoupon -- 회원 -> 유저쿠폰현황
		FOREIGN KEY (
			userno -- 유저번호
		)
		REFERENCES tour.user ( -- 회원
			userno -- 유저번호
		);

-- 유저쿠폰현황
ALTER TABLE tour.usercoupon
	ADD CONSTRAINT FK_coupon_TO_usercoupon -- 쿠폰 -> 유저쿠폰현황
		FOREIGN KEY (
			cno -- 쿠폰번호
		)
		REFERENCES tour.coupon ( -- 쿠폰
			cno -- 쿠폰번호
		);

-- 상품평
ALTER TABLE tour.review
	ADD CONSTRAINT FK_product_TO_review -- 상품 -> 상품평
		FOREIGN KEY (
			pno -- 상품번호
		)
		REFERENCES tour.product ( -- 상품
			pno -- 상품번호
		);

-- 상품평
ALTER TABLE tour.review
	ADD CONSTRAINT FK_user_TO_review -- 회원 -> 상품평
		FOREIGN KEY (
			userno -- 유저번호
		)
		REFERENCES tour.user ( -- 회원
			userno -- 유저번호
		);
create user if not exists 'tour'@'localhost';
grant all privileges on tour.* to 'tour'@'localhost' identified by 'tour';