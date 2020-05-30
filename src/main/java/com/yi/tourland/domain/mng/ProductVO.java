package com.yi.tourland.domain.mng;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

public class ProductVO {
	private int pno;
	private String pname;
	private String pcontent;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date pexpire;
	private int pprice;
	private String pic;
	private boolean pdiv;
	private List<AirplaneVO> air;
	private List<HotelVO> hotel;
	private List<TourVO> tour;
	private List<RentcarVO> rentcar;
	public ProductVO() {
		
	}
	
	public ProductVO(int pno) {
		this.pno = pno;
	}
	
	public ProductVO(int pno, String pname, String pcontent, Date pexire, int pprice, String pic, boolean pdiv) {
		this.pno = pno;
		this.pname = pname;
		this.pcontent = pcontent;
		this.pexpire = pexire;
		this.pprice = pprice;
		this.pic = pic;
		this.pdiv = pdiv;
	}
	

	public ProductVO(int pno, String pname, String pcontent, Date pexire, int pprice, String pic, boolean pdiv,
			List<AirplaneVO> air, List<HotelVO> hotel, List<TourVO> tour, List<RentcarVO> rentcar) {
		this.pno = pno;
		this.pname = pname;
		this.pcontent = pcontent;
		this.pexpire = pexire;
		this.pprice = pprice;
		this.pic = pic;
		this.pdiv = pdiv;
		this.air = air;
		this.hotel = hotel;
		this.tour = tour;
		this.rentcar = rentcar;
	}

	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPcontent() {
		return pcontent;
	}
	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}
	public int getPprice() {
		return pprice;
	}
	public void setPprice(int pprice) {
		this.pprice = pprice;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public List<AirplaneVO> getAir() {
		return air;
	}
	public void setAir(List<AirplaneVO> air) {
		this.air = air;
	}
	public List<HotelVO> getHotel() {
		return hotel;
	}
	public void setHotel(List<HotelVO> hotel) {
		this.hotel = hotel;
	}
	public List<TourVO> getTour() {
		return tour;
	}
	public void setTour(List<TourVO> tour) {
		this.tour = tour;
	}
	public List<RentcarVO> getRentcar() {
		return rentcar;
	}
	public void setRentcar(List<RentcarVO> rentcar) {
		this.rentcar = rentcar;
	}
	public Date getPexpire() {
		return pexpire;
	}
	public void setPexpire(Date pexpire) {
		this.pexpire = pexpire;
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
				"productVO [pno=%s, pname=%s, pcontent=%s, pexire=%s, pprice=%s, pic=%s, pdiv=%s, air=%s, hotel=%s, tour=%s, rentcar=%s]",
				pno, pname, pcontent, pexpire, pprice, pic, pdiv, air, hotel, tour, rentcar);
	}
	
}
