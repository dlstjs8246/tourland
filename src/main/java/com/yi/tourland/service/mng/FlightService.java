package com.yi.tourland.service.mng;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.AirplaneVO;
import com.yi.tourland.persistance.mng.dao.FlightDAO;

@Service
public class FlightService {
	
	@Autowired
	private FlightDAO dao;
	
	public List<AirplaneVO> airplaneList(SearchCriteria cri) throws Exception{
		return dao.airplaneList(cri);
	}
	public List<AirplaneVO> airplaneListByDepature(SearchCriteria cri) throws Exception{
		return dao.airplaneListByDepature(cri);
	}
	public List<AirplaneVO> airplaneListByRending(SearchCriteria cri) throws Exception{
		return dao.airplaneListByRending(cri);
	}
	public int totalCountAirplane (SearchCriteria cri) throws Exception {
		return dao.totalCountAirplane(cri);
	}
	public int totalCountAirplaneByDepature (SearchCriteria cri) throws Exception {
		return dao.totalCountAirplaneByDepature(cri);
	}
	public int totalCountAirplaneByRending (SearchCriteria cri) throws Exception {
		return dao.totalCountAirplaneByRending(cri);
	}
	public AirplaneVO airplaneByNo(AirplaneVO vo) throws SQLException {
		return dao.airplaneByNo(vo);
	}
}
