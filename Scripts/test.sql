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
insert into user values (6,'도라지','1989-12-18','010-4333-3825','대구시 북구 태전동 254-30',null,'customer5',password('customer'),1);
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
select * from product;
select * from photelstatus;
select * from prentstatus;
select * from pairstatus;
select * from ptourstatus;

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

-- 인선 --------------------------------------------------------------------------------------------
select count(no) from faq where title like concat('%','쿠폰','%');
select * from faq where lcate = 'D' and mcate = 'J' and title like concat ('%','제주','%') order by no desc limit 1,10;
desc tour;
select * from tour where no = 3001 order by no desc;
delete from tour;
select * from product;
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

	
INSERT INTO tour.product
(pno, pname, pcontent, pexpire, pprice, ppic, pdiv)
VALUES(1, '[제주 3일]시크릿 특가!제주시내/한라산 대한항공 바로출발!', '<h1><strong>상품 세부 설명</strong></h1>

<h2>숙소(Hidden Cliff)</h2>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/hotel/suite.jpg" style="height:570px; width:1000px" /></p>

<h3>180만년 동안 제주가 한 번도 드러내지 않았던 그 자리에 제주의 하늘, 구름, 초원, 절벽, 바다, 땅을 담은 히든 클리프 호텔이 들어섰습니다&nbsp;</h3>

<h2>&nbsp;</h2>

<h2>우도</h2>

<h3><strong>우도</strong>(牛島)는&nbsp;<a href="https://ko.wikipedia.org/wiki/%EC%A0%9C%EC%A3%BC%EB%8F%84" style="color: rgb(11, 0, 128); text-decoration-line: none; background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: sans-serif; font-size: 14px;" title="제주도">제주도</a>의 동쪽 끝에 접하는&nbsp;<a href="https://ko.wikipedia.org/wiki/%EC%84%AC" style="color: rgb(11, 0, 128); text-decoration-line: none; background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: sans-serif; font-size: 14px;" title="섬">섬</a>으로,&nbsp;<a href="https://ko.wikipedia.org/wiki/%EC%A0%9C%EC%A3%BC%ED%8A%B9%EB%B3%84%EC%9E%90%EC%B9%98%EB%8F%84" style="color: rgb(11, 0, 128); text-decoration-line: none; background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: sans-serif; font-size: 14px;" title="제주특별자치도">제주특별자치도</a>에서&nbsp;<a href="https://ko.wikipedia.org/wiki/%EC%A0%9C%EC%A3%BC%EB%8F%84" style="color: rgb(11, 0, 128); text-decoration-line: none; background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: sans-serif; font-size: 14px;" title="제주도">제주도</a>&nbsp;다음으로 큰 섬이다. 우도란 이름은 섬의 모습이&nbsp;<a href="https://ko.wikipedia.org/wiki/%EC%86%8C" style="color: rgb(11, 0, 128); text-decoration-line: none; background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: sans-serif; font-size: 14px;" title="소">소</a>가 누워 있는 것 같다고 해서 붙여졌다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour2.jpg" style="height:966px; width:1000px" /></p>

<h2>한라산</h2>

<h3>백록담 정상을 제외하고는 대부분 숲으로 형성되어 있어 삼림욕을 즐기며 탐방하기에 최적의 장소이다. 탐방로에서 보이는 오름군락은 화산섬의 신비감을 그대로 전달해준다. 한라산 자생지인 구상나무 숲이 가장 넓게 형성된 곳이며 한라장구채 큰오색딱따구리 오소리 노루 등의 한라산 동&middot;식물을 관찰할 수 있다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour1.jpg" style="height:800px; width:1000px" /></p>
', '2020-03-29', 30140000, '/2020/05/13/6adef0ef-50b6-4703-ae73-ad8a636d7501_tour1.jpg', 0);
INSERT INTO tour.product
(pno, pname, pcontent, pexpire, pprice, ppic, pdiv)
VALUES(2, '[제주 5일]시크릿 특가!제주시내/성산일출봉 대한항공 바로출발!', '<h1><strong>상품 세부 설명</strong></h1>

<h2>숙소(Hidden Cliff)</h2>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/hotel/suite.jpg" style="height:570px; width:1000px" /></p>

<h3>180만년 동안 제주가 한 번도 드러내지 않았던 그 자리에 제주의 하늘, 구름, 초원, 절벽, 바다, 땅을 담은 히든 클리프 호텔이 들어섰습니다&nbsp;</h3>

<p>&nbsp;</p>

<h2>오셜록 티 뮤지엄</h2>

<h3>제주 오설록 서광 차밭과 맞닿아 있는 오설록 티뮤지엄은 아모레퍼시픽이 차와 한국 전통차 문화를 소개하고, 널리 보급하고자 2001년 9월에 개관한 국내 최초의 차 박물관입니다. 동양과 서양, 전통과 현대가 조화를 이룬 문화공간으로 차 유물관, 자연친화적인 휴식공간, 2013년 티클래스를 더해 21세기형 차 박물관으로 발돋움했습니다.<br />
세계적인 디자인 건축 전문사이트인 &lsquo;디자인붐&rsquo;이 선정한 세계 10대 미술관에 오를만큼 안팎으로 아름다운 풍광을 뽐내는 티뮤지엄은 연간 150만 명의 관람객이 방문하는 제주 최고 명소이자 문화 공간입니다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour5.jpg" style="height:500px; width:1000px" /></p>

<h2>성산 일출봉</h2>

<h3><kbd><a class="wiki-link-internal" href="https://namu.wiki/w/%EC%84%B1%EC%82%B0%EC%9D%8D" style="box-sizing: inherit; color: rgb(2, 117, 216); text-decoration-line: none; font-family: &quot;Open Sans&quot;, arial, &quot;Apple SD Gothic Neo&quot;, &quot;Noto Sans CJK KR&quot;, 본고딕, KoPubDotum, 나눔바른고딕, 나눔고딕, NanumGothic, 맑은고딕, &quot;Malgun Gothic&quot;, sans-serif; font-size: 14.4px;" title="성산읍">성산읍</a>&nbsp;성산리 성산반도(성산포구) 끝에 위치해있는 화산.&nbsp;산 전체가 하나의 움푹한 분화구로 이루어져 있으며, 육지와 연결된 서쪽을 제외한 삼면이 해안절벽을 이루고 있다. 초지가 형성되어 있는 접시 모양의 분화구 주위에는 99개의 봉우리가 왕관처럼 분화구를 둘러싸고 있다. 성산일출봉과 그 일대는&nbsp;<a class="wiki-link-internal" href="https://namu.wiki/w/%EC%9C%A0%EB%84%A4%EC%8A%A4%EC%BD%94%20%EC%84%B8%EA%B3%84%EC%9C%A0%EC%82%B0" style="box-sizing: inherit; color: rgb(2, 117, 216); text-decoration-line: none; font-family: &quot;Open Sans&quot;, arial, &quot;Apple SD Gothic Neo&quot;, &quot;Noto Sans CJK KR&quot;, 본고딕, KoPubDotum, 나눔바른고딕, 나눔고딕, NanumGothic, 맑은고딕, &quot;Malgun Gothic&quot;, sans-serif; font-size: 14.4px;" title="유네스코 세계유산">유네스코 세계자연유산</a>에 등재되어 있으며,&nbsp;<a class="wiki-link-internal" href="https://namu.wiki/w/%EC%B2%9C%EC%97%B0%EA%B8%B0%EB%85%90%EB%AC%BC" style="box-sizing: inherit; color: rgb(2, 117, 216); text-decoration-line: none; font-family: &quot;Open Sans&quot;, arial, &quot;Apple SD Gothic Neo&quot;, &quot;Noto Sans CJK KR&quot;, 본고딕, KoPubDotum, 나눔바른고딕, 나눔고딕, NanumGothic, 맑은고딕, &quot;Malgun Gothic&quot;, sans-serif; font-size: 14.4px;" title="천연기념물">천연기념물</a>&nbsp;제420호(2000년 7월) 및 유네스코 세계지질공원(2010년 10월)으로 지정되어 있다.</kbd></h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour6.jpg" style="height:663px; width:1000px" /></p>

<h2>섭지 코지</h2>

<h3>제주 동부해안에 볼록 튀어나온 섭지코지는 성산 일출봉을 배경으로한 해안풍경이 일품이다.<br />
들머리의 신양해변백사장, 끝머리 언덕위 평원에 드리워진 유채밭, 여유롭게 풀을 뜯는 제주조랑말들, 바위로 둘러친 해안절벽과 우뚝 치솟은 전설어린 선바위 등은 전형적인 제주의 아름다움을 만날 수 있다. 특히 제주의 다른 해안과는 달리 송이라는 붉은 화산재로 되어 있고, 밀물과 썰물에 따라 물속에 잠겼다가 일어서는 기암괴석들은 어디에서도 볼 수 없는 자연의 수석전시회를 연출한다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour7.jpg" style="height:563px; width:1000px" /></p>

<h2>지니어스 로사이</h2>

<h3>지니어스로사이는 섭지코지에 자리한 건축물로 개개인의 마음에 남는 공간을 만들고 싶다는 건축가 안도 타다오의 바람이 담긴 건축물이다. 건물을 둘러보는 과정에서 자연과 호흡하는 명상을 할수 있도록 공간을 설계한 점이, 지니어스로사이를 단순한 건축물이 아닌 하나의 커다란 예술작품으로 승격시키는 점이다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour8.jpg" style="height:667px; width:1000px" /></p>

<h2>만장굴</h2>

<h3>제주말로 &#39;아주 깊다&#39;는 의미에서 &#39;만쟁이거머리굴&#39;로 불려온 만장굴은 약10만년전~30만년전에 생성, 제주도는 180만년전에 형성된 것으로 추정되지만, 1958년에야 당시 김녕초등학교 교사였던 부종휴씨에 의해 발견되어 세상에 알려지게 되었다. 만장굴은 총 길이가 약 7.4km에 이르며, 부분적으로 다층구조를 지니는 용암동굴이다. 인근에 있는, 김녕사굴, 밭굴, 개우젯굴과 애초에 모두 연결되어 있었으나 천장이 붕괴되면서 분리된 것으로 여겨진다. 만장굴의 주 통로는 폭이 18m, 높이가 23m에 이르러, 세계적으로도 큰 규모의 용암동굴이다. 전 세계에는 많은 용암동굴이 분포하지만 만장굴과 같이 수십만 년 전에 형성된 동굴로서 내부의 형태와 지형이 잘 보존되어 있는 용암동굴은 드물어서 학술적, 보전적 가치가 매우 크다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour9.jpg" style="height:666px; width:1000px" /></p>

<h2>제주 민속촌</h2>

<h3>민속은 민족의 얼이다. 시대와 환경에 적응하여 변화하면서 대대로 전승되는 생활문화이다. 세월이 흐르면서 새로운 요소가 생성되거나 추가되고 또 때로는 부분적으로 소멸되기도 하지만 큰 줄기는 유지되는 것이다. 민속은 주민의 얼과 사상을 담은 구체적 생활양상이며 기층문화라 할 수 있을 것이다.<br />
그런의미에서 제주도민의 민속문화를 간직하고 있는 제주민속촌은 제주에서 가장 제주다운 곳이라 할 수 있다. 제주민속촌은 조선말인 1890년대를 기준 연대로 삼아 제주 전래의 민속자료를 총체적으로 정리하여 전시하고 있다. 제주의 민속 문화가 제대로 보존되어 있으며, 우리의 꽃과 나무를 한눈에 보고, 세계문화의 유사성과 차별성을 비교해 볼 수 있는 문화공간이다.</h3>

<h2><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour10.jpg" style="height:577px; width:1000px" /><br />
카멜리아 힐</h2>

<h3>태교 여행의 순간을 아름답게 남기고 싶다면 카멜리아힐을 방문해보자.<br />
카멜리아힐은 동양에서 가장 큰 동백 수목원으로 토종 동백부터 아기 동백, 유럽 동백 등 80여 개국 500여 품종의 수많은 동백꽃을 만날 수 있다.<br />
수목원 안에 아기자기한 포토 스폿이 많아 연인과 가족 단위 관광객에게 특히 인기가 높다.<br />
동백꽃이 피는 계절이면 흐드러지게 피어난 동백꽃을 배경으로 멋진 인생 사진을 남기기 위해 찾아드는 발걸음이 끊이지 않는다.<br />
어디 동백꽃뿐이랴.<br />
여름이 시작되면 파란 하늘을 닮은 수국 꽃이 관람객들을 맞이하고 가을에는 억새와 핑크뮬리가 가을 정원을 가득 채운다.<br />
계절마다 새롭게 옷을 갈아입는 덕분에 어느 때에 방문해도 인생샷 100%의 성공률을 자랑한다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour32.jpg" style="height:562px; width:1000px" /></p>

<h2>제주 신화테마파크</h2>

<h3>캐릭터와 스토리가 살아 숨쉬는 미지의 세계, 신화테마파크<br />
<br />
한국 토종 애니메이션으로 세계적인 인기를 끈 라바의 세계관이 곳곳에 심어진 정통 테마파크. 제주 유일의 롤러코스터인 &#39;댄싱 오스카&#39;를 포함한 짜릿한 놀이기구들은 투바앤의 유머 넘치는 디자인을 입고 세상 어디에도 없는 독창적인 테마파크로 완성되었다. 모험의 시작점이 되어주는 &#39;로터리 파크&#39;를 지나, 신비한 정글 고대 도시 &#39;오스카 뉴월드&#39;를 거쳐, 귀여운 캐릭터가 가득한 &#39;라바 어드벤처 빌리지&#39;에 도착하는 동안 15개의 최신 놀이기구와 어트랙션, VR체험과 게임, 퍼레이드와 쇼 등을 즐길 수 있다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour33.jpg" style="height:666px; width:1000px" /></p>
', '2020-03-29', 52285000, '/2020/05/14/c761a3b1-7eb6-416c-8da7-f7894fd1ff13_tour6.jpg', 0);
INSERT INTO tour.product
(pno, pname, pcontent, pexpire, pprice, ppic, pdiv)
VALUES(3, '[제주 7일]시크릿 특가!제주시내/우도 대한항공 바로출발!', '<h1><strong>상품 세부 설명</strong></h1>

<h2>숙소(Hidden Cliff)</h2>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/hotel/suite.jpg" style="height:570px; width:1000px" /></p>

<h3>180만년 동안 제주가 한 번도 드러내지 않았던 그 자리에 제주의 하늘, 구름, 초원, 절벽, 바다, 땅을 담은 히든 클리프 호텔이 들어섰습니다&nbsp;</h3>

<p>&nbsp;</p>

<h2>김녕 미로 공원</h2>

<h3>높이 3m의 랠란디 나무로 이루어진 미로의 수벽을 따라 미로찾기를 할수 있는 김녕미로공원. 붉은 화산송이 흙을 밝으며 상쾌한 기분으로 스트레스를 완화시키는 산책을 즐길 수 있다. 김녕미로공원의 미로는 제주도 모양으로 만들어져 있으며, 제주를 상징하는 7가지 이야기를 찾아 떠나는 미로 체험을 즐길 수 있다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour34.jpg" style="height:656px; width:1000px" /></p>

<h2>선녀와 나무꾼 테마공원</h2>

<h3>조천읍 선흘리에 위치한 &#39;선녀와 나무꾼&#39;은 옛 추억을 회상할 수 있는 실내 테마공원이다.&nbsp; 옛 서울역의 모습을 재현한 건물로 들어서면 다양한 테마의 건물 모형에 옛날 물건들이 전시되어 있다.&nbsp; 옛장터의 모습을&nbsp; 재현한 장터거리와 고고장, 다방, 만화방 등 옛 도심의 거리와 달동네 풍경을 보며 그 시절을 살아온 세대는 추억에 잠기고, 그 시절을 경험하지 못한 세대는 부모님이 살아온 삶의 모습을 짐작할 수 있다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour35.jpg" style="height:750px; width:1000px" /></p>

<h2>테지움</h2>

<h3>테디베어사파리(테지움)는 정서적 안정과 심리치료에 탁월한 효과가 있는 귀엽고 앙증맞은 테디베어로 구성된 인형 박물관으로 정서적으로 메마르기 쉬운 환경에 놓여있는 현대인들에게 테디베어 특유의 포근함을 느끼게 해준다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour36.jpg" style="height:654px; width:1000px" /></p>

<h2>어승생악</h2>

<h3>어승생악은 가벼운 등산을 원하는 탐방객이 즐겨찾는 오름으로서 자연생태가 잘 보존되어 있으며, 자연학습탐방로로 활용되고 있다. 날씨가 쾌청한 날에는 멀리 추자도, 비양도, 성산일출봉이 한눈에 내려다보이며 어승생악 정상까지는 1.3Km이다. 탐방소요시간은 편도 약 30분이며, 어리목 탐방안내소 옆에 입구가 있다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour37.jpg" style="height:667px; width:1000px" /></p>

<h2>제주목 관아</h2>

<h3>제주목관아는 관덕정(보물 제322호)을 포함하는 주변 일대에 자리하고 있었으며, 주요 관아시설이 있었던 곳이다. 탐라국 이래 조선시대에 이르기까지 제주 행정의 중추 역할을 해왔던 제주목 관아지를 1991년부터 1998년까지 4차례 발굴조사한 결과 문헌상에 나타나는 중심건물인 홍화각(弘化閣), 연희각(延羲閣), 우연당(友蓮堂), 귤림당(橘林堂), 영주협당(瀛洲協堂) 등 30여 채의 건물의 흔적이 확인되었고, 지난 1993. 3. 30일과 2003. 7. 6일 2회에 걸쳐 주변토지가 국가 사적지 제380호로 지정되었다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour38.jpg" style="height:663px; width:1000px" /></p>

<h2>한라수목원</h2>

<h3>제주시 연동 1100도로변에 광이오름 기슭에 위치한 한라수목원은 제주의 자생수종과 아열대 식물 등 1,100여 종의 식물이 식재 전시되어 있는 수목원으로써 학생 및 전문인을 위한 교육과 연구의 장으로 역할을 하고 있다. 특히 5만평에 달하는 삼림욕장은 1.7㎞의 산책코스로 거의 오름 정상까지 올라갔다 내려오는 코스로 만들어져 있다. 체력단련시설과 잘 조성된 산책코스는 아침 일찍 운동을 하려는 사람들이 많이 찾으며 시내에서 가까워 주말이면 가족 단위로 이곳을 찾는 사람들이 많다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour39.jpg" style="height:563px; width:1000px" /></p>

<h2>제주 국립 박물관</h2>

<h3>국립제주 박물관은 제주항이 내려다보이는 사라봉공원 남쪽에 자리하고 있으며 제주국제공항과의 거리는 차로 20분 남짓이다. 국립제주박물관은 2001년 개관하였으며, 제주의 역사와 문화유산을 체계적으로 전시&middot;보존&middot;연구하는 고고&middot;역사박물관이다. 한반도와 중국, 일본을 잇는 동북아시아지역 문화교류의 주요 거점인 제주도의 독특한 역사와 문화를 압축해서 만나볼 수 있다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour40.jpg" style="height:668px; width:1000px" /></p>

<h2>용두암</h2>

<h3>용담2동, 공항 북동쪽 해안에 있는 영두암은 제주관광의 상징과도 같은 곳이다. 공항과 가장 가까운 관광지로 해외여행자나 단체여행객들이 자주 찾는 관광지다. &nbsp;용이 포요하며 바다에서 솟구쳐 오르는 형상을 따 용두암이라 이름지어졌다. 전설에 의하면 인근 계곡 용연에서 살던 용이 승천하려다가 돌로 굳어졌다고 한다. 겉으로 드러난 부분의 높이가 10m, 바다 속에 잠긴 몸의 길이가 30m 쯤 된다고 하니, 괴암을 응시하고 있자면, 정말로 용이 꿈틀거리는 것 같은 상상을 할법도 하다. 이 용두암을 제대로 감상하려면 서쪽으로 100m 쯤 떨어진 곳이 적당하며, 바다가 잔잔한 날보다 파도가 심하게 몰아치는 날이 적격이다. 마치 천지개벽이 이루어지는 것 같기도 하고 신의 노여움 속에 용이 &#39;으르르&#39; 울부짖으며 바다 속에서 솟구쳐 오르는 듯 하기도 하다.</h3>

<p><img alt="" src=" http://localhost:8080/tourland/resources/images/jeju/tour3.jpg" style="height:643px; width:1000px" /></p>

<h2>용연계곡</h2>

<h3>용두암에서 200m정도 떨어져있는 곳으로, 바다와 민물이 만나는 곳이다.&nbsp;비를 몰고 오는 용이 살던 연못이라 하여 용연(龍淵)이라 이름 지어졌는데, 이곳에서 기우제를 지내면 신기하게도 비가 내렸다고 한다. 물빛이 아름답고 구름다리를 통해 가로지를 수 있다. 밤에는 아름다운 조명들로 야경이 아름답고, 한적한 산책로가 있어 시간을 보내기 좋다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour4.jpg" style="height:667px; width:1000px" /></p>

<p>&#39;</p>

<h2>우도</h2>

<h3><strong>우도</strong>(牛島)는&nbsp;<a href="https://ko.wikipedia.org/wiki/%EC%A0%9C%EC%A3%BC%EB%8F%84" style="text-decoration-line: none; color: rgb(11, 0, 128); background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: sans-serif; font-size: 14px;" title="제주도">제주도</a>의 동쪽 끝에 접하는&nbsp;<a href="https://ko.wikipedia.org/wiki/%EC%84%AC" style="text-decoration-line: none; color: rgb(11, 0, 128); background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: sans-serif; font-size: 14px;" title="섬">섬</a>으로,&nbsp;<a href="https://ko.wikipedia.org/wiki/%EC%A0%9C%EC%A3%BC%ED%8A%B9%EB%B3%84%EC%9E%90%EC%B9%98%EB%8F%84" style="text-decoration-line: none; color: rgb(11, 0, 128); background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: sans-serif; font-size: 14px;" title="제주특별자치도">제주특별자치도</a>에서&nbsp;<a href="https://ko.wikipedia.org/wiki/%EC%A0%9C%EC%A3%BC%EB%8F%84" style="text-decoration-line: none; color: rgb(11, 0, 128); background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: sans-serif; font-size: 14px;" title="제주도">제주도</a>&nbsp;다음으로 큰 섬이다. 우도란 이름은 섬의 모습이&nbsp;<a href="https://ko.wikipedia.org/wiki/%EC%86%8C" style="text-decoration-line: none; color: rgb(11, 0, 128); background-image: none; background-position: initial; background-size: initial; background-repeat: initial; background-attachment: initial; background-origin: initial; background-clip: initial; font-family: sans-serif; font-size: 14px;" title="소">소</a>가 누워 있는 것 같다고 해서 붙여졌다.</h3>

<p><img alt="" src="http://localhost:8080/tourland/resources/images/jeju/tour2.jpg" style="height:966px; width:1000px" /></p>
', '2020-03-29', 72540000, '/2020/05/14/bff374d8-dc56-4cd0-9e79-fba692e8b4b8_tour2.jpg', 0);

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

select p.pno,p.pname,p.pcontent,p.pexpire,p.pprice,p.ppic,p.pdiv,
	    a2.no as a2no,a2.ano,a2.dlocation,a2.rlocation,a2.ddate,a2.rdate,a2.ldiv,a2.capacity as a2capacity,a2.seat,a2.price as a2price,a2.pdiv, 
	    h2.no as h2no,h2.hname,h2.haddr,h2.checkin,h2.checkout,h2.capacity as h2capacity,h2.price as h2price,h2.roomcapacity,h2.roomtype,h2.ldiv,h2.bookedup,h2.pdiv,
	    t2.no as t2no,t2.tname,t2.tlocation,t2.startdate,t2.enddate,t2.taddr,t2.etime,t2.capacity as t2capacity,t2.tprice as t2tprice,t2.ldiv,t2.pdiv,
	    r2.no as r2no,r2.cdiv,r2.cno,r2.rentddate,r2.returndate,r2.rentaddr,r2.returnaddr,r2.price as r2price,r2.capacity as r2capacity,r2.insurance,r2.ldiv,r2.pdiv 
		from product p join pairstatus a on p.pno = a.pno join airplane a2 on a.ano = a2.no
							 	join photelstatus h on p.pno = h.pno join hotel h2 on h.hno = h2.no
							 	join ptourstatus t on p.pno = t.pno join tour t2 on t.tno = t2.no
							 	join prentstatus r on p.pno = r.pno join rentcar r2 on r.rno = r2.no;
							 
select * from product where substring(pname,2,3) = '제주' order by pno desc limit 0,10;	
select * from product where substring(pname,2,4) = '베이징' order by pno desc limit 0,10;
select * from product where substring(pname,2,3) = '도쿄' order by pno desc limit 0,10;
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

-- 하나 --------------------------------------------------------------------------------------------

SELECT * FROM notice;
select count(*) from airplane; 
select * from coupon;
select * from airplane;

