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
select * from usercoupon u ;
select user.username, coupon.cno, coupon.cname from user left join usercoupon uc on user.userno = uc.userno left join coupon on uc.cno = coupon.cno;
delete from `user` where userno = 7;
insert into user values (6,'도라지','1989-12-18','010-4333-3825','대구시 북구 태전동 254-30',null,'customer5',password('customer'),1);
select * from rentcar r order by no desc ;
select * from rentcar r where ldiv =0  order by no desc ;
-- 렌트카
select count(no) from rentcar r ;
select * from rentcar where rentddate=  '2020-04-01' between  returndate  = '2020-04-05';
select * from rentcar where rentddate =  '2020-04-01' and returndate  = '2020-04-05';
-- 배너
select * from banner b2 ;
delete from banner;
select * from banner order by no desc limit 1, 3;
delete from banner where no in(1,3,4,5,6,7,8,9,10,11);

select  count(no) from banner ;
select * from product;
select * from photelstatus;
select * from prentstatus;
select * from pairstatus;
select * from ptourstatus;
desc ptourstatus ;

select * from tour;

-- 최근본 상품 쿠키 생성 위함
select * from product where pno = 180;

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
delete from event ;
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

select * from product p ;
select * from product where substring(pname,2,3) = '도쿄';

-- 메인화면 검색을 위한
select * from product where pname like concat('%','골동품','%');

select p.pno,p.pname,p.pcontent,p.pexpire,p.pprice,p.ppic,p.pdiv,
	    a2.no as a2no,a2.ano,a2.dlocation,a2.rlocation,a2.ddate,a2.rdate,a2.ldiv,a2.capacity as a2capacity,a2.seat,a2.price as a2price,a2.pdiv, 
	    h2.no as h2no,h2.hname,h2.haddr,h2.checkin,h2.checkout,h2.capacity as h2capacity,h2.price as h2price,h2.roomcapacity,h2.roomtype,h2.ldiv,h2.bookedup,h2.pdiv,
	    t2.no as t2no,t2.tname,t2.tlocation,t2.startdate,t2.enddate,t2.taddr,t2.etime,t2.capacity as t2capacity,t2.tprice as t2tprice,t2.ldiv,t2.pdiv,
	    r2.no as r2no,r2.cdiv,r2.cno,r2.rentddate,r2.returndate,r2.rentaddr,r2.returnaddr,r2.price as r2price,r2.capacity as r2capacity,r2.insurance,r2.ldiv,r2.pdiv 
		from (select * from product where substring(pname,2,4) = '베이징' and pname like CONCAT('%','골동품','%') order by pno desc) p join pairstatus a on p.pno = a.pno join airplane a2 on a.ano = a2.no
							 	join photelstatus h on p.pno = h.pno join hotel h2 on h.hno = h2.no
							 	join ptourstatus t on p.pno = t.pno join tour t2 on t.tno = t2.no
							 	join prentstatus r on p.pno = r.pno join rentcar r2 on r.rno = r2.no
							 	where p.pdiv = 0;

-- 인선 --------------------------------------------------------------------------------------------
<<<<<<< HEAD
=======
select count(no) from faq where title like concat('%','쿠폰','%');
select * from faq where lcate = 'D' and mcate = 'J' and title like concat ('%','제주','%') order by no desc limit 1,10;
desc tour;
select * from tour where no = 3001 order by no desc;
delete from tour;
select * from product order by pno desc;
desc airplane;
select p.pno,p.pname,p.pcontent,p.pexpire,p.pprice,p.ppic,p.pdiv,
	   a2.no,a2.ano,a2.dlocation,a2.rlocation,a2.ddate,a2.rdate,a2.ldiv,a2.capacity,a2.seat,a2.price,a2.pdiv, 
	   h2.no,h2.hname,h2.haddr,h2.checkin,h2.checkout,h2.capacity,h2.price,h2.roomcapacity,h2.roomtype,h2.ldiv,h2.bookedup,h2.pdiv,
	   t2.no,t2.tname,t2.tlocation,t2.startdate,t2.enddate,t2.taddr,t2.etime,t2.capacity,t2.tprice,t2.ldiv,t2.pdiv,
	   r2.no,r2.cdiv,r2.cno,r2.rentddate,r2.returndate,r2.rentaddr,r2.returnaddr,r2.price,r2.capacity,r2.insurance,r2.ldiv,r2.pdiv 
	from (select * from product order by pno desc limit 0
	,10) p join pairstatus a on p.pno = a.pno join airplane a2 on a.ano = a2.no
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
>>>>>>> branch 'master' of https://github.com/dlstjs8246/tourland.git

