package com.yi.tourland.controller.user;

import java.io.FileInputStream;
import java.io.InputStream;
import java.net.CookieHandler;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.yi.tourland.domain.mng.BannerVO;
import com.yi.tourland.domain.mng.CouponVO;
import com.yi.tourland.domain.mng.CustBoardVO;
import com.yi.tourland.domain.mng.EmployeeVO;
import com.yi.tourland.domain.mng.EventVO;
import com.yi.tourland.domain.mng.FaqVO;
import com.yi.tourland.domain.mng.NoticeVO;
import com.yi.tourland.domain.mng.PlanBoardVO;
import com.yi.tourland.domain.mng.PopupVO;
import com.yi.tourland.domain.mng.ProductVO;
import com.yi.tourland.domain.mng.UserVO;
import com.yi.tourland.persistance.mng.daoimpl.EmailServiceImpl;
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
	EmailServiceImpl sendEmail;
	

		
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
	//ID, 비밀번호 찾기
	@RequestMapping(value="tourlandFindIdPw", method=RequestMethod.GET) 
	public String tourlandFindIdPw() throws Exception { 
		return "/user/tourlandFindIdPw"; 
	}
	@RequestMapping(value="tourlandFindIdPw", method=RequestMethod.POST) 
	public String tourlandFindIdPwPost() throws Exception {
		
		
		return "/user/tourlandLoginForm"; 
	}
	
	//마이페이지의 비밀번호 확인
	@RequestMapping(value="EditPassword", method=RequestMethod.GET) 
	public String tourlandEditPassword() throws Exception { 
		return "/user/mypage/tourlandMyInfoEditPassword"; 
	}
	
