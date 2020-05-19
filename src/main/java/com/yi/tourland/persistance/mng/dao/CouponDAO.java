package com.yi.tourland.persistance.mng.dao;

import java.util.List;

import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.CouponVO;
import com.yi.tourland.domain.mng.UserVO;

public interface CouponDAO {
	//쿠폰 리스트
	public List<CouponVO> couponList(SearchCriteria cri) throws Exception;
	//쿠폰 유저 리스트
	public List<CouponVO> couponUserList(SearchCriteria cri) throws Exception;	
	//쿠폰 전체 갯수
	public int totalCountCoupon(SearchCriteria cri) throws Exception;
	//쿠폰 추가
	public void addCoupon(CouponVO coupon) throws Exception;
	//쿠폰 번호로 쿠폰 객체 불러오기
	public CouponVO readCouponByNo(int cno) throws Exception;
	//쿠폰 삭제
	public void removeCoupon(int cno) throws Exception;
	//쿠폰 수정
	public void editCoupon(CouponVO coupon) throws  Exception;
	//해당 고객의 쿠폰
	public List<CouponVO> userCouponList(UserVO vo) throws Exception;
	public void editCouponNo1(CouponVO coupon) throws Exception;
}