<<<<<<< HEAD
=======
select * from product p join photelstatus h on p.pno = h.pno join hotel h2 on h.hno = h2.no join prentstatus r on p.pno = r.pno join rentcar r2 on r.rno = r2.no where p.pno = 2;
desc pairstatus;
desc prentstatus;
select * from hotel where haddr like "%베이징%";
select * from tour;
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
delete from airplane;
delete from hotel;
delete from tour;
delete from rentcar;			
select * from product where substring(pname,2,3) = '제주' order by pno desc limit 0,10;	
select * from product where substring(pname,2,4) = '베이징' order by pno desc limit 0,10;
select * from product where substring(pname,2,3) = '도쿄' order by pno desc limit 0,10;

select p.pno,p.pname,p.pcontent,p.pexpire,p.pprice,p.ppic,p.pdiv,
	    a2.no as a2no,a2.ano,a2.dlocation,a2.rlocation,a2.ddate,a2.rdate,a2.ldiv,a2.capacity as a2capacity,a2.seat,a2.price as a2price,a2.pdiv, 
	    h2.no as h2no,h2.hname,h2.haddr,h2.checkin,h2.checkout,h2.capacity as h2capacity,h2.price as h2price,h2.roomcapacity,h2.roomtype,h2.ldiv,h2.bookedup,h2.pdiv,
	    t2.no as t2no,t2.tname,t2.tlocation,t2.startdate,t2.enddate,t2.taddr,t2.etime,t2.capacity as t2capacity,t2.tprice as t2tprice,t2.ldiv,t2.pdiv,
	    r2.no as r2no,r2.cdiv,r2.cno,r2.rentddate,r2.returndate,r2.rentaddr,r2.returnaddr,r2.price as r2price,r2.capacity as r2capacity,r2.insurance,r2.ldiv,r2.pdiv 
		from (select * from product where substring(pname,2,3) = '도쿄' order by pno desc limit 0,10) p join pairstatus a on p.pno = a.pno join airplane a2 on a.ano = a2.no
							 	join photelstatus h on p.pno = h.pno join hotel h2 on h.hno = h2.no
							 	join ptourstatus t on p.pno = t.pno join tour t2 on t.tno = t2.no
							 	join prentstatus r on p.pno = r.pno join rentcar r2 on r.rno = r2.no
							 	where p.pdiv = 0;

select p.*,((a2.price * 2) + (h2.price * datediff(h2.checkout,h2.checkin)) + tsum) as 'defaultPrice'
		from (select p2.*,sum(t2.tprice) as 'tsum' from product p2 join ptourstatus t on p2.pno = t.pno join tour t2 on t.tno = t2.no group by p2.pno) p 
								join pairstatus a on p.pno = a.pno join airplane a2 on a.ano = a2.no and a2.seat = 'E'
							 	join photelstatus h on p.pno = h.pno join hotel h2 on h.hno = h2.no and h2.roomtype = 'N' and h2.checkin = date(a2.ddate)
							 	join ptourstatus t on p.pno = t.pno join tour t2 on t.tno = t2.no
							 	join prentstatus r on p.pno = r.pno join rentcar r2 on r.rno = r2.no
							 	where p.pdiv = 0 and substring(p.pname,2,3) = '제주' group by p.pno order by defaultPrice;
select p.*,((a2.price * 2) + (h2.price * datediff(h2.checkout,h2.checkin)) + t2.tprice) as 'defaultPrice'
		from product p 
		join pairstatus a on p.pno = a.pno join airplane a2 on a.ano = a2.no and a2.seat = 'E'
		join photelstatus h on p.pno = h.pno join hotel h2 on h.hno = h2.no and h2.roomtype = 'N' and h2.checkin = date(a2.ddate)
		join ptourstatus t on p.pno = t.pno join tour t2 on t.tno = t2.no
		join prentstatus r on p.pno = r.pno join rentcar r2 on r.rno = r2.no
		where p.pdiv = 0 and substring(p.pname,2,3) = '제주' group by p.pno order by defaultPrice;
select p.pno,p.pname,p.pcontent,p.pexpire,p.pprice,p.ppic,p.pdiv,
	    a2.no as a2no,a2.ano,a2.dlocation,a2.rlocation,a2.ddate,a2.rdate,a2.ldiv,a2.capacity as a2capacity,a2.seat,a2.price as a2price,a2.pdiv, 
	    h2.no as h2no,h2.hname,h2.haddr,h2.checkin,h2.checkout,h2.capacity as h2capacity,h2.price as h2price,h2.roomcapacity,h2.roomtype,h2.ldiv,h2.bookedup,h2.pdiv,
	    t2.no as t2no,t2.tname,t2.tlocation,t2.startdate,t2.enddate,t2.taddr,t2.etime,t2.capacity as t2capacity,t2.tprice as t2tprice,t2.ldiv,t2.pdiv,
	    r2.no as r2no,r2.cdiv,r2.cno,r2.rentddate,r2.returndate,r2.rentaddr,r2.returnaddr,r2.price as r2price,r2.capacity as r2capacity,r2.insurance,r2.ldiv,r2.pdiv 
		from (select p.*,((a2.price * 2) + (h2.price * datediff(h2.checkout,h2.checkin)) + tsum) as 'defaultPrice'
		from (select p2.*,sum(t2.tprice) as 'tsum' from product p2 join ptourstatus t on p2.pno = t.pno join tour t2 on t.tno = t2.no group by p2.pno) p 
								join pairstatus a on p.pno = a.pno join airplane a2 on a.ano = a2.no and a2.seat = 'E'
							 	join photelstatus h on p.pno = h.pno join hotel h2 on h.hno = h2.no and h2.roomtype = 'N' and h2.checkin = date(a2.ddate)
							 	join ptourstatus t on p.pno = t.pno join tour t2 on t.tno = t2.no
							 	join prentstatus r on p.pno = r.pno join rentcar r2 on r.rno = r2.no
							 	where p.pdiv = 0 and substring(p.pname,2,3) = '도쿄' group by p.pno order by defaultPrice limit 0,10) p  
				join pairstatus a on p.pno = a.pno join airplane a2 on a.ano = a2.no
				join photelstatus h on p.pno = h.pno join hotel h2 on h.hno = h2.no
				join ptourstatus t on p.pno = t.pno join tour t2 on t.tno = t2.no
				join prentstatus r on p.pno = r.pno join rentcar r2 on r.rno = r2.no
				where p.pdiv = 0;

		select p.pno,p.pname,p.pcontent,p.pexpire,p.pprice,p.ppic,p.pdiv,
	    a2.no as a2no,a2.ano,a2.dlocation,a2.rlocation,a2.ddate,a2.rdate,a2.ldiv,a2.capacity as a2capacity,a2.seat,a2.price as a2price,a2.pdiv, 
	    h2.no as h2no,h2.hname,h2.haddr,h2.checkin,h2.checkout,h2.capacity as h2capacity,h2.price as h2price,h2.roomcapacity,h2.roomtype,h2.ldiv,h2.bookedup,h2.pdiv,
	    t2.no as t2no,t2.tname,t2.tlocation,t2.startdate,t2.enddate,t2.taddr,t2.etime,t2.capacity as t2capacity,t2.tprice as t2tprice,t2.ldiv,t2.pdiv,
	    r2.no as r2no,r2.cdiv,r2.cno,r2.rentddate,r2.returndate,r2.rentaddr,r2.returnaddr,r2.price as r2price,r2.capacity as r2capacity,r2.insurance,r2.ldiv,r2.pdiv 
		from (select * from product where substring(pname,2,3) = '제주' and pdiv = 0 order by pno desc limit 0,10) p join pairstatus a on p.pno = a.pno join airplane a2 on a.ano = a2.no
							 	join photelstatus h on p.pno = h.pno join hotel h2 on h.hno = h2.no
							 	join ptourstatus t on p.pno = t.pno join tour t2 on t.tno = t2.no
							 	join prentstatus r on p.pno = r.pno join rentcar r2 on r.rno = r2.no;
