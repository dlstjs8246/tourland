package com.yi.tourland.controller.mng;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.JsonObject;
import com.yi.tourland.domain.PageMaker;
import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.AirplaneVO;
import com.yi.tourland.domain.mng.BannerVO;
import com.yi.tourland.domain.mng.CouponVO;
import com.yi.tourland.domain.mng.CustBoardVO;
import com.yi.tourland.domain.mng.DataListVO;
import com.yi.tourland.domain.mng.EmployeeVO;
import com.yi.tourland.domain.mng.EventVO;
import com.yi.tourland.domain.mng.FaqVO;
import com.yi.tourland.domain.mng.HotelVO;
import com.yi.tourland.domain.mng.NoticeVO;
import com.yi.tourland.domain.mng.PlanBoardVO;
import com.yi.tourland.domain.mng.PopupVO;
import com.yi.tourland.domain.mng.ProductVO;
import com.yi.tourland.domain.mng.RentcarVO;
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
import com.yi.tourland.service.mng.TourService;
import com.yi.tourland.service.mng.UserService;
import com.yi.tourland.util.UploadFileUtils;
@Controller
@RequestMapping("/manager/*")
public class ManagerController {
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

	// 예약관리
	@RequestMapping(value = "reservMngList", method = RequestMethod.GET)
	public String reservMngList(SearchCriteria cri, Model model) {
		return "/manager/reservation/reservationMngList";
	}

