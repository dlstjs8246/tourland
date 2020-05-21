package com.yi.tourland.service.mng;

import java.io.File;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yi.tourland.domain.Criteria;
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
	public List<ProductVO> productListPageByDomestic(SearchCriteria cri) throws SQLException {
		return dao.productListPageByDomestic(cri);
	}
	public List<ProductVO> productListPageByChina(SearchCriteria cri) throws SQLException {
		return dao.productListPageByChina(cri);
	}
	public List<ProductVO> productListPageByJapan(SearchCriteria cri) throws SQLException {
		return dao.productListPageByJapan(cri);
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
			System.out.println(rvo.getNo());
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
	public int totalCountProduct() throws SQLException {
		return dao.totalCountProduct();
	}
	public int totalCountBySearchProductDomestic(SearchCriteria cri) throws SQLException {
		return dao.totalCountBySearchProductDomestic(cri);
	}
	public int totalCountBySearchProductChina(SearchCriteria cri) throws SQLException {
		return dao.totalCountBySearchProductChina(cri);
	}
	public int totalCountBySearchProductJapan(SearchCriteria cri) throws SQLException {
		return dao.totalCountBySearchProductJapan(cri);
	}
	//고객 페이지 - 중국 패키지 검색 박스 Ajax 
	public List<ProductVO> tourlandProductChinaSearchList(String ddate, String rdate, String cnt, String tourDays) throws SQLException{
		return dao.tourlandProductChinaSearchList(ddate, rdate, cnt, tourDays);
	};
	//고객 페이지 - 일본 패키지 검색 박스 Ajax 
	public List<ProductVO> tourlandProductJapanSearchList(String ddate, String rdate, String cnt, String tourDays) throws SQLException{
		return dao.tourlandProductJapanSearchList(ddate, rdate, cnt, tourDays);
	};
	//고객 페이지 - 제주 패키지 검색 박스 Ajax 
		public List<ProductVO> tourlandProductKRSearchList(String ddate, String rdate, String cnt, String tourDays) throws SQLException{
			return dao.tourlandProductKRSearchList(ddate, rdate, cnt, tourDays);
		};
		
	// 고객 페이지 - 중국 패키지 검색 박스 "낮은 가격 순 " Ajax
	public List<ProductVO> tourlandProductChinaSearchLowPriceList(SearchCriteria cri) throws SQLException {
		return dao.tourlandProductChinaSearchLowPriceList(cri);
	};

	// 고객 페이지 - 일본 패키지 검색 박스 "낮은 가격 순 "  Ajax
	public List<ProductVO> tourlandProductJapanSearchLowPriceList(SearchCriteria cri) throws SQLException {
		return dao.tourlandProductJapanSearchLowPriceList(cri);
	};

	// 고객 페이지 - 제주 패키지 검색 박스 "낮은 가격 순 "  Ajax
	public List<ProductVO> tourlandProductKRSearchLowPriceList(SearchCriteria cri) throws SQLException {
		return dao.tourlandProductKRSearchLowPriceList(cri);
	};
}
