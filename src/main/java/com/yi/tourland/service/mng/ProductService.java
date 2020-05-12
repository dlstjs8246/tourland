package com.yi.tourland.service.mng;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.AirplaneVO;
import com.yi.tourland.domain.mng.HotelVO;
import com.yi.tourland.domain.mng.ProductVO;
import com.yi.tourland.domain.mng.RentcarVO;
import com.yi.tourland.domain.mng.TourVO;
import com.yi.tourland.persistance.mng.dao.ProductDao;

@Service
public class ProductService {
	@Autowired
	private ProductDao dao;	
	public List<ProductVO> listPage(SearchCriteria cri) throws SQLException {
		return dao.productListPage(cri);
	}
	public ProductVO productByNo(ProductVO vo) throws SQLException {
		return dao.productByNo(vo);
	}
	@Transactional
	public void insertProduct(ProductVO pvo) throws SQLException {
		dao.insertProduct(pvo);
		for(AirplaneVO avo :pvo.getAir()) {
			dao.insertpAirStatus(pvo, avo);
		}
		for(HotelVO hvo : pvo.getHotel()) {
			dao.insertpHotelStatus(pvo, hvo);
		}
		for(TourVO tvo : pvo.getTour()) {
			dao.insertpTourStatus(pvo, tvo);
		}
		for(RentcarVO rvo : pvo.getRentcar()) {
			dao.insertpRentcarStatus(pvo, rvo);
		}	
	}
	@Transactional
	public void updateProduct(ProductVO pvo) throws SQLException {
		dao.updateProduct(pvo);
		for(AirplaneVO avo :pvo.getAir()) {
			dao.updatepAirStatus(pvo, avo);
		}
		for(HotelVO hvo : pvo.getHotel()) {
			dao.updatepHotelStatus(pvo, hvo);
		}
		for(TourVO tvo : pvo.getTour()) {
			dao.updatepTourStatus(pvo, tvo);
		}
		for(RentcarVO rvo : pvo.getRentcar()) {
			dao.updatepRentStatus(pvo, rvo);
		}	
	}
	@Transactional
	public void deleteProduct(ProductVO pvo) throws SQLException {
		dao.deletepAirStatus(pvo);
		dao.deletepHotelStatus(pvo);
		dao.deletepTourStatus(pvo);
		dao.deletepRentStatus(pvo);
		dao.deleteProduct(pvo);
	}
	public int totalCountBySearchProduct(SearchCriteria cri) throws SQLException {
		return dao.totalCountBySearchProduct(cri);
	}
}