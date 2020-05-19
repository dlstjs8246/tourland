package com.yi.tourland.persistance.mng.daoimpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.CouponVO;
import com.yi.tourland.domain.mng.UserVO;
import com.yi.tourland.persistance.mng.dao.CouponDAO;

@Repository
public class CouponDAOImpl implements CouponDAO {
	private static final String namespace = "mappers.mngMappers.CouponMapper.";  
	
	@Autowired
	private SqlSession sqlSession;
	//쿠폰 전체 리스트
	public List<CouponVO> couponList(SearchCriteria cri) throws Exception {
		return sqlSession.selectList(namespace + "couponList", cri);
	}
	//쿠폰 전체 갯수
	@Override
	public int totalCountCoupon(SearchCriteria cri) throws Exception {
		return sqlSession.selectOne(namespace + "totalCountCoupon", cri);
	}
	//쿠폰 추가
	@Override
	public void addCoupon(CouponVO coupon) throws Exception {
		sqlSession.insert(namespace + "addCoupon", coupon);
	}
	//쿠폰 번호로 쿠폰 객체 불러오기
	@Override
	public CouponVO readCouponByNo(int cno) throws Exception {
		return sqlSession.selectOne(namespace + "readCouponByNo", cno);
	}
	//쿠폰 삭제
	@Override
	public void removeCoupon(int cno) throws Exception {
		sqlSession.delete(namespace + "removeCoupon", cno);
	}
	//쿠폰 수정
	@Override
	public void editCoupon(CouponVO coupon) throws Exception {
		sqlSession.update(namespace + "editCoupon" , coupon);
	}
	@Override
	public List<CouponVO> couponUserList(SearchCriteria cri) throws Exception {
		return sqlSession.selectList(namespace+"couponUserList", cri);
	}
	@Override
	public List<CouponVO> userCouponList(UserVO vo) throws Exception {
		/*
		 * Map<String,Object> map = new HashMap<>(); map.put("cri", cri); map.put("vo",
		 * vo);
		 */
		return sqlSession.selectList(namespace + "userCouponList", vo);
	}
	@Override
	public void editCouponNo1(CouponVO coupon) throws Exception {
		sqlSession.update(namespace + "editCouponNo1", coupon);
	}
}
