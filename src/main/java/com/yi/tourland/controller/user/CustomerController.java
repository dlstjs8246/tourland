package com.yi.tourland.controller.user;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.yi.tourland.domain.PageMaker;
import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.AirplaneVO;
import com.yi.tourland.domain.mng.BannerVO;
import com.yi.tourland.domain.mng.CouponVO;
import com.yi.tourland.domain.mng.CustBoardVO;
import com.yi.tourland.domain.mng.EmailVO;
import com.yi.tourland.domain.mng.EmployeeVO;
import com.yi.tourland.domain.mng.EventVO;
import com.yi.tourland.domain.mng.FaqVO;
import com.yi.tourland.domain.mng.HotelVO;
import com.yi.tourland.domain.mng.NoticeVO;
import com.yi.tourland.domain.mng.PlanBoardVO;
import com.yi.tourland.domain.mng.PopupVO;
import com.yi.tourland.domain.mng.ProductVO;
import com.yi.tourland.domain.mng.RentcarVO;
import com.yi.tourland.domain.mng.ReservationVO;
import com.yi.tourland.domain.mng.TourVO;
import com.yi.tourland.domain.mng.UserVO;
import com.yi.tourland.service.mng.BannerService;
import com.yi.tourland.service.mng.CouponService;
import com.yi.tourland.service.mng.CustBoardService;
import com.yi.tourland.service.mng.EmployeeService;
import com.yi.tourland.service.mng.EventService;
import com.yi.tourland.service.mng.FaqService;
import com.yi.tourland.service.mng.FlightService;
import com.yi.tourland.service.mng.HotelService;
import com.yi.tourland.service.mng.NoticeService;
import com.yi.tourland.service.mng.PlanBoardService;
import com.yi.tourland.service.mng.PopupService;
import com.yi.tourland.service.mng.ProductService;
import com.yi.tourland.service.mng.RentcarService;
import com.yi.tourland.service.mng.ReservationService;
import com.yi.tourland.service.mng.TourService;
import com.yi.tourland.service.mng.UserService;

@Controller
@RequestMapping("/customer/*")
public class CustomerController {
	
	@Resource(name = "uploadPathBanner") // 서블릿컨텍스트의 id값과 일치해야함 private String
	private String uploadPathBanner; // D:/workspace/workspace_spring/tourland/src/main/webapp/resources/images/banner
	 
	@Resource(name = "uploadPathPopup") 
	private String uploadPathPopup;
	 
	@Resource(name ="uploadPathEvent") 
	private String uploadPathEvent;
	 
	@Resource(name = "uploadPathProduct")
	private String uploadPathProduct; // c:/tourland/upload/product
	 
	@Autowired
	private TourService tourService;
	@Autowired
	private FaqService faqService;

	@Autowired
	NoticeService noticeService;

	@Autowired
	CustBoardService custBoardService;

	@Autowired
	CouponService couponService;

	@Autowired
	EmployeeService employeeService;

	@Autowired
	UserService userService;

	@Autowired
	HotelService hotelService;
	
	@Autowired
	EventService eventService;
	
	@Autowired
	PopupService popupService;

	@Autowired
	BannerService bannerService;

	@Autowired
	FlightService flightService;

	@Autowired
	RentcarService rentcarService;
	
	@Autowired
	private ProductService productService;

	@Autowired
	PlanBoardService planBoardService;
	
	@Autowired
	private EmailVO emailVo;
	
	@Autowired
	private ReservationService reservationService;
		
