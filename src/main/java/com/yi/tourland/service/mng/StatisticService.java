package com.yi.tourland.service.mng;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yi.tourland.domain.mng.StatisticVO;
import com.yi.tourland.persistance.mng.dao.StatisticDao;

@Service
public class StatisticService {
	@Autowired
	private StatisticDao dao;
	public List<StatisticVO> searchTotalPriceJejuByMonth() throws SQLException {
		return dao.searchTotalPriceJejuByMonth();
	}
	public List<StatisticVO> searchTotalPriceDokyoByMonth() throws SQLException {
		return dao.searchTotalPriceDokyoByMonth();
	}
	public List<StatisticVO> searchTotalPriceBeijingByMonth() throws SQLException {
		return dao.searchTotalPriceBeijingByMonth();
	}
	public List<StatisticVO> searchTotalCountByLocation() throws SQLException {
		return dao.searchTotalCountByLocation();
	}
}
