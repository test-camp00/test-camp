package com.customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class CustomerDAO {
	private Connection conn=DBConn.getConnection();
	
	public int insertCustomer(CustomerDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("INSERT INTO customer(");
			sb.append("num, notice, userId, subject, content, saveFilename, originalFilename, filesize");
			sb.append(") VALUES (customer_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, dto.getNotice());
			pstmt.setString(2, dto.getUserId());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getSaveFilename());
			pstmt.setString(6, dto.getOriginalFilename());
			pstmt.setLong(7, dto.getFileSize());

			result=pstmt.executeUpdate();
			pstmt.close();
			
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
			sql="SELECT NVL(COUNT(*), 0) FROM customer";
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
	
	// 검색 에서 전체의 개수
    public int dataCount(String searchKey, String searchValue) {
        int result=0;
        PreparedStatement pstmt=null;
        ResultSet rs=null;
        String sql;

        try {
        	if(searchKey.equalsIgnoreCase("created"))
        		sql="SELECT NVL(COUNT(*), 0) FROM customer n JOIN member m ON n.userId=m.userId WHERE TO_CHAR(created, 'YYYY-MM-DD') = ?  ";
        	else
        		sql="SELECT NVL(COUNT(*), 0) FROM customer n JOIN member m ON n.userId=m.userId WHERE  INSTR(" + searchKey + ", ?) >= 1 ";

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
	
    // 게시물 리스트
	public List<CustomerDTO> listCustomer(int start, int end) {
		List<CustomerDTO> list=new ArrayList<CustomerDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("        SELECT num, n.userId, userName");
			sb.append("            ,subject, saveFilename,  hitCount");
			sb.append("            ,created");
			//sb.append("            ,TO_CHAR(created, 'YYYY-MM-DD') created");
			sb.append("         FROM customer  n JOIN member m ON n.userId=m.userId");
			sb.append("	       ORDER BY num DESC");
			sb.append("    ) tb WHERE ROWNUM <= ? ");
			sb.append(") WHERE rnum >= ? ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				CustomerDTO dto=new CustomerDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				
				list.add(dto);
			}
			rs.close();
			pstmt.close();
			

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}
	
	// 검색에서 리스트
    public List<CustomerDTO> listCustomer(int start, int end, String searchKey, String searchValue) {
        List<CustomerDTO> list=new ArrayList<CustomerDTO>();

        PreparedStatement pstmt=null;
        ResultSet rs=null;
        StringBuffer sb = new StringBuffer();

        try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("        SELECT num, n.userId, userName");
			sb.append("            ,subject, saveFilename,  hitCount");
			sb.append("            ,created");
			//sb.append("            ,TO_CHAR(created, 'YYYY-MM-DD') created");
			sb.append("         FROM customer  n JOIN member m ON n.userId=m.userId");
			if(searchKey.equalsIgnoreCase("created"))
				sb.append("           WHERE TO_CHAR(created, 'YYYY-MM-DD') = ? ");
			else
				sb.append("           WHERE INSTR(" + searchKey + ", ?) >= 1 ");
			sb.append("	       ORDER BY num DESC");
			sb.append("    ) tb WHERE ROWNUM <= ?");
			sb.append(") WHERE rnum >= ?");
            
			pstmt=conn.prepareStatement(sb.toString());
            
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);
            
            rs=pstmt.executeQuery();
            
            while(rs.next()) {
				CustomerDTO dto=new CustomerDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
                
                list.add(dto);
            }
            rs.close();
            pstmt.close();
        }catch (Exception e) {
            System.out.println(e.toString());
        }
        return list;
    }
	
    // 공지글
	public List<CustomerDTO> listCustomer() {
		List<CustomerDTO> list=new ArrayList<CustomerDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("   SELECT num, n.userId, userName");
			sb.append("            ,subject, saveFilename,  hitCount");
			sb.append("            ,TO_CHAR(created, 'YYYY-MM-DD') created");
			sb.append("         FROM customer  n JOIN member m ON n.userId=m.userId");
			sb.append("         WHERE notice=1 ");
			sb.append("	      ORDER BY num DESC");

			pstmt=conn.prepareStatement(sb.toString());
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				CustomerDTO dto=new CustomerDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				
				list.add(dto);
			}
			rs.close();
			pstmt.close();
			

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}
    
	public CustomerDTO readCustomer(int num) {
		CustomerDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		sql = "SELECT num, notice, n.userId, userName, subject, content, saveFilename,originalFilename, filesize, hitCount, created ";
		sql+= "  FROM customer n JOIN member m ON n.userId=m.userId WHERE num = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if( rs.next()) {
				dto = new CustomerDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setNotice(rs.getInt("Notice"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				dto.setOriginalFilename(rs.getString("originalFilename"));
				dto.setFileSize(rs.getLong("filesize"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}
	
    // 이전글
    public CustomerDTO preReadCustomer(int groupNum, int orderNo, String searchKey, String searchValue) {
    	CustomerDTO dto=null;

        PreparedStatement pstmt=null;
        ResultSet rs=null;
        StringBuffer sb = new StringBuffer();

       
    
        return dto;
    }

    // 다음글
    public CustomerDTO nextReadCustomer(int groupNum, int orderNo, String searchKey, String searchValue) {
    	CustomerDTO dto=null;

        PreparedStatement pstmt=null;
        ResultSet rs=null;
        StringBuffer sb = new StringBuffer();

       
    
        return dto;
    }

	public int updateHitCount(int num) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "UPDATE customer SET hitCount=hitCount+1 WHERE num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	public int updateCustomer(CustomerDTO dto) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql="UPDATE customer SET customer=?, subject=?, content=?, saveFilename=?, originalFilename=?, filesize=? ";
			sql+= " WHERE num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNotice());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getSaveFilename());
			pstmt.setString(5, dto.getOriginalFilename());
			pstmt.setLong(6, dto.getFileSize());
			pstmt.setInt(7, dto.getNum());
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	public int deleteCustomer(int num) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql="DELETE FROM customer WHERE num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}

}
