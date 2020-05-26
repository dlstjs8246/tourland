package com.yi.tourland.persistance.mng.daoimpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yi.tourland.domain.Criteria;
import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.PopupVO;
import com.yi.tourland.persistance.mng.dao.PopupDAO;

@Repository
public class PopupDAOImpl implements PopupDAO {
	private static final String namespace = "mappers.mngMappers.PopupMapper.";

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertPopup(PopupVO vo) throws Exception {
		sqlSession.insert(namespace+"insertPopup",vo);
		
	}

	@Override
	public PopupVO readByNoPopup(int no) throws Exception {
		return sqlSession.selectOne(namespace+"readByNoPopup",no);
	}

	@Override
	public void updatePopup(PopupVO vo) throws Exception {
		sqlSession.update(namespace+"updatePopup",vo);
		
	}

	@Override
	public void deletePopup(int no) throws Exception {
		sqlSession.delete(namespace+"deletePopup",no);
		
	}

	@Override
	public List<PopupVO> listCriteriaPopup(Criteria cri) throws Exception {
		return sqlSession.selectList(namespace+"listCriteriaPopup", cri);
	}

	@Override
	public int totalCountPopup() throws Exception {
		return sqlSession.selectOne(namespace+"totalCountPopup");
	}

	@Override
	public List<PopupVO> listSearchCriteriaPopup(SearchCriteria cri) throws Exception {
		return sqlSession.selectList(namespace+"listSearchCriteriaPopup",cri);
	}

	@Override
	public int totalSearchCountPopup(SearchCriteria cri) throws Exception {
		return sqlSession.selectOne(namespace+"totalSearchCountPopup",cri);
	}

	@Override
	public PopupVO setPopup(String position) throws Exception {
		return sqlSession.selectOne(namespace+"setPopup",position);
	}

	@Override
	public List<PopupVO> setPopupList(String position) throws Exception {
		return sqlSession.selectList(namespace+"setPopupList",position);
	}


	
	
}
