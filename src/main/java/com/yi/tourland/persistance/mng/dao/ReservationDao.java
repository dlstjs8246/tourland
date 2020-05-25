package com.yi.tourland.persistance.mng.dao;

import java.sql.SQLException;
import java.util.List;

import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.ReservationVO;
import com.yi.tourland.domain.mng.UserVO;

public interface ReservationDao {
	public void insertReservation(ReservationVO vo) throws SQLException;
	public List<ReservationVO> listReservation(SearchCriteria cri) throws SQLException;
	public List<ReservationVO> ReadReservationByUserNo(UserVO vo,SearchCriteria cri) throws SQLException;
	public List<ReservationVO> ReadCartByUserNo(UserVO vo,SearchCriteria cri) throws SQLException;
	public int totalSearchReservationCount(SearchCriteria cri) throws SQLException;
	public int totalSearchReservationCountByUserNo(SearchCriteria cri,UserVO vo) throws SQLException;
	public int totalSearchCartCountByUserNo(SearchCriteria cri,UserVO vo) throws SQLException;
	public void updateReservation(ReservationVO vo) throws SQLException;
	public void deleteReservation(ReservationVO vo) throws SQLException;
}
