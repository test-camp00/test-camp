package com.campground;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
			sb.append(" VALUES (placeDetail_seq.NEXTVAL,?,?,?,?,?,?,?)");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, dto.getAreaName());
			pstmt.setString(2, dto.getPlaceName());
			pstmt.setString(3, dto.getAddr());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getFilename());
			pstmt.setString(6, dto.getMemo1());
			pstmt.setString(7, dto.getMemo2());
			result=pstmt.executeUpdate();
			
			pstmt.close();
			pstmt=null;
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
	
	// 테이블 항목의 전체 개수
	public int dataCount() {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="SELECT NVL(COUNT(*), 0) FROM placedetail";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next())
				result=rs.getInt(1);
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	
	// 검색상태에서 테이블 항목의 전체 개수
    public int dataCount(String searchArea, String searchValue) {
        int result=0;
        PreparedStatement pstmt=null;
        ResultSet rs=null;
        String sql="";

        try {
        	if(!searchArea.equals("") && searchValue.equals("")){
        		sql="SELECT NVL(COUNT(*), 0) FROM placedetail WHERE areaname=? ";
        		pstmt=conn.prepareStatement(sql);
                pstmt.setString(1, searchArea);
        	}
        	else if(searchArea.equals("") && !searchValue.equals("")){
        		sql="SELECT NVL(COUNT(*), 0) FROM placedetail WHERE INSTR(placename,?)>=1 OR INSTR(addr,?)>=1";
        		pstmt=conn.prepareStatement(sql);
                pstmt.setString(1, searchValue);
                pstmt.setString(2, searchValue);
        	} else if(!searchArea.equals("") && !searchValue.equals("")){
        		sql="SELECT NVL(COUNT(*), 0) FROM placedetail WHERE areaname=? AND INSTR(placename,?)>=1 OR INSTR(addr,?)>=1";
        		pstmt=conn.prepareStatement(sql);
                pstmt.setString(1, searchArea);
                pstmt.setString(2, searchValue);
                pstmt.setString(3, searchValue);
        	}

        	rs=pstmt.executeQuery();

            if(rs.next())
                result=rs.getInt(1);
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return result;
    }
    
 // 리스트
  	public List<CampgroundDTO> listBoard(int start, int end){
  		List<CampgroundDTO> list=new ArrayList<>();
  		PreparedStatement pstmt=null;
  		ResultSet rs=null;
  		String sql;
  		
  		try {
  			// num, subject, name, hitCount, created
  			// num 내림차순 - 최근글이 먼저 나오게 하기 위함
  			sql="SELECT * FROM "
  				+ " (SELECT ROWNUM rnum, tb.* FROM "
  				+ " (SELECT areaName, num, placename, addr, tel, memo1 "
  				+ " FROM placedetail ORDER BY num DESC)tb "
  				+ " WHERE ROWNUM <=?) WHERE rnum>=?";
  			
  			pstmt=conn.prepareStatement(sql);
  			pstmt.setInt(1, end);
  			pstmt.setInt(2, start);
  			rs=pstmt.executeQuery();
  			// 변수를 다 넣어준 후에 rs에서 넣을 것
  			
  			while(rs.next()){
  				CampgroundDTO dto=new CampgroundDTO();
  				dto.setAreaName(rs.getString("areaname"));
  				dto.setNum(rs.getInt("num"));
  				dto.setPlaceName(rs.getString("placename"));
  				dto.setAddr(rs.getString("addr"));
  				dto.setTel(rs.getString("tel"));
  				dto.setMemo1(rs.getString("memo1"));
  							
  				
  				list.add(dto);
  			}
  			
  			pstmt.close();
  			rs.close();
  			pstmt=null;
  			rs=null;
  		} catch (Exception e) {
  			System.out.println(e.toString());
  		}
  		return list;
  	}
  	
  	// 글보기용 DB의 값 가져오기
  	public CampgroundDTO readBoard(int num){
  		CampgroundDTO dto=null;
    	PreparedStatement pstmt=null;
    	ResultSet rs=null;
    	StringBuffer sb=new StringBuffer();
    	
    	try {
    		sb.append("SELECT num, areaname, placename, ");
    		sb.append(" addr, tel, filename, memo1, memo2 ");
    		sb.append(" FROM placedetail WHERE num= ?");
    		
    		pstmt=conn.prepareStatement(sb.toString());
    		pstmt.setInt(1, num);
    		rs=pstmt.executeQuery();
    		
    		while(rs.next()){
    			dto=new CampgroundDTO();
    			dto.setNum(rs.getInt("num"));
    			dto.setAreaName(rs.getString("areaname"));
    			dto.setPlaceName(rs.getString("placename"));
    			dto.setAddr(rs.getString("addr"));
    			dto.setTel(rs.getString("tel"));
    			dto.setFilename(rs.getString("filename"));
    			dto.setMemo1(rs.getString("memo1"));
    			dto.setMemo2(rs.getString("memo2"));
    			
    		}
    		rs.close();
    		pstmt.close();
    		rs=null;
    		pstmt=null;
    		
		} catch (Exception e) {
			System.out.println(e.toString());
		}
    	return dto;
    }
  	
  	// 수정하기
  	public int updateCampground(CampgroundDTO dto){
		int result=0; 
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("UPDATE placedetail SET ");
			sb.append(" areaname=?, placename=?, addr=?, tel=?,");
			sb.append(" filename='', memo1=?, memo2=? ");
			sb.append(" WHERE num=?");

			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, dto.getAreaName());
			pstmt.setString(2, dto.getPlaceName());
			pstmt.setString(3, dto.getAddr());
			pstmt.setString(4, dto.getTel());
			//pstmt.setString(5, dto.getFilename());
			pstmt.setString(5, dto.getMemo1());
			pstmt.setString(6, dto.getMemo2());
			pstmt.setInt(7, dto.getNum());
			
			result=pstmt.executeUpdate(sb.toString());
			
			pstmt.close();
			pstmt=null;
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return result;
	}
}
