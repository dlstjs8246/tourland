package com.yi.tourland.persistance.mng.dao;

import java.sql.SQLException;
import java.util.List;

import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.AirplaneVO;
import com.yi.tourland.domain.mng.HotelVO;
import com.yi.tourland.domain.mng.ProductVO;
import com.yi.tourland.domain.mng.RentcarVO;
import com.yi.tourland.domain.mng.ReservationVO;
import com.yi.tourland.domain.mng.TourVO;
import com.yi.tourland.domain.mng.UserVO;

public interface ProductDao {
	public List<ProductVO> productListPage(SearchCriteria cri) throws SQLException;
	public List<ProductVO> productListPageByDomestic(SearchCriteria cri) throws SQLException;
	public List<ProductVO> productListPageByChina(SearchCriteria cri) throws SQLException;
	public List<ProductVO> productListPageByJapan(SearchCriteria cri) throws SQLException;
	public ProductVO productByNo(ProductVO vo) throws SQLException;
	public void insertProduct(ProductVO vo) throws SQLException;
	public void insertpAirStatus(ProductVO pvo, AirplaneVO avo) throws SQLException;
	public void insertpHotelStatus(ProductVO pvo, HotelVO hvo) throws SQLException;
	public void insertpTourStatus(ProductVO pvo, TourVO tvo) throws SQLException;
	public void insertpRentcarStatus(ProductVO pvo, RentcarVO rvo) throws SQLException;
	public void insertpUserStatus(ReservationVO rvo, UserVO uvo, ProductVO pvo) throws SQLException;
	public void updateProduct(ProductVO vo) throws SQLException;
	public void updatepAirStatus(ProductVO pvo, AirplaneVO avo) throws SQLException;
	public void updatepHotelStatus(ProductVO pvo, HotelVO hvo) throws SQLException;
	public void updatepTourStatus(ProductVO pvo, TourVO tvo) throws SQLException;
	public void updatepRentStatus(ProductVO pvo, RentcarVO rvo) throws SQLException;
	public void deleteUserpStatus(ProductVO pvo, ReservationVO rvo) throws SQLException;
	public void deletepAirStatus(ProductVO pvo) throws SQLException;
	public void deletepHotelStatus(ProductVO pvo) throws SQLException;
	public void deletepTourStatus(ProductVO pvo) throws SQLException;
	public void deletepRentStatus(ProductVO pvo) throws SQLException;
	public void deleteProduct(ProductVO vo) throws SQLException;
	public int totalCountBySearchProduct(SearchCriteria cri) throws SQLException;
	public int totalCountBySearchProductDomestic(SearchCriteria cri) throws SQLException;
	public int totalCountBySearchProductChina(SearchCriteria cri) throws SQLException;
	public int totalCountBySearchProductJapan(SearchCriteria cri) throws SQLException;
	public int totalCountProduct() throws SQLException;
	// 상품 리스트 검색 박스 Ajax (중국) 
	public List<ProductVO> tourlandProductChinaSearchList(String ddate, String rdate, String cnt, String tourDays) throws SQLException; 
	// 상품 리스트 검색 박스 Ajax (일본) 
	public List<ProductVO> tourlandProductJapanSearchList(String ddate, String rdate, String cnt, String tourDays) throws SQLException; 
	// 상품 리스트 검색 박스 Ajax (제주) 
	public List<ProductVO> tourlandProductKRSearchList(String ddate, String rdate, String cnt, String tourDays) throws SQLException;
	// 상품 리스트 검색 박스 Ajax "낮은 가격 순" (중국) 
	public List<ProductVO> tourlandProductChinaSearchLowPriceList(SearchCriteria cri) throws SQLException; 
	// 상품 리스트 검색 박스 Ajax "낮은 가격 순"  (일본) 
	public List<ProductVO> tourlandProductJapanSearchLowPriceList(SearchCriteria cri) throws SQLException; 
	// 상품 리스트 검색 박스 Ajax "낮은 가격 순" (제주) 
	public List<ProductVO> tourlandProductKRSearchLowPriceList(SearchCriteria cri) throws SQLException;
	
	
}
