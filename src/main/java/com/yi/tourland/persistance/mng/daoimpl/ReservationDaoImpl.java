package com.yi.tourland.persistance.mng.daoimpl;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.ReservationVO;
import com.yi.tourland.persistance.mng.dao.ReservationDao;
@Repository
public class ReservationDaoImpl implements ReservationDao {
	@Autowired
	private SqlSession sqlSession;
	private static final String namespace = "mappers.mngMappers.reservationMapper.";
	@Override
	public void insertReservation(ReservationVO vo) throws SQLException {
		sqlSession.insert(namespace + "insertReservation",vo);
	}

	@Override
	public List<ReservationVO> listReservation(SearchCriteria cri) throws SQLException {
		return sqlSession.selectList(namespace + "listReservation",cri);
	}

	@Override
	public ReservationVO ReadReservationByNo(ReservationVO vo) throws SQLException {
		return sqlSession.selectOne(namespace + "ReadReservationByNo",vo);
	}

	@Override
	public int totalSearchReservationCount(SearchCriteria cri) throws SQLException {
		return sqlSession.selectOne(namespace + "totalSearchReservationCount",cri);
	}

	@Override
	public void updateReservation(ReservationVO vo) throws SQLException {
		sqlSession.update(namespace + "updateReservation",vo);
	}

	@Override
	public void deleteReservation(ReservationVO vo) throws SQLException {
		sqlSession.delete(namespace + "deleteReservation",vo);
	}
}