//	@RequestMapping(value="EditPassword", method=RequestMethod.POST) 
//	public String EditPasswordCheck(String checkPass, UserVO userVO, EmployeeVO empVO, Model model) throws Exception { 
//		
//		UserVO dbUserId = userService.readByIdUser(userVO.getUserid());
//
//		EmployeeVO dbEmpId = employeeService.readByIdEmployee(empVO.getEmpid());
//		
//		System.out.println(dbUserId);
//		System.out.println(dbUserId.getUserpass());
//		System.out.println(checkPass);
//		if(dbEmpId !=null) {
//			if(dbEmpId.getEmppass().equals(checkPass)==false) {
//				model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
//			}
//		}
//		if(dbUserId!=null) {
//			if(dbUserId.getUserpass().equals(checkPass)==false){
//				model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
//			}
//		}
//		return "redirect:/tourlandMyInfoEdit";
//	}
	
	//비밀번호 확인 되었을때 나타나는곳 현서때문에 이렇게 함
	@ResponseBody
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
	public String tourlandMyReserv() { 
		return "/user/mypage/tourlandMyReserv"; 
	}
	//상품 리뷰    
	@RequestMapping(value="tourlandMyReview", method=RequestMethod.GET)
	public String tourlandMyReview() throws SQLException {
		
		return "/user/mypage/tourlandMyReview"; 
	}
	//마이 페이지 - 장바구니
	@RequestMapping(value="tourlandMyWishes", method=RequestMethod.GET)
	public String tourlandMyWishes() { 
		return "/user/mypage/tourlandMyWishes"; 
	}
	//마이 페이지 - 내 쿠폰
	@RequestMapping(value="tourlandMyCoupon", method=RequestMethod.GET)
	public String tourlandMyCoupon(SearchCriteria cri, Model model, HttpSession session) throws Exception { 
	
		if(session.getAttribute("Auth")!=null) {
			//세션에 로그인 정보가 있으면 해당 고객 불러오기
			UserVO vo = (UserVO) session.getAttribute("Auth");
			//1번 쿠폰(가입 축하 쿠폰) 의 만료일을 고객의 가입한 날짜로부터 이
			Calendar cal = Calendar.getInstance();
			Date now = new Date();
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
			String to = transFormat.format(now);
			String year = to.substring(0, to.indexOf("-"));
			String month = to.substring(to.indexOf("-")+1, to.lastIndexOf("-"));
			String date = to.substring(to.lastIndexOf("-")+1);
			//캘린더에 날짜 세팅
			cal.set(Integer.parseInt(year), Integer.parseInt(month)-1,Integer.parseInt(date)-1);
		
			//더해줌 
			cal.add(Calendar.DATE, 7);
			String edate = transFormat.format(cal.getTime());
			CouponVO coupon = new CouponVO();
			coupon.setCno(1);
			coupon.setEdate(edate);
			
			couponService.editCouponNo1(coupon);
			List<CouponVO> list = couponService.userCouponList(vo);
			model.addAttribute("list", list);
		}
	
		return "/user/mypage/tourlandMyCoupon"; 
	}    
	//상품 리스트   (제주 패키지)
	@RequestMapping(value="tourlandProductKRList", method=RequestMethod.GET)
	public String tourlandProductKRList(Model model,SearchCriteria cri) throws SQLException {
		List<ProductVO> list = productService.productListPageByDomestic(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(productService.totalCountBySearchProductDomestic());
		model.addAttribute("list",list);
		model.addAttribute("pageMaker",pageMaker);
		model.addAttribute("cri",cri);
		model.addAttribute("count",productService.totalCountBySearchProductDomestic());
		return "/user/product/tourlandProductKRList"; 
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
			List<ProductVO> list = productService.tourlandProductKRSearchList(ddate, rdate,cnt);
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
			pageMaker.setTotalCount(productService.totalCountBySearchProductDomestic());
			//맵에 넣음 
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("pageMaker",pageMaker);
			map.put("cri",cri);
			map.put("count",productService.totalCountBySearchProductDomestic());
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
			pageMaker.setTotalCount(productService.totalCountBySearchProductDomestic());
			//맵에 넣음 
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("pageMaker",pageMaker);
			map.put("cri",cri);
			map.put("count",productService.totalCountBySearchProductDomestic());
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
		List<ProductVO> list = productService.productListPageByJapan(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(productService.totalCountBySearchProductJapan());
		model.addAttribute("list",list);
		model.addAttribute("pageMaker",pageMaker);
		model.addAttribute("cri",cri);
		model.addAttribute("count",productService.totalCountBySearchProductJapan());
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
			List<ProductVO> list = productService.tourlandProductJapanSearchList(ddate, rdate,cnt);
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
			pageMaker.setTotalCount(productService.totalCountBySearchProductJapan());
			//맵에 넣음 
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("pageMaker",pageMaker);
			map.put("cri",cri);
			map.put("count",productService.totalCountBySearchProductJapan());
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
			pageMaker.setTotalCount(productService.totalCountBySearchProductJapan());
			//맵에 넣음 
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("pageMaker",pageMaker);
			map.put("cri",cri);
			map.put("count",productService.totalCountBySearchProductDomestic());
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
			System.out.println(cri.getPage());
			List<ProductVO> list = productService.productListPageByChina(cri);
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(productService.totalCountBySearchProductChina());
			model.addAttribute("list",list);
			model.addAttribute("pageMaker",pageMaker);
			model.addAttribute("cri",cri);
			model.addAttribute("count",productService.totalCountBySearchProductChina());
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
				List<ProductVO> list = productService.tourlandProductChinaSearchList(ddate, rdate,cnt);
				System.out.println(list.size() + " : 리스트사이즈");
				System.out.println(list.get(0));
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
				pageMaker.setTotalCount(productService.totalCountBySearchProductChina());
				//맵에 넣음 
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("list", list);
				map.put("pageMaker",pageMaker);
				map.put("cri",cri);
				map.put("count",productService.totalCountBySearchProductChina());
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
				pageMaker.setTotalCount(productService.totalCountBySearchProductChina());
				//맵에 넣음 
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("list", list);
				map.put("pageMaker",pageMaker);
				map.put("cri",cri);
				map.put("count",productService.totalCountBySearchProductChina());
				entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}   
			return entity; 
	}			
	//상품 세부 정보    
	@RequestMapping(value="tourlandProductDetail", method=RequestMethod.GET)
	public String tourlandProductDetail(SearchCriteria cri,ProductVO vo,Model model) throws SQLException {
		vo = productService.productByNo(vo);
		model.addAttribute("cri",cri);
		model.addAttribute("vo",vo);
		return "/user/product/tourlandProductDetail"; 
	}
	//상품 리뷰    
	@RequestMapping(value="tourlandProductReview", method=RequestMethod.GET)
	public String tourlandProductReview(SearchCriteria cri,ProductVO vo,Model model) throws SQLException {
		
		  vo = productService.productByNo(vo); model.addAttribute("cri",cri);
		  model.addAttribute("vo",vo);
		 
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
	@RequestMapping(value = "tourlandCustBoardDetail", method = RequestMethod.GET)
	public String tourlandCustBoardDetail(int no, SearchCriteria cri, Model model) throws Exception {
		CustBoardVO vo = custBoardService.readByNoCustBoard(no);

		model.addAttribute("custBoardVO", vo);
		model.addAttribute("cri", cri);

		return "/user/board/tourlandCustBoardDetail";
	}
	
	
	//상품문의 사항
	@RequestMapping(value="tourlandProductBoard", method=RequestMethod.GET)
	public String tourlandProductBoard(SearchCriteria cri, Model model) throws Exception { 
		List<PlanBoardVO> list = planBoardService.listSearchCriteriaPlanBoard(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(planBoardService.totalSearchCountPlanBoard(cri) < 10 ? 10 : planBoardService.totalSearchCountPlanBoard(cri));
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
		return "/user/board/tourlandProductBoard"; 
	}
	
	@RequestMapping(value = "tourlandProductBoardDetail", method = RequestMethod.GET)
	public String tourlandProductBoardDetail(PlanBoardVO vo, SearchCriteria cri, Model model) throws Exception {
		vo = planBoardService.readByVoPlanBoard(vo);
		model.addAttribute("plan", vo);
		model.addAttribute("cri", cri);
		return "/user/board/tourlandProductBoardDetail";
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

}
