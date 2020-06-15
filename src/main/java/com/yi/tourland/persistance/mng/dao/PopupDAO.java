package com.yi.tourland.persistance.mng.dao;

import java.util.List;

import com.yi.tourland.domain.Criteria;
import com.yi.tourland.domain.SearchCriteria;
import com.yi.tourland.domain.mng.PopupVO;

public interface PopupDAO {
	public void insertPopup(PopupVO vo) throws Exception;
	public PopupVO readByNoPopup(int no)throws Exception;
	public void updatePopup(PopupVO vo)throws Exception;
	public void deletePopup(int no)throws Exception;
	public List<PopupVO> listCriteriaPopup(Criteria cri)throws Exception;
    public int totalCountPopup() throws Exception;
	public List<PopupVO> listSearchCriteriaPopup(SearchCriteria cri)throws Exception;
	public int totalSearchCountPopup(SearchCriteria cri) throws Exception;

	//팝업 리스트 부르기 
    public PopupVO setPopup(String position) throws Exception;
    
    public List<PopupVO> setPopupList(String position) throws Exception;
}
