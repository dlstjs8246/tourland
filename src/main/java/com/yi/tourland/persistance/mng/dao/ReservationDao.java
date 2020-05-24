package com.yi.tourland.persistance.mng.dao;

import java.sql.SQLException;
import java.util.List;

import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.ReservationVO;

public interface ReservationDao {
	public void insertReservation(ReservationVO vo) throws SQLException;
	public List<ReservationVO> listReservation(SearchCriteria cri) throws SQLException;
	public ReservationVO ReadReservationByNo(ReservationVO vo) throws SQLException;
	public int totalSearchReservationCount(SearchCriteria cri) throws SQLException;
	public void updateReservation(ReservationVO vo) throws SQLException;
	public void deleteReservation(ReservationVO vo) throws SQLException;
}
