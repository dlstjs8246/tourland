package com.yi.tourland.domain.mng;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class TourVO {
	private int no;
	private String tname;
	private String tlocation;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	private String taddr;
	@DateTimeFormat(pattern = "HH:mm:ss")
	private Date etime;
	private int capacity;
	private int tprice;
	private boolean ldiv;
	private boolean pdiv;
	public TourVO() {
		
	}
	public TourVO(int no) {
		this.no = no;
	}
	public TourVO(int no, String tname, String tlocation, Date startDate, Date endDate, String taddr, Date etime,
			int capacity, int tprice, boolean ldiv) {
		this.no = no;
		this.tname = tname;
		this.tlocation = tlocation;
		this.startDate = startDate;
		this.endDate = endDate;
		this.taddr = taddr;
		this.etime = etime;
		this.capacity = capacity;
		this.tprice = tprice;
		this.ldiv = ldiv;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public String getTlocation() {
		return tlocation;
	}
	public void setTlocation(String tlocation) {
		this.tlocation = tlocation;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getTaddr() {
		return taddr;
	}
	public void setTaddr(String taddr) {
		this.taddr = taddr;
	}
	public Date getEtime() {
		return etime;
	}
	public void setEtime(Date etime) {
		this.etime = etime;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public int getTprice() {
		return tprice;
	}
	public void setTprice(int tprice) {
		this.tprice = tprice;
	}
	public boolean isLdiv() {
		return ldiv;
	}
	public void setLdiv(boolean ldiv) {
		this.ldiv = ldiv;
	}
	
	public boolean isPdiv() {
		return pdiv;
	}
	public void setPdiv(boolean pdiv) {
		this.pdiv = pdiv;
	}
	@Override
	public String toString() {
		return String.format(
				"TourVO [no=%s, tname=%s, tlocation=%s, startDate=%s, endDate=%s, taddr=%s, etime=%s, capacity=%s, tprice=%s, ldiv=%s, pdiv=%s]",
				no, tname, tlocation, startDate, endDate, taddr, etime, capacity, tprice, ldiv, pdiv);
	}
	
}
