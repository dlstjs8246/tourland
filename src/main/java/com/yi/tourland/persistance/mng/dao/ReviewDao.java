package com.yi.tourland.persistance.mng.dao;

import java.sql.SQLException;
import java.util.List;

import com.yi.tourland.domain.mng.ReviewVO;

public interface ReviewDao {
	
	//리뷰 추가
	public void addReview (ReviewVO vo) throws SQLException;
	//리뷰 있는지 확인
	public List<ReviewVO> checkReviewExists() throws SQLException; 
}