select * from userpstatus;
select * from cart;
select * from hotel order by no asc;
select distinct no,r.userno,rdate,rstatus,pno from reservation r join userpstatus u on r.userno = u.userno;
select * from reservation;
select * from product order by pno desc;
desc tour;
select * from user;
select * from airplane order by no desc;
select p.pno,p.pname,p.pcontent,p.pexpire,p.pprice,p.ppic,p.pdiv,
	    a2.no as a2no,a2.ano,a2.dlocation,a2.rlocation,a2.ddate,a2.rdate,a2.ldiv,a2.capacity as a2capacity,a2.seat,a2.price as a2price,a2.pdiv, 
	    h2.no as h2no,h2.hname,h2.haddr,h2.checkin,h2.checkout,h2.capacity as h2capacity,h2.price as h2price,h2.roomcapacity,h2.roomtype,h2.ldiv,h2.bookedup,h2.totalcapacity,h2.pdiv,
	    t2.no as t2no,t2.tname,t2.tlocation,t2.startdate,t2.enddate,t2.taddr,t2.etime,t2.capacity as t2capacity,t2.tprice as t2tprice,t2.ldiv,t2.pdiv,
	    r2.no as r2no,r2.cdiv,r2.cno,r2.rentddate,r2.returndate,r2.rentaddr,r2.returnaddr,r2.price as r2price,r2.capacity as r2capacity,r2.insurance,r2.ldiv,r2.pdiv 
		from (select p.*,((a2.price * 2) + (h2.price * datediff(h2.checkout,h2.checkin)) + tsum) as 'defaultPrice'
		from (select p2.*,sum(t2.tprice) as 'tsum' from product p2 join ptourstatus t on p2.pno = t.pno join tour t2 on t.tno = t2.no group by p2.pno) p 
		join pairstatus a on p.pno = a.pno join airplane a2 on a.ano = a2.no and a2.seat = 'E'
		join photelstatus h on p.pno = h.pno join hotel h2 on h.hno = h2.no and h2.roomtype = 'N' and h2.checkin = date(a2.ddate)
		join ptourstatus t on p.pno = t.pno join tour t2 on t.tno = t2.no
		join prentstatus r on p.pno = r.pno join rentcar r2 on r.rno = r2.no
		where p.pdiv = 0 and substring(p.pname,2,3) = '제주' group by p.pno order by defaultPrice limit 10,10) p  
		join pairstatus a on p.pno = a.pno join airplane a2 on a.ano = a2.no
		join photelstatus h on p.pno = h.pno join hotel h2 on h.hno = h2.no
		join ptourstatus t on p.pno = t.pno join tour t2 on t.tno = t2.no
		join prentstatus r on p.pno = r.pno join rentcar r2 on r.rno = r2.no
		where p.pdiv = 0;
