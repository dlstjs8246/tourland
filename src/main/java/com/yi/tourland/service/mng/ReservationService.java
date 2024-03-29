package com.yi.tourland.service.mng;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yi.tourland.domain.Criteria;
import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.ReservationVO;
import com.yi.tourland.domain.mng.UserVO;
import com.yi.tourland.persistance.mng.dao.ReservationDao;
@Service
public class ReservationService {
	@Autowired
	ReservationDao dao;
	public void insertReservation(ReservationVO vo) throws SQLException {
		dao.insertReservation(vo);
	}
	public List<ReservationVO> listReservation(SearchCriteria cri) throws SQLException {
		return dao.listReservation(cri);
	}
	public List<ReservationVO> ReadCartByUserNo(UserVO vo,SearchCriteria cri) throws SQLException {
		return dao.ReadCartByUserNo(vo,cri);
	}
	public List<ReservationVO> ReadReservationByUserNo(UserVO vo,SearchCriteria cri) throws SQLException {
		return dao.ReadReservationByUserNo(vo,cri);
	}
	public int totalSearchReservationCount(SearchCriteria cri) throws SQLException {
		return dao.totalSearchReservationCount(cri);
	}
	public int totalSearchCartCountByUserNo(SearchCriteria cri, UserVO vo) throws SQLException {
		return dao.totalSearchCartCountByUserNo(cri, vo);
	}
	public int totalSearchReservationCountByUserNo(SearchCriteria cri, UserVO vo) throws SQLException {
		return dao.totalSearchReservationCountByUserNo(cri, vo);
	}
	public void updateReservation(ReservationVO vo) throws SQLException {
		dao.updateReservation(vo);
	}
	public void deleteReservation(ReservationVO vo) throws SQLException {
		dao.deleteReservation(vo);
	}
	//관리자 페이지 - 예약 관리
	public List<ReservationVO> listReservationForMng(SearchCriteria cri) throws SQLException{
		return dao.listReservationForMng(cri);
	}
	//관리자 페이지 - 예약 관리 - 예약 상세 modal Ajax
	public List<ReservationVO> listReservationForModal(String userno, String pno) throws SQLException {
		return dao.listReservationForModal(userno, pno);
	}
	public ReservationVO ReadCartByNoAndUserNo(int rno, int userno) throws SQLException {
		return dao.ReadCartByNoAndUserNo(rno,userno);
	}
	
}
