package com.yi.tourland.domain.mng;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class EventVO {
	private int no;
	private String title;
	private String content;
	private String pic;
	private Date startdate;
	private Date enddate;

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) throws ParseException {
		this.startdate = new SimpleDateFormat("yyyy-MM-dd").parse(startdate);

	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) throws ParseException {
		this.enddate = new SimpleDateFormat("yyyy-MM-dd").parse(enddate);

	}

	@Override
	public String toString() {
		return "EventVO [no=" + no + ", title=" + title + ", content=" + content + ", pic=" + pic + ", startdate="
				+ startdate + ", enddate=" + enddate + "]";
	}

}
