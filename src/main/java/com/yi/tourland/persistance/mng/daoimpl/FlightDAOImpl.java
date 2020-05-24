package com.yi.tourland.persistance.mng.daoimpl;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.AirplaneVO;
import com.yi.tourland.persistance.mng.dao.FlightDAO;

@Repository
public class FlightDAOImpl implements FlightDAO {
	
	@Autowired
	private static final String namespace = "mappers.mngMappers.FlightMapper.";
	@Autowired
	private SqlSession sqlSession;
	       
	//항공편 전체 리스트
	@Override
	public List<AirplaneVO> airplaneList(SearchCriteria cri) throws Exception {
		return sqlSession.selectList(namespace + "airplaneList", cri);
	}
	
	//항공편 국내 리스트
	@Override
	public List<AirplaneVO> airplaneDomList(SearchCriteria cri) throws Exception {
		return sqlSession.selectList(namespace + "airplaneDomList", cri);
	}
	//항공편 해외 리스트
	@Override
	public List<AirplaneVO> airplaneAbroadList(SearchCriteria cri) throws Exception {
		return sqlSession.selectList(namespace + "airplaneAbroadList", cri);
	}
	//항공 전체 갯수
	@Override   
	public int totalCountAirplane(SearchCriteria cri) throws Exception {
		return sqlSession.selectOne(namespace + "totalCountAirplane", cri);
	}
	//번호로 검색
	@Override
	public AirplaneVO airplaneByNo(AirplaneVO vo) throws SQLException {
		return sqlSession.selectOne(namespace + "airplaneByNo",vo);
	}
	
	@Override
	public List<AirplaneVO> airplaneListByDepature(SearchCriteria cri) throws Exception {
		return sqlSession.selectList(namespace + "airplaneListByDepature",cri);
	}

	@Override
	public List<AirplaneVO> airplaneListByRending(AirplaneVO vo) throws Exception {
		return sqlSession.selectList(namespace + "airplaneListByRending",vo);
	}

	@Override
	public int totalCountAirplaneByDepature(SearchCriteria cri) throws Exception {
		return sqlSession.selectOne(namespace + "totalCountAirplaneByDepature", cri);
	}

	@Override
	public int totalCountAirplaneByRending(AirplaneVO vo) throws Exception {
		return sqlSession.selectOne(namespace + "totalCountAirplaneByRending", vo);
	}
	@Override
	public int totalCountAirplaneByReserv() throws SQLException {
		return sqlSession.selectOne(namespace + "totalCountAirplaneByReserv");
	}
	//항공 추가
	@Override
	public void addAirplane(AirplaneVO vo) throws Exception {
		sqlSession.insert(namespace + "addAirplane", vo);
	}
	//항공 삭제
	@Override
	public void removeAirplane(int no) throws Exception {
		sqlSession.delete(namespace + "removeAirplane", no);
	}
	//항공 수정
	@Override
	public void editAirplane(AirplaneVO vo) throws Exception {
		sqlSession.update(namespace + "editAirplane", vo);
	}


}
