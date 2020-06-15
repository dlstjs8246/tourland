package com.yi.tourland.service.mng;

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
	//항공편 전체 리스트
	public List<AirplaneVO> airplaneList(SearchCriteria cri) throws Exception{
		return dao.airplaneList(cri);
	}
	//항공편 국내 리스트
	public List<AirplaneVO> airplaneDomList(SearchCriteria cri) throws Exception{
		return dao.airplaneDomList(cri);
	}
	//항공편 해외 리스트
	public List<AirplaneVO> airplaneAbroadList(SearchCriteria cri) throws Exception{
		return dao.airplaneAbroadList(cri);
	}
	public List<AirplaneVO> airplaneListByDepature(SearchCriteria cri) throws Exception{
		return dao.airplaneListByDepature(cri);
	}
	public List<AirplaneVO> airplaneListByRending(AirplaneVO vo) throws Exception{
		return dao.airplaneListByRending(vo);
	}
	//항공편 전체 숫자
	public int totalCountAirplane (SearchCriteria cri) throws Exception {
		return dao.totalCountAirplane(cri);
	}
	public int totalCountAirplaneByDepature (SearchCriteria cri) throws Exception {
		return dao.totalCountAirplaneByDepature(cri);
	}
	public int totalCountAirplaneByRending (AirplaneVO vo) throws Exception {
		return dao.totalCountAirplaneByRending(vo);
	}
	public int totalAllCountAirplane() throws Exception{
		return dao.totalAllCountAirplane();
	}
	//항공편 번호로 검색
	public AirplaneVO airplaneByNo(AirplaneVO vo) throws Exception {
		return dao.airplaneByNo(vo);
	}
	//항공 추가
	public void addAirplane(AirplaneVO vo) throws Exception{
		 dao.addAirplane(vo);
	}
	//항공 삭제
	public void removeAirplane(int no) throws Exception{
		dao.removeAirplane(no);
	}
	//항공 수정
	public void editAirplane(AirplaneVO vo) throws Exception{
		dao.editAirplane(vo);
	}
}
