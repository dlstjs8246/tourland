package com.yi.tourland.service.mng;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yi.tourland.domain.Criteria;
import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.PopupVO;
import com.yi.tourland.persistance.mng.dao.PopupDAO;

@Service
public class PopupService {
    @Autowired
	PopupDAO dao;
    
    
	public void insertPopup(PopupVO vo) throws Exception {
		dao.insertPopup(vo);
		
	}

	
	public PopupVO readByNoPopup(int no) throws Exception {
		return dao.readByNoPopup(no);
	}

	
	public void updatePopup(PopupVO vo) throws Exception {
		dao.updatePopup(vo);
		
	}

	
	public void deletePopup(int no) throws Exception {
		dao.deletePopup(no);
		
	}

	
	public List<PopupVO> listCriteriaPopup(Criteria cri) throws Exception {
		return dao.listCriteriaPopup(cri);
	}

	
	public int totalCountPopup() throws Exception {
		return dao.totalCountPopup();
	}

	
	public List<PopupVO> listSearchCriteriaPopup(SearchCriteria cri) throws Exception {
		return dao.listSearchCriteriaPopup(cri);
	}

	
	public int totalSearchCountPopup(SearchCriteria cri) throws Exception {
		return dao.totalSearchCountPopup(cri);
	}

	public PopupVO setPopup(String position) throws Exception {
		return dao.setPopup(position);
	}
	
	public List<PopupVO> setPopupList(String position) throws Exception {
		return dao.setPopupList(position);
	}
    
}
