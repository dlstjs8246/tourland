package com.yi.tourland.domain.mng;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

public class UserVO {
	private int userno;
	private String username;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date userbirth;
	private String usertel;
	private String useraddr;
	private String userpassport;
	private String userid;
	private String userpass;
	private int usersecess;
	private List<ProductVO> userProduct;

	public int getUserno() {
		return userno;
	}

	public void setUserno(int userno) {
		this.userno = userno;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Date getUserbirth() {
		return userbirth;
	}

	public void setUserbirth(String userbirth) throws ParseException {
		this.userbirth = new SimpleDateFormat("yyyy-MM-dd").parse(userbirth);
	}

	public String getUsertel() {
		return usertel;
	}

	public void setUsertel(String usertel) {
		this.usertel = usertel;
	}

	public String getUseraddr() {
		return useraddr;
	}

	public void setUseraddr(String useraddr) {
		this.useraddr = useraddr;
	}

	public String getUserpassport() {
		return userpassport;
	}

	public void setUserpassport(String userpassport) {
		this.userpassport = userpassport;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUserpass() {
		return userpass;
	}

	public void setUserpass(String userpass) {
		this.userpass = userpass;
	}

	public int getUsersecess() {
		return usersecess;
	}

	public void setUsersecess(int usersecess) {
		this.usersecess = usersecess;
	}
	
	public List<ProductVO> getUserProduct() {
		return userProduct;
	}

	public void setUserProduct(List<ProductVO> userProduct) {
		this.userProduct = userProduct;
	}

	@Override
	public String toString() {
		return "UserVO [userno=" + userno + ", username=" + username + ", userbirth=" + userbirth + ", usertel="
				+ usertel + ", useraddr=" + useraddr + ", userpassport=" + userpassport + ", userid=" + userid
				+ ", userpass=" + userpass + ", usersecess=" + usersecess + "]";
	}

}
