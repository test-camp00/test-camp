package com.freeboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;


public class BoardDAO {
	private Connection conn=DBConn.getConnection();
	
	public int insertBoard(BoardDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		
		try {

			sb.append("INSERT INTO freeboard(");
			sb.append("  NUM, USERID, SUBJECT, CONTENT, ");
			sb.append("  HITCOUNT, SAVEFILENAME, ORIGINALFILENAME,FILESIZE) ");
			sb.append("  VALUES (freeboard_seq.nextval,?,?,?,?,?,?,?)");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getHitCount());
			pstmt.setString(5, dto.getSaveFilename());
			pstmt.setString(6, dto.getOriginalFilename());
			pstmt.setLong(7, dto.getFilesize());
			
			result=pstmt.executeUpdate();
			pstmt.close();
			pstmt=null;
			
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return result;
	}
	
	public int dataCount(){
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		try {
			sql="SELECT NVL(COUNT(*),0) FROM FREEBOARD";
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
	
	public int dataCount(String searchKey,String searchValue){
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			if(searchKey.equals("created"))
        		sql="SELECT NVL(COUNT(*), 0) FROM FREEBOARD f JOIN MEMBER m ON f.userId=m.userId WHERE TO_CHAR(created, 'YYYY-MM-DD') = ?  ";
        	else if(searchKey.equals("userName"))
        		sql="SELECT NVL(COUNT(*), 0) FROM FREEBOARD f JOIN MEMBER m ON f.userId=m.userId WHERE INSTR(userName, ?) = 1 ";
        	else
        		sql="SELECT NVL(COUNT(*), 0) FROM FREEBOARD f JOIN MEMBER m ON f.userId=m.userId WHERE INSTR(" + searchKey + ", ?) >= 1 ";

            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, searchValue);

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
	
	public List<BoardDTO> listBoard(int start,int end){
		List<BoardDTO> list=new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("         SELECT num, f.userId, userName,");
			sb.append("               subject, TO_CHAR(created,'yyyy-mm-dd') created,hitCount,");
			sb.append("               saveFilename");
			sb.append("               FROM FREEBOARD f");
			sb.append("               JOIN MEMBER m ON f.userId=m.userId");
			sb.append("               ORDER BY num DESC ");
			sb.append("    ) tb WHERE ROWNUM <= ? ");
			sb.append(") WHERE rnum >= ? ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);

			rs=pstmt.executeQuery();
			
			while (rs.next()) {
				BoardDTO dto=new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setCreated(rs.getString("created"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				
				list.add(dto);
			}
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	public List<BoardDTO> listBoard(int start,int end,String searchKey,String searchValue){
		List<BoardDTO> list=new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("         SELECT num, f.userId, userName,");
			sb.append("               subject, created,hitCount,");
			sb.append("               saveFilename");
			sb.append("               FROM FREEBOARD f");
			sb.append("               JOIN MEMBER m ON f.userId=m.userId");
			if(searchKey.equals("created"))
				sb.append("           WHERE TO_CHAR(created, 'YYYY-MM-DD') = ? ");
			else if(searchKey.equals("userName"))
				sb.append("           WHERE INSTR(userName, ?) = 1 ");
			else
				sb.append("           WHERE INSTR(" + searchKey + ", ?) >= 1 ");
			
			sb.append("               ORDER BY num DESC ");
			sb.append("    ) tb WHERE ROWNUM <= ?");
			sb.append(") WHERE rnum >= ?");
			

			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);

			rs=pstmt.executeQuery();
			
			while (rs.next()) {
				BoardDTO dto=new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setCreated(rs.getString("created"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				
				list.add(dto);
			}
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}
}
