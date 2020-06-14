package com.yi.tourland.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

public class UploadFileUtils {
      public static String uploadFile(String uploadPath, String fileName, byte[] fileData) throws IOException {  
    	  //그냥 만들면 부를때마다 new로 생성해야하기때문에 static으로 만듦
      
    			// 서버 외부 
    		//	String uploadPath = "c:/tourland/upload/";
    			File dir = new File(uploadPath);
    			if(dir.exists()== false) { //폴더 없으면 폴더 만들어줌 
    				dir.mkdirs();
    			}
    			//년. 월. 일 폴더를 만들기 
    			//다른 폴더에 저장할때 또 복 붙해야해서 업로드 전용 클래스를 만든다 
    			String todays = calcPath(uploadPath); // 2020/04/29
    			
    	//원본 저장하는것
    			UUID uuid = UUID.randomUUID(); //중복되지 않는 고유한 키  값을 반환해줌 
    			String savedName = uuid.toString()+"_"+fileName; //중복되지 않게 이름을 맞춤
    			File target = new File(uploadPath+todays+"/"+savedName);
    			//핵심!! 
    			FileCopyUtils.copy(fileData,target); //서버 upload폴더 안에 파일이 생성됨 
    	//썸네일 호출
    			String thumbPath = makeThumbnail(uploadPath, todays, savedName);
    			
    	  //return target+"/"+savedName; // 2020/04/29/aaa.jpg 의 형태로 보내짐   
    			
    	//작은 이미지가 넘어가야한다. 클릭해야만 원본이 나오도록 하기 위해서 		
    	   return thumbPath;		
      }
    		
    	private static String calcPath(String uploadPath) {
    		Calendar cal = Calendar.getInstance();
    		String yearPath = "/" + cal.get(Calendar.YEAR); //2020
    		String monthPath = String.format("%s/%02d", yearPath, cal.get(Calendar.MONTH)+1); //2020/04
    		String datePath = String.format("%s/%02d", monthPath, cal.get(Calendar.DATE)); // 2020/04/29
    		
    		makeDir(uploadPath, yearPath, monthPath, datePath);
    		return datePath; //년월일 값은 datePath가 다 가지고 있음 
    	}
    	
    	public static void makeDir(String uploadPath, String... paths) {
    		for(String path: paths) {
    			File dir = new File(uploadPath+path);
    			if(dir.exists()==false) {
    				dir.mkdir();
    			}
    		}
    	}
    	
    	//썸네일 함수
    	//uploadPath : root
    	//path: 년/월/일 폴더
    	//fileName : 오리지널 파일 이름 
    	private static String makeThumbnail(String uploadPath, String path, String fileName) throws IOException {
    		
    		//원본 이미지 데이터를 컴퓨터 상의 가상 도화지에 옮겨온다.
    		BufferedImage sourceImg = ImageIO.read(new File(uploadPath+path+"/"+fileName));
    		//가상 도화지에 옮겨진 원본을 기준으로 작은 이미지를 가상 공간에 만든다.
    		BufferedImage destImg = Scalr.resize(sourceImg,                //원본데이터
    				                             Scalr.Method.AUTOMATIC,   //크기는 automatic
    				                             Scalr.Mode.FIT_TO_HEIGHT, //높이고정 to_WIDTH면 가로 고정 설정 
    				                             100);                     //100px로 고정 
    		//thumbname 이미지 파일명에 s_붙임 
    		String thumbnailName = uploadPath + path + "/s_" +fileName;    //실제 파일 명  앞에 s_ 붙이면 작은 이미지다 알려주는것 내마음
    		
    		//해당 경로에 빈 파일 만듦
    		File newFile = new File(thumbnailName);
    		
    		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
    		
    		//가상 작은 이미지 데이터를 원하는 경로에 저장을 함
    		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
    		// 작은 이미지 경로는 c:/zzz/upload/2020... 인데 여기서 root빼고 가져가자 
    		return thumbnailName.substring(uploadPath.length());  // 2020/04/29/s_Image.jpg
    		
    	}
}
