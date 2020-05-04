package com.yi.tourland.persistance.mng.daoimpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.yi.tourland.domain.Criteria;
import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.UserVO;
import com.yi.tourland.persistance.mng.dao.UserDAO;
@Repository
public class UserDAOImpl implements UserDAO{

   private static final String namespace ="mappers.mngMappers.UserMapper.";
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@Override
	public void insertUser(UserVO vo) throws Exception {
		sqlSession.insert(namespace+"insertUser",vo);
		
	}

	@Override
	public UserVO readByNoUser(int userno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+"readByNoUser", userno);
	}

	@Override
	public void updateUser(UserVO vo) throws Exception {
		sqlSession.update(namespace+"updateUser",vo);
		
	}

	@Override
	public void deleteUser(int userno) throws Exception {
		sqlSession.delete(namespace+"deleteUser",userno);
		
	}

	@Override
	public List<UserVO> listCriteriaUser(Criteria cri, int usersecess) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cri",cri);
		map.put("usersecess",usersecess);
		return sqlSession.selectList(namespace+"listCriteriaUser", map);

	}

	@Override
	public int totalCountUser(int usersecess) throws Exception {
		return sqlSession.selectOne(namespace+"totalCountUser", usersecess);
}

	@Override
	public List<UserVO> listSearchCriteriaUser(SearchCriteria cri, int usersecess) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cri",cri);
		map.put("usersecess",usersecess);
		
		return sqlSession.selectList(namespace+"listSearchCriteriaUser",map);
	}

	@Override
	public int totalSearchCountUser(SearchCriteria cri, int usersecess) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cri",cri);
		map.put("usersecess",usersecess);
		return sqlSession.selectOne(namespace+"totalSearchCountUser",map);
	}

	//아이디 중복체크 위함 사원에서도 쓰임
	@Override
	public UserVO readByIdUser(String userid) throws Exception {
		return sqlSession.selectOne(namespace+"readByIdUser",userid);
	}
   
}
