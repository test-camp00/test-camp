package com.gallery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.util.DBConn;

public class GalleryDAO {
	private Connection conn=DBConn.getConnection();
	
	public int insertGallery(GalleryDTO dto){
		int result=0;
		PreparedStatement pstmt=null;
		String sql;

		String fields = "num, userId, subject, content";
		sql="INSERT INTO GALLERYBOARD (" + fields + ") VALUES (GALLERYBOARD_SEQ.NEXTVAL, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			
			result = pstmt.executeUpdate();
			pstmt.close();
			pstmt=null;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		fields = "filenum, filename, num";
		sql="INSERT INTO GALLERYFILE (" + fields + ") VALUES (GALLERYFILE_SEQ.NEXTVAL, ?, GALLERYBOARD_SEQ.CURRVAL)";
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getFilename());			
			
			result = pstmt.executeUpdate();
			pstmt.close();
			pstmt=null;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		
		return result;
	}
	public int dataCount() {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="SELECT NVL(COUNT(*), 0) FROM GALLERYBOARD";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next())
				result=rs.getInt(1);
			rs.close();
			pstmt.close();
			
			rs=null;
			pstmt=null;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}public List<GalleryDTO> listGallery(int start, int end) {
		List<GalleryDTO> list=new ArrayList<GalleryDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("        SELECT g.num, g.userId, subject, f.Filename ");
			sb.append("         FROM galleryboard g JOIN member m ON g.userId = m.userId ");
			sb.append("			JOIN galleryfile f ON g.num=f.num");
			sb.append("	       ORDER BY num DESC");
			sb.append("    ) tb WHERE ROWNUM <= ? ");
			sb.append(") WHERE rnum >= ? ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				GalleryDTO dto=new GalleryDTO();
				dto.setNum(rs.getInt("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setSubject(rs.getString("subject"));
				dto.setFilename(rs.getString("Filename"));
				list.add(dto);
			}
			rs.close();
			pstmt.close();
			

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}
	public GalleryDTO readGallery(int num) {
		GalleryDTO dto=null;
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT g.num, g.userId,userName ");
			sb.append("    ,subject, content,");
			sb.append("    TO_CHAR(created, 'YYYY-MM-DD') created, ");
			sb.append("    f.Filename,f.fileNum ");
			sb.append("    FROM galleryboard g");
			sb.append("    JOIN member m ON g.userId=m.userId");
			sb.append("    JOIN galleryfile f ON f.num=g.num");
			sb.append("    WHERE g.num=?");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new GalleryDTO();
				dto.setNum(rs.getInt("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setFilename(rs.getString("Filename"));
				dto.setCreated(rs.getString("created"));
				dto.setFileNum(rs.getInt("fileNum"));
			}
			rs.close();
			pstmt.close();
					
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}
	
	public int updateGallery(GalleryDTO dto){
		int result=0;
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("UPDATE GALLERYBOARD SET subject=?");
			sb.append("   ,content=?");
			sb.append("   WHERE num=?");
			pstmt=conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNum());
			
			result=pstmt.executeUpdate();
			pstmt.close();
			pstmt=null;
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		sb=new StringBuffer();
		
		try {
			sb.append("UPDATE GALLERYFILE SET filename=?");
			sb.append("   WHERE num=?");
			pstmt=conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, dto.getFilename());
			pstmt.setInt(2, dto.getNum());
			
			result=pstmt.executeUpdate();
			pstmt.close();
			pstmt=null;
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		
		return result;
	}
	public int deleteGallery(int num) {
		int result=0;
		PreparedStatement pstmt=null;
		String sql;
		
		try {
			sql="DELETE FROM GALLERYBOARD WHERE num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result=pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		try {
			sql="DELETE FROM GALLERYFILE WHERE num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result=pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}	
	public int insertReply(ReplyDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		
		try {

			sb.append("INSERT INTO GALLERYREPLY(");
			sb.append("  REPLYNUM, NUM, USERID, CONTENT)");
			sb.append("  VALUES (GALLERYREPLY_SEQ.NEXTVAL,?,?,?)");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getUserId());
			pstmt.setString(3, dto.getContent());

			
			
			result=pstmt.executeUpdate();
			pstmt.close();
			pstmt=null;
			
			
		} catch (Exception e) {
			System.out.println("Äõ¸®°¡ ±×°Ô ¹¹³Ä");
			System.out.println(e.getMessage());
		}
		
		return result;
	}
	
	public List<ReplyDTO> readreply(int num) {
		ReplyDTO dto=null;
		List<ReplyDTO> list=new ArrayList<>();;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append(" SELECT REPLYNUM, NUM, USERID, CONTENT, CREATED");
			sb.append("    FROM GALLERYREPLY");
			sb.append("    WHERE num=?");
			sb.append("    ORDER BY CREATED ");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				dto=new ReplyDTO();
				dto.setReplyNum(rs.getInt("REPLYNUM"));
				dto.setNum(rs.getInt("NUM"));
				dto.setUserId(rs.getString("USERID"));
				dto.setContent(rs.getString("CONTENT"));
				dto.setCreated(rs.getString("CREATED"));
				
				list.add(dto);
			}
			rs.close();
			pstmt.close();
					
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}
	
	public int deleteReply(int replyNum) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		sql="DELETE FROM GALLERYREPLY WHERE replyNum=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, replyNum);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}		
		return result;
	}	
}
