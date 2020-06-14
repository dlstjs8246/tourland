package com.yi.tourland.persistance.mng.daoimpl;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yi.tourland.domain.mng.StatisticVO;
import com.yi.tourland.persistance.mng.dao.StatisticDao;
@Repository
public class StatisticDaoImpl implements StatisticDao {
	@Autowired
	private SqlSession sqlSession;
	private static final String namespace = "mappers.mngMappers.statisticMapper.";

	@Override
	public List<StatisticVO> searchTotalCountByLocation() throws SQLException {
		return sqlSession.selectList(namespace + "searchTotalCountByLocation");
	}

	@Override
	public List<StatisticVO> searchTotalPriceJejuByMonth() throws SQLException {
		return sqlSession.selectList(namespace + "searchTotalPriceJejuByMonth");
	}

	@Override
	public List<StatisticVO> searchTotalPriceDokyoByMonth() throws SQLException {
		return sqlSession.selectList(namespace + "searchTotalPriceDokyoByMonth");
	}

	@Override
	public List<StatisticVO> searchTotalPriceBeijingByMonth() throws SQLException {
		return sqlSession.selectList(namespace + "searchTotalPriceBeijingByMonth");
	}

}
