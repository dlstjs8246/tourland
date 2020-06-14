package com.yi.tourland.service.mng;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yi.tourland.domain.mng.ReviewVO;
import com.yi.tourland.persistance.mng.dao.ReviewDao;
@Service
public class ReviewService {
	@Autowired
	ReviewDao dao;
	
	//리뷰 추가
	public void addReview (ReviewVO vo) throws SQLException {
		dao.addReview(vo);
	}
	//해당 상품이 리뷰가 있는지 확인
	public List<ReviewVO> checkReviewExists() throws SQLException {
		return dao.checkReviewExists();
	} 
	//상품번호와 같은 리뷰 조회하기
	public ReviewVO readReviewByRno(ReviewVO vo) throws SQLException {
		return dao.readReviewByRno(vo);
	}
	
}
