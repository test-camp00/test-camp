package com.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.util.DBConn;

public class MemberDAO {
	private Connection conn = DBConn.getConnection();
	
	
	public MemberDTO readMember(String userId) {
		MemberDTO dto=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT m1.userId, userName, userPwd, ");
			sb.append("enabled, created_date, modify_date, ");
			sb.append("TO_CHAR(birth, 'YYYY-MM-DD') birth, ");     
			sb.append("email, tel, addr ");      
			sb.append("FROM member m1 ");     
			sb.append("LEFT OUTER JOIN memberdetail m2 ");      
			sb.append("ON m1.userId=m2.userId ");      
			sb.append("WHERE m1.userId=? ");     
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, userId);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto=new MemberDTO();
				dto.setUserId(rs.getString("userId"));
				dto.setUserPwd(rs.getString("userPwd"));
				dto.setUserName(rs.getString("userName"));
				dto.setEnabled(rs.getInt("enabled"));
				dto.setCreated_date(rs.getString("created_date"));
				dto.setModify_date(rs.getString("modify_date"));
				dto.setBirth(rs.getString("birth"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setAddr(rs.getString("addr"));
			}
			rs.close();
			pstmt.close();
			pstmt=null;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}
	
	public int insertMember(MemberDTO dto) {
		int result=0;
		
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("INSERT INTO MEMBER(userId, userPwd, userName) VALUES (?, ?, ?)");
			pstmt=conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getUserPwd());
			pstmt.setString(3, dto.getUserName());
			result=pstmt.executeUpdate();
			pstmt.close();
			pstmt=null;
			
			// sb=new StringBuffer();
			sb.delete(0, sb.length());
			
			sb.append("INSERT INTO MEMBERDETAIL(userId, birth, tel, addr, email) VALUES (?, ?, ?, ?, ?)");
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getBirth());
			pstmt.setString(3, dto.getTel());
			pstmt.setString(4, dto.getAddr());
			pstmt.setString(5, dto.getEmail());

			
			pstmt.executeUpdate();
			pstmt.close();
			pstmt=null;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		
		return result;
	}
	
	public int updateMember(MemberDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("UPDATE MEMBERDETAIL SET birth=?, tel=?, addr=?, email=? ");
			sb.append("   WHERE userId=?");
			pstmt=conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, dto.getBirth());
			pstmt.setString(2, dto.getTel());
			pstmt.setString(3, dto.getAddr());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getUserId());
			
			result=pstmt.executeUpdate();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	public int deleteMember(MemberDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("UPDATE MEMBER SET enabled=0 ");
			sb.append("   WHERE userId=?");
			pstmt=conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, dto.getUserId());
			
			result=pstmt.executeUpdate();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	public int changePwd(MemberDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		try {
			sb.append("UPDATE MEMBER SET userPwd=? ");
			sb.append("   WHERE userId=?");
			pstmt=conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, dto.getUserPwd());
			pstmt.setString(2, dto.getUserId());
			
			result=pstmt.executeUpdate();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
		
	} 
	
	public MemberDTO searchId(String userName, String tel) {
		MemberDTO dto=null;
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		ResultSet rs=null;
		
		try {
			sb.append("SELECT m.userid, enabled");
			sb.append(" FROM member m");
			sb.append(" JOIN memberdetail md ON m.userId=md.userId");
			sb.append(" WHERE userName=? AND tel=?");
			pstmt=conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, userName);
			pstmt.setString(2, tel);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto=new MemberDTO();
				dto.setUserId(rs.getString("userId"));
				dto.setEnabled(rs.getInt("enabled"));
			}
			rs.close();
			pstmt.close();
			pstmt=null;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
		
	}
	
	public MemberDTO searchPwd(String userId, String userName, String tel) {
		MemberDTO dto=null;
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		ResultSet rs=null;
		
		try {
			sb.append("SELECT m.userid, enabled");
			sb.append(" FROM member m");
			sb.append(" JOIN memberdetail md ON m.userId=md.userId");
			sb.append(" WHERE m.userId=? AND userName=? AND tel=?");
			pstmt=conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, userId);
			pstmt.setString(2, userName);
			pstmt.setString(3, tel);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto=new MemberDTO();
				dto.setUserId(rs.getString("userId"));
				dto.setEnabled(rs.getInt("enabled"));
			}
			rs.close();
			pstmt.close();
			pstmt=null;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
		
	}
	
	
	
}