select * from reservation;
select rv.*,
		p.pno,p.pname,p.pcontent,p.pexpire,p.pprice,p.ppic,p.pdiv,
	    a2.no as a2no,a2.ano,a2.dlocation,a2.rlocation,a2.ddate,a2.rdate as 'a2rdate',a2.ldiv,a2.capacity as a2capacity,a2.seat,a2.price as a2price,a2.pdiv, 
	    h2.no as h2no,h2.hname,h2.haddr,h2.checkin,h2.checkout,h2.capacity as h2capacity,h2.price as h2price,h2.roomcapacity,h2.roomtype,h2.ldiv,h2.bookedup,h2.totalcapacity,h2.pdiv,
	    t2.no as t2no,t2.tname,t2.tlocation,t2.startdate,t2.enddate,t2.taddr,t2.etime,t2.capacity as t2capacity,t2.tprice as t2tprice,t2.ldiv,t2.pdiv,
	    r2.no as r2no,r2.cdiv,r2.cno,r2.rentddate,r2.returndate,r2.rentaddr,r2.returnaddr,r2.price as r2price,r2.capacity as r2capacity,r2.insurance,r2.ldiv,r2.pdiv 
		from (select * from reservation where no = 1 and userno = 6 and rstatus = '1' order by no desc) rv 
		join userpstatus u on rv.userno = u.userno and rv.no = u.no join product p on u.pno = p.pno
		left join pairstatus a on p.pno = a.pno left join airplane a2 on a.ano = a2.no
		left join photelstatus h on p.pno = h.pno left join hotel h2 on h.hno = h2.no
		left join ptourstatus t on p.pno = t.pno left join tour t2 on t.tno = t2.no
		left join prentstatus r on p.pno = r.pno left join rentcar r2 on r.rno = r2.no;
>>>>>>> branch 'master' of https://github.com/dlstjs8246/tourland.git
-- 태원 --------------------------------------------------------------------------------------------
SELECT *
FROM hotel; 

where no = 811;
select count(no) from hotel;
select * from hotel order by no desc limit 10, 3;
select * from user;
select * from hotel
where hname like CONCAT('%','hidden','%');
select * from user;
select * from employee;
select * from planboard;
select * from hotel;
select * from rentcar;
select * from product;
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

update user set 
username ='테스트', userbirth='1991-12-18', usertel='010-4245-3825', 
useraddr='북구 태전동 254-30번지', userpassport='이래저래', userpass='test'
where userno=6;

update user set username ='테스트', userbirth='1991-12-18 00:00:00', usertel='010-4333-3825', 
useraddr='대구시 북구 태전동 254-30', userpassport=NULL, userpass='*94BDCEBE19083CE2A1F959FD02F964C7AF4CFC29' 
where userno=6 

select * from user;
select * from employee;
select userid,userpass
from user
where username='황태원' and userbirth='1991-12-18' and usertel='010-4245-3825';

select *
from reservation;

select * from hotel;

insert into reservation values(1, 2, '2020-05-20',2);

select * from userpstatus;
select * from user;
insert into userpstatus values(1,2,270);

select u.username, p.pname, a.ano, a.ddate, a.rdate, r.rstatus
from user u join reservation r on u.userno = r.userno 
			join userpstatus up on up.userno = u.userno and up.no = r.no
			join product p on p.pno = up.pno
			join pairstatus ps on ps.pno = p.pno 
			join airplane a on ps.ano = a.no
where r.rstatus=2 order by u.userno desc limit 5, 5;

select * from user;

select * from reservation;

select count(userno) from reservations

select r.no, r.userno, u.username, p.pno, p.pname, a.ano, a.ddate, a.rdate, r.rdate, r.rstatus
	from user u join reservation r on u.userno = r.userno 
				join userpstatus up on up.userno = u.userno and up.no = r.no
				join product p on p.pno = up.pno 
				join pairstatus ps on ps.pno = p.pno 
				join airplane a on ps.ano = a.no 
	where r.rstatus=2
	order by u.username desc limit 1,9;
select r.no, r.userno, u.username, p.pno, p.pname, a.ano, a.ddate, a.rdate as 'returndate', r.rdate as 'reservdate', r.rstatus
	from (select * from reservation where rstatus = '2' limit 0,10) r join user u on u.userno = r.userno 
				join userpstatus up on up.userno = u.userno and up.no = r.no
				join product p on p.pno = up.pno
				join pairstatus ps on ps.pno = p.pno 
				join airplane a on ps.ano = a.no
				order by userno desc; 
	
	
