package com.yi.tourland.domain.mng;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ReviewVO {
	private int no; //번호
	private int rno; //예약번호
	private int pno; //상품번호
	private int userno; //유저번호
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date regdate; //등록일
	private String starpoint; //별점
	private String reviewTitle; //리뷰제목
	private String reviewContent; //리뷰내용
	
	
	
	public ReviewVO() {
		super();
		// TODO Auto-generated constructor stub
	}



	public ReviewVO(int no, int pno, int userno, Date regdate, String starpoint, String reviewTitle,
			String reviewContent) {
		super();
		this.no = no;
		this.pno = pno;
		this.userno = userno;
		this.regdate = regdate;
		this.starpoint = starpoint;
		this.reviewTitle = reviewTitle;
		this.reviewContent = reviewContent;
	}



	public int getNo() {
		return no;
	}



	public void setNo(int no) {
		this.no = no;
	}

	

	public int getRno() {
		return rno;
	}



	public void setRno(int rno) {
		this.rno = rno;
	}



	public int getPno() {
		return pno;
	}



	public void setPno(int pno) {
		this.pno = pno;
	}



	public int getUserno() {
		return userno;
	}



	public void setUserno(int userno) {
		this.userno = userno;
	}



	public Date getRegdate() {
		return regdate;
	}



	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}



	public String getStarpoint() {
		return starpoint;
	}



	public void setStarpoint(String starpoint) {
		this.starpoint = starpoint;
	}



	public String getReviewTitle() {
		return reviewTitle;
	}



	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}



	public String getReviewContent() {
		return reviewContent;
	}



	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}



	@Override
	public String toString() {
		return "ReviewVO [no=" + no + ", rno=" + rno + ", pno=" + pno + ", userno=" + userno + ", regdate=" + regdate
				+ ", starpoint=" + starpoint + ", reviewTitle=" + reviewTitle + ", reviewContent=" + reviewContent
				+ "]";
	}



}
