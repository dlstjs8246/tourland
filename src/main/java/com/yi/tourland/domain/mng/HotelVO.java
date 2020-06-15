package com.yi.tourland.domain.mng;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HotelVO {
	private int no; // 호텔번호 .기본키
	private String hname; // 호텔이름
	private String haddr; // 호텔의 주소
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date checkin; // 체크인날짜
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date checkout; // 체크아웃날짜
	private int capacity; // 허용인원수
	private int price; // 룸 가격
	private int roomcapacity; // 허용객실의숫자
	private String roomtype; // 객실타입
	private String ldiv; // 장소구분
	private int bookedup; // 객실체크여부
	private int totalcapacity; //전체 인원
	private boolean pdiv;
	public HotelVO() {
		//기본생성자
	}
	
	public HotelVO(int no) {
		this.no = no;
	}

	
		public HotelVO(int no, String hname, String haddr, Date checkin, Date checkout, int capacity, int price,
			int roomcapacity, String roomtype, String ldiv, int bookedup, int totalcapacity, boolean pdiv) {
		this.no = no;
		this.hname = hname;
		this.haddr = haddr;
		this.checkin = checkin;
		this.checkout = checkout;
		this.capacity = capacity;
		this.price = price;
		this.roomcapacity = roomcapacity;
		this.roomtype = roomtype;
		this.ldiv = ldiv;
		this.bookedup = bookedup;
		this.totalcapacity = totalcapacity;
		this.pdiv = pdiv;
	}

		//밑으로 get, set, toString

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getHname() {
		return hname;
	}

	public void setHname(String hname) {
		this.hname = hname;
	}

	public String getHaddr() {
		return haddr;
	}

	public void setHaddr(String haddr) {
		this.haddr = haddr;
	}

	public Date getCheckin() {
		return checkin;
	}

	public void setCheckin(Date checkin) {
		this.checkin = checkin;
	}

	public Date getCheckout() {
		return checkout;
	}

	public void setCheckout(Date checkout) {
		this.checkout = checkout;
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getRoomcapacity() {
		return roomcapacity;
	}

	public void setRoomcapacity(int roomcapacity) {
		this.roomcapacity = roomcapacity;
	}

	public String getRoomtype() {
		return roomtype;
	}

	public void setRoomtype(String roomtype) {
		this.roomtype = roomtype;
	}

	public String getLdiv() {
		return ldiv;
	}

	public void setLdiv(String ldiv) {
		this.ldiv = ldiv;
	}

	public int getBookedup() {
		return bookedup;
	}

	public void setBookedup(int bookedup) {
		this.bookedup = bookedup;
	}

	public int getTotalcapacity() {
		return totalcapacity;
	}

	public void setTotalcapacity(int totalcapacity) {
		this.totalcapacity = totalcapacity;
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
				"HotelVO [no=%s, hname=%s, haddr=%s, checkin=%s, checkout=%s, capacity=%s, price=%s, roomcapacity=%s, roomtype=%s, ldiv=%s, bookedup=%s, totalcapacity=%s, pdiv=%s]",
				no, hname, haddr, checkin, checkout, capacity, price, roomcapacity, roomtype, ldiv, bookedup,
				totalcapacity, pdiv);
	}
}
