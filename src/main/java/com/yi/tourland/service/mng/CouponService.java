package com.yi.tourland.service.mng;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.CouponVO;
import com.yi.tourland.domain.mng.UserVO;
import com.yi.tourland.persistance.mng.dao.CouponDAO;

@Service
public class CouponService {
	
	@Autowired
	CouponDAO dao;
	
	//쿠폰 전체 리스트
	public List<CouponVO> couponList(SearchCriteria cri) throws Exception{
		return dao.couponList(cri);
	}
	//쿠폰 유저 리스트
	public List<CouponVO> couponUserList(SearchCriteria cri) throws Exception{
		return dao.couponUserList(cri);
	}
	//쿠폰 총 갯수
	public int totalCountNotice (SearchCriteria cri) throws Exception {
		return dao.totalCountCoupon(cri);
	}
	//쿠폰 추가
	public void addCoupon (CouponVO coupon) throws Exception{
		dao.addCoupon(coupon);
	}
	//쿠폰 번호로 쿠폰 객체 불러오기
	public CouponVO readCouponByNo(int cno) throws Exception{
		return dao.readCouponByNo(cno);
	}
	//쿠폰 삭제
	public void removeCoupon(int cno) throws Exception {
		dao.removeCoupon(cno);
	}
	//쿠폰 수정
	public void editCoupon(CouponVO coupon) throws Exception{
		dao.editCoupon(coupon);
	}
	//해당 유저의 쿠폰 확인
	public List<CouponVO> userCouponList(UserVO vo) throws Exception {
		return dao.userCouponList(vo);
	}
	public void editCouponNo1(CouponVO coupon) throws Exception{
		dao.editCouponNo1(coupon);
	}
}
