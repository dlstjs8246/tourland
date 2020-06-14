package com.yi.tourland.persistance.mng.daoimpl;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yi.tourland.domain.mng.ReviewVO;
import com.yi.tourland.persistance.mng.dao.ReviewDao;
@Repository
public class ReviewDaoImpl implements ReviewDao {
	@Autowired
	private SqlSession sqlSession;
	private static final String namespace = "mappers.mngMappers.ReviewMapper.";
	
	@Override
	public void addReview(ReviewVO vo) throws SQLException {
		sqlSession.insert(namespace + "addReview", vo);
	}

	@Override
	public List<ReviewVO> checkReviewExists() throws SQLException {
		return sqlSession.selectList(namespace + "checkReviewExists");
	}

	@Override
	public List<ReviewVO> readReviewByUserno(int userno) throws SQLException {
		return sqlSession.selectList(namespace + "readReviewByUserno", userno);
	}
	
	
}
