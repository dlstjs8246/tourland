package com.yi.tourland.domain.mng;

public class StatisticVO {
	private String location;
	private int year;
	private int month;
	private int totalprice;
	private String pname;
	private int count;
	public StatisticVO() {
		
	}
	public StatisticVO(String pname, int count) {
		this.pname = pname;
		this.count = count;
	}
	public StatisticVO(String location, int year, int month, int totalprice) {
		this.location = location;
		this.year = year;
		this.month = month;
		this.totalprice = totalprice;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public int getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	@Override
	public String toString() {
		return String.format("StatisticVO [location=%s, year=%s, month=%s, totalprice=%s, pname=%s, count=%s]",
				location, year, month, totalprice, pname, count);
	}
	
}
