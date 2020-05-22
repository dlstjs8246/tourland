package com.yi.tourland.domain.mng;

import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

public class EmailVO {
	private static final int port= 465;
	private String host;
	private String user;
	private String tail;
	private String password;
	
    //하단 setter, getter를 활용한 정보 주입
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getTail() {
		return tail;
	}
	public void setTail(String tail) {
		this.tail = tail;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	private Properties props = System.getProperties();
	private boolean setEnv(){
		props.put("mail.smtp.host", host);  
		props.put("mail.smtp.port", port);  
		props.put("mail.smtp.auth", "true");  
		props.put("mail.smtp.ssl.enable", "true");  
		props.put("mail.smtp.ssl.trust", host);  
		return true;
	}
	
    //파일 없이 전송
	public boolean sendMail(String receiver,String title, String text) throws Exception{
		setEnv();
		Message msg = sendingHead();
		sendingBody(msg, receiver, title, text);
		
		msg.setText(text);
        Transport.send(msg);	
		return true;
	}
	
	private Message sendingHead(){
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un = user;
			String pw = password;
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication(un, pw);
			}
		});
		session.setDebug(true); //for debug  
		Message msg = new MimeMessage(session); //MimeMessage 생성 
		return msg;
	}

	private void sendingBody(Message msg, String receiver, String title, String text) throws Exception{
		msg.setFrom(new InternetAddress(user+tail)); //보내는 사람
		msg.setRecipient(Message.RecipientType.TO, new InternetAddress(receiver)); //받는 사람
		msg.setSubject(title); //제목
	}
}
