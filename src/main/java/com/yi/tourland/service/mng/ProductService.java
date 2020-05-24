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
import com.yi.tourland.domain.mng.ReservationVO;
import com.yi.tourland.domain.mng.TourVO;
import com.yi.tourland.domain.mng.UserVO;
import com.yi.tourland.persistance.mng.dao.FlightDAO;
import com.yi.tourland.persistance.mng.dao.HotelDAO;
import com.yi.tourland.persistance.mng.dao.ProductDao;
import com.yi.tourland.persistance.mng.dao.RentcarDAO;
import com.yi.tourland.persistance.mng.dao.ReservationDao;
import com.yi.tourland.persistance.mng.dao.TourDao;

@Service
public class ProductService {
	@Autowired
	private FlightDAO adao;
	@Autowired
	private HotelDAO hdao;
	@Autowired
	private TourDao tdao;
	@Autowired
	private RentcarDAO rdao;
	@Autowired
	private ProductDao dao;	
	@Autowired
	private ReservationDao reservDao;
	
	
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
	@Transactional
	public void insertUserProduct(ProductVO pvo,ProductVO upvo, UserVO uvo, SearchCriteria cri) throws Exception {
		//선택한 상품 옵션들의 인원수에 따라 전체 상품 옵션들 update
		for(int i=0;i<pvo.getAir().size();i++) {
			for(int j=0;j<upvo.getAir().size();j++) {
				if(pvo.getAir().get(i).getNo()==upvo.getAir().get(j).getNo()) {
					if(pvo.getAir().get(i).getCapacity()<=0) {
						return;
					}
					pvo.getAir().get(i).setCapacity(pvo.getAir().get(i).getCapacity() - upvo.getAir().get(j).getCapacity());
					adao.editAirplane(pvo.getAir().get(i));
				}
				else {
					continue;
				}
			}
		}
		for(int i=0;i<pvo.getHotel().size();i++) {
			for(int j=0;j<upvo.getHotel().size();j++) {
				if(pvo.getHotel().get(i).getNo()==upvo.getHotel().get(j).getNo()) {
					if(pvo.getHotel().get(i).getTotalcapacity()<=0) {
						pvo.getHotel().get(i).setBookedup(1);
						hdao.updateHotel(pvo.getHotel().get(i));
						return;
					}
					pvo.getHotel().get(i).setTotalcapacity(pvo.getHotel().get(i).getTotalcapacity() - upvo.getHotel().get(j).getTotalcapacity());
					hdao.updateHotel(pvo.getHotel().get(i));
				}
				else {
					continue;
				}
			}
		}
		for(int i=0;i<pvo.getTour().size();i++) {
			for(int j=0;j<upvo.getTour().size();j++) {
				if(pvo.getTour().get(i).getNo()==upvo.getTour().get(j).getNo()) {
					if(pvo.getTour().get(i).getCapacity()<=0) {
						return;
					}
					pvo.getTour().get(i).setCapacity(pvo.getTour().get(i).getCapacity() - upvo.getTour().get(j).getCapacity());
					tdao.updateTour(pvo.getTour().get(i));
				}
				else {
					continue;
				}
			}
		}
		for(int i=0;i<pvo.getRentcar().size();i++) {
			for(int j=0;j<upvo.getRentcar().size();j++) {
				if(pvo.getRentcar().get(i).getNo()==upvo.getRentcar().get(j).getNo()) {
					if(pvo.getRentcar().get(i).getCapacity()<=0) {
						return;
					}
					pvo.getRentcar().get(i).setCapacity(pvo.getRentcar().get(i).getCapacity() - upvo.getRentcar().get(j).getCapacity());
					rdao.updateRentcar(pvo.getRentcar().get(i));
				}
				else {
					continue;
				}
			}
		}
		//선택한 상품 옵션들 insert
		for(AirplaneVO vo : upvo.getAir()) {
			vo.setNo(adao.totalCountAirplane(cri)+1);
			adao.addAirplane(vo);
		}
		for(HotelVO vo : upvo.getHotel()) {
			vo.setNo(hdao.totalSearchCountHotel(cri)+1);
			hdao.insertHotel(vo);
		}
		for(TourVO vo : upvo.getTour()) {
			vo.setNo(tdao.totalCountBySearchCriteria(cri)+1);
			tdao.insertTour(vo);
		}
		for(RentcarVO vo : upvo.getRentcar()) {
			vo.setNo(rdao.totalSearchCountRentcar(cri)+1);
			rdao.insertRentcar(vo);
		}
		//새로운 상품 insert
		insertProduct(upvo);
		dao.insertpUserStatus(uvo, upvo);
	}
	// userpstatus
		public void tourlandProductUserPStatus(UserVO user, ProductVO product) throws SQLException {
			 dao.tourlandProductUserPStatus(user, product);
		};
}
