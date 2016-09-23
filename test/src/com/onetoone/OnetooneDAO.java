package com.onetoone;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.util.DBConn;

public class OnetooneDAO {
	private Connection conn = DBConn.getConnection();

	public int insertOnetoone(OnetooneDTO dto) {
		int result = 0;
		PreparedStatement pstmt = null;
		StringBuffer sb = new StringBuffer();

		try {
			sb.append("INSERT INTO onetoone(num, userId, subject, content, secret) ");
			sb.append("VALUES(onetoone_seq.NEXTVAL, ?, ?,?,?)");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getSecret());
			
			result=pstmt.executeUpdate();
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
			sql="SELECT NVL(COUNT(*), 0) FROM onetoone";
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
	}

	public List<OnetooneDTO> listOnetoOne(int start, int end) {
		List<OnetooneDTO> list=new ArrayList<OnetooneDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		

		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("        SELECT num, g.userId, content,subject, secret");
			sb.append("         FROM Onetoone g JOIN member m ON g.userId=m.userId ");
			sb.append("	       ORDER BY num DESC");
			sb.append("    ) tb WHERE ROWNUM <= ? ");
			sb.append(") WHERE rnum >= ? ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				OnetooneDTO dto=new OnetooneDTO();
				dto.setNum(rs.getInt("num"));
				dto.setUserId(rs.getString("userId"));
				
				dto.setContent(rs.getString("content"));
				dto.setSubject(rs.getString("subject"));
				dto.setSecret(rs.getInt("secret"));
				
				list.add(dto);
			}
			
			rs.close();
			pstmt.close();
			rs=null;
			pstmt=null;
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}

	public int deleteOnetoone(int num) {

	int result=0;
	PreparedStatement pstmt=null;
	String sql;
	
	try {
		sql="DELETE FROM Onetoone WHERE num=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		result=pstmt.executeUpdate();
		
		pstmt.close();
		pstmt=null;
	} catch (Exception e) {
		System.out.println(e.toString());
	}
	
	return result;
}
	
	public int updateOnetoone(OnetooneDTO dto) {

		int result=0;
		PreparedStatement pstmt=null;
		String sql;
		sql="UPDATE bbs SET subject=?, content=?, secret=? WHERE num=?";
		
	try {
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getSubject());
		pstmt.setString(2, dto.getContent());
		pstmt.setInt(3, dto.getSecret());
		pstmt.setInt(4, dto.getNum());
		result = pstmt.executeUpdate();
		
		pstmt.close();
		pstmt=null;
	} catch (Exception e) {
		System.out.println(e.toString());
	}finally {
		if(pstmt!=null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
			}
		}
	}		
	return result;
}
	
	public OnetooneDTO readOnetoone(int num) {
		OnetooneDTO dto=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT num, b.userId, subject, content, secret ");
			sb.append("   FROM onetoone b JOIN member m ON b.userId=m.userId  ");
			sb.append("   WHERE num = ? ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, num);

			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new OnetooneDTO();
				dto.setNum(rs.getInt("num"));
				dto.setUserId(rs.getString("userId"));
				
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setSecret(Integer.parseInt(rs.getString("secret")));
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
				}
			}
				
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
				}
			}
		}
		
		return dto;
	}
	
}
