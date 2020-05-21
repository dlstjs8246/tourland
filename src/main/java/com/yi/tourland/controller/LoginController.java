package com.yi.tourland.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yi.tourland.domain.mng.EmployeeVO;
import com.yi.tourland.domain.mng.UserVO;
import com.yi.tourland.service.mng.EmployeeService;
import com.yi.tourland.service.mng.UserService;

@Controller
/* @RequestMapping("/user/*") */
public class LoginController {
	
	@Autowired
	EmployeeService empService;
	
	@Autowired
	UserService userService;
	
	//로그인 view 화면
	@RequestMapping(value="loginForm",method = RequestMethod.GET)
	public String loginGet(){
		return "/user/tourlandLoginForm";
	}
	
	//로그인 post 화면
	@RequestMapping(value="loginForm",method=RequestMethod.POST)
	public String loginPost(String id, String pass, UserVO userVO, EmployeeVO empVO, Model model, HttpSession session) throws Exception {
		//input에서 받는 아이디,비밀번호를 유저와 사원쪽에 넣고
		userVO.setUserid(id);
		userVO.setUserpass(pass);
		empVO.setEmpid(id);
		empVO.setEmppass(pass);

		//맞는게 있는지 비교하기 위함
		UserVO dbUserId = userService.readByIdUser(userVO.getUserid());
		UserVO dbUserIdPw = userService.readByIdPwUser(userVO.getUserid(),userVO.getUserpass());
		EmployeeVO dbEmpId = empService.readByIdEmployee(empVO.getEmpid());
		EmployeeVO dbEmpIdPw = empService.readByIdPwEmployee(empVO.getEmpid(),empVO.getEmppass());
		
		//직원아이디가 있는 경우
		if(dbEmpId!=null) {
			//퇴사한 직원인 경우
			if(dbEmpId.getEmpretired()==1) {
				model.addAttribute("error", "로그인 권한이 없습니다.");
				model.addAttribute("EmpStay", empVO);
				return "/user/tourlandLoginForm";
			}
			//비밀번호가 맞지않는 경우
			/* if(dbEmp.getEmppass().equals(empVO.getEmppass())==false) { */ //원래라면 이렇게 비교하지만 password로 쌓여져있으니까
			if(dbEmpIdPw==null) {
				model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
				model.addAttribute("EmpStay", empVO); 
				return "/user/tourlandLoginForm";
			}
			//전부 다 맞는 경우(직원)
			Map<String, Object> map = new HashMap<>();
			map.put("name", dbEmpIdPw.getEmpname());
			map.put("right", dbEmpIdPw.getEmpauth());
			session.setAttribute("Manager",map);
			session.setAttribute("Auth", dbEmpIdPw);//정보 다 가지고 있는거
			session.setAttribute("pass", pass);
			session.setAttribute("mypage","mypageemp");
			return "redirect:/customer/tourlandMain";
			
		//회원아이디가 있는 경우
		}else if(dbUserId!=null) {
			
			//탈퇴한 회원인 경우
			if(dbUserId.getUsersecess()==1) {
				model.addAttribute("error", "로그인 권한이 없습니다.");
				model.addAttribute("UserStay", userVO);
				return "/user/tourlandLoginForm";
			}
			
			//회원 비밀번호가 맞지 않는 경우. 아이디 비밀번호를 같이 쓴건 비밀번호가 중복되는 회원이 있을까봐
			if(dbUserIdPw==null){
				model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
				model.addAttribute("UserStay", userVO); //이거는 비밀번호를 틀린경우에도 아이디 비밀번호를 남기기위해.
				return "/user/tourlandLoginForm";
			}

			//전부 다 맞는 경우(회원)
			
			session.setAttribute("User",dbUserId.getUsername());
			session.setAttribute("Auth", dbUserIdPw); //정보 다 가지고 있는거
			session.setAttribute("pass", pass);
			session.setAttribute("mypage","mypageuser");
			return "redirect:/customer/tourlandMain";
			
		//아이디가 없는 경우	(직원,회원)
		}else{
			model.addAttribute("error", "아이디가 존재하지 않습니다.");
			model.addAttribute("UserStay", userVO);
			model.addAttribute("EmpStay", empVO);
			return "/user/tourlandLoginForm";
		}
	}

	//로그아웃
	@RequestMapping(value="logout",method = RequestMethod.GET)
	public String logoutGet(HttpSession session){
		session.invalidate();
		return "redirect:/customer/tourlandMain";
	}
}