	// c드라이브에 있는 이미지에 대한 데이터를 직접 가져와야한다. ajax용으로 처리됨
		@ResponseBody
		@RequestMapping(value = "displayFile/{whichOne}", method = RequestMethod.GET)
		public ResponseEntity<byte[]> displayFile(String filename,@PathVariable("whichOne") String choice) {
			ResponseEntity<byte[]> entity = null;
	        String path = null;
	        
	        if(choice.equals("banner")) {
	        	path = uploadPathBanner;
	        }
	        
	        if(choice.equals("popup")) {
	        	path = uploadPathPopup; 
	        }
	        
	        if(choice.contentEquals("event")) {
	        	path = uploadPathEvent; 
	        }
	        if(choice.contentEquals("product") || choice.contentEquals("productSmall")) {
	        	path = uploadPathProduct;
	        }
	        
	        if(choice.equals("practice")) {
	        	path= "D:/workspace/workspace_spring/tourland/src/main/webapp/resources/images/practice";
	        }
			// System.out.println("displayFile-----------"+ filename);
			InputStream in = null;
			try {
				
		//		System.out.println("path=="+path);
				if(choice.contentEquals("productSmall")) {
					if(filename!="") filename = filename.substring(0, 12) + "s_" + filename.substring(12);
				}
				in = new FileInputStream(path + filename); // 파일개체는 오류처리하라고..
				String format = filename.substring(filename.lastIndexOf(".") + 1); // 파일 확장자 뽑아내기 점 빼고
				MediaType mType = null;

				if (format.equalsIgnoreCase("png")) {
					mType = MediaType.IMAGE_PNG;
				} else if (format.equalsIgnoreCase("jpg") || format.equalsIgnoreCase("jpeg")) {
					mType = MediaType.IMAGE_JPEG;
				} else if (format.equalsIgnoreCase("GIF")) {
					mType = MediaType.IMAGE_GIF;
				}
				HttpHeaders headers = new HttpHeaders();
				headers.setContentType(mType);

				entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);

				in.close();

			} catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
			}

			return entity;
		}

	//메인
	@RequestMapping(value="tourlandMain", method=RequestMethod.GET)
	public String tourlandMain(Model model, HttpServletResponse response, HttpServletRequest request) throws Exception {
	 //쿠키불러오기
		Cookie[] currentC = request.getCookies();
		if(currentC != null) {
		for(Cookie c : currentC) {
			 if(c.getName().contentEquals("currentProduct")) {
				 ProductVO currentP = new ProductVO();
				 currentP.setPno(Integer.parseInt(c.getValue()));
				 ProductVO dbcurrentP = productService.productByNo(currentP);
				 model.addAttribute("currentProduct",dbcurrentP);
			 }if(c.getName().contentEquals("currentProduct2")) {
				 ProductVO currentP = new ProductVO();
				 currentP.setPno(Integer.parseInt(c.getValue()));
				 ProductVO dbcurrentP = productService.productByNo(currentP);
				 model.addAttribute("currentProduct2",dbcurrentP);
			 }if(c.getName().contentEquals("currentProductPrice")) {
				 String currentProductPrice =  c.getValue();
				 model.addAttribute("currentProductPrice",currentProductPrice);
			 }if(c.getName().contentEquals("currentProductPrice2")) {
				 String currentProductPrice2 =  c.getValue();
				 model.addAttribute("currentProductPrice2",currentProductPrice2);
			 }
		   }
		}
		
	//팝업 불러오기
	    PopupVO popup1 = popupService.setPopup("L");
		if(popup1 != null) {
			long settingDays = (popup1.getEnddate().getTime()- popup1.getStartdate().getTime());
			long settingDays2 = Math.abs(settingDays/(24*60*60*1000));
			Cookie cookie = new Cookie("popup1", popup1.getPic());
			cookie.setPath("/");
			cookie.setMaxAge((int)(settingDays2*24*60*60));
			response.addCookie(cookie);
			
			model.addAttribute("popup1",popup1);
			
		}
		PopupVO popup2 = popupService.setPopup("R");
		if(popup2 != null) {
			long settingDays = (popup2.getEnddate().getTime()- popup2.getStartdate().getTime());
			long settingDays2 = Math.abs(settingDays/(24*60*60*1000));
			Cookie cookie = new Cookie("popup2", popup2.getPic());
			cookie.setPath("/");
			cookie.setMaxAge((int)(settingDays2*24*60*60));
			response.addCookie(cookie);
			
			model.addAttribute("popup2",popup2);
		}
		
	//배너 불러오기
		BannerVO banner1 = bannerService.setBanner("L");
		if(banner1 != null) {
			model.addAttribute("banner1",banner1);
		}
		BannerVO banner2 = bannerService.setBanner("R");
		if(banner2 != null) {
			model.addAttribute("banner2",banner2);
		}
		return "/user/tourlandMain"; 
	}
	
	//투어랜드 회원가입
	@RequestMapping(value="tourlandRegister", method=RequestMethod.GET)
	public String tourlandRegister(SearchCriteria cri, UserVO vo, Model model) { 
		int lastNo = 0;
		int lastNo2 = 0;
		try {
			List<UserVO> userList = userService.listSearchCriteriaUser(cri, 0);
			List<UserVO> secessuserList = userService.listSearchCriteriaUser(cri, 1);
			
			lastNo = userList.get(0).getUserno();
			lastNo2 = secessuserList.get(0).getUserno();
			if (lastNo > lastNo2) {
				model.addAttribute("autoNo", lastNo + 1);
			} else {
				model.addAttribute("autoNo", lastNo2 + 1);
			}

		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return "/user/tourlandRegisterForm"; 
	}

	//신규 회원 가입
	//ModelAndView 클래스 사용(회원 가입 후 CustomerController에서 LoginController 커맨드로 redirect 바로 이동할 수 없기 때문)
	@RequestMapping(value = "tourlandRegister", method = RequestMethod.POST)
	public ModelAndView tourlandRegisterPost(UserVO vo, RedirectAttributes rattr) throws Exception {
		try{
			userService.insertUser(vo);
			rattr.addFlashAttribute("registerSuccess","aa");
			
		}catch (Exception e) {
		
		}
		return new ModelAndView(new RedirectView("/loginForm",true)); //ModelAndView는 포워드로도 리다이렉트로도 보낼 수 있는거
	}
	
	// 아이디 존재유무 체크
		@ResponseBody
		@RequestMapping(value = "idCheck/{empid}", method = RequestMethod.GET)
		public ResponseEntity<String> checkEmpId(@PathVariable("empid") String empid) {

			ResponseEntity<String> entity = null;

			try {
				EmployeeVO voForIdCheck = employeeService.readByIdEmployee(empid);
				UserVO voForIdCheck2 = userService.readByIdUser(empid); // 유저 테이블에서 아이디로 검색
				if (voForIdCheck != null || voForIdCheck2 != null) {
					entity = new ResponseEntity<String>("exist", HttpStatus.OK);
				}
			} catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST); // 400에러
			}
			return entity;
		}
	//ID, 비밀번호 찾기 페이지
	@RequestMapping(value="tourlandFindIdPw", method=RequestMethod.GET) 
	public String tourlandFindIdPw() throws Exception { 
		return "/user/tourlandFindIdPw"; 
	}
	
	//입력데이터를 받아 아이디와 비밀번호 이메일로 전송할때 입력데이터에 만족하는 회원이 있는지 거르는 post문
	@RequestMapping(value="tourlandFindIdPw", method=RequestMethod.POST) 
	public String tourlandFindIdPwPost(UserVO userVo,String username,String userbirth, String usertel, String useremail,Model model,HttpSession session) throws Exception {		
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String sDate = sdf.format(now);
		
		userVo.setUsername(username);
		userVo.setUserbirth(userbirth);
		userVo.setUsertel(usertel);
		//위의 정보들을 입력받아 DB에 같은 정보의 회원이 있는지 검색
		UserVO dbUser = userService.readByNameBirthTel(username, userbirth, usertel);
		//입력된 정보의 회원이 없을때
		if(dbUser==null) {
			model.addAttribute("NotInfo", "입력된 정보를 다시 한번 확인해 주세요.");
			//입력을 잘못하는경우 입력값을 남겨두기 위해 이 코드 만듬  //useremail은 원래 있던 컬럼이 아님
			model.addAttribute("emailStay", useremail);
			model.addAttribute("inputStay", userVo);
			return "/user/tourlandFindIdPw"; 
		}
	
		//임시비밀번호 생성하기 
		Random rnd = new Random();
		StringBuffer buf = new StringBuffer();
		for(int i=0; i<8; i++) {
			if(rnd.nextBoolean()) { //true와 false를 랜덤하게 뽑음
				buf.append((char)((int)(rnd.nextInt(26))+97));
			}else { //true면 문자를 false면 숫자를 뽑는다
				buf.append((rnd.nextInt(10)));
			}
		}
		//생성된 임시비밀번호 넣어서 메일 보내기 첫번째부터 받는사람 메일주소, 받는사람의 이름 ,일시, db에있는 받는사람의 아이디, 임시비밀번호
		try {
			emailVo.sendMail(useremail, "[ "+username+" ] 님"+" 아이디와 비밀번호 안내 메일입니다.",
							"변경일시 : " + sDate +"\n"+
							"\n변경방법 : 아이디/패스워드 찾기를 통한 임시 비밀번호 발급" +"\n"+
							"\n아이디 : " +" [ "+ dbUser.getUserid()+" ] "+"\n"+
							"\n임시 비밀번호 : "+" [ "+ buf + " ] " +"\n"+
							"\n 임시 비밀번호로 로그인 후 비밀번호 변경 해 주시길 바랍니다.");
			
			//임시비밀번호로 수정
			dbUser.setUserpass(buf.toString());
			userService.updateUser(dbUser);
			model.addAttribute("success", "메일이 전송되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			return "FAIL";			
		}	
		return "/user/tourlandFindIdPw";
	}

	//마이페이지의 비밀번호 확인
	@RequestMapping(value="EditPassword", method=RequestMethod.GET) 
	public String tourlandEditPassword() throws Exception { 
		return "/user/mypage/tourlandMyInfoEditPassword"; 
	}

	//비밀번호 확인 되었을때 나타나는곳
	
	@RequestMapping(value = "EditPasswordCheck/{totalId}/{checkPass}", method = RequestMethod.GET)
	public ResponseEntity<String> EditPasswordCheck(@PathVariable("totalId") String totalId,@PathVariable("checkPass") String checkPass,Model model) {
		ResponseEntity<String> entity = null;

		try {
			UserVO dbUserId = userService.readByIdUser(totalId);
			EmployeeVO dbEmpId = employeeService.readByIdEmployee(totalId);
			EmployeeVO dbEmp = employeeService.readByIdPwEmployee(totalId,checkPass);
			UserVO dbUser = userService.readByIdPwUser(totalId,checkPass); // 유저 테이블에서 아이디로 검색
			if(dbEmpId!=null) {
				if(dbEmp==null) {
						entity = new ResponseEntity<String>("NoPass", HttpStatus.OK);
				}
			}
			if(dbUserId!=null) {
				if(dbUser==null) {
						entity = new ResponseEntity<String>("NoPass", HttpStatus.OK);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST); // 400에러
		}
		
		return entity;
	}
	
		
	//마이 페이지-내정보수정에서 보이는 개인정보
	@RequestMapping(value="tourlandMyInfoEdit", method=RequestMethod.GET) 
	public String tourlandMyInfoEdit() throws Exception { 
		return "/user/mypage/tourlandMyInfoEdit"; 
	}
	//마이 페이지 - 내정보수정에서 수정 후 수정버튼을 눌릴때 받을곳
	@RequestMapping(value="editProfile", method=RequestMethod.POST) 
	public String tourlandEditProfile(UserVO userVo, EmployeeVO empVo) throws Exception { 						
		if(userVo.getUserno()!=0) {
			userService.updateUser(userVo);
		}else if(empVo.getEmpno()!=0){
			employeeService.updateEmployee(empVo);
		}
		return "redirect:/"; 
	}
	
	//마이 페이지 - 탈퇴버튼 눌리는 경우
	@RequestMapping(value="logoutWithdrawal",method = RequestMethod.GET)
	public String logoutWithdrawal(String id,UserVO vo,HttpSession session) throws Exception{
		vo = userService.readByIdUser(id);
		vo.setUsersecess(1);
		userService.updateUser(vo);
		session.invalidate();
		return "redirect:/";
	}
	
	
	//마이 페이지 - 내 예약 현황
	@RequestMapping(value="tourlandMyReserv", method=RequestMethod.GET)
	public String tourlandMyReserv(HttpServletRequest req,SearchCriteria cri,UserVO vo,Model model,String payNow) throws SQLException {
		HttpSession session = req.getSession();
		vo = (UserVO)session.getValue("Auth");
		List<ReservationVO> list = reservationService.ReadReservationByUserNo(vo, cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(reservationService.totalSearchReservationCountByUserNo(cri, vo));
		model.addAttribute("list",list);
		model.addAttribute("pageMaker",pageMaker);
		if(payNow != null) {
			model.addAttribute("paySuccess", "paySuccess");
		}
		return "/user/mypage/tourlandMyReserv"; 
	}
	//마이 페이지 - 내 예약 현황 - 결제
	@RequestMapping(value="tourlandMyReservPayNow", method=RequestMethod.GET)
	public String tourlandMyReservPayNowSearch(String rno, Model model) throws SQLException {
		ReservationVO rs = new ReservationVO();
		rs.setNo(Integer.parseInt(rno));
		rs.setRstatus("2");
		reservationService.updateReservation(rs);
		model.addAttribute("payNow", "payNow");
		return "redirect:/customer/tourlandMyReserv"; 
	}
	
	
	//상품 리뷰    
	@RequestMapping(value="tourlandMyReview", method=RequestMethod.GET)
	public String tourlandMyReview() throws SQLException {
		
		return "/user/mypage/tourlandMyReview"; 
	}
	//마이 페이지 - 장바구니
	@RequestMapping(value="tourlandMyWishes", method=RequestMethod.GET)
	public String tourlandMyWishes(HttpServletRequest req,SearchCriteria cri,UserVO vo,Model model,ProductVO pvo,String suc) throws SQLException { 
		HttpSession session = req.getSession();
		vo = (UserVO)session.getValue("Auth");
		List<ReservationVO> list = reservationService.ReadCartByUserNo(vo, cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(reservationService.totalSearchCartCountByUserNo(cri, vo));
		model.addAttribute("list",list);
		model.addAttribute("pageMaker",pageMaker);
		if(suc != null) {
			model.addAttribute("success", "success");
		}
		return "/user/mypage/tourlandMyWishes"; 
	}
	//마이 페이지 - 장바구니에서 들어온 상품 삭제
	@RequestMapping(value="tourlandMyWishesDelete", method=RequestMethod.GET)
	public String tourlandMyWishesDelete(int pno,int rno,Model model,ProductVO pvo,ReservationVO rvo,SearchCriteria cri) throws Exception { 
		pvo.setPno(pno);
		pvo.setPdiv(true);
		rvo.setNo(rno);
		productService.deleteProductInUserCart(pvo,rvo,cri);
		model.addAttribute("suc", "suc");
		return "redirect:/customer/tourlandMyWishes"; 
	}
	
	//마이 페이지 - 장바구니 - 예약하기
	@RequestMapping(value="tourlandMyWishesRes", method=RequestMethod.GET)
	public String tourlandMyWishesRes(int rno,ReservationVO rvo) throws Exception {
		rvo.setNo(rno);
		rvo.setRstatus("1");
		reservationService.updateReservation(rvo);
		return "redirect:/customer/tourlandMyWishes";
	}
	
	//마이 페이지 - 장바구니 - 클릭으로 상세보기
	@RequestMapping(value="tourlandMyWishesDetail", method=RequestMethod.GET)
	public String tourlandMyWishesDetail(int userno,int rno,SearchCriteria cri,Model model) throws Exception {
		ReservationVO rvo = reservationService.ReadCartByNoAndUserNo(rno,userno);
		ProductVO upvo = rvo.getProduct();
		cri.setSearchType("userCart");
		cri.setKeyword(upvo.getPname());
		List<ProductVO> list = productService.listPage(cri);
		ProductVO pvo = null;
		Date uddate = upvo.getAir().get(0).getDdate();
		Date urdate = upvo.getAir().get(1).getRdate();
		if(list.size()>1) {
			for(ProductVO vo : list) {
				if(uddate.equals(vo.getAir().get(0).getDdate()) && urdate.equals(vo.getAir().get(1).getRdate())) {
					pvo = vo;
					break;
				}
			}
		}
		else {
			pvo = list.get(0);
		}
		model.addAttribute("uvo",upvo);
		model.addAttribute("vo",pvo);
		return "/user/mypage/tourlandCartDetail"; 
	}
	
	//마이 페이지 - 내 쿠폰
	@RequestMapping(value="tourlandMyCoupon", method=RequestMethod.GET)
	public String tourlandMyCoupon(SearchCriteria cri, Model model, HttpSession session) throws Exception { 
		//Auth 키가 있을 때 
		if(session.getAttribute("Auth")!=null) {
			if(session.getAttribute("Auth") instanceof UserVO) { //세션 객체가 UserVO 일 경우 = 회원 일 경우
				//세션에 로그인 정보가 있으면 해당 고객 불러오기
				UserVO vo = (UserVO) session.getAttribute("Auth");
				//해당 고객의 쿠폰 불러오기
				List<CouponVO> list = couponService.userCouponList(vo);
				
				//쿠폰이 있을 때
				if(list.size()!=0) {
					List<CouponVO> available = new ArrayList<>(); //아직 만료되지 않은 쿠폰
					List<CouponVO> expired= new ArrayList<>(); // 만료된 쿠폰
					
					//포맷 
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
					//오늘 날짜 생성
					Date date = new Date();
					//형식 변경
					String today = dateFormat.format(date);
					
					int result;
					for(int i=0; i<list.size(); i++) {
						//오늘 날짜와 해당 고객의 쿠폰의 만료일을 하나씩 비교 후 알맞은 리스트에 넣기 (만료되면 만료된 쿠폰리스트, 안됐으면 만료안된 리스트에)
						result = today.compareTo(dateFormat.format(list.get(i).getEdate()));
						
						if(result == 1 || result == 2 || result == 0) {//today > edate or today == edate
							expired.add(list.get(i));
							
						}else { //today < edate
							available.add(list.get(i));
						}
					}
					model.addAttribute("available", available);
					model.addAttribute("expired", expired);
					model.addAttribute("noListChk", 0);
				}else {//쿠폰이 없을 때 
					model.addAttribute("noListChk", 1);
				}
			}else {//관리자 일 경우 
				model.addAttribute("noListChk", 2);
			}
		}
		return "/user/mypage/tourlandMyCoupon"; 
	}    
	//상품 리스트   (제주 패키지)
	@RequestMapping(value="tourlandProductKRList", method=RequestMethod.GET)
	public String tourlandProductKRList(Model model,SearchCriteria cri) throws SQLException {
		int jejulistCount = productService.totalCountBySearchProductDomestic(cri);
		model.addAttribute("jejucount",jejulistCount);
		String keyword = cri.getKeyword();
		String keyword2 = cri.getKeyword2();
		String keyword3 = cri.getKeyword3();
		if(keyword3 !=null) {
			  if(keyword3.contentEquals("forsearchjeju")) {
					cri.setPerPageNum(10); //다시 리스트 10개로 세팅
					model.addAttribute("keyword",keyword);
					model.addAttribute("keyword3","jeju");
					if(keyword2 != null) {
						model.addAttribute("keyword2",keyword2);
					}
					List<ProductVO> list = productService.productListPageByDomestic(cri);
					model.addAttribute("list",list);
					PageMaker pageMaker = new PageMaker();
					pageMaker.setCri(cri);
					pageMaker.setTotalCount(jejulistCount);
					model.addAttribute("pageMaker", pageMaker);
					model.addAttribute("cri",cri);
					model.addAttribute("count",jejulistCount);
				    return "/user/product/tourlandProductKRList"; 
			   }
		}
		
		List<ProductVO> list = productService.productListPageByDomestic(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(productService.totalCountBySearchProductDomestic(cri));
		model.addAttribute("list",list);
		model.addAttribute("pageMaker",pageMaker);
		model.addAttribute("cri",cri);
		model.addAttribute("count",productService.totalCountBySearchProductDomestic(cri));
		return "/user/product/tourlandProductKRList"; 
	}
	//메인 검색 박스 - 상품 리스트
	@RequestMapping(value="tourlandProductMainSearchList", method=RequestMethod.GET)
	public String tourlandProductMainSearchList(Model model,SearchCriteria cri, String tourDays, String to, String capa, String date) throws SQLException {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		if(to.equals("제주")) {
				List<ProductVO> list = productService.productListPageByDomestic(cri);
				
				pageMaker.setTotalCount(productService.totalCountBySearchProductDomestic(cri));
				model.addAttribute("list",list);
				model.addAttribute("pageMaker",pageMaker);
				model.addAttribute("cri",cri);
				model.addAttribute("count",productService.totalCountBySearchProductDomestic(cri));
				model.addAttribute("date",date);
				model.addAttribute("tourDays",tourDays);
				model.addAttribute("capa",capa);
				
				return "/user/product/tourlandProductKRList"; 
		}else if(to.equals("일본")) {
				List<ProductVO> list = productService.productListPageByJapan(cri);
				pageMaker.setTotalCount(productService.totalCountBySearchProductJapan(cri));
				model.addAttribute("list",list);
				model.addAttribute("pageMaker",pageMaker);
				model.addAttribute("cri",cri);
				model.addAttribute("count",productService.totalCountBySearchProductJapan(cri));
				model.addAttribute("date",date);
				model.addAttribute("tourDays",tourDays);
				model.addAttribute("capa",capa);
				
				return "/user/product/tourlandProductJPList";
		}else { //중국
				List<ProductVO> list = productService.productListPageByChina(cri);
				
				pageMaker.setTotalCount(productService.totalCountBySearchProductChina(cri));
				model.addAttribute("list",list);
				model.addAttribute("pageMaker",pageMaker);
				model.addAttribute("cri",cri);
				model.addAttribute("count",productService.totalCountBySearchProductChina(cri));
				model.addAttribute("date",date);
				model.addAttribute("tourDays",tourDays);
				model.addAttribute("capa",capa);
				
				return "/user/product/tourlandProductChinaList"; 
		}

		
	}

	//상품 리스트 검색  ajax (제주 패키지) 
	@RequestMapping(value="tourlandProductKRSearchList", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> tourlandProductKRSearchList(String ddate, String tourDays, String cnt) throws SQLException {
		ResponseEntity<Map<String,Object>> entity = null;	
		try {
			//출발일자에 여행일 더해줌
			Calendar cal = Calendar.getInstance();
			String year = ddate.substring(0, ddate.indexOf("-"));
			String month = ddate.substring(ddate.indexOf("-")+1, ddate.lastIndexOf("-"));
			String date = ddate.substring(ddate.lastIndexOf("-")+1);
			//캘린더에 날짜 세팅
			cal.set(Integer.parseInt(year), Integer.parseInt(month)-1,Integer.parseInt(date)-1);
			//형식 변경
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			//출발일자에 여행일 더해줌 
			cal.add(Calendar.DATE, Integer.parseInt(tourDays.substring(0,tourDays.length()-1)));
			//더해준 날짜 string으로 변환 (실제로 돌아오는 날짜) 
			String rdate = sdf.format(cal.getTime());
			//해당 조건에 맞는 리스트 검색
			List<ProductVO> list = productService.tourlandProductKRSearchList(ddate, rdate,cnt ,tourDays.substring(0,tourDays.length()-1));
			
			//맵에 넣음 
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}catch(Exception e) {
		e.printStackTrace();
		entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
	}   
		return entity; 
}
	
	//상품 전체 리스트 검색  ajax (제주 패키지) 
	@RequestMapping(value="tourlandProductKRListAll/{page}", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> tourlandProductKRListAll(SearchCriteria cri, @PathVariable("page") int page) throws SQLException {
		ResponseEntity<Map<String,Object>> entity = null;	
		try {
			cri.setPage(page);
			//해당 조건에 맞는 리스트 검색
			List<ProductVO> list = productService.productListPageByDomestic(cri);
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(productService.totalCountBySearchProductDomestic(cri));
			//맵에 넣음 
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("pageMaker",pageMaker);
			map.put("cri",cri);
			map.put("count",productService.totalCountBySearchProductDomestic(cri));
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}catch(Exception e) {
		e.printStackTrace();
		entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
	}   
		return entity; 
}	
	
	//상품 전체 리스트 검색  ajax "낮은 가격 순" (제주 패키지) 
	@RequestMapping(value="tourlandProductKRSearchLowPirceList/{page}", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> tourlandProductKRSearchLowPirceList(SearchCriteria cri, @PathVariable("page") int page) throws SQLException {
		ResponseEntity<Map<String,Object>> entity = null;	
		try {
			cri.setPage(page);
			//해당 조건에 맞는 리스트 검색
			List<ProductVO> list = productService.tourlandProductKRSearchLowPriceList(cri);
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(productService.totalCountBySearchProductDomestic(cri));
			//맵에 넣음 
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("pageMaker",pageMaker);
			map.put("cri",cri);
			map.put("count",productService.totalCountBySearchProductDomestic(cri));
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}catch(Exception e) {
		e.printStackTrace();
		entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
	}   
		return entity; 
}	

	//상품 리스트   (일본 패키지)
	@RequestMapping(value="tourlandProductJPList", method=RequestMethod.GET)
	public String tourlandProductJPList(SearchCriteria cri,Model model) throws SQLException { 
		int japanlistCount = productService.totalCountBySearchProductJapan(cri);
		model.addAttribute("japancount",japanlistCount);

		String keyword = cri.getKeyword();
		String keyword2 = cri.getKeyword2();
		String keyword3 = cri.getKeyword3();
		if(keyword3 !=null) {
			  if(keyword3.contentEquals("forsearchjapan")) {
					cri.setPerPageNum(10); //다시 리스트 10개로 세팅
					model.addAttribute("keyword",keyword);
					model.addAttribute("keyword3","japan");
					if(keyword2 != null) {
						model.addAttribute("keyword2",keyword2);
					}
					List<ProductVO> list = productService.productListPageByJapan(cri);
					model.addAttribute("list",list);
					PageMaker pageMaker = new PageMaker();
					pageMaker.setCri(cri);
					pageMaker.setTotalCount(japanlistCount);
					model.addAttribute("pageMaker", pageMaker);
					model.addAttribute("cri",cri);
					model.addAttribute("count",japanlistCount);

				    return "/user/product/tourlandProductJPList"; 
			   }
		}
		
		
		List<ProductVO> list = productService.productListPageByJapan(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(productService.totalCountBySearchProductJapan(cri));
		model.addAttribute("list",list);
		model.addAttribute("pageMaker",pageMaker);
		model.addAttribute("cri",cri);
		model.addAttribute("count",productService.totalCountBySearchProductJapan(cri));
		return "/user/product/tourlandProductJPList"; 
	}
	
	//상품 리스트 검색  ajax (일본 패키지) 
	@RequestMapping(value="tourlandProductJapanSearchList", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> tourlandProductJapanSearchList(String ddate, String tourDays, String cnt) throws SQLException {
		ResponseEntity<Map<String,Object>> entity = null;	
		try {
			//출발일자에 여행일 더해줌
			Calendar cal = Calendar.getInstance();
			String year = ddate.substring(0, ddate.indexOf("-"));
			String month = ddate.substring(ddate.indexOf("-")+1, ddate.lastIndexOf("-"));
			String date = ddate.substring(ddate.lastIndexOf("-")+1);
			//캘린더에 날짜 세팅
			cal.set(Integer.parseInt(year), Integer.parseInt(month)-1,Integer.parseInt(date)-1);
			//형식 변경
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			//출발일자에 여행일 더해줌 
			cal.add(Calendar.DATE, Integer.parseInt(tourDays.substring(0,tourDays.length()-1)));
			//더해준 날짜 string으로 변환 (실제로 돌아오는 날짜) 
			String rdate = sdf.format(cal.getTime());
			
			//해당 조건에 맞는 리스트 검색
			List<ProductVO> list = productService.tourlandProductJapanSearchList(ddate, rdate,cnt , tourDays.substring(0,tourDays.length()-1));
			//맵에 넣음 
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}catch(Exception e) {
		e.printStackTrace();
		entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
	}   
		return entity; 
}
	
	
	//상품 전체 리스트 검색  ajax (일본 패키지) 
	@RequestMapping(value="tourlandProductJapanListAll/{page}", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> tourlandProductJapanListAll(SearchCriteria cri, @PathVariable("page") int page) throws SQLException {
		ResponseEntity<Map<String,Object>> entity = null;	
		try {
			cri.setPage(page);
			//해당 조건에 맞는 리스트 검색
			List<ProductVO> list = productService.productListPageByJapan(cri);
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(productService.totalCountBySearchProductJapan(cri));
			//맵에 넣음 
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("pageMaker",pageMaker);
			map.put("cri",cri);
			map.put("count",productService.totalCountBySearchProductJapan(cri));
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}catch(Exception e) {
		e.printStackTrace();
		entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
	}   
		return entity; 
}	
	
	//상품 전체 리스트 검색  ajax "낮은 가격 순" (일본 패키지) 
	@RequestMapping(value="tourlandProductJPSearchLowPirceList/{page}", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> tourlandProductJPSearchLowPirceList(SearchCriteria cri, @PathVariable("page") int page) throws SQLException {
		ResponseEntity<Map<String,Object>> entity = null;	
		try {
			cri.setPage(page);
			//해당 조건에 맞는 리스트 검색
			List<ProductVO> list = productService.tourlandProductJapanSearchLowPriceList(cri);
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(productService.totalCountBySearchProductJapan(cri));
			//맵에 넣음 
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("pageMaker",pageMaker);
			map.put("cri",cri);
			map.put("count",productService.totalCountBySearchProductDomestic(cri));
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}catch(Exception e) {
		e.printStackTrace();
		entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
	}   
		return entity; 
}	
	
	//상품 리스트   (중국 패키지)
		@RequestMapping(value="tourlandProductChinaList", method=RequestMethod.GET)
		public String tourlandProductChinaList(SearchCriteria cri,Model model) throws SQLException {
			int chinalistCount = productService.totalCountBySearchProductChina(cri);
			model.addAttribute("chinalistCount",chinalistCount);

			String keyword = cri.getKeyword();
			String keyword2 = cri.getKeyword2();
			String keyword3 = cri.getKeyword3();
			if(keyword3 !=null) {
				  if(keyword3.contentEquals("forsearchchina")) {
						cri.setPerPageNum(10); //다시 리스트 10개로 세팅
						model.addAttribute("keyword",keyword);
						model.addAttribute("keyword3","china");
						if(keyword2 != null) {
							model.addAttribute("keyword2",keyword2);
						}
						List<ProductVO> list = productService.productListPageByChina(cri);
						model.addAttribute("list",list);
						PageMaker pageMaker = new PageMaker();
						pageMaker.setCri(cri);
						pageMaker.setTotalCount(chinalistCount);
						model.addAttribute("pageMaker", pageMaker);
						model.addAttribute("cri",cri);
						model.addAttribute("count",chinalistCount);
					    return "/user/product/tourlandProductChinaList"; 
				   }
			}
			List<ProductVO> list = productService.productListPageByChina(cri);
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(productService.totalCountBySearchProductChina(cri));
			
			model.addAttribute("list",list);
			model.addAttribute("pageMaker",pageMaker);
			model.addAttribute("cri",cri);
			model.addAttribute("count",productService.totalCountBySearchProductChina(cri));
			return "/user/product/tourlandProductChinaList"; 
	}
	//상품 리스트 검색  ajax (중국 패키지) 
		@RequestMapping(value="tourlandProductChinaSearchList", method=RequestMethod.GET)
		public ResponseEntity<Map<String,Object>> tourlandProductChinaSearchList(String ddate, String tourDays, String cnt) throws SQLException {
			ResponseEntity<Map<String,Object>> entity = null;	
			try {
				//출발일자에 여행일 더해줌
				Calendar cal = Calendar.getInstance();
				String year = ddate.substring(0, ddate.indexOf("-"));
				String month = ddate.substring(ddate.indexOf("-")+1, ddate.lastIndexOf("-"));
				String date = ddate.substring(ddate.lastIndexOf("-")+1);
				//캘린더에 날짜 세팅
				cal.set(Integer.parseInt(year), Integer.parseInt(month)-1,Integer.parseInt(date)-1);
				//형식 변경
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				//출발일자에 여행일 더해줌 
				cal.add(Calendar.DATE, Integer.parseInt(tourDays.substring(0,tourDays.length()-1)));
				//더해준 날짜 string으로 변환 (실제로 돌아오는 날짜) 
				String rdate = sdf.format(cal.getTime());
				
				//해당 조건에 맞는 리스트 검색
				List<ProductVO> list = productService.tourlandProductChinaSearchList(ddate, rdate,cnt, tourDays.substring(0,tourDays.length()-1));
				//맵에 넣음 
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("list", list);
				entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}   
			return entity; 
	}

	//상품 전체 리스트 검색  ajax (중국 패키지) 
		@RequestMapping(value="tourlandProductChinaListAll/{page}", method=RequestMethod.GET)
		public ResponseEntity<Map<String,Object>> tourlandProductChinaListAll(SearchCriteria cri, @PathVariable("page") int page) throws SQLException {
			ResponseEntity<Map<String,Object>> entity = null;	
			try {
				cri.setPage(page);
				//해당 조건에 맞는 리스트 검색
				List<ProductVO> list = productService.productListPageByChina(cri);
				PageMaker pageMaker = new PageMaker();
				pageMaker.setCri(cri);
				pageMaker.setTotalCount(productService.totalCountBySearchProductChina(cri));
				//맵에 넣음 
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("list", list);
				map.put("pageMaker",pageMaker);
				map.put("cri",cri);
				map.put("count",productService.totalCountBySearchProductChina(cri));
				entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}   
			return entity; 
	}		
		
		//상품 전체 리스트 검색  ajax "낮은 가격 순" (중국 패키지) 
		@RequestMapping(value="tourlandProductChinaSearchLowPirceList/{page}", method=RequestMethod.GET)
		public ResponseEntity<Map<String,Object>> tourlandProductChinaSearchLowPirceList(SearchCriteria cri, @PathVariable("page") int page) throws SQLException {
			ResponseEntity<Map<String,Object>> entity = null;	
			try {
				cri.setPage(page);
				//해당 조건에 맞는 리스트 검색
				List<ProductVO> list = productService.tourlandProductChinaSearchLowPriceList(cri);
				PageMaker pageMaker = new PageMaker();
				pageMaker.setCri(cri);
				pageMaker.setTotalCount(productService.totalCountBySearchProductChina(cri));
				//맵에 넣음 
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("list", list);
				map.put("pageMaker",pageMaker);
				map.put("cri",cri);
				map.put("count",productService.totalCountBySearchProductChina(cri));
				entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}   
			return entity; 
	}			
	//상품 세부 정보    
	@RequestMapping(value="tourlandProductDetail", method=RequestMethod.GET)
	public String tourlandProductDetail(SearchCriteria cri,ProductVO vo,Model model,int price) throws SQLException {
		vo = productService.productByNo(vo);
		model.addAttribute("cri",cri);
		model.addAttribute("vo",vo);
		model.addAttribute("price",price);
		return "/user/product/tourlandProductDetail"; 
	}
	
	@ResponseBody
	@RequestMapping(value="tourlandProductDetail/reserv", method=RequestMethod.GET)
	public ResponseEntity<String> tourlandProductReservation(SearchCriteria cri, Model model, int uno, int pno, int price, int[] ano, int[] acapacity, int[] hno, int[] hcapacity, int[] tno, int tcapacity, int[] rno, int rcapacity) throws Exception {
		ResponseEntity<String> entity = null;
		List<AirplaneVO> air = new ArrayList<>();
		List<HotelVO> hotel = new ArrayList<>();
		List<TourVO> tour = new ArrayList<>();
		List<RentcarVO> rentcar = new ArrayList<>();
		for(int i : ano) {
			air.add(flightService.airplaneByNo(new AirplaneVO(i)));
			air.add(flightService.airplaneByNo(new AirplaneVO(i+1)));
		}
		if(hno!=null) for(int i : hno) hotel.add(hotelService.readHotel(new HotelVO(i)));
		if(tno!=null) for(int i : tno) tour.add(tourService.selectTourByNo(new TourVO(i)));
		if(rno!=null) for(int i : rno) rentcar.add(rentcarService.readByNo(i));
		for(int i=0;i<acapacity.length;i++) {
			air.get(i+i).setCapacity(acapacity[i]);
			air.get(i+i).setPdiv(1);
			air.get(i+i+1).setCapacity(acapacity[i]);
			air.get(i+i+1).setPdiv(1);
		}
		for(int i=0;i<hcapacity.length;i++) {
			hotel.get(i).setTotalcapacity(hcapacity[i]);
			hotel.get(i).setPdiv(true);
		}
		for(int i=0;i<tour.size();i++) {
			tour.get(i).setCapacity(tcapacity);
			tour.get(i).setPdiv(true);
		}
		for(int i=0;i<rentcar.size();i++) {
			rentcar.get(i).setCapacity(rcapacity);
			rentcar.get(i).setPdiv(1);
		}
		UserVO user = userService.readByNoUser(uno);
		ProductVO product = productService.productByNo(new ProductVO(pno));
		ProductVO userProduct = productService.productByNo(new ProductVO(pno));
		userProduct.setPprice(price);
		userProduct.setPdiv(true);
		userProduct.setAir(air);
		userProduct.setHotel(hotel);
		userProduct.setTour(tour);
		userProduct.setRentcar(rentcar);
		userProduct.setPno(productService.totalCountProduct()+1);
		try {
			Date chkStartDate = null;
			Date chkEndDate = null;
			Date startDate = null;
			Date endDate = null;
			List<ReservationVO> list = reservationService.ReadReservationByUserNo(user, cri);
			for(ReservationVO vo : list) {
				if(vo.getUserno().getUserno()==uno) {
					chkStartDate = vo.getProduct().getAir().get(0).getDdate();
					chkEndDate = vo.getProduct().getAir().get(1).getRdate();
					startDate = userProduct.getAir().get(0).getDdate();
					endDate = userProduct.getAir().get(1).getRdate();
					if(chkStartDate.equals(startDate) && chkEndDate.getTime() - chkStartDate.getTime() == endDate.getTime() - startDate.getTime()) {
						throw new Exception("중복");
					}
				}	
			}
			productService.insertUserProduct(product, userProduct, user, cri);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		}
		catch(Exception e) {
			if(e.getMessage().equals("중복")) {
				entity = new ResponseEntity<String>("OVERLAP",HttpStatus.BAD_REQUEST);
			}
			else {
				e.printStackTrace();
				entity = new ResponseEntity<String>("FAIL",HttpStatus.BAD_REQUEST);
			}
		}
		return entity;
	}
	
	//상품 장바구니에 담기 ajax
	@ResponseBody
	@RequestMapping(value="tourlandProductDetail/cart", method=RequestMethod.GET)
	public ResponseEntity<String> tourlandProductDoWith(SearchCriteria cri, Model model, int uno, int pno, int price, String[] ano,String[] rano, String[] acapacity, String[] hno, String[] hcapacity, String[] tno, String[] tcapacity, String[] rno, String[] rcapacity) throws Exception {
		//기본 로직
		
		//1.항공,호텔,투어,렌트카 테이블 insert 
		//(1)고객이 선택한 항공편, 호텔, 투어, 렌터카 번호 배열 가져옴
		//(2)해당 번호의 객체 찾기
		//(3)새로운 객체 만듦 > 새로운 객체에 DB에서 번호로 찾아온 객체 정보 세팅 (번호:total넘버+1..,인원:고객이 옵션에서 선택한 인원, pdiv:1) 
		//(4)테이블에 새로운 객체 insert
		//1~4번 (항공편, 호텔, 투어, 렌터카 테이블) 반복
		
		//2.상품 테이블 insert
		//(1)가져온 상품 번호로 상품 객체 DB에서 찾아옴
		//(2)새 상품 객체 만듦 > 새 상품 객체에 DB에서 찾아온 객체 정보 세팅 (가격 : 페이지에서 가져온 가격, pdiv : 1) 
		//(3)상품 테이블에 새로운 객체 insert
		
		//3.연결 테이블
		//3-1. 연결테이블1 (userpstatus)
		//(1)user번호, 방금 새로 insert 한 상품 객체 번호 insert
		//3-2. 연결테이블 2~5 (항공, 호텔, 투어, 렌트 연결 테이블)
		//(1) 각 테이블에 새로 insert 한 고객용 객체의 번호, 새로 insert 한 고객용 상품 번호 insert
		ResponseEntity<String> entity = null;
		List<AirplaneVO> airList = new ArrayList<>();
		List<HotelVO> hotelList = new ArrayList<>();
		List<TourVO> tourList = new ArrayList<>();
		List<RentcarVO> rentList = new ArrayList<>();
		
		
		//항공 출발편
		for(int i=0; i<ano.length; i++) {
			System.out.println("항공 출발편 번호 : " + ano[i]);
			
			AirplaneVO dair = new AirplaneVO();//출발편
			AirplaneVO rair = new AirplaneVO();//도착편
			
			dair.setNo(Integer.parseInt(ano[i]));
			rair.setNo(Integer.parseInt(rano[i]));
			
			AirplaneVO dbdAir = flightService.airplaneByNo(new AirplaneVO(dair.getNo()));
			AirplaneVO dbrAir = flightService.airplaneByNo(new AirplaneVO(rair.getNo()));
			System.out.println("출발편 : "+dbdAir);
			System.out.println("도착편 : "+dbrAir);
			airList.add(dbdAir);
			airList.add(dbrAir);
		}
		for(int i=0; i<acapacity.length; i++) {
			
			airList.get(i+i+1).setNo(flightService.totalAllCountAirplane()+(i+i+1));
			airList.get(i+i+1).setCapacity(Integer.parseInt(acapacity[i]));
			airList.get(i+i+1).setPdiv(1);
			//도착편
			airList.get(i+i).setNo(flightService.totalAllCountAirplane()+(i+i+1)+1);
			airList.get(i+i).setCapacity(Integer.parseInt(acapacity[i]));
			airList.get(i+i).setPdiv(1);
			
		}
		for(AirplaneVO air : airList) {
			System.out.println("변경된 항공편 : ");
			System.out.println(air);
			
		}
		for(int i=0; i<hno.length; i++) {
			System.out.println("호텔 번호 :"+hno[i]);
			
			HotelVO hotel = new HotelVO();//객체에 불러온 호텔 번호 세팅
			hotel.setNo(Integer.parseInt(hno[i]));
			HotelVO newHotel = hotelService.readHotel(new HotelVO(hotel.getNo()));
			System.out.println("호텔 : "+newHotel);
			hotelList.add(newHotel);
			
		}
		for(int i=0; i<hcapacity.length; i++) {
			System.out.println("호텔 인원 : "+hcapacity[i]);
			
			hotelList.get(i).setNo(hotelService.totalCountHotel()+i+1);
			hotelList.get(i).setCapacity(Integer.parseInt(hcapacity[i]));
			hotelList.get(i).setPdiv(true);
			
		}
		
		for(int i=0; i<tno.length; i++) {
			System.out.println("투어 번호 : "+tno[i]);
		
			TourVO tour = new TourVO();
			tour.setNo(Integer.parseInt(tno[i]));
			TourVO newTour = tourService.selectTourByNo(new TourVO(tour.getNo()));
			System.out.println("투어 : "+newTour);
			tourList.add(newTour);
		}
		for(int i=0; i<tcapacity.length; i++) {
			System.out.println("투어 인원 : "+tcapacity[i]);
			
			
		}  
		for(int i = 0; i<tourList.size(); i++) {
			System.out.println("변경 전 투어 : " + tourList.get(i));
		
			tourList.get(i).setNo(tourService.totalCount()+i+1);
			tourList.get(i).setCapacity(Integer.parseInt(tcapacity[0]));
			tourList.get(i).setPdiv(true);
			System.out.println("변경된 투어 : " + tourList.get(i));
		}
		if(rno!=null) {
			for(int i=0; i<rno.length; i++) {
				System.out.println("렌트카 번호 : "+rno[i]);
				RentcarVO rent = new RentcarVO();
				rent.setNo(Integer.parseInt(rno[i]));
				RentcarVO newRent = rentcarService.readByNo(rent.getNo());
				System.out.println("렌트카  : "+newRent);
				rentList.add(newRent);
			}
			for(int i=0; i<rcapacity.length; i++) {
				System.out.println("렌트카 인원 : "+rcapacity[i]);
				System.out.println("변경 전 렌트카 : " + rentList.get(i));
				rentList.get(i).setNo(rentcarService.totalCountRentcar() + i + 1);
				rentList.get(i).setCapacity(Integer.parseInt(rcapacity[i]));
				rentList.get(i).setPdiv(1);
				System.out.println("변경 후 렌트카 : " + rentList.get(i));
			}
		}
		
		// 가격
		System.out.println("가격 : " + price);
		//상품 
		System.out.println("상품번호 : " + pno);
		ProductVO p = new ProductVO();
		p.setPno(pno);
		ProductVO product = productService.productByNo(p);
		product.setPno(productService.totalCountProduct()+1);
		product.setPprice(price);
		product.setAir(airList);
		product.setHotel(hotelList);
		product.setTour(tourList);
		product.setRentcar(rentList);
		product.setPdiv(true);
		
		//INSERT
		//유저
		UserVO user = userService.readByNoUser(uno);
		System.out.println("유저번호 : " + uno );
		//상품
		System.out.println(product);
		for(AirplaneVO i : product.getAir()) {
			System.out.println(i);
		}
		for(HotelVO i : product.getHotel()) {
			System.out.println(i);
		}
		for(TourVO i : product.getTour()) {
			System.out.println(i);
		}
		for(RentcarVO i : product.getRentcar()) {
			System.out.println(i);
		}
		try {
			Date chkStartDate = null;
			Date chkEndDate = null;
			Date startDate = null;
			Date endDate = null;
			List<ReservationVO> list = reservationService.ReadCartByUserNo(user, cri);
			for(ReservationVO vo : list) {
				if(vo.getUserno().getUserno()==uno) {
					chkStartDate = vo.getProduct().getAir().get(0).getDdate();
					chkEndDate = vo.getProduct().getAir().get(1).getRdate();
					startDate = product.getAir().get(0).getDdate();
					endDate = product.getAir().get(1).getRdate();
					if(chkStartDate.equals(startDate) && chkEndDate.getTime() - chkStartDate.getTime() == endDate.getTime() - startDate.getTime()) {
						throw new Exception("중복");
					}
				}	
			}
			productService.insertProductInUserCart(product, user, cri);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		}
		
		catch(Exception e) {
			if(e.getMessage().equals("중복")) {
				entity = new ResponseEntity<String>("OVERLAP",HttpStatus.BAD_REQUEST);
			}
			else {
				e.printStackTrace();
				entity = new ResponseEntity<String>("FAIL",HttpStatus.BAD_REQUEST);
			}
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	//상품 리뷰    
	@RequestMapping(value="tourlandProductReview", method=RequestMethod.GET)
	public String tourlandProductReview(SearchCriteria cri,ProductVO vo,Model model,int price) throws SQLException {
		  vo = productService.productByNo(vo); 
		  model.addAttribute("cri",cri);
		  model.addAttribute("vo",vo);
		  model.addAttribute("price",price);
		return "/user/product/tourlandProductReview"; 
	}

	//이벤트 --------------------------------------------------------------------------------------
	@RequestMapping(value="tourlandEventList/{times}", method=RequestMethod.GET)
	public String tourlandEventList(@PathVariable("times") String times, Model model) { 
		String aaaaa= "";
				
		if(times.equals("ingEvent")) {
			List<EventVO> list = eventService.eventListDependsTime(times);
			model.addAttribute("eventList",list);
			aaaaa= "inging";
			model.addAttribute("mistyrose",aaaaa);
		}
		if(times.equals("commingEvent")) {
			List<EventVO> list = eventService.eventListDependsTime(times);
			model.addAttribute("eventList",list);
			aaaaa= "comecome";
			model.addAttribute("mistyrose",aaaaa);
		}
		if(times.equals("expiredEvent")) {
			List<EventVO> list = eventService.eventListDependsTime(times);
			model.addAttribute("eventList",list);
			aaaaa= "donedone";
			model.addAttribute("mistyrose",aaaaa);
		}
		
		
		return "/user/event/eventList"; 
	}
	
	//이벤트 상세 페이지
	 @RequestMapping(value = "eventDetailPage", method = RequestMethod.GET)
		public String eventDetailPage(int no, SearchCriteria cri, Model model) throws Exception {
		 EventVO vo = eventService.readByNoEvent(no);
			model.addAttribute("eventVO", vo);
			model.addAttribute("cri", cri);

			return "/user/event/eventDetailPage";
		}
	
	 
	 
	 //쿠폰 ---------------------------------------------------------------------------------------
	 @RequestMapping(value="userpageCoupon", method = RequestMethod.GET)
	 public String userpageCoupon() throws Exception {
		 
		 return "/user/coupon/tourlandCoupon";
	 }
	 
	
	//게시판 ---------------------------------------------------------------------------------------
	
	//공지사항
	@RequestMapping(value="tourlandBoardNotice", method=RequestMethod.GET)
	public String tourlandBoardNotice(SearchCriteria cri, Model model) throws Exception { 
		List<NoticeVO> noticeList = noticeService.noticeList(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(noticeService.totalCountNotice(cri));
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
		return "/user/board/tourlandBoardNotice"; 
	}
	
	// 공지사항 상세페이지
		@RequestMapping(value = "tourlandBoardNoticeDetail", method = RequestMethod.GET)
		public String tourlandBoardNoticeDetail(int no, SearchCriteria cri, Model model) throws Exception {
			NoticeVO notice = noticeService.readNoticeByNo(no);
			model.addAttribute("notice", notice);
			model.addAttribute("cri", cri);
			return "/user/board/tourlandBoardNoticeDetail";
		}
	
	//FAQ
	@RequestMapping(value="tourlandBoardFAQ", method=RequestMethod.GET)
	public String tourlandBoardFAQ(SearchCriteria cri, Model model) throws SQLException {
		cri.setPerPageNum(7);
		List<FaqVO> list = faqService.listPage(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(faqService.totalCount(cri) < 10 ? 10 : faqService.totalCount(cri));
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
		return "/user/board/tourlandBoardFAQ"; 
	}
	
	//고객의 소리
	@RequestMapping(value="tourlandCustBoard", method=RequestMethod.GET)
	public String tourlandCustBoard(SearchCriteria cri, Model model) throws Exception { 
		cri.setPerPageNum(5);
		List<CustBoardVO> custBoardList = custBoardService.listSearchCriteriaCustBoard(cri);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(custBoardService.totalSearchCountCustBoard(cri));

		model.addAttribute("cri", cri);
		model.addAttribute("list", custBoardList);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/user/board/tourlandCustBoard"; 
	}
	
	@RequestMapping(value = "tourlandBoardPassCheck/{where}", method = RequestMethod.GET)
	public String tourlandBoardDetailCheck(@PathVariable("where")String where, int no, SearchCriteria cri, Model model) throws Exception {
      if(where.contentEquals("custBoard")){
			CustBoardVO vo = custBoardService.readByNoCustBoard(no);
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(custBoardService.totalSearchCountCustBoard(cri));
			model.addAttribute("no",no);
			model.addAttribute("custBoardVO", vo);
			model.addAttribute("cri", cri);
			model.addAttribute("pageMaker", pageMaker);

		  }
	  if(where.contentEquals("planBoard")) {
		 List<PlanBoardVO> list = planBoardService.listSearchCriteriaPlanBoard(cri);
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(planBoardService.totalSearchCountPlanBoard(cri) < 10 ? 10 : planBoardService.totalSearchCountPlanBoard(cri));
			model.addAttribute("no",no);
			model.addAttribute("list", list);
			model.addAttribute("pageMaker", pageMaker);
			model.addAttribute("cri", cri); 
	      }
	 
	    model.addAttribute("where",where);
	 return "/user/board/tourlandBoardPassCheck";
	}
	
	@RequestMapping(value = "tourlandCustBoardDetail", method = RequestMethod.GET)
	public String tourlandCustBoardDetail(int no, SearchCriteria cri, Model model) throws Exception {
		
		CustBoardVO vo = custBoardService.readByNoCustBoard(no);
		model.addAttribute("custBoardVO", vo);
		model.addAttribute("cri", cri);

		return "/user/board/tourlandCustBoardDetail";
	}
	
	
	@RequestMapping(value = "tourlandCustBoardRegister", method = RequestMethod.GET)
	public String tourlandCustBoardRegister(SearchCriteria cri, Model model) {
		int lastNo = 0;
		try {
			List<CustBoardVO> custBoardList = custBoardService.listSearchCriteriaCustBoard(cri);
			lastNo = custBoardList.get(0).getNo() + 1;
		} catch (Exception e) {
			lastNo = 1;
		}

		model.addAttribute("autoNo", lastNo); // 가장 나중 번호로 자동세팅

		return "/user/board/tourlandCustBoardRegister";
	}
	@RequestMapping(value = "tourlandCustBoardRegister", method = RequestMethod.POST)
	public String tourlandCustBoardRegisterPost(CustBoardVO vo, Model model) throws Exception {
		custBoardService.insertCustBoard(vo);

		return "redirect:/customer/tourlandCustBoardDetail?no=" + vo.getNo();
	}
	
	
	//상품문의 사항 글쓰기
	@RequestMapping(value = "tourlandPlanBoardRegister", method = RequestMethod.GET)
	public String tourlandPlanBoardRegister() {
		return "/user/board/tourlandPlanBoardRegister";
	}
	
	@RequestMapping(value = "tourlandPlanBoardRegister", method = RequestMethod.POST)
	public String tourlandPlanBoardRegisterPost(PlanBoardVO vo) throws Exception {
		planBoardService.insertPlanBoard(vo);
		return "redirect:/customer/tourlandPlanBoard";
	}
	
	
	//상품문의사항 리스트
	@RequestMapping(value="tourlandPlanBoard", method=RequestMethod.GET)
	public String tourlandPlanBoard(SearchCriteria cri, Model model) throws Exception { 
		List<PlanBoardVO> list = planBoardService.listSearchCriteriaPlanBoard(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(planBoardService.totalSearchCountPlanBoard(cri) < 10 ? 10 : planBoardService.totalSearchCountPlanBoard(cri));
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
		return "/user/board/tourlandPlanBoard"; 
	}
	
	//상품문의사항 상세보기
	@RequestMapping(value = "tourlandPlanBoardDetail", method = RequestMethod.GET)
	public String tourlandPlanBoardDetail(int no,PlanBoardVO vo, SearchCriteria cri, Model model) throws Exception {
		vo = planBoardService.readByVoPlanBoard(vo);
		model.addAttribute("plan", vo);
		model.addAttribute("cri", cri);
		return "/user/board/tourlandPlanBoardDetail";
	}
	
	//Footer
	//찾아 오시는 길
	@RequestMapping(value="tourlandMap", method=RequestMethod.GET)
	public String tourlandMap() { 
		return "/user/footer/tourlandMap"; 
	}
	
	@RequestMapping(value="tourlandAgreement", method=RequestMethod.GET)
	public String tourlandAgreement() { 
		return "/user/footer/tourlandAgreement"; 
	}
	
	//회사소개
	@RequestMapping(value="tourlandIntroduce", method=RequestMethod.GET)
	public String tourlandIntroduce() { 
		return "/user/footer/tourlandIntroduce"; 
	}
	
	//제휴페이지
	@RequestMapping(value="tourlandAdvertising", method=RequestMethod.GET)
	public String tourlandAdvertising() { 
		return "/user/footer/tourlandAdvertising"; 
	}
	
	//검색
	@RequestMapping(value="tourlandSearch/{where}", method=RequestMethod.GET)
	public String tourlandSearch(@PathVariable("where")String where,SearchCriteria cri, Model model) throws Exception {
		int chinalistCount = productService.totalCountBySearchProductChina(cri);
		model.addAttribute("chinalistCount",chinalistCount);
		int japanlistCount = productService.totalCountBySearchProductJapan(cri);
		model.addAttribute("japancount",japanlistCount);
		int jejulistCount = productService.totalCountBySearchProductDomestic(cri);
		model.addAttribute("jejucount",jejulistCount);
		
        model.addAttribute("searchkeyword",cri.getKeyword());
		String keyword = cri.getKeyword();
		String keyword2 = cri.getKeyword2();
        if(keyword2 != null) {
        model.addAttribute("searchkeyword2",cri.getKeyword2());	
        }
		cri.setPerPageNum(3); //보기쉬우라고 일단3
		String keyword3 = cri.getKeyword3();
		
		if(keyword3 !=null) {
		  if(keyword3.contentEquals("forsearchchina")) {
				cri.setPerPageNum(10); //다시 리스트 10개로 세팅
	            model.addAttribute("keyword",keyword);
				if(keyword2 != null) {
				model.addAttribute("keyword2",keyword2);
   		    	}
                model.addAttribute("keyword3",keyword3);
		    	PageMaker pageMaker = new PageMaker();
				pageMaker.setCri(cri);
				pageMaker.setTotalCount(chinalistCount);
			       return "redirect:/customer/tourlandProductChinaList?searchType=";
		   }else if(keyword3.contentEquals("forsearchjapan")) {
				cri.setPerPageNum(10); //다시 리스트 10개로 세팅
				model.addAttribute("keyword",keyword);
				if(keyword2 != null) {
					model.addAttribute("keyword2",keyword2);
				}
				
				model.addAttribute("keyword3",keyword3);
			    PageMaker pageMaker = new PageMaker();
				pageMaker.setCri(cri);
				pageMaker.setTotalCount(japanlistCount);
				   return "redirect:/customer/tourlandProductJPList?searchType=";
			}else if(keyword3.contentEquals("forsearchjeju")) {
				cri.setPerPageNum(10); //다시 리스트 10개로 세팅
				model.addAttribute("keyword",keyword);
				if(keyword2 != null) {
					model.addAttribute("keyword2",keyword2);
				}
				model.addAttribute("keyword3",keyword3);
		    	PageMaker pageMaker = new PageMaker();
				pageMaker.setCri(cri);
				pageMaker.setTotalCount(jejulistCount);
				   return "redirect:/customer/tourlandProductKRList?searchType=";
			  }
		}
		
		//중국리스트
		if(where.equals("china") || where.equals("default")  ) {
			//System.out.println("중국");
		List<ProductVO> chinalist = productService.productListPageByChina(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(productService.totalCountBySearchProductChina(cri));
		model.addAttribute("list",chinalist);
		
		
		 model.addAttribute("chinapageMaker",pageMaker);
		 model.addAttribute("chinacri",cri);
		 model.addAttribute("chinacount",productService.totalCountBySearchProductChina(cri));
		 model.addAttribute("listCount",chinalist.size());
		
		}else if(where.equals("japan")) {
			//System.out.println("일본");
		//일본리스트
		List<ProductVO> japanlist = productService.productListPageByJapan(cri);
		PageMaker pageMaker2 = new PageMaker();
		pageMaker2.setCri(cri);
		pageMaker2.setTotalCount(productService.totalCountBySearchProductJapan(cri));
		
		model.addAttribute("list",japanlist);
		model.addAttribute("japanpageMaker",pageMaker2);
		model.addAttribute("japancri",cri);
		model.addAttribute("listCount",japanlist.size());
		
		}else if(where.equals("jeju")) {
			//System.out.println("제주");
        //한국리스트
		List<ProductVO> jejulist = productService.productListPageByDomestic(cri);
		PageMaker pageMaker3 = new PageMaker();
		pageMaker3.setCri(cri);
		pageMaker3.setTotalCount(productService.totalCountBySearchProductDomestic(cri));
		
		model.addAttribute("list",jejulist);
		model.addAttribute("jejupageMaker",pageMaker3);
		model.addAttribute("jejucri",cri);
		model.addAttribute("listCount",jejulist.size());
		}

		//FAQ리스트
		List<FaqVO> faqlist = faqService.listPage(cri);
		model.addAttribute("faqlist", faqlist);
		int faqlistCount = faqlist.size();
	    model.addAttribute("faqlistCount",faqlistCount);
	
	    //이벤트리스트
		List<EventVO> eventlist = eventService.listSearchCriteriaEvent(cri);
		model.addAttribute("eventList",eventlist);
		int eventlistCount = eventlist.size();
	    model.addAttribute("eventlistCount",eventlistCount);
		
		//총 숫자
		int totalCount = chinalistCount+japanlistCount+faqlistCount+eventlistCount+jejulistCount;
		model.addAttribute("totalSearchCount",totalCount);
	    //여행 상품에서 검색 된 숫자
		int totalProductCount = chinalistCount+japanlistCount+jejulistCount;
		model.addAttribute("totalProductCount",totalProductCount);
	
		return "/user/tourlandSearch"; 
	}

}
