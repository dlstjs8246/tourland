-- 사원  권한부분 관리자가 1, 일반 사원이 0
insert into employee values
(1,'차은우','1990-01-01','010-1111-4321','대구 광역시 달서구',1,'employee',password('employee'),0),
(2,'신세경','1992-01-01','010-2222-4321','대구 광역시 달서구',0,'employee1',password('employee'),0),
(3,'장현서','1988-01-01','010-4334-4321','대구 광역시 달서구',0,'employee2',password('employee'),0),
(4,'박인선','1989-01-01','010-3333-4321','대구 광역시 달서구',0,'employee3',password('employee'),0),
(5,'황하나','1987-01-01','010-4444-4321','대구 광역시 달서구',0,'employee4',password('employee'),1),
(7,'테스트','1991-12-18','010-4245-3825','대구 광역시 달서구',1,'manager',password('test'),0);

-- 고객
desc user;
insert into user values
(1,'황태원','1991-12-18','010-4245-3825','대구시 북구 태전동 254-30',null,'customer1',password('customer'), 0),
(2,'정아름','1988-12-18','010-7777-3825','대구시 북구 태전동 254-30',null,'customer2',password('customer'), 0),
(3,'정윤호','1952-12-18','010-1111-3825','대구시 북구 태전동 254-30',null,'customer3',password('customer'), 0),
(4,'박상아','1970-12-18','010-4245-3825','대구시 북구 태전동 254-30',null,'customer4',password('customer'), 0),
(5,'지민서','1989-12-18','010-4333-3825','대구시 북구 태전동 254-30',null,'customer5',password('customer'), 1),
(6,'테스트','1991-12-18','010-4333-3825','대구시 북구 태전동 254-30',null,'user',password('test'), 0);


-- 고객의 소리
desc custboard ;
insert into custboard values
(1,'홈페이지 이용이 너무 어려워요','좀더 편했으면 좋겠음','장초코',now(),password(111)),
(2,'상품이 다양하면 좋겠어요','좀더 많았으면..','장도롱',now(),password(111)),
(3,'차은우 가이드님 칭찬합니다','존잘!!','박열무',now(),password(111));


-- 배너
desc banner;
insert into banner values
(1,'중국 자금성','세계 최대 규모 궁궐','/2020/05/15/e5d4138a-3910-44cf-a9aa-368e3b9d484f_banner.jpg',0,'L'),
(2,'일본 센소지','도쿄에서 가장 오래된 절','/2020/05/15/59b0e99c-ffd0-421a-8e09-8574b5eda653_banner2.jpg',0,'R');

-- 팝업
desc popup ;
insert into popup values
(1,'패키지여행 스벅이벤트','스벅증정','/2020/05/15/4e96f9ce-8cb8-4530-9a29-137903ac8a50_event1.jpg','2020-01-01','2021-01-01','L','http://localhost:8080/tourland/customer/eventDetailPage?no=5'),
(2,'구급키트 증정','구급키트 증정','/2020/05/15/3cfbd968-8c92-4473-8065-e009e07c0614_event2.jpg','2020-03-01','2020-12-01','R','http://localhost:8080/tourland/customer/eventDetailPage?no=1');

desc event ;
load DATA LOCAL infile 'D:/workspace/workspace_spring/tourland/file/CSV/event.csv'
INTO TABLE tour.event
fields terminated by ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 lines;



-- 현서 렌트카 ----------------------------------------------------------------------------------------------
DESC rentcar; 
load DATA LOCAL infile 'D:/workspace/workspace_spring/tourland/file/CSV/rentcar.csv'
INTO TABLE tour.rentcar
character set 'utf8'
fields terminated by ',';

-- 인선 ---------------------------------------------------------------------------------------------------
LOAD DATA LOCAL INFILE 'D:/workspace/workspace_spring/tourland/file/CSV/FAQ.csv'  
INTO TABLE faq
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 lines;

load DATA LOCAL infile 'D:/workspace/workspace_spring/tourland/file/CSV/tour.csv'
INTO table tour
character set 'utf8'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 lines;

#상품 테이블 CSV 테스트용(연결 테이블 까지 포함)
LOAD DATA LOCAL INFILE 'D:/workspace/workspace_spring/tourland/file/CSV/product.csv'  
INTO TABLE product
character set 'utf8'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n' 
IGNORE 1 lines;

LOAD DATA LOCAL INFILE 'D:/workspace/workspace_spring/tourland/file/CSV/pairstatus.csv'  
INTO TABLE pairstatus
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 lines;

LOAD DATA LOCAL INFILE 'D:/workspace/workspace_spring/tourland/file/CSV/photelstatus.csv'  
INTO TABLE photelstatus
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 lines;

LOAD DATA LOCAL INFILE 'D:/workspace/workspace_spring/tourland/file/CSV/ptourstatus.csv'  
INTO TABLE ptourstatus
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 lines;

LOAD DATA LOCAL INFILE 'D:/workspace/workspace_spring/tourland/file/CSV/prentstatus.csv'  
INTO TABLE prentstatus
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 lines;
#여기까지

-- 태원 ---------------------------------------------------------------------------------------------------

-- 호텔
desc hotel;
load data local infile 'D:/workspace/workspace_spring/tourland/file/CSV/hotel.csv'
into table tour.hotel
character set 'utf8'
fields terminated by ',';

-- 상품문의사항
desc planboard;
insert into planboard values
(null, "문의합니다", "단체상품에 대해 문의하고싶습니다.", "박인선", "2020-04-27","D", "J", "0",null),
(null, "상품 문의사항입니다.", "이미 예약을 했는데 호텔만 변경가능할까요?", "장현서", "2020-04-27","I","P","0",null),
(null, "상품 4가지 중 한가지만 가능한가요?", "패키지 상품 중 1가지만 예약하고싶습니다.", "황하나", "2020-04-27","R","B","0",null),
(null, "상품 환불 문의입니다.", "일이 생겨 못가게 되었습니다. 환불 규정이 어떻게 되나요?", "황태원", "2020-04-27","R","R","0",null),
(null, "렌트카 보험 문의입니다.", "보험을 안들어도 괜찮은가요?", "정아름", "2020-04-27","U","C","0",null);

-- 하나 ---------------------------------------------------------------------------------------------------

-- 항공
load data local infile 'D:/workspace/workspace_spring/tourland/file/CSV/flight.csv'
into table tour.airplane
character set 'utf8'
fields terminated by ',';


-- 공지사항
insert into notice values
(1, "코로나 19로 인한 패키지 취소", "투어랜드", "투어랜드 고객 여러분, 코로나 19로 인한 결항으로 몇몇 패키지가 취소되었습니다. 마이 페이지에서 예약 상황을 꼼꼼히 확인 하시기 바랍니다.", "2020-04-27"),
(2, "발로투어 달랏 폭포 체험 특가 판매 연장", "투어랜드", "발로투어의 달랏 폭포 체험이 특가 판매를 2020/5/20일까지 연장합니다. 등록하시려면 지금 달랏 폭포 체험을 검색창에서 검색하세요! ", "2020-04-25"),
(3, "투어랜드 서비스 점검", "투어랜드", "투어랜드는 2020/05/04 AM 00:00 부터 AM 05:00 까지 사이트 점검을 실시합니다. 점검 시간 동안에는 서비스를 이용하실 수 없습니다. 서비스 이용에 불편을 끼쳐 대단히 죄송합니다.", "2020-04-23");

-- 쿠폰

insert into coupon values
(1, "가입 축하 할인", "2020-04-27", now(), "투어랜드 첫 가입 축하 20% 할인 쿠폰", 20.0), 
(2, "모든 해외여행 총집합 할인", "2020-04-27", "2020-05-04", "모든 해외여행 30% 할인", 30.0),
(3, "여름 휴가 시작 할인", "2020-07-01", "2020-08-01", "여름 휴가 떠나자 할인 쿠폰", 20.0),
(4, "얼리버드 할인 쿠폰", "2020-06-01", "2020-06-30", "얼리버드를 잡아라 할인 쿠폰", 10.0),
(5, "동남아시아 패키지 할인", "2020-05-01", "2020-05-30", "동남아시아로 떠나는 패키지 할인 쿠폰", 12.0);


-- 트리거 
drop trigger if exists tri_after_insert_user;
delimiter $
create trigger tri_after_insert_user
  	after insert on user
   for each row 
   begin
     	 insert into usercoupon values(new.userno,1);
   end $
delimiter ;
