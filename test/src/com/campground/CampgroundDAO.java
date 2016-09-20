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
		
		try {
			sb.append("INSERT INTO placedetail");
			sb.append(" (num, areaname, placename, addr, tel, filename, memo1, memo2)");
			sb.append(" VALUES (placeDetail_seq.NEXTVAL,?,?,?,?,'',?,?)");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, dto.getAreaName());
			pstmt.setString(2, dto.getPlaceName());
			pstmt.setString(3, dto.getAddr());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getMemo1());
			pstmt.setString(6, dto.getMemo2());
			result=pstmt.executeUpdate();
			
			pstmt.close();
			pstmt=null;
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
}
