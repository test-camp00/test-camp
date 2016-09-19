package com.campground;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.util.DBConn;

public class CampgroundDAO {
	private Connection conn=DBConn.getConnection();
	
	public int insertCampground(CampgroundDTO dto){
		int result=0; 
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		
		sb.append("");
		try {
			
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
}
