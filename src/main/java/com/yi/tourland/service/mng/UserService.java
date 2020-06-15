package com.yi.tourland.service.mng;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yi.tourland.domain.Criteria;
import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.ReservationVO;
import com.yi.tourland.domain.mng.UserVO;
import com.yi.tourland.persistance.mng.dao.UserDAO;

@Service
public class UserService {

	@Autowired
	UserDAO dao;

	
	public void insertUser(UserVO vo) throws Exception {
		dao.insertUser(vo);
		
	}


	public UserVO readByNoUser(int userno) throws Exception {
		return dao.readByNoUser(userno);
	}


	public void updateUser(UserVO vo) throws Exception {
		dao.updateUser(vo);
	}


	public void deleteUser(int userno) throws Exception {
		dao.deleteUser(userno);
		
	}


	public List<UserVO> listCriteriaUser(Criteria cri, int usersecess) throws Exception {
		return dao.listCriteriaUser(cri, usersecess);
	}


	public int totalCountUser(int usersecess) throws Exception {
		return dao.totalCountUser(usersecess);
    }


	public List<UserVO> listSearchCriteriaUser(SearchCriteria cri, int usersecess) throws Exception {
		return dao.listSearchCriteriaUser(cri, usersecess);
	}

	
	public int totalSearchCountUser(SearchCriteria cri, int usersecess) throws Exception {
		return dao.totalSearchCountUser(cri, usersecess);
	}
	
	public UserVO readByIdUser(String userid) throws Exception {
		return dao.readByIdUser(userid);
	}
	
	public UserVO readByIdPwUser(String userid,String userpass) throws Exception {
		return dao.readByIdPwUser(userid,userpass);
	}
	
	//태원
	//결제관리에 쓰일 리스트
	public List<ReservationVO> listSearchCriteriaPaymentUser(SearchCriteria cri) throws Exception {
		return dao.listSearchCriteriaPaymentUser(cri);
	}
	public int totalSearchCountPaymentUser(SearchCriteria cri) throws Exception {
		return dao.totalSearchCountPaymentUser(cri);
	}
	
	//메일보내기
	public UserVO readByNameBirthTel(String username,String userbirth,String usertel) throws Exception {
		return dao.readByNameBirthTel(username,userbirth,usertel);
	}
}
