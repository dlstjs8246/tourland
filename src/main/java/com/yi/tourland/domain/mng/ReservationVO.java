package com.yi.tourland.domain.mng;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

public class ReservationVO {
	private int no;
	private UserVO userno;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date rdate;
	private String rstatus;
	private List<ProductVO> products;
	
	public ReservationVO() {
		
	}
	
	public ReservationVO(int no, UserVO userno, String rstatus) {
		this.no = no;
		this.userno = userno;
		this.rstatus = rstatus;
	}

	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public UserVO getUserno() {
		return userno;
	}
	public void setUserno(UserVO userno) {
		this.userno = userno;
	}
	public Date getRdate() {
		return rdate;
	}
	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	public String getConfirm() {
		return rstatus;
	}
	
	public String getRstatus() {
		return rstatus;
	}

	public void setRstatus(String rstatus) {
		this.rstatus = rstatus;
	}

	public List<ProductVO> getProducts() {
		return products;
	}

	public void setProducts(List<ProductVO> products) {
		this.products = products;
	}

	@Override
	public String toString() {
		return String.format("ReservationVO [no=%s, userno=%s, rdate=%s, rstatus=%s, products=%s]", no, userno, rdate,
				rstatus, products);
	}
	
}