select count(userno) from reservation 
WHERE r.rstatus=2;

select count(u.userno) from user u join reservation r on u.userno = r.userno 
								  join userpstatus up on up.userno = u.userno and up.no = r.no
								  join product p on p.pno = up.pno
								  join pairstatus ps on ps.pno = p.pno 
							      join airplane a on ps.ano = a.no
where r.rstatus=2 and a.ddate =  '2020-04-30' and a.rdate = '2020-05-06'; 


select count(r.userno)
	from (select * from reservation where rstatus = '2' limit 0,10) r 
				join user u on u.userno = r.userno 
				join userpstatus up on up.userno = u.userno and up.no = r.no
				join product p on p.pno = up.pno
				join pairstatus ps on ps.pno = p.pno 
				join airplane a on ps.ano = a.no  
	where rstatus = '2' and u.username = '정아름'
	order by u.userno desc;


select * from reservation;
select * from airplane;

select count(no) from airplane;

select r.no, r.userno, u.username, p.pno, p.pname, a.ano, date_format(a.ddate, '%Y-%m-%d'), a.rdate as 'returndate', r.rdate as 'reservdate', r.rstatus
	from (select * from reservation where rstatus = '2' limit 0, 10) r 
				join user u on u.userno = r.userno 
				join userpstatus up on up.userno = u.userno and up.no = r.no
				join product p on p.pno = up.pno
				join pairstatus ps on ps.pno = p.pno 
				join airplane a on ps.ano = a.no
	where rstatus = '2'
	order by userno desc;

select r.no, r.userno, u.username, p.pno, p.pname,a.no, a.ano, a.ddate, a.rdate as 'returndate', r.rdate as 'reservdate', r.rstatus
	from (select * from reservation where rstatus = '2' limit 0, 10) r 
				join user u on u.userno = r.userno 
				join userpstatus up on up.userno = u.userno and up.no = r.no
				join product p on p.pno = up.pno
				join pairstatus ps on ps.pno = p.pno 
				join airplane a on ps.ano = a.no
	where rstatus = '2'
	order by a.no asc;
select * from airplane order by no desc;
select r.no, r.userno, u.username, p.pno, p.pname, a.ano, a.ddate, a.rdate as 'returndate', r.rdate as 'reservdate', r.rstatus
from (select * from reservation where rstatus = '2') r 
				join user u on u.userno = r.userno 
				join userpstatus up on up.userno = u.userno and up.no = r.no
				join product p on p.pno = up.pno
				join pairstatus ps on ps.pno = p.pno 
				join airplane a on ps.ano = a.no
where rstatus = '2' and DATE(a.ddate) = '2020-04-30'
union 
select r.no, r.userno, u.username, p.pno, p.pname, a.ano, a.ddate, a.rdate as 'returndate', r.rdate as 'reservdate', r.rstatus
from (select * from reservation where rstatus = '2') r 
				join user u on u.userno = r.userno 
				join userpstatus up on up.userno = u.userno and up.no = r.no
				join product p on p.pno = up.pno
				join pairstatus ps on ps.pno = p.pno 
				join airplane a on ps.ano = a.no
	where rstatus = '2' and date(a.ddate) = date_add(str_to_date('2020-04-30','%Y-%m-%d'), interval (trim(substring(substring_index(p.pname,'일]',1),5))-1) day);
select trim(substring(substring_index(pname,'일]',1),5)) from product p; 
select date_add(str_to_date('2020-04-30','%Y-%m-%d'), interval (trim(substring(substring_index(pname,'일]',1),5))-1) day) from product;

select * from reservation;
select * from userpstatus;

select * from product;

delete 
from userpstatus u join reservation r on u.no=r.no
where no=10;

-- 하나 --------------------------------------------------------------------------------------------
select * from reservation;
SELECT * FROM notice;
select count(*) from airplane; 
select * from coupon;
select * from airplane;