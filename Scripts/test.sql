select user(),database();



-- 현서 --------------------------------------------------------------------------------------------
-- 사원
desc employee;
select * from employee;
select * from employee where empretired=0 order by empno desc  limit 3, 3;
select * from employee where empno like concat('%','1','%') and empretired =0;
delete from employee where empid = 'apple';
insert into employee values (6,'장우주','1987-01-01','010-4444-4321','대구 광역시 달서구',0,'employee4',password('employee'),1);
desc user;
select * from `user` u ;
delete from `user` where userno = 7;
insert into user values (6,'도라지','1989-12-18','010-4333-3825','대구시 북구 태전동 254-30',null,null,'customer5',password('customer'),1);
select * from rentcar r order by no desc ;
select * from rentcar r where ldiv =0  order by no desc ;
-- 렌트카
select count(no) from rentcar r ;
select * from rentcar where rentddate=  '2020-04-01' between  returndate  = '2020-04-05';
select * from rentcar where rentddate =  '2020-04-01' and returndate  = '2020-04-05';
-- 배너
select * from banner b2 ;
select * from banner order by no desc limit 1, 3;
delete from banner where no in(1,3,4,5,6,7,8,9,10,11);

select  count(no) from banner ;

-- 팝업
select  * from popup;
delete from popup where position in ('R','L');
-- 이벤트
select * from event order by no desc;
-- 다가올 이벤트
select * from event where startdate > now() ;
-- 진행중인 이벤트
select * from event where startdate <= now() and enddate >= now();
-- 종료된 이벤트
select * from event where enddate < now() ;
delete from event where no in(3);
insert into event (no,title,content,pic,startdate,enddate ) values
(6,	'이벤트1','이벤트1','/2020/05/13/89d3198a-d27f-4a83-8a80-48b4e4c8e714_ddddd.jpg','2020-05-10','2020-06-19'),
(7,	'이벤트2','이벤트2','/2020/05/13/a6a92948-ea66-46a6-8236-6b6120191d2f_주석_2020-05-04_144946.jpg','2020-05-10','2020-06-19'),
(8,	'이벤트3','이벤트3','/2020/05/13/055bc95a-75b2-4489-96bc-5afc2285cd1e_dafadfasdf.jpg','2020-05-10','2020-06-19');

-- 고객의 소리
insert into custboard values
(1,'홈페이지 이용이 너무 어려워요','좀더 편했으면 좋겠음','장초코',now(),password(111)),
(2,'상품이 다양하면 좋겠어요','좀더 많았으면..','장도롱',now(),password(111)),
(3,'차은우 가이드님 칭찬합니다','존잘!!','박열무',now(),password(111));
select * from custboard ;
desc custboard ;
delete from custboard where no = 3;
select * from custboard order by no desc limit 1, 3;



-- 인선 --------------------------------------------------------------------------------------------
select count(no) from faq where title like concat('%','쿠폰','%');
select * from faq where lcate = 'D' and mcate = 'J' and title like concat ('%','제주','%') order by no desc limit 1,10;
desc tour;
select * from tour where no = 3001 order by no desc;
delete from tour;
desc airplane;
select p.pno,p.pname,p.pcontent,p.pexpire,p.pprice,p.ppic,p.pdiv,
	   a2.no,a2.ano,a2.dlocation,a2.rlocation,a2.ddate,a2.rdate,a2.ldiv,a2.capacity,a2.seat,a2.price,a2.pdiv, 
	   h2.no,h2.hname,h2.haddr,h2.checkin,h2.checkout,h2.capacity,h2.price,h2.roomcapacity,h2.roomtype,h2.ldiv,h2.bookedup,h2.pdiv,
	   t2.no,t2.tname,t2.tlocation,t2.startdate,t2.enddate,t2.taddr,t2.etime,t2.capacity,t2.tprice,t2.ldiv,t2.pdiv,
	   r2.no,r2.cdiv,r2.cno,r2.rentddate,r2.returndate,r2.rentaddr,r2.returnaddr,r2.price,r2.capacity,r2.insurance,r2.ldiv,r2.pdiv 
	from (select * from product order by pno desc limit 0,10) p join pairstatus a on p.pno = a.pno join airplane a2 on a.ano = a2.no
							 	join photelstatus h on p.pno = h.pno join hotel h2 on h.hno = h2.no
							 	join ptourstatus t on p.pno = t.pno join tour t2 on t.tno = t2.no
							 	join prentstatus r on p.pno = r.pno join rentcar r2 on r.rno = r2.no;
							 
select p.pno,p.pname,p.pcontent,p.pexpire,p.pprice,p.ppic,p.pdiv,
	    a2.no as a2no,a2.ano,a2.dlocation,a2.rlocation,a2.ddate,a2.rdate,a2.ldiv,a2.capacity,a2.seat,a2.price,a2.pdiv, 
	    h2.no as h2no,h2.hname,h2.haddr,h2.checkin,h2.checkout,h2.capacity,h2.price,h2.roomtype,h2.roomcapacity,h2.ldiv,h2.bookedup,h2.pdiv,
	    t2.no as t2no,t2.tname,t2.tlocation,t2.startdate,t2.enddate,t2.taddr,t2.etime,t2.capacity,t2.tprice,t2.ldiv,t2.pdiv,
	    r2.no as r2no,r2.cdiv,r2.cno,r2.rentddate,r2.returndate,r2.rentaddr,r2.returnaddr,r2.price,r2.capacity,r2.insurance,r2.ldiv,r2.pdiv 
		from product p join pairstatus a on p.pno = a.pno join airplane a2 on a.ano = a2.no
					   join photelstatus h on p.pno = h.pno join hotel h2 on h.hno = h2.no
					   join ptourstatus t on p.pno = t.pno join tour t2 on t.tno = t2.no
					   join prentstatus r on p.pno = r.pno join rentcar r2 on r.rno = r2.no
		where p.pno = 2;
	
select * from product p join photelstatus h on p.pno = h.pno join hotel h2 on h.hno = h2.no join prentstatus r on p.pno = r.pno join rentcar r2 on r.rno = r2.no where p.pno = 2;
desc pairstatus;
desc prentstatus;
select * from product;
select * from pairstatus;
select * from photelstatus;
select * from ptourstatus;
select * from prentstatus;
delete from prentstatus;
delete from ptourstatus;
delete from photelstatus;
delete from pairstatus;
delete from product;
-- 태원 --------------------------------------------------------------------------------------------
SELECT *
FROM hotel; 

where no = 811;
select count(no) from hotel;
select * from hotel order by no desc limit 10, 3;

select * from hotel
where hname like CONCAT('%','hidden','%');

select * from user;

select * from employee;

select * from planboard;
select * from hotel;

insert into planboard(title, content, writer, regdate, lcate, mcate, answer,respond)
(select title, content, writer, regdate, lcate, mcate, answer,respond from planboard);

 select from user
 where userpass = password('test');

select count(no)
from planboard;

insert into planboard(title, content, writer, regdate, lcate, mcate, answer) values
 ('test','test','test',now(),'D','P',0);

       update planboard  set 
       title ='test11', content='test11', respond='답변'
       where no=6;


-- 하나 --------------------------------------------------------------------------------------------

SELECT * FROM notice;
select count(*) from airplane; 
select * from coupon;
select * from airplane;

