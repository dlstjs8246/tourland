package com.yi.tourland.persistance.mng.daoimpl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.AirplaneVO;
import com.yi.tourland.domain.mng.HotelVO;
import com.yi.tourland.domain.mng.ProductVO;
import com.yi.tourland.domain.mng.RentcarVO;
import com.yi.tourland.domain.mng.TourVO;
import com.yi.tourland.domain.mng.UserVO;
import com.yi.tourland.persistance.mng.dao.ProductDao;
@Repository
public class ProductDaoImpl implements ProductDao {
	@Autowired
	private SqlSession sqlSession;
	private static final String namespace = "mappers.mngMappers.productMapper.";
	@Override
	public List<ProductVO> productListPage(SearchCriteria cri) throws SQLException {
		return sqlSession.selectList(namespace + "productListPage",cri);
	}
	@Override
	public List<ProductVO> productListPageByDomestic(SearchCriteria cri) throws SQLException {
		return sqlSession.selectList(namespace + "productListPageByDomestic",cri);
	}
	@Override
	public List<ProductVO> productListPageByChina(SearchCriteria cri) throws SQLException {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + "productListPageByChina",cri);
	}
	@Override
	public List<ProductVO> productListPageByJapan(SearchCriteria cri) throws SQLException {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+"productListPageByJapan",cri);
	}
	@Override
	public int totalCountBySearchProduct(SearchCriteria cri) throws SQLException {
		return sqlSession.selectOne(namespace + "totalCountBySearchProduct",cri);
	}
	
	@Override
	public ProductVO productByNo(ProductVO vo) throws SQLException {
		return sqlSession.selectOne(namespace + "productByNo",vo);
	}

	@Override
	public void insertProduct(ProductVO vo) throws SQLException {
		sqlSession.insert(namespace + "insertProduct",vo);
	}
	@Override
	public void insertpAirStatus(ProductVO pvo, AirplaneVO avo) throws SQLException {
		Map<String,Object> map = new HashMap<>();
		map.put("p", pvo);
		map.put("a", avo);
		sqlSession.insert(namespace + "insertpAirStatus",map);
	}

	@Override
	public void insertpHotelStatus(ProductVO pvo, HotelVO hvo) throws SQLException {
		Map<String,Object> map = new HashMap<>();
		map.put("p", pvo);
		map.put("h", hvo);
		sqlSession.insert(namespace + "insertpHotelStatus",map);
	}

	@Override
	public void insertpTourStatus(ProductVO pvo, TourVO tvo) throws SQLException {
		Map<String,Object> map = new HashMap<>();
		map.put("p", pvo);
		map.put("t", tvo);
		sqlSession.insert(namespace + "insertpTourStatus",map);
		
	}

	@Override
	public void insertpRentcarStatus(ProductVO pvo, RentcarVO rvo) throws SQLException {
		Map<String,Object> map = new HashMap<>();
		map.put("p", pvo);
		map.put("r", rvo);
		sqlSession.insert(namespace + "insertpRentcarStatus",map);
		
	}

	@Override
	public void updateProduct(ProductVO vo) throws SQLException {
		sqlSession.update(namespace + "updateProduct",vo);
	}

	@Override
	public void updatepAirStatus(ProductVO pvo, AirplaneVO avo) throws SQLException {
		Map<String,Object> map = new HashMap<>();
		map.put("p", pvo);
		map.put("a", avo);
		sqlSession.update(namespace + "updatepAirStatus",map);
		
	}

	@Override
	public void updatepHotelStatus(ProductVO pvo, HotelVO hvo) throws SQLException {
		Map<String,Object> map = new HashMap<>();
		map.put("p", pvo);
		map.put("h", hvo);
		sqlSession.update(namespace + "updatepHotelStatus",map);
	}

	@Override
	public void updatepTourStatus(ProductVO pvo, TourVO tvo) throws SQLException {
		Map<String,Object> map = new HashMap<>();
		map.put("p", pvo);
		map.put("t", tvo);
		sqlSession.update(namespace + "updatepTourStatus",map);
		
	}

	@Override
	public void updatepRentStatus(ProductVO pvo, RentcarVO rvo) throws SQLException {
		Map<String,Object> map = new HashMap<>();
		map.put("p", pvo);
		map.put("r", rvo);
		sqlSession.update(namespace + "updatepRentStatus",map);
		
	}
	
	@Override
	public void deletepAirStatus(ProductVO pvo) throws SQLException {
		sqlSession.delete(namespace + "deletepAirStatus",pvo);
		
	}

	@Override
	public void deletepHotelStatus(ProductVO pvo) throws SQLException {
		sqlSession.delete(namespace + "deletepHotelStatus",pvo);
		
	}

	@Override
	public void deletepTourStatus(ProductVO pvo) throws SQLException {
		sqlSession.delete(namespace + "deletepTourStatus",pvo);
		
	}

	@Override
	public void deletepRentStatus(ProductVO pvo) throws SQLException {
		sqlSession.delete(namespace + "deletepRentStatus",pvo);
		
	}

	@Override
	public void deleteProduct(ProductVO vo) throws SQLException {
		sqlSession.delete(namespace + "deleteProduct",vo);
	}

	@Override
	public int totalCountProduct() throws SQLException {
		return sqlSession.selectOne(namespace + "totalCountProduct");
	}
	@Override
	public int totalCountBySearchProductDomestic(SearchCriteria cri) throws SQLException {
		return sqlSession.selectOne(namespace + "totalCountBySearchProductDomestic",cri);
	}
	@Override
	public int totalCountBySearchProductChina(SearchCriteria cri) throws SQLException {
		return sqlSession.selectOne(namespace + "totalCountBySearchProductChina",cri);
	}
	//상품 리스트 검색 박스 Ajax (중국)
	@Override
	public List<ProductVO> tourlandProductChinaSearchList(String ddate, String rdate, String cnt, String tourDays) throws SQLException {
		Map<String,Object> map = new HashMap<>();
		map.put("ddate", ddate);
		map.put("rdate", rdate);
		map.put("cnt", cnt);
		map.put("tourDays", tourDays);
		return sqlSession.selectList(namespace + "tourlandProductChinaSearchList", map);
	}
	@Override
	public int totalCountBySearchProductJapan(SearchCriteria cri) throws SQLException {
		return sqlSession.selectOne(namespace + "totalCountBySearchProductJapan",cri);
	}
	//상품 리스트 검색 박스 Ajax (일본)
	@Override
	public List<ProductVO> tourlandProductJapanSearchList(String ddate, String rdate, String cnt, String tourDays) throws SQLException {
		Map<String,Object> map = new HashMap<>();
		map.put("ddate", ddate);
		map.put("rdate", rdate);
		map.put("cnt", cnt);
		map.put("tourDays", tourDays);
		return sqlSession.selectList(namespace + "tourlandProductJapanSearchList", map);
	}
	//상품 리스트 검색 박스 Ajax (제주)
	@Override
	public List<ProductVO> tourlandProductKRSearchList(String ddate, String rdate, String cnt, String tourDays) throws SQLException {
		Map<String,Object> map = new HashMap<>();
		map.put("ddate", ddate);
		map.put("rdate", rdate);
		map.put("cnt", cnt);
		map.put("tourDays", tourDays);
		return sqlSession.selectList(namespace + "tourlandProductKRSearchList", map);
	}
	
	//상품 리스트 검색 박스 Ajax "낮은 가격 순" (중국)
	@Override
	public List<ProductVO> tourlandProductChinaSearchLowPriceList(SearchCriteria cri) throws SQLException {
		return sqlSession.selectList(namespace + "tourlandProductChinaSearchLowPriceList", cri);
	}
	
	//상품 리스트 검색 박스 Ajax "낮은 가격 순"  (일본)
	@Override
	public List<ProductVO> tourlandProductJapanSearchLowPriceList(SearchCriteria cri) throws SQLException {
		return sqlSession.selectList(namespace + "tourlandProductJapanSearchLowPriceList", cri);
	}
	//상품 리스트 검색 박스 Ajax "낮은 가격 순"  (제주)
	@Override
	public List<ProductVO> tourlandProductKRSearchLowPriceList(SearchCriteria cri) throws SQLException {
		return sqlSession.selectList(namespace + "tourlandProductKRSearchLowPriceList", cri);
	}
	@Override
	public void insertpUserStatus(UserVO uvo, ProductVO pvo) throws SQLException {
		Map<String,Object> map = new HashMap<>();
		map.put("u", uvo);
		map.put("p", pvo);
		sqlSession.insert(namespace + "insertpUserStatus",map);
	}
	
}