	// 항공 관리
	@RequestMapping(value = "flightMngList", method = RequestMethod.GET)
	public String flightMngList(SearchCriteria cri, Model model) throws Exception {
		List<AirplaneVO> flightList = flightService.airplaneList(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(flightService.totalCountAirplane(cri));
		model.addAttribute("flightList", flightList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
		return "/manager/flight/flightMngList";
	}

	// 항공 추가 GET
	@RequestMapping(value = "addFlightForm", method = RequestMethod.GET)
	public String addFlightForm(Model model) throws Exception {
		SearchCriteria cri = new SearchCriteria();
		//항공기번호 세팅
		int dbNo = flightService.totalCountAirplane(cri);
		//출발편 번호
		int no = dbNo +1;
		//도착편 번호
		int nextNo = dbNo+2;
		model.addAttribute("airTotalCnt",no);
		model.addAttribute("airTotalNextCnt",nextNo);
		return "/manager/flight/addFlightForm2";
	}

	// 항공 추가 POST
	@RequestMapping(value = "addFlightForm", method = RequestMethod.POST)
	public String addFlightResult(DataListVO list) throws Exception {
		for(AirplaneVO a : list.getList()) {
			flightService.addAirplane(a);
		}
		
		return "redirect:/flightMngList";
	}
	
	// 항공 세부 페이지
	@RequestMapping(value = "flightDetail", method = RequestMethod.GET)
	public String flightDetail(int no, SearchCriteria cri, Model model) throws Exception {
			AirplaneVO selectedVo = new AirplaneVO();
			AirplaneVO prevVo = new AirplaneVO();
			AirplaneVO nextVo = new AirplaneVO();
			int prevNo = no-1;//이전번호
			int nextNo = no+1;//이후번호
			selectedVo.setNo(no);//선택한 항공편
			prevVo.setNo(prevNo);//이전번호 항공편
			nextVo.setNo(nextNo);//이후번호 항공편
			int noDiv = 0;
			
			//선택한 항공편
			AirplaneVO selectedAir = flightService.airplaneByNo(selectedVo);//선택한 항공편 모든정보
			//선택한 항공편 출발 시간
			Date selected_dDate = selectedAir.getDdate();
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String selected_dText = transFormat.format(selected_dDate);
			String selected_dtime = selected_dText.substring(selected_dText.lastIndexOf("-")+3);
			//선택한 항공편 도착 시간
			Date selected_rDate = selectedAir.getRdate();
			String selected_rText = transFormat.format(selected_rDate);
			String selected_rtime = selected_rText.substring(selected_rText.lastIndexOf("-")+3);
			
			model.addAttribute("selected_dtime", selected_dtime);
			model.addAttribute("selected_rtime", selected_rtime);
			model.addAttribute("cri", cri);
			
			//항공편 번호 == 짝수 -> 도착편 // 항공편 번호 == 홀수 -> 출발편
			if(no%2 == 0) {//항공편 번호가 짝수 -> 선택한 항공편 & 이전번호 항공편 들고옴
				AirplaneVO prevAir = flightService.airplaneByNo(prevVo);//이전번호 항공편 모든정보
				
				//이전번호 항공편 출발 시간
				Date prev_dDate = prevAir.getDdate();
				String prev_dText = transFormat.format(prev_dDate);
				String prev_dtime = prev_dText.substring(prev_dText.lastIndexOf("-")+3);
				//이전번호 항공편 도착 시간
				Date prev_rDate = prevAir.getRdate();
				String prev_rText = transFormat.format(prev_rDate);
				String prev_rtime = prev_rText.substring(prev_rText.lastIndexOf("-")+3);
				
				model.addAttribute("selectedAir", selectedAir);
				model.addAttribute("prevAir", prevAir);
				model.addAttribute("noDiv", noDiv);
				model.addAttribute("prev_dtime", prev_dtime);
				model.addAttribute("prev_rtime", prev_rtime);
			}else if(no%2 == 1) {//항공편 번호가 홀수  -> 선택한 항공편 & 이후번호 항공편 들고옴
				noDiv = 1;
				AirplaneVO nextAir = flightService.airplaneByNo(nextVo);//이후번호 항공편 모든정보
				
				//이후번호 항공편 출발 시간
				Date next_dDate = nextAir.getDdate();
				String next_dText = transFormat.format(next_dDate);
				String next_dtime = next_dText.substring(next_dText.lastIndexOf("-")+3);
				//이후번호 항공편 도착 시간
				Date next_rDate = nextAir.getRdate();
				String next_rText = transFormat.format(next_rDate);
				String next_rtime = next_rText.substring(next_rText.lastIndexOf("-")+3);
				
				model.addAttribute("selectedAir", selectedAir);
				model.addAttribute("nextAir", nextAir);
				model.addAttribute("noDiv", noDiv);
				model.addAttribute("next_dtime", next_dtime);
				model.addAttribute("next_rtime", next_rtime);
		} 
			
			return "/manager/flight/flightDetail";
	}
		
	//항공 삭제
	@RequestMapping(value = "removeFlight", method = RequestMethod.GET)
	public String removeFlight(int d_no, int r_no, SearchCriteria cri, Model model) throws Exception {
		
		flightService.removeAirplane(d_no);
		flightService.removeAirplane(r_no);
		model.addAttribute("cri", cri);
		return "redirect:/flightMngList";
	}
	
	// 항공 수정
		@RequestMapping(value = "editFlight", method = RequestMethod.GET)
		public String editFlight(int no_d, int no_r, SearchCriteria cri, Model model) throws Exception {
				AirplaneVO depVo = new AirplaneVO();//출발 항공편
				AirplaneVO appVo = new AirplaneVO();//도착 항공편
			
				depVo.setNo(no_d);//출발 항공편
				appVo.setNo(no_r);//도착 항공편
				
				//출발 항공편
				AirplaneVO depAir = flightService.airplaneByNo(depVo);//출발 항공편 모든정보
				//출발 항공편 출발 시간
				Date dep_dDate = depAir.getDdate();
				SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String dep_dText = transFormat.format(dep_dDate);
				String dep_dtime = dep_dText.substring(dep_dText.lastIndexOf("-")+3);
				//출발 항공편 도착 시간
				Date dep_rDate = depAir.getRdate();
				String dep_rText = transFormat.format(dep_rDate);
				String dep_rtime = dep_rText.substring(dep_rText.lastIndexOf("-")+3);
				
				
				
				AirplaneVO appAir = flightService.airplaneByNo(appVo);// 도착 항공편 모든정보
		
				// 도착 항공편 출발 시간
				Date app_dDate = appAir.getDdate();
				String app_dText = transFormat.format(app_dDate);
				String app_dtime = app_dText.substring(app_dText.lastIndexOf("-") + 3);
				// 도착 항공편 도착 시간
				Date app_rDate = appAir.getRdate();
				String app_rText = transFormat.format(app_rDate);
				String app_rtime = app_rText.substring(app_rText.lastIndexOf("-") + 3);
		
				model.addAttribute("depAir", depAir);//출발 항공편
				model.addAttribute("appAir", appAir);//도착 항공편
				model.addAttribute("dep_dtime", dep_dtime);//출발 항공편 출발 시간
				model.addAttribute("dep_rtime", dep_rtime);//출발 항공편 도착 시간
				model.addAttribute("app_dtime", app_dtime);//도착 항공편 출발 시간
				model.addAttribute("app_rtime", app_rtime);//도착 항공편 도착 시간
				model.addAttribute("cri", cri);//페이징
				
				return "/manager/flight/editFlight";
		}
	
	// 항공 수정 POST
	@RequestMapping(value = "editFlight", method = RequestMethod.POST)
	public String editFlight(DataListVO list, SearchCriteria cri, Model model) throws Exception {
		AirplaneVO depVo = new AirplaneVO();//출발 항공편
		AirplaneVO appVo = new AirplaneVO();//도착 항공편
		int noDiv = 0;
		depVo = list.getList().get(0);
		appVo = list.getList().get(1);
		
		flightService.editAirplane(depVo);
		flightService.editAirplane(appVo);
		
		//출발 항공편
		AirplaneVO depAir = flightService.airplaneByNo(depVo);//출발 항공편 모든정보
		//출발 항공편 출발 시간
		Date dep_dDate = depAir.getDdate();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dep_dText = transFormat.format(dep_dDate);
		String dep_dtime = dep_dText.substring(dep_dText.lastIndexOf("-")+3);
		//출발 항공편 도착 시간
		Date dep_rDate = depAir.getRdate();
		String dep_rText = transFormat.format(dep_rDate);
		String dep_rtime = dep_rText.substring(dep_rText.lastIndexOf("-")+3);
		
		AirplaneVO appAir = flightService.airplaneByNo(appVo);// 도착 항공편 모든정보

		// 도착 항공편 출발 시간
		Date app_dDate = appAir.getDdate();
		String app_dText = transFormat.format(app_dDate);
		String app_dtime = app_dText.substring(app_dText.lastIndexOf("-") + 3);
		// 도착 항공편 도착 시간
		Date app_rDate = appAir.getRdate();
		String app_rText = transFormat.format(app_rDate);
		String app_rtime = app_rText.substring(app_rText.lastIndexOf("-") + 3);
		
		//세부 페이지에서 선택한 항공편&선택한 항공편의 짝인 항공편 으로 나누고 해당 항공편들의 정보를 들고감
		//여기서는 edit페이지를 지나 다시 detail페이지로 들어갈때, 단순히 출발/도착항공편으로 나뉘기 때문에 다시 구분해서 detail페이지 value에 따라 다시 세팅해줌
		if(depVo.getNo()%2==1) {
			noDiv = 1;
			model.addAttribute("selectedAir", depAir);//출발 항공편
			model.addAttribute("nextAir", appAir);//도착 항공편
			model.addAttribute("selected_dtime", dep_dtime);//출발 항공편 출발 시간
			model.addAttribute("selected_rtime", dep_rtime);//출발 항공편 도착 시간
			model.addAttribute("next_dtime", app_dtime);//도착 항공편 출발 시간
			model.addAttribute("next_rtime", app_rtime);//도착 항공편 도착 시간
		}else {
			model.addAttribute("prevAir", depAir);//출발 항공편
			model.addAttribute("selectedAir", appAir);//도착 항공편
			model.addAttribute("prev_dtime", dep_dtime);//출발 항공편 출발 시간
			model.addAttribute("prev_rtime", dep_rtime);//출발 항공편 도착 시간
			model.addAttribute("selected_dtime", app_dtime);//도착 항공편 출발 시간
			model.addAttribute("selected_rtime", app_rtime);//도착 항공편 도착 시간
		}
		
		model.addAttribute("cri", cri);//페이징
		model.addAttribute("noDiv", noDiv);
		
		
		return "/manager/flight/flightDetail";
	}
	
	//항공 국내 검색 ajax
	@RequestMapping(value="flightDomList/{page}", method= RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> listPage(@PathVariable("page") int page){
		ResponseEntity<Map<String,Object>> entity = null;	
		try {
			SearchCriteria cri = new SearchCriteria();
			cri.setPage(page);
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			int totalCount = flightService.totalCountAirplane(cri);
			pageMaker.setTotalCount(totalCount);
			List<AirplaneVO> list = flightService.airplaneDomList(cri);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("pageMaker", pageMaker);
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}   
		return entity;
	}
	
	//항공 해외 검색 ajax
	@RequestMapping(value="flightAbroadList/{page}", method= RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> abroadlistPage(@PathVariable("page") int page){
		ResponseEntity<Map<String,Object>> entity = null;	
		try {
			SearchCriteria cri = new SearchCriteria();
			cri.setPage(page);
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			int totalCount = flightService.totalCountAirplane(cri);
			pageMaker.setTotalCount(totalCount);
			List<AirplaneVO> list = flightService.airplaneAbroadList(cri);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("pageMaker", pageMaker);
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}   
		return entity;
	}	
	

	// 직원관리리스트
	@RequestMapping(value = "empMngList/{empretired}", method = RequestMethod.GET)
	public String empMngList(SearchCriteria cri, Model model, @PathVariable("empretired") int empretired)
			throws Exception {

		List<EmployeeVO> empList = employeeService.listSearchCriteriaEmployee(cri, empretired);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(employeeService.totalSearchCountEmployee(cri, empretired));

		model.addAttribute("cri", cri);
		model.addAttribute("list", empList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("empretired", empretired);

		// 같은 페이지를 공유하기에 버튼이름 변경을 위한 model값 선언
		if (empretired == 1) {
			model.addAttribute("btnName", "근무사원 리스트");
		} else {
			model.addAttribute("btnName", "퇴사사원 조회");
		}

		return "/manager/employee/empMngList";
	}

	// 사원 추가
	@RequestMapping(value = "employeeRegister", method = RequestMethod.GET)
	public String employeeRegisterGet(SearchCriteria cri, Model model) {
		int lastNo = 0;
		int lastNo2 = 0;

		try {
			List<EmployeeVO> empList = employeeService.listSearchCriteriaEmployee(cri, 0);
			List<EmployeeVO> retiredEmpList = employeeService.listSearchCriteriaEmployee(cri, 1);

			lastNo = empList.get(0).getEmpno();
			lastNo2 = retiredEmpList.get(0).getEmpno();

			if (lastNo > lastNo2) {
				model.addAttribute("autoNo", lastNo + 1);
			} else {
				model.addAttribute("autoNo", lastNo2 + 1);
			}

		} catch (Exception e) {
			e.printStackTrace();
			// 퇴사 사원이 없는 경우 오류가 뜨기에 시범 데이터 입력
		}

		return "/manager/employee/empRegisterForm";
	}

	@RequestMapping(value = "employeeRegister", method = RequestMethod.POST)
	public String employeeRegisterPost(EmployeeVO vo) throws Exception {

		employeeService.insertEmployee(vo);
		return "redirect:empMngList/0";
	}

	// 아이디 존재유무 체크
	@ResponseBody
	@RequestMapping(value = "empIdCheck/{empid}", method = RequestMethod.GET)
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

	// 사원 리스트 클릭했을 때 자세한 정보 보기로 넘어가기
	@RequestMapping(value = "employeeDetail/{empretired}", method = RequestMethod.GET)
	public String employeeDetail(EmployeeVO vo, SearchCriteria cri, Model model,
			@PathVariable("empretired") int empretired) throws Exception {
		vo = employeeService.readByNoEmployee(vo.getEmpno());
		model.addAttribute("empVO", vo);
		// System.out.println(vo); //퇴사사원 null로 찍혀서 mapper수정
		model.addAttribute("cri", cri);
		model.addAttribute("empretired", empretired);
		return "/manager/employee/empDetailForm";
	}

	// 사원 디테일 페이지에서 수정 버튼 눌렀을 때 수정 처리
	@RequestMapping(value = "employeeUpdate/{empretired}", method = RequestMethod.POST)
	public String employeeUpdate(EmployeeVO vo, SearchCriteria cri, Model model,
			@PathVariable("empretired") int empretired) throws Exception {
		employeeService.updateEmployee(vo);
		// System.out.println(vo);
		model.addAttribute("empVO", vo);
		model.addAttribute("cri", cri);
		model.addAttribute("empretired", empretired);
		return "redirect:/employeeDetail/" + empretired + "?empno=" + vo.getEmpno() + "&page=" + cri.getPage()
				+ "&searchType=" + cri.getSearchType() + "&keyword=" + cri.getKeyword();
	}

	// 사원 논리 삭제(퇴사처리) 및 완전 삭제(정보삭제)
	@RequestMapping(value = "employeeDelete/{empretired}/{empno}", method = RequestMethod.GET)
	public String employeeDelete(SearchCriteria cri, Model model, @PathVariable("empretired") int empretired,
			@PathVariable("empno") int empno) throws Exception {
		EmployeeVO vo = employeeService.readByNoEmployee(empno);
		// System.out.println(vo);
		if (empretired == 0) { // 근무사원이라면
			vo.setEmpretired(1); // 퇴사 사원 처리
			employeeService.updateEmployee(vo);
		} else {
			employeeService.deleteEmployee(vo.getEmpno()); // 완전 삭제
		}

		return "redirect:/empMngList/" + empretired + "?page=" + cri.getPage() + "&searchType=" + cri.getSearchType()
				+ "&keyword=" + cri.getKeyword();
	}

	// 고객관리리스트
	@RequestMapping(value = "userMngList/{usersecess}", method = RequestMethod.GET)
	public String custMngList(SearchCriteria cri, Model model, @PathVariable("usersecess") int usersecess)
			throws Exception {
		List<UserVO> userList = userService.listSearchCriteriaUser(cri, usersecess);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(userService.totalSearchCountUser(cri, usersecess));

		model.addAttribute("cri", cri);
		model.addAttribute("list", userList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("usersecess", usersecess);

		// 같은 페이지를 공유하기에 버튼이름 변경을 위한 model값 선언
		if (usersecess == 1) { // 탈퇴회원일 경우
			model.addAttribute("btnName", "회원 리스트");
		} else {
			model.addAttribute("btnName", "탈퇴회원 조회");
		}

		return "/manager/user/userMngList";
	}

	@RequestMapping(value = "userRegister", method = RequestMethod.GET)
	public String userRegister(SearchCriteria cri, UserVO vo, Model model) throws Exception {
		int lastNo = 0;
		int lastNo2 = 0;
		try {
			List<UserVO> userList = userService.listSearchCriteriaUser(cri, 0);
			List<UserVO> secessuserList = userService.listSearchCriteriaUser(cri, 1);

			lastNo = userList.get(0).getUserno();
			lastNo2 = secessuserList.get(0).getUserno();

//			System.out.println(lastNo);
//			System.out.println(lastNo2);
			if (lastNo > lastNo2) {
				model.addAttribute("autoNo", lastNo + 1);
			} else {
				model.addAttribute("autoNo", lastNo2 + 1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/manager/user/userRegister";
	}


	// 고객 리스트 클릭했을 때 자세한 정보 보기로 넘어가기
	@RequestMapping(value = "userDetailForm/{usersecess}", method = RequestMethod.GET)
	public String userDetailForm(int no, SearchCriteria cri, Model model, @PathVariable("usersecess") int usersecess) throws Exception {
		UserVO vo = userService.readByNoUser(no);
		System.out.println(vo);
		model.addAttribute("userVO", vo);
		model.addAttribute("cri", cri);
		model.addAttribute("usersecess", usersecess);
		return "/manager/user/userDetailForm";
	}

	@RequestMapping(value = "userRegister", method = RequestMethod.POST)
	public String userRegisterPost(UserVO vo) throws Exception {
        System.out.println(vo);
		userService.insertUser(vo);
		return "redirect:userMngList/0";
	}

	// 예약관리
	@RequestMapping(value = "reservationMgnList", method = RequestMethod.GET)
	public String reservationMgnList() {
		return "/manager/reservation/reservationMngList";
	}

	// 상품관리
	@RequestMapping(value = "addProductForm", method = RequestMethod.GET)
	public String addProductFormGet(SearchCriteria cri,Model model) throws Exception {
		List<AirplaneVO> flightListDepature = flightService.airplaneListByDepature(cri);
		List<HotelVO> hotelList = hotelService.listSearchHotel(cri);
		List<TourVO> tourList = tourService.listPage(cri);
		List<RentcarVO> rentcarList = rentcarService.listSearchCriteriaRentcar(cri);
		PageMaker pageMakerByFlightDepature = new PageMaker();
		pageMakerByFlightDepature.setCri(cri);
		pageMakerByFlightDepature.setTotalCount(flightService.totalCountAirplaneByDepature(cri));
		PageMaker pageMakerByHotel = new PageMaker();
		pageMakerByHotel.setCri(cri);
		pageMakerByHotel.setTotalCount(hotelService.totalSearchCountHotel(cri));
		PageMaker pageMakerByTour = new PageMaker();
		pageMakerByTour.setCri(cri);
		pageMakerByTour.setTotalCount(tourService.totalCountBySearchCriteria(cri));
		PageMaker pageMakerByRentcar = new PageMaker();
		pageMakerByRentcar.setCri(cri);
		pageMakerByRentcar.setTotalCount(rentcarService.totalSearchCountRentcar(cri));
		model.addAttribute("flightListDepature",flightListDepature);
		model.addAttribute("pageMakerByFlightDepature",pageMakerByFlightDepature);
		model.addAttribute("hotelList",hotelList);
		model.addAttribute("pageMakerByHotel",pageMakerByHotel);
		model.addAttribute("tourList",tourList);
		model.addAttribute("pageMakerByTour",pageMakerByTour);
		model.addAttribute("rentcarList",rentcarList);
		model.addAttribute("pageMakerByRentcar",pageMakerByRentcar);
		model.addAttribute("size",productService.totalCountProduct()+1);
		return "/manager/product/addProductForm";
	}

	@RequestMapping(value = "addProductForm", method = RequestMethod.POST)
	public String addProductFormPost(int[] airNo, int[] hotelNo, int[] tourNo, int[] rentcarNo, ProductVO vo, MultipartFile file) throws SQLException, IOException {
		List<AirplaneVO> air = new ArrayList<>();
		List<HotelVO> hotel = new ArrayList<>();
		List<TourVO> tour = new ArrayList<>();
		List<RentcarVO> rentcar = new ArrayList<>();
		for(int no : airNo) {
			AirplaneVO avo = new AirplaneVO(no);
			air.add(avo);
		}
		for(int no : hotelNo) {
			HotelVO hvo = new HotelVO(no);
			hotel.add(hvo);
		}
		for(int no : tourNo) {
			TourVO hvo = new TourVO(no);
			tour.add(hvo);
		}
		for(int no : rentcarNo) {
			RentcarVO rvo = new RentcarVO(no);
			rentcar.add(rvo);
		}
		vo.setAir(air);
		vo.setHotel(hotel);
		vo.setTour(tour);
		vo.setRentcar(rentcar);
		File filePath = new File("uploadPathProduct");
		if(!filePath.exists()) filePath.mkdir();
		String savedName = UploadFileUtils.uploadFile(uploadPathProduct, file.getOriginalFilename().replaceAll(" ", "_"),
				file.getBytes());
		String bigSizePic = savedName.substring(0, 12) + savedName.substring(14);
		vo.setPic(bigSizePic.replaceAll(" ", "_"));
		productService.insertProduct(vo);
		return "redirect:productMngList";
	}
	
	@RequestMapping(value = "productMngList", method = RequestMethod.GET)
	public String productMngList(SearchCriteria cri,Model model) throws SQLException {
		List<ProductVO> list = productService.listPage(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(productService.totalCountBySearchProduct(cri));
		model.addAttribute("list",list);
		model.addAttribute("pageMaker",pageMaker);
		model.addAttribute("cri",cri);
		return "manager/product/productMngList";
	}
	@RequestMapping(value = "productDetail", method = RequestMethod.GET)
	public String productDetail(int no,ProductVO vo,SearchCriteria cri,Model model) throws SQLException {
		vo.setPno(no);
		vo = productService.productByNo(vo);
		model.addAttribute("vo",vo);
		model.addAttribute("cri",cri);
		return "manager/product/productDetail";
	}
	@RequestMapping(value = "productModify", method = RequestMethod.GET)
	public String productModiftyGet(int no,ProductVO vo,SearchCriteria cri,Model model) throws Exception {
		vo.setPno(no);
		vo = productService.productByNo(vo);
		List<AirplaneVO> flightListDepature = flightService.airplaneListByDepature(cri);
		List<HotelVO> hotelList = hotelService.listSearchHotel(cri);
		List<TourVO> tourList = tourService.listPage(cri);
		List<RentcarVO> rentcarList = rentcarService.listSearchCriteriaRentcar(cri);
		PageMaker pageMakerByFlightDepature = new PageMaker();
		pageMakerByFlightDepature.setCri(cri);
		pageMakerByFlightDepature.setTotalCount(flightService.totalCountAirplaneByDepature(cri));
		PageMaker pageMakerByHotel = new PageMaker();
		pageMakerByHotel.setCri(cri);
		pageMakerByHotel.setTotalCount(hotelService.totalSearchCountHotel(cri));
		PageMaker pageMakerByTour = new PageMaker();
		pageMakerByTour.setCri(cri);
		pageMakerByTour.setTotalCount(tourService.totalCountBySearchCriteria(cri));
		PageMaker pageMakerByRentcar = new PageMaker();
		pageMakerByRentcar.setCri(cri);
		pageMakerByRentcar.setTotalCount(rentcarService.totalSearchCountRentcar(cri));
		model.addAttribute("flightListDepature",flightListDepature);
		model.addAttribute("pageMakerByFlightDepature",pageMakerByFlightDepature);
		model.addAttribute("hotelList",hotelList);
		model.addAttribute("pageMakerByHotel",pageMakerByHotel);
		model.addAttribute("tourList",tourList);
		model.addAttribute("pageMakerByTour",pageMakerByTour);
		model.addAttribute("rentcarList",rentcarList);
		model.addAttribute("pageMakerByRentcar",pageMakerByRentcar);
		model.addAttribute("vo",vo);
		model.addAttribute("cri",cri);
		return "manager/product/productModify";
	}
	@RequestMapping(value = "productModify", method = RequestMethod.POST)
	public String productModifyPost(int[] airNo, int[] hotelNo, int[] tourNo, int[] rentcarNo, ProductVO vo, MultipartFile file, SearchCriteria cri,String originalPic,Model model) throws Exception {
		int pno = vo.getPno();
		ProductVO delProd = new ProductVO(pno);
		productService.deleteProduct(delProd);
		System.out.println(file.getSize());
		System.out.println(vo.getPic());
		if (file.getSize()>0 && vo.getPic()!=null) {
			File pBig = new File(uploadPathProduct + vo.getPic());
			if(pBig.exists()) pBig.delete();
			String updatePath = vo.getPic().substring(0, 12) + "s_" + vo.getPic().substring(12);
			File pSmall = new File(uploadPathProduct + updatePath);
			if(pSmall.exists()) pSmall.delete();
		}
		List<AirplaneVO> air = new ArrayList<>();
		List<HotelVO> hotel = new ArrayList<>();
		List<TourVO> tour = new ArrayList<>();
		List<RentcarVO> rentcar = new ArrayList<>();
		for(int no : airNo) {
			AirplaneVO avo = new AirplaneVO(no);
			air.add(avo);
		}
		for(int no : hotelNo) {
			HotelVO hvo = new HotelVO(no);
			hotel.add(hvo);
		}
		for(int no : tourNo) {
			TourVO hvo = new TourVO(no);
			tour.add(hvo);
		}
		for(int no : rentcarNo) {
			RentcarVO rvo = new RentcarVO(no);
			rentcar.add(rvo);
		}
		vo.setAir(air);
		vo.setHotel(hotel);
		vo.setTour(tour);
		vo.setRentcar(rentcar);
		if(file.getSize()>0 && vo.getPic()==null) {
			File filePath = new File("uploadPathProduct");
			if(!filePath.exists()) filePath.mkdir();
			String savedName = UploadFileUtils.uploadFile(uploadPathProduct, file.getOriginalFilename().replaceAll(" ", "_"),
					file.getBytes());
			String bigSizePic = savedName.substring(0, 12) + savedName.substring(14);
			vo.setPic(bigSizePic.replaceAll(" ", "_"));
		}
		else {
			vo.setPic(originalPic);
		}
		productService.insertProduct(vo);
		return "redirect:productDetail?no="+vo.getPno()+"&page="+cri.getPage()+"&searchType="+cri.getSearchType()+"&keyword="+cri.getKeyword();
	}
	@RequestMapping(value = "productDelete", method = RequestMethod.GET)
	public String productDelete(int no,ProductVO vo,SearchCriteria cri,Model model) throws SQLException {
		vo.setPno(no);
		vo = productService.productByNo(vo);
		if (vo.getPic() != null) {
			File pBig = new File(uploadPathProduct + vo.getPic());
			pBig.delete();
			String updatePath = vo.getPic().substring(0, 12) + "s_" + vo.getPic().substring(12);
			File pSmall = new File(uploadPathProduct + updatePath);
			pSmall.delete();
		}
		productService.deleteProduct(vo);
		model.addAttribute("cri",cri);
		return "redirect:productMngList";
	}

	@ResponseBody
	@RequestMapping(value = "flightList", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> flightList(String div, AirplaneVO vo, SearchCriteria cri, Model model) {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<>();
		if (div.equals("Depature")) {
			try {
				List<AirplaneVO> flightList = flightService.airplaneListByDepature(cri);
				PageMaker pageMaker = new PageMaker();
				pageMaker.setCri(cri);
				pageMaker.setTotalCount(flightService.totalCountAirplaneByDepature(cri));
				map.put("list", flightList);
				map.put("pageMaker", pageMaker);
				entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
			}
		} else if (div.equals("Rending")) {
			try {
				vo = new AirplaneVO(cri.getPage());
				List<AirplaneVO> flightList = flightService.airplaneListByRending(vo);
				map.put("list", flightList);
				entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
			}
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping(value = "flightList/{no}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> flightList(@PathVariable("no") int no, AirplaneVO vo, Model model) {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<>();
		try {
			vo.setNo(no);
			vo = flightService.airplaneByNo(vo);
			map.put("vo", vo);
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "hotelList", method = RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> hotelList(SearchCriteria cri, Model model) {
		ResponseEntity<Map<String,Object>> entity = null;
		Map<String,Object> map = new HashMap<>();
		try {
			List<HotelVO> hotelList = hotelService.listSearchHotel(cri);
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(hotelService.totalSearchCountHotel(cri));
			map.put("list", hotelList);
			map.put("pageMaker", pageMaker);
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}
		catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "hotelList/{no}", method = RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> hotelList(@PathVariable("no") int no,HotelVO vo, Model model) {
		ResponseEntity<Map<String,Object>> entity = null;
		Map<String,Object> map = new HashMap<>();
		try {
			vo.setNo(no);
			vo = hotelService.readHotel(vo);
			map.put("vo", vo);
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}
		catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "tourList", method = RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> tourList(SearchCriteria cri, Model model) {
		ResponseEntity<Map<String,Object>> entity = null;
		Map<String,Object> map = new HashMap<>();
		try {
			List<TourVO> tourList = tourService.listPage(cri);
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(tourService.totalCountBySearchCriteria(cri));
			map.put("list", tourList);
			map.put("pageMaker", pageMaker);
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}
		catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "tourList/{no}", method = RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> tourList(@PathVariable("no") int no,TourVO vo, Model model) {
		ResponseEntity<Map<String,Object>> entity = null;
		Map<String,Object> map = new HashMap<>();
		try {
			vo.setNo(no);
			vo = tourService.selectTourByNo(vo);
			map.put("vo", vo);
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}
		catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "rentList", method = RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> rentList(SearchCriteria cri, Model model) {
		ResponseEntity<Map<String,Object>> entity = null;
		Map<String,Object> map = new HashMap<>();
		try {
			List<RentcarVO> rentList = rentcarService.listSearchCriteriaRentcar(cri);
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(rentcarService.totalSearchCountRentcar(cri));
		
			map.put("list", rentList);
			map.put("pageMaker", pageMaker);
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}
		catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "rentList/{no}", method = RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> rentList(@PathVariable("no") int no,RentcarVO vo, Model model) {
		ResponseEntity<Map<String,Object>> entity = null;
		Map<String,Object> map = new HashMap<>();
		try {
			vo.setNo(no);
			vo = rentcarService.readByNo(no);
			map.put("vo", vo);
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}
		catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	// 현지 투어 관리
	@RequestMapping(value = "tourMngList", method = RequestMethod.GET)
	public String tourMngList(SearchCriteria cri, Model model) throws SQLException {
		List<TourVO> list = tourService.listPage(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(
				tourService.totalCountBySearchCriteria(cri) < 10 ? 10 : tourService.totalCountBySearchCriteria(cri));
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
		model.addAttribute("page", cri.getPage());
		return "/manager/tour/tourMngList";
	}

	@RequestMapping(value = "tourRegister", method = RequestMethod.GET)
	public String tourRegisterGet(Model model) throws SQLException {
		int no = tourService.totalCount();
		model.addAttribute("no", no);
		return "/manager/tour/tourRegister";
	}

	@RequestMapping(value = "tourRegister", method = RequestMethod.POST)
	public String tourRegisterPost(TourVO vo, Model model) throws SQLException {
		tourService.insertTour(vo);
		return "redirect:tourMngList";
	}

	@RequestMapping(value = "tourDetail", method = RequestMethod.GET)
	public String tourDetail(TourVO vo, SearchCriteria cri, Model model) throws SQLException {
		vo = tourService.selectTourByNo(vo);
		model.addAttribute("tour", vo);
		model.addAttribute("cri", cri);
		return "/manager/tour/tourDetail";
	}

	@RequestMapping(value = "tourModify", method = RequestMethod.GET)
	public String tourModifyGet(TourVO vo, SearchCriteria cri, Model model) throws SQLException {
		vo = tourService.selectTourByNo(vo);
		model.addAttribute("tour", vo);
		model.addAttribute("cri", cri);
		return "/manager/tour/tourModify";
	}

	@RequestMapping(value = "tourModify", method = RequestMethod.POST)
	public String tourModifyPost(TourVO vo, SearchCriteria cri) throws SQLException {
		tourService.updateTour(vo);
		return "redirect:tourDetail?no=" + vo.getNo() + "&page=" + cri.getPage() + "&searchType=" + cri.getSearchType()
				+ "&searchType2=" + cri.getSearchType2() + "&keyword=" + cri.getKeyword();
	}

	@RequestMapping(value = "tourDelete", method = RequestMethod.GET)
	public String tourDelete(TourVO vo, SearchCriteria cri, Model model) throws SQLException {
		tourService.deleteTour(vo);
		return "redirect:tourMngList?page=" + cri.getPage() + "&searchType=" + cri.getSearchType() + "&searchType2="
				+ cri.getSearchType2() + "&keyword=" + cri.getKeyword();
	}

	// 렌트카 상품 관리
	@RequestMapping(value = "rentcarMngList", method = RequestMethod.GET)
	public String rentcarMngList(SearchCriteria cri, Model model) throws Exception {
		List<RentcarVO> rentcarList = rentcarService.listSearchCriteriaRentcar(cri);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(rentcarService.totalSearchCountRentcar(cri));
		
	//	System.out.println(rentcarService.totalSearchCountRentcar(cri));
		System.out.println("리스트 사이즈"+rentcarList.size());
		for(RentcarVO rentcar: rentcarList) {
			  System.out.println("렌트"+rentcar.getRentddate());
			  System.out.println("리턴"+rentcar.getReturndate());
			  
		}
		model.addAttribute("cri", cri);
		model.addAttribute("list", rentcarList);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/manager/rentcar/rentcarMngList";
	}

	//렌트카 추가 폼
	@RequestMapping(value = "rentcarRegister", method = RequestMethod.GET)
	public String rentcarRegister(SearchCriteria cri, Model model) {
		int lastNo =0;
		
		try{
			List<RentcarVO> rentcarList = rentcarService.listSearchCriteriaRentcar(cri);

		    if(rentcarList.size() != 0) {
		         lastNo = rentcarList.get(0).getNo();
		    }
				model.addAttribute("autoNo",lastNo+1);
			
			
		}catch (Exception e) {
		    e.printStackTrace();
		    //퇴사 사원이 없는 경우 오류가 뜨기에 시범 데이터 입력 
		}
		
		return "/manager/rentcar/rentcarRegister";
	}
	
	@RequestMapping(value = "rentcarRegister", method = RequestMethod.POST)
	public String rentcarRegisterPost(RentcarVO vo, Model model) throws Exception {
		  rentcarService.insertRentcar(vo);
		return "redirect:rentcarMngList";
	}
	
	//렌트카 상세 페이지
	@RequestMapping(value = "rentcarDetailForm", method = RequestMethod.GET)
	public String rentcarDetailForm(int no, SearchCriteria cri, Model model) throws SQLException {
		RentcarVO vo = rentcarService.readByNo(no);

		model.addAttribute("rentcarVO", vo);
		model.addAttribute("cri", cri);

		return "/manager/rentcar/rentcarDetailForm";
	}
	
	//렌트카 정보 수정
	@RequestMapping(value = "rentcarDetailFormUpdate", method = RequestMethod.POST)
	public String rentcarDetailFormUpdate(RentcarVO vo, SearchCriteria cri, Model model) throws Exception {
		System.out.println(vo);
		rentcarService.updateRentcar(vo);

		model.addAttribute("rentcarVO", vo);
		model.addAttribute("cri", cri);
		return "redirect:/rentcarDetailForm?no=" + vo.getNo() + "&page=" + cri.getPage() + "&searchType="
				+ cri.getSearchType() + "&keyword=" + cri.getKeyword();
	}
	
	//렌트카 상품 삭제
		@RequestMapping(value = "delRentcar", method = RequestMethod.GET)
		public String delRentcar(int no, SearchCriteria cri) throws Exception{
			rentcarService.deleteRentcar(no);
			return "redirect:/rentcarMngList?page="+cri.getPage()+"&searchType="+cri.getSearchType()+"&keyword="+cri.getKeyword();
		}

// 이벤트관리  -------------------------------------------------------------------------------
	 @RequestMapping(value ="eventMngList", method = RequestMethod.GET)
	 public String eventMngList(SearchCriteria cri, Model model) throws Exception {
			cri.setPerPageNum(5);
		    List<EventVO> eventList = eventService.listSearchCriteriaEvent(cri);
		       
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(eventService.totalSearchCountEvent(cri));
			model.addAttribute("cri", cri);
			model.addAttribute("list", eventList);
		    model.addAttribute("pageMaker", pageMaker);

			return "/manager/event/eventMngList";
	 }		
	//이벤트 추가 
	 @RequestMapping(value = "eventRegister", method = RequestMethod.GET)
		public String eventRegister(SearchCriteria cri, Model model) {
			int lastNo = 0;
			try {
				List<EventVO> eventList = eventService.listSearchCriteriaEvent(cri);
				lastNo = eventList.get(0).getNo() + 1;
			} catch (Exception e) {
				lastNo = 1;
			}

			model.addAttribute("autoNo", lastNo); // 가장 나중 번호로 자동세팅

			return "/manager/event/eventRegister";
		}
	 
	 @RequestMapping(value = "eventRegister", method = RequestMethod.POST)
		public String eventRegisterPost(EventVO vo, MultipartFile eventPic, Model model) throws Exception {
			String savedName = UploadFileUtils.uploadFile(uploadPathEvent, eventPic.getOriginalFilename().replaceAll(" ", "_"),
					eventPic.getBytes());
			String bigSizePic = savedName.substring(0, 12) + savedName.substring(14);

			vo.setPic(bigSizePic.replaceAll(" ", "_"));
			eventService.insertEvent(vo);
			return "redirect:/eventMngList";
		}
	 @RequestMapping(value = "eventDetailForm", method = RequestMethod.GET)
		public String eventDetailForm(int no, SearchCriteria cri, Model model) throws Exception {
		 EventVO vo = eventService.readByNoEvent(no);

			model.addAttribute("eventVO", vo);
			model.addAttribute("cri", cri);

			return "/manager/event/eventDetailForm";
		}
		
		@RequestMapping(value = "eventUpdate", method = RequestMethod.POST)
		public String eventUpdate(EventVO vo, MultipartFile eventPic, Model model) throws Exception {
		     System.out.println(vo);
			if (eventPic.getBytes().length != 0) { // 새로 첨부한 파일이 있다면
				// 원래 vo가 가진 pic의 네임으로 폴더에 저장된 사진들 지우기

				File eventFile = new File(uploadPathEvent + vo.getPic());
				eventFile.delete();

				String smallSizePic = vo.getPic().substring(0, 12) + "s_" + vo.getPic().substring(12); // 썸네일용 사진도
				// System.out.println(smallSizePic);
				File eventFile2 = new File(uploadPathEvent + smallSizePic);
				eventFile2.delete();

				// 수정 된 파일로 교체
				String savedName = UploadFileUtils.uploadFile(uploadPathEvent, eventPic.getOriginalFilename(),
						eventPic.getBytes());
				String bigSizePic = savedName.substring(0, 12) + savedName.substring(14);
				
				vo.setPic(bigSizePic);
			}
			eventService.updateEvent(vo);

			return "redirect:/eventDetailForm?no=" + vo.getNo();

		}
	 //이벤트 삭제	
		 @RequestMapping(value = "removeEvent", method = RequestMethod.GET)
	     public String removeEvent(SearchCriteria cri, Model model, int no) throws Exception {
			 EventVO vo = eventService.readByNoEvent(no);
				if (vo.getPic() != null) {
					// 폴더에 남은 사진들 먼저 지우기
					File eventFile = new File(uploadPathEvent + vo.getPic());
					eventFile.delete();

					String smallSizePic = vo.getPic().substring(0, 12) + "s_" + vo.getPic().substring(12); // 썸네일용 사진도

					File eventFile2 = new File(uploadPathEvent + smallSizePic);
					eventFile2.delete();
				}

				eventService.deleteEvent(no);

				return "redirect:/eventMngList?page=" + cri.getPage() + "&searchType=" + cri.getSearchType() + "&keyword="
						+ cri.getKeyword();
			}
// 게시판관리 -------------------------------------------------------------------------------------------------------------------------

	// FAQ 관리
	@RequestMapping(value = "FAQMngList", method = RequestMethod.GET)
	public String FAQMngList(SearchCriteria cri, Model model) throws SQLException {
		List<FaqVO> list = faqService.listPage(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(faqService.totalCount(cri) < 10 ? 10 : faqService.totalCount(cri));
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
		return "/manager/board/FAQMngList";
	}

	@RequestMapping(value = "FAQRegister", method = RequestMethod.GET)
	public String FAQResgiterGet() throws SQLException {
		return "/manager/board/FAQRegister";
	}

	@RequestMapping(value = "FAQRegister", method = RequestMethod.POST)
	public String FAQResgiterPost(FaqVO vo) throws SQLException {
		faqService.insertFAQ(vo);
		return "redirect:FAQMngList";
	}

	@RequestMapping(value = "FAQDetail", method = RequestMethod.GET)
	public String FAQDetail(FaqVO vo, SearchCriteria cri, Model model) throws SQLException {
		vo = faqService.selectFAQByNo(vo);
		model.addAttribute("faq", vo);
		model.addAttribute("cri", cri);
		return "/manager/board/FAQDetail";
	}

	@RequestMapping(value = "FAQModify", method = RequestMethod.GET)
	public String FAQModifyGet(FaqVO vo, SearchCriteria cri, Model model) throws SQLException {
		vo = faqService.selectFAQByNo(vo);
		model.addAttribute("faq", vo);
		model.addAttribute("cri", cri);
		return "/manager/board/FAQModify";
	}

	@RequestMapping(value = "FAQModify", method = RequestMethod.POST)
	public String FAQModifyPost(FaqVO vo, SearchCriteria cri) throws SQLException {
		faqService.updateFAQ(vo);
		return "redirect:FAQDetail?no=" + vo.getNo() + "&page=" + cri.getPage() + "&searchType=" + cri.getSearchType()
				+ "&searchType2=" + cri.getSearchType2() + "&keyword=" + cri.getKeyword();
	}

	@RequestMapping(value = "FAQDelete", method = RequestMethod.GET)
	public String FAQDelete(FaqVO vo, SearchCriteria cri, Model model) throws SQLException {
		faqService.deleteFAQ(vo);
		return "redirect:FAQMngList?page=" + cri.getPage() + "&searchType=" + cri.getSearchType() + "&searchType2="
				+ cri.getSearchType2() + "&keyword=" + cri.getKeyword();
	}

	// 고객의 소리

	// 고객의 소리 리스트
	@RequestMapping(value = "custBoardMngList", method = RequestMethod.GET)
	public String custBoardMngList(SearchCriteria cri, Model model) throws Exception {
        cri.setPerPageNum(5);
		List<CustBoardVO> custBoardList = custBoardService.listSearchCriteriaCustBoard(cri);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(custBoardService.totalSearchCountCustBoard(cri));

		model.addAttribute("cri", cri);
		model.addAttribute("list", custBoardList);
		model.addAttribute("pageMaker", pageMaker);

		return "/manager/board/custBoardList";
	}

	// 고객의 소리 조회
	@RequestMapping(value = "custBoardDetail", method = RequestMethod.GET)
	public String custBoardDetail(int no, SearchCriteria cri, Model model) throws Exception {
		CustBoardVO vo = custBoardService.readByNoCustBoard(no);

		model.addAttribute("custBoardVO", vo);
		model.addAttribute("cri", cri);

		return "/manager/board/custBoardDetail";
	}

	// 고객의 소리 추가 버튼 눌렀을 때
	@RequestMapping(value = "custBoardRegister", method = RequestMethod.GET)
	public String custBoardRegister(SearchCriteria cri, Model model) {
		int lastNo = 0;
		try {
			List<CustBoardVO> custBoardList = custBoardService.listSearchCriteriaCustBoard(cri);
			lastNo = custBoardList.get(0).getNo() + 1;
		} catch (Exception e) {
			lastNo = 1;
		}

		model.addAttribute("autoNo", lastNo); // 가장 나중 번호로 자동세팅

		return "/manager/board/custBoardRegister";
	}

	// 고객의 소리 추가
	@RequestMapping(value = "custBoardRegister", method = RequestMethod.POST)
	public String custBoardRegisterPost(CustBoardVO vo, Model model) throws Exception {

		custBoardService.insertCustBoard(vo);

		return "redirect:/custBoardDetail?no=" + vo.getNo();
	}

	// 고객의 소리 업데이트- 고객글을 함부로 업데이트 하면 안되기 때문에 테스트용에 가까움
	@RequestMapping(value = "custBoardUpdate", method = RequestMethod.POST)
	public String custBoardUpdate(CustBoardVO vo, SearchCriteria cri, Model model) throws Exception {
		System.out.println(vo);
		custBoardService.updateCustBoard(vo);

		model.addAttribute("custBoardVO", vo);
		model.addAttribute("cri", cri);
		return "redirect:/custBoardDetail?no=" + vo.getNo() + "&page=" + cri.getPage() + "&searchType="
				+ cri.getSearchType() + "&keyword=" + cri.getKeyword();
	}

	// 고객의 소리 게시글 삭제
	@RequestMapping(value = "removeCustBoard", method = RequestMethod.GET)
	public String removeCustBoard(int no, SearchCriteria cri) throws Exception {
		custBoardService.deleteCustBoard(no);
		return "redirect:/custBoardMngList?page=" + cri.getPage() + "&searchType=" + cri.getSearchType() + "&keyword="
				+ cri.getKeyword();
	}


// 디자인관리 ---------------------------------------------------------------------------------------------------------------

	// 팝업
    @RequestMapping(value ="popupMngList", method = RequestMethod.GET)
	public String popupMngList(SearchCriteria cri, Model model) throws Exception {
		cri.setPerPageNum(5);
        List<PopupVO> popupList = popupService.listSearchCriteriaPopup(cri);
        
        PopupVO popup1 = popupService.setPopup("L");
        if(popup1 != null) {
        	model.addAttribute("popup1", popup1.getPic());
        }
        PopupVO popup2 = popupService.setPopup("R");
        if(popup2 != null) {
        	model.addAttribute("popup2", popup2.getPic());
        }
       
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(popupService.totalSearchCountPopup(cri));
		model.addAttribute("cri", cri);
		model.addAttribute("list", popupList);
       	model.addAttribute("pageMaker", pageMaker);

		return "/manager/design/popupMngList";
	}
    //팝업 추가
    @RequestMapping(value = "popupRegister", method = RequestMethod.GET)
	public String popupRegister(SearchCriteria cri, Model model) {
		int lastNo = 0;
		try {
			List<PopupVO> popupList = popupService.listSearchCriteriaPopup(cri);
			lastNo = popupList.get(0).getNo() + 1;
		} catch (Exception e) {
			lastNo = 1;
		}

		model.addAttribute("autoNo", lastNo); // 가장 나중 번호로 자동세팅

		return "/manager/design/popupRegister";
	}
	@RequestMapping(value = "popupRegister", method = RequestMethod.POST)
	public String popupRegisterPost(PopupVO vo, MultipartFile popupPic, Model model) throws Exception {

		String savedName = UploadFileUtils.uploadFile(uploadPathPopup, popupPic.getOriginalFilename().replaceAll(" ", "_"),
				popupPic.getBytes());
		String bigSizePic = savedName.substring(0, 12) + savedName.substring(14);

		vo.setPic(bigSizePic.replaceAll(" ", "_"));
		popupService.insertPopup(vo);
		return "redirect:/popupMngList";
	}
	
	//팝업 디테일 조회
	@RequestMapping(value = "popupDetailForm", method = RequestMethod.GET)
	public String popupDetailForm(int no, SearchCriteria cri, Model model) throws Exception {
		PopupVO vo = popupService.readByNoPopup(no);

		model.addAttribute("popupVO", vo);
		model.addAttribute("cri", cri);

		return "/manager/design/popupDetailForm";
	}
	
	//팝업 수정
	@RequestMapping(value = "popupUpdate", method = RequestMethod.POST)
	public String popupUpdate(PopupVO vo, MultipartFile popupPic, Model model) throws Exception {
	
		if (popupPic.getBytes().length != 0) { // 새로 첨부한 파일이 있다면
			// 원래 vo가 가진 pic의 네임으로 폴더에 저장된 사진들 지우기

			File popupFile = new File(uploadPathPopup + vo.getPic());
			popupFile.delete();

			String smallSizePic = vo.getPic().substring(0, 12) + "s_" + vo.getPic().substring(12); // 썸네일용 사진도
			// System.out.println(smallSizePic);
			File popupFile2 = new File(uploadPathPopup + smallSizePic);
			popupFile2.delete();

			// 수정 된 파일로 교체
			String savedName = UploadFileUtils.uploadFile(uploadPathPopup, popupPic.getOriginalFilename(),
					popupPic.getBytes());
			String bigSizePic = savedName.substring(0, 12) + savedName.substring(14);
			
			vo.setPic(bigSizePic);
		}
		popupService.updatePopup(vo);

		return "redirect:/popupDetailForm?no=" + vo.getNo();

	}
	//리스트에서 팝업 미리보기
		@ResponseBody
		@RequestMapping(value = "getPopupPicPath/{no}",produces = "application/text; charset=utf8" ,method = RequestMethod.GET)
		public ResponseEntity<String> getPopupPicPath(@PathVariable("no") int no){

			ResponseEntity<String> entity = null;
			
			try {
				PopupVO vo = popupService.readByNoPopup(no);
				if(vo !=null ) {
				entity = new ResponseEntity<String>(vo.getPic(),HttpStatus.OK);
				   }
			}catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST); //400에러
					
			}
			return entity;
			
		}
		
    //팝업 설정하기
		@ResponseBody
		@RequestMapping(value = "setPopup/{no}/{numbering}", method = RequestMethod.GET)
		public ResponseEntity<String> setPopup(@PathVariable("no") int no,@PathVariable("numbering") String numbering, Model model,SearchCriteria cri, HttpServletResponse response) throws Exception{
			ResponseEntity<String> entity = null;

			try {
				//왼쪽배너부터
				
				if(numbering.equals("popup1")) {

					PopupVO lvo = popupService.setPopup("L");
					//System.out.println("lvo"+lvo);
					if(lvo != null) {
						lvo.setPosition(null);
						popupService.updatePopup(lvo);
						
					}
					PopupVO firstVO = popupService.readByNoPopup(no);
					firstVO.setPosition("L");
					popupService.updatePopup(firstVO);

					model.addAttribute("popup1",firstVO.getPic());
					entity = new ResponseEntity<String>("success", HttpStatus.OK);
				}
				if(numbering.equals("popup2")) {
					PopupVO rvo = popupService.setPopup("R");
					if(rvo != null) {
						rvo.setPosition(null);
						popupService.updatePopup(rvo);

					}
					PopupVO secondVO = popupService.readByNoPopup(no);
					secondVO.setPosition("R");
					popupService.updatePopup(secondVO);

					model.addAttribute("popup2",secondVO.getPic());
					entity = new ResponseEntity<String>("success", HttpStatus.OK);
				}

			} catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST); // 400에러

			}
			return entity;
			
		}
	
	//팝업삭제
     @RequestMapping(value = "removePopup", method = RequestMethod.GET)
     public String removePopup(SearchCriteria cri, Model model, int no) throws Exception {
    	 PopupVO vo = popupService.readByNoPopup(no);
			if (vo.getPic() != null) {
				// 폴더에 남은 사진들 먼저 지우기
				File popupFile = new File(uploadPathPopup + vo.getPic());
				popupFile.delete();

				String smallSizePic = vo.getPic().substring(0, 12) + "s_" + vo.getPic().substring(12); // 썸네일용 사진도

				File popupFile2 = new File(uploadPathPopup + smallSizePic);
				popupFile2.delete();
			}

			popupService.deletePopup(no);

			return "redirect:/popupMngList?page=" + cri.getPage() + "&searchType=" + cri.getSearchType() + "&keyword="
					+ cri.getKeyword();
		}

	// 배너
	@RequestMapping(value = "bannerMngList", method = RequestMethod.GET)
	public String bannerMngList(SearchCriteria cri, Model model) throws Exception {
		cri.setPerPageNum(5);
        List<BannerVO> bannerList = bannerService.listSearchCriteriaBanner(cri);
        
        BannerVO leftBannerVO = bannerService.setBanner("L");
        BannerVO rightBannerVO = bannerService.setBanner("R");
        if(leftBannerVO != null) {
//  		
		   String leftBanner = leftBannerVO.getPic();
		   model.addAttribute("leftBanner",leftBanner);
		   
        }
        
        if(rightBannerVO != null) {
		 	String rightBanner = rightBannerVO.getPic();
			// 작은이미지는 앞에 s_달려있음
			model.addAttribute("rightBanner",rightBanner);
        }
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(bannerService.totalSearchCountBanner(cri));
		model.addAttribute("cri", cri);
		model.addAttribute("list", bannerList);
       	model.addAttribute("pageMaker", pageMaker);

		return "/manager/design/bannerMngList";
	}

	// 배너 추가 버튼 눌렀을 때
	@RequestMapping(value = "bannerRegister", method = RequestMethod.GET)
	public String bannerRegister(SearchCriteria cri, Model model) {
		int lastNo = 0;
		try {
			List<BannerVO> bannerList = bannerService.listSearchCriteriaBanner(cri);
			lastNo = bannerList.get(0).getNo() + 1;
		} catch (Exception e) {
			lastNo = 1;
		}

		model.addAttribute("autoNo", lastNo); // 가장 나중 번호로 자동세팅

		return "/manager/design/bannerRegister";
	}

	// 배너 이미지 한개 업로드
	@RequestMapping(value = "bannerRegister", method = RequestMethod.POST)
	public String bannerRegisterPost(BannerVO vo, MultipartFile bannerPic, Model model) throws Exception {

		String savedName = UploadFileUtils.uploadFile(uploadPathBanner, bannerPic.getOriginalFilename().replaceAll(" ", "_"),
				bannerPic.getBytes());
		String bigSizePic = savedName.substring(0, 12) + savedName.substring(14);
		// 배너기 때문에 썸네일 아닌 이미지 파일 이름으로 디비에 저장

		vo.setPic(bigSizePic.replaceAll(" ", "_"));
		bannerService.insertBanner(vo);
		return "redirect:/bannerMngList";
	}

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

	// 배너 디테일 조회
	@RequestMapping(value = "bannerDetailForm", method = RequestMethod.GET)
	public String bannerDetailForm(int no, SearchCriteria cri, Model model) throws Exception {
		BannerVO vo = bannerService.readByNoBanner(no);

		model.addAttribute("bannerVO", vo);
		model.addAttribute("cri", cri);

		return "/manager/design/bannerDetailForm";
	}

	// 디테일 페이지이자 폼에서 업데이트를 하는 경우
	@RequestMapping(value = "bannerUpdate", method = RequestMethod.POST)
	public String bannerUpdate(BannerVO vo, MultipartFile bannerPic, Model model) throws Exception {

		if (bannerPic.getBytes().length != 0) { // 새로 첨부한 파일이 있다면
			// 원래 vo가 가진 pic의 네임으로 폴더에 저장된 사진들 지우기

			File bannerFile = new File(uploadPathBanner + vo.getPic());
			bannerFile.delete();

			String smallSizePic = vo.getPic().substring(0, 12) + "s_" + vo.getPic().substring(12); // 썸네일용 사진도
			// System.out.println(smallSizePic);
			File bannerFile2 = new File(uploadPathBanner + smallSizePic);
			bannerFile2.delete();

			// 수정 된 파일로 교체
			String savedName = UploadFileUtils.uploadFile(uploadPathBanner, bannerPic.getOriginalFilename(),
					bannerPic.getBytes());
			String bigSizePic = savedName.substring(0, 12) + savedName.substring(14);
			// 배너기 때문에 썸네일 아닌 이미지 파일 이름으로 디비에 저장

			vo.setPic(bigSizePic);
		}
		bannerService.updateBanner(vo);

		return "redirect:/bannerDetailForm?no=" + vo.getNo();

	}

	// 배너 삭제
	@RequestMapping(value = "removeBanner", method = RequestMethod.GET)
	public String removeBanner(SearchCriteria cri, Model model, int no) throws Exception {
		BannerVO vo = bannerService.readByNoBanner(no);
		if (vo.getPic() != null) {
			// 폴더에 남은 사진들 먼저 지우기
			File bannerFile = new File(uploadPathBanner + vo.getPic());
			bannerFile.delete();

			String smallSizePic = vo.getPic().substring(0, 12) + "s_" + vo.getPic().substring(12); // 썸네일용 사진도

			File bannerFile2 = new File(uploadPathBanner + smallSizePic);
			bannerFile2.delete();
		}

		bannerService.deleteBanner(vo.getNo());

		return "redirect:/bannerMngList?page=" + cri.getPage() + "&searchType=" + cri.getSearchType() + "&keyword="
				+ cri.getKeyword();
	}

	//리스트에서 배너 미리보기
	@ResponseBody
	@RequestMapping(value = "getPicPath/{no}",produces = "application/text; charset=utf8" ,method = RequestMethod.GET)
	public ResponseEntity<String> getPicPath(@PathVariable("no") int no){

		ResponseEntity<String> entity = null;
		
		try {
			BannerVO vo = bannerService.readByNoBanner(no);
	
			if(vo !=null ) {
			entity = new ResponseEntity<String>(vo.getPic(),HttpStatus.OK);
			   }
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST); //400에러
					
		}
		return entity;
		
	}
	//배너 설정하기 
		@ResponseBody
		@RequestMapping(value = "setBanner/{no}/{side}", method = RequestMethod.GET)
		public ResponseEntity<String> setBanner(@PathVariable("no") int no,@PathVariable("side") String side, Model model,SearchCriteria cri) throws Exception{
			ResponseEntity<String> entity = null;

			try {
				//왼쪽배너부터
				
				if(side.equals("left")) {

					BannerVO lvo = bannerService.setBanner("L");
					//System.out.println("lvo"+lvo);
					if(lvo != null) {
						lvo.setPosition(null);
						bannerService.updateBanner(lvo);
						
					}
					BannerVO leftVO = bannerService.readByNoBanner(no);
					leftVO.setPosition("L");
					bannerService.updateBanner(leftVO);
					model.addAttribute("leftBanner",leftVO.getPic());
					entity = new ResponseEntity<String>("leftSuccess", HttpStatus.OK);
				}
				if(side.equals("right")) {
					BannerVO rvo = bannerService.setBanner("R");
					if(rvo != null) {
						rvo.setPosition(null);
						bannerService.updateBanner(rvo);
						
					}
					BannerVO rightVO = bannerService.readByNoBanner(no);
					rightVO.setPosition("R");
					bannerService.updateBanner(rightVO);
					model.addAttribute("rightBanner",rightVO.getPic());
					entity = new ResponseEntity<String>("rightSuccess", HttpStatus.OK);
				}

			} catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST); // 400에러

			}
			return entity;
			
		}
		
// 공지사항 관리 ------------------------------------------------------------------------------------------------------------------

	@RequestMapping(value = "noticeMngList", method = RequestMethod.GET)
	public String noticeMngList(SearchCriteria cri, Model model) throws Exception {
		List<NoticeVO> noticeList = noticeService.noticeList(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(noticeService.totalCountNotice(cri));
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
		return "/manager/notice/noticeMngList";
	}

	// 공지사항 추가
	@RequestMapping(value = "addNoticeForm", method = RequestMethod.GET)
	public String addNoticeForm(Model model) throws Exception {
		SearchCriteria cri = new SearchCriteria();
		int total = noticeService.totalCountNotice(cri);
		int totalCnt = total + 1;
		model.addAttribute("totalCnt", totalCnt);
		return "/manager/notice/addNoticeForm";
	}

	// 공지사항 추가
	@RequestMapping(value = "addNoticeForm", method = RequestMethod.POST)
	public String addNoticeResult(NoticeVO notice, Model model) throws Exception {
		System.out.println(notice);
		noticeService.addNotice(notice);
		return "redirect:/noticeMngList";
	}

	// 공지사항 상세페이지
	@RequestMapping(value = "noticeDetail", method = RequestMethod.GET)
	public String noticeDetail(int no, SearchCriteria cri, Model model) throws Exception {
		NoticeVO notice = noticeService.readNoticeByNo(no);
		model.addAttribute("notice", notice);
		model.addAttribute("cri", cri);
		return "/manager/notice/noticeDetail";
	}

	// 공지사항 삭제
	@RequestMapping(value = "removeNotice", method = RequestMethod.GET)
	public String removeNotice(int no, SearchCriteria cri, Model model) throws Exception {
		noticeService.removeNotice(no);
		model.addAttribute("cri", cri);
		return "redirect:/noticeMngList";
	}

	// 공지사항 수정
	@RequestMapping(value = "editNotice", method = RequestMethod.GET)
	public String editNoticeGET(int no, Model model) throws Exception {
		NoticeVO notice = noticeService.readNoticeByNo(no);
		model.addAttribute("notice", notice);
		return "/manager/notice/editNotice";
	}

	// 공지사항 수정
	@RequestMapping(value = "editNotice", method = RequestMethod.POST)
	public String editNoticePOST(NoticeVO notice, Model model) throws Exception {
		System.out.println(notice);
		noticeService.editNotice(notice);
		return "redirect://noticeDetail?no=" + notice.getNo();
	}

	// 쿠폰관리
	@RequestMapping(value = "couponMngList", method = RequestMethod.GET)
	public String couponMngList(SearchCriteria cri, Model model) throws Exception {
		List<CouponVO> couponList = couponService.couponList(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(couponService.totalCountNotice(cri));
		model.addAttribute("couponList", couponList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);
		return "/manager/coupon/couponMngList";
	}
	//쿠폰 추가
		@RequestMapping(value="addCouponForm", method=RequestMethod.GET)
		public String addCouponForm(Model model) throws Exception{
			SearchCriteria cri = new SearchCriteria();
			int total = couponService.totalCountNotice(cri);
			int totalCnt = total+1;
			model.addAttribute("totalCnt", totalCnt);
			return "/manager/coupon/addCouponForm";
		}
	//쿠폰 추가
	@RequestMapping(value="addCouponForm", method=RequestMethod.POST)
	public String addCouponResult(CouponVO coupon,Model model) throws Exception{

		System.out.println(coupon);

		couponService.addCoupon(coupon);
		return "redirect:/couponMngList";
	}
	
	//쿠폰 상세페이지
		@RequestMapping(value="couponDetail", method=RequestMethod.GET)
		public String couponDetail(int cno,SearchCriteria cri, Model model) throws Exception{
			CouponVO coupon = couponService.readCouponByNo(cno);
			model.addAttribute("coupon", coupon);
			model.addAttribute("pdate", coupon.getPdate());
			model.addAttribute("edate", coupon.getEdate());
			model.addAttribute("cri", cri);
			return "/manager/coupon/couponDetail";
		}
	
	//쿠폰 삭제
		@RequestMapping(value = "removeCoupon", method = RequestMethod.GET)
		public String removeCoupon(int cno, SearchCriteria cri, Model model) throws Exception {
			couponService.removeCoupon(cno);
			model.addAttribute("cri",cri);
			return "redirect:/couponMngList";
		}

	// 쿠폰 수정
	@RequestMapping(value = "editCoupon", method = RequestMethod.GET)
	public String editCouponGET(int cno, Model model) throws Exception {
		CouponVO coupon = couponService.readCouponByNo(cno);
		 model.addAttribute("pdate", coupon.getPdate()); 
		 model.addAttribute("edate",coupon.getEdate()); 
		 model.addAttribute("coupon", coupon);
		
		return "/manager/coupon/editCoupon";
	}

	// 쿠폰 수정
	@RequestMapping(value = "editCoupon", method = RequestMethod.POST)
	public String editCouponPOST(CouponVO coupon, Model model) throws Exception {
		couponService.editCoupon(coupon);
		return "redirect:/couponDetail?cno=" + coupon.getCno();
	}

	//호텔관리
	@RequestMapping(value="hotelMngList", method=RequestMethod.GET)
	public String hotelListPage(SearchCriteria cri, Model model) throws Exception { 
		List<HotelVO> list = hotelService.listSearchHotel(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(hotelService.totalSearchCountHotel(cri));
		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pageMaker", pageMaker);
		return "/manager/hotel/hotelMngList";
	}

	@RequestMapping(value = "hotelRegister", method = RequestMethod.GET)
	public String hotelResgiter(SearchCriteria cri, Model model) throws Exception {
		List<HotelVO> list = hotelService.listCriteriaHotel(cri);
		model.addAttribute("lastNum", list.get(0).getNo());
		return "/manager/hotel/hotelRegister";
	}

	@RequestMapping(value = "hotelRegister", method = RequestMethod.POST)
	public String hotelResgiterPost(HotelVO vo) throws Exception {
		hotelService.insertHotel(vo);
		return "redirect:hotelMngList";
	}

	@RequestMapping(value = "hotelModify", method = RequestMethod.GET)
	public String hotelModify(HotelVO vo, SearchCriteria cri, Model model) throws Exception {
		vo = hotelService.readHotel(vo);
		model.addAttribute("hotelVo", vo);
		model.addAttribute("cri", cri);
		return "/manager/hotel/hotelModify";
	}

	@RequestMapping(value = "hotelModify", method = RequestMethod.POST)
	public String hotelModifyPost(HotelVO vo, SearchCriteria cri) throws Exception {
		hotelService.updateHotel(vo);
		return "redirect:hotelMngList?page="+cri.getPage() +"&searchType=" + cri.getSearchType()+"&keyword=" + cri.getKeyword();
	}

	@RequestMapping(value = "hotelDelete", method = RequestMethod.GET)
	public String hotelDelete(HotelVO vo, SearchCriteria cri) throws Exception {
		hotelService.deleteHotel(vo);
		return "redirect:hotelMngList?page=" + cri.getPage() +"&searchType=" + cri.getSearchType()+"&keyword=" + cri.getKeyword();
	}
	
	// 상품 문의사항
		@RequestMapping(value = "planBoardList", method = RequestMethod.GET)
		public String planBoardList(SearchCriteria cri, Model model) throws Exception {
			List<PlanBoardVO> list = planBoardService.listSearchCriteriaPlanBoard(cri);
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(planBoardService.totalSearchCountPlanBoard(cri) < 10 ? 10 : planBoardService.totalSearchCountPlanBoard(cri));
			model.addAttribute("list", list);
			model.addAttribute("pageMaker", pageMaker);
			model.addAttribute("cri", cri);
			return "/manager/board/planBoardList";
		}
		
		@RequestMapping(value = "planBoardDetail", method = RequestMethod.GET)
		public String planBoardDetail(PlanBoardVO vo, SearchCriteria cri, Model model,String respond) throws Exception {
			vo = planBoardService.readByVoPlanBoard(vo);
			model.addAttribute("vo", vo);
			model.addAttribute("cri", cri);
			model.addAttribute("respond", respond);
			return "/manager/board/planBoardDetail";
		}
		//답변내용 달기
		@RequestMapping(value = "planBoardModify", produces = "application/text; charset=utf8", method = RequestMethod.GET)
		public String planBoardModify(PlanBoardVO vo, SearchCriteria cri, Model model,int no, String respond) throws Exception {
			vo = planBoardService.readByNoPlanBoard(no);
			vo.setRespond(respond);
			vo.setAnswer(1);
			planBoardService.updatePlanBoard(vo);
			model.addAttribute("vo", vo);
			model.addAttribute("cri", cri);
			return "/manager/board/planBoardModify";
		}
		//답변내용 수정
		@ResponseBody
		@RequestMapping(value = "planBoardModifyApi", produces = "application/text; charset=utf8", method = RequestMethod.GET)
		public ResponseEntity<String> planBoardModifyAjax(PlanBoardVO vo, SearchCriteria cri, Model model,int no, String respondText) throws Exception {
			ResponseEntity<String> entity = null;
			try {
				vo = planBoardService.readByNoPlanBoard(no);
				vo.setRespond(respondText);
				vo.setAnswer(1);
				planBoardService.updatePlanBoard(vo);
				entity = new ResponseEntity<String>(respondText, HttpStatus.OK);  
				
			}catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			}
			model.addAttribute("vo", vo);
			model.addAttribute("cri", cri);
			model.addAttribute("entity", entity);
			return entity;
		}
		
		@RequestMapping(value = "planBoardDelete", method = RequestMethod.GET)
		public String planBoardDelete(PlanBoardVO vo, SearchCriteria cri, Model model,int no) throws Exception {
			vo=planBoardService.readByNoPlanBoard(no);
			planBoardService.deletePlanBoard(vo);
			return "redirect:planBoardList?page=" + cri.getPage() + "&searchType=" + cri.getSearchType() + "&searchType2="
					+ cri.getSearchType2() + "&keyword=" + cri.getKeyword();
		}

		
		
		//결제 관리
		
		@RequestMapping(value = "paymentList", method = RequestMethod.GET)
		public String paymentList(SearchCriteria cri, Model model) throws Exception {
			return "/manager/payment/paymentList";
		}
		
		
	//ckEditor 이미지 업로드용
		@ResponseBody
		@RequestMapping(value = "imageUpload", method = RequestMethod.POST)
		public String imageUpload(HttpServletRequest req, HttpServletResponse resp, 
                MultipartHttpServletRequest multiFile, Model model,String ckEditorFuncNum) throws Exception {
			
			JsonObject json = new JsonObject();
			PrintWriter printWriter = null;
			OutputStream out = null;
			MultipartFile file = multiFile.getFile("upload");
			
			if(file !=null && file.getSize() > 0) {
         try {
			printWriter = resp.getWriter();
			resp.setContentType("text/html");
			String serverPath ="http://localhost:8080/tourland/displayFile/practice?filename=";
			String serverPath2 = "D:/workspace/workspace_spring/tourland/src/main/webapp/resources/images/practice";
			String savedName = UploadFileUtils.uploadFile(serverPath2, file.getOriginalFilename().replaceAll(" ", "_"),
			file.getBytes());
			String bigSizePic = savedName.substring(0, 12) + savedName.substring(14);
			
			json.addProperty("uploaded", 1);
            json.addProperty("fileName", file.getOriginalFilename());
            json.addProperty("url", serverPath+bigSizePic);
            printWriter.println(json);
            
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
			    if(printWriter != null) {
				    printWriter.close();
				 }
			   }
			}
          return null;
		}

	
}