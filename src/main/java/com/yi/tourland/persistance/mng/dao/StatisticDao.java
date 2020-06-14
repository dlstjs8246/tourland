package com.yi.tourland.persistance.mng.dao;

import java.sql.SQLException;
import java.util.List;

import com.yi.tourland.domain.mng.StatisticVO;

public interface StatisticDao {
	public List<StatisticVO> searchTotalPriceJejuByMonth() throws SQLException;
	public List<StatisticVO> searchTotalPriceDokyoByMonth() throws SQLException;
	public List<StatisticVO> searchTotalPriceBeijingByMonth() throws SQLException;
	public List<StatisticVO> searchTotalCountByLocation() throws SQLException;
}
