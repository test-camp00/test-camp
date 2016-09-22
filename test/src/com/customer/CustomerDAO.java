package com.customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class CustomerDAO {
	private Connection conn = DBConn.getConnection();

	public int maxCustomerNum() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(MAX(boardNum), 0) FROM customer";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				result = rs.getInt(1);
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	public int updateOrderNo(int groupNum, int orderNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		sql = "UPDATE customer SET orderNo=orderNo+1";
		sql += "WHERE groupNum=? AND orderNo>?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, groupNum);
			pstmt.setInt(2, orderNo);
			result = pstmt.executeUpdate();

			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	public int insertCustomer(CustomerDTO dto, String mode) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		int maxNum = maxCustomerNum() + 1;
		dto.setBoardNum(maxNum);

		if (mode.equals("created")) {
			dto.setGroupNum(maxNum);
			dto.setOrderNo(0);
			dto.setDepth(0);
			dto.setParent(0);
		} else {
			updateOrderNo(dto.getGroupNum(), dto.getOrderNo());
			dto.setDepth(dto.getDepth() + 1);
			dto.setOrderNo(dto.getOrderNo() + 1);
		}

		try {
			sql = "INSERT INTO customer(boardNum, userId, ";
			sql += "subject, content, groupNum, orderNo, ";
			sql += "depth, parent) VALUES(?,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getBoardNum());
			pstmt.setString(2, dto.getUserId());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, dto.getGroupNum());
			pstmt.setInt(6, dto.getOrderNo());
			pstmt.setInt(7, dto.getDepth());
			pstmt.setInt(8, dto.getParent());

			result = pstmt.executeUpdate();
			pstmt.close();
			pstmt = null;

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	public int dataCount() {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(COUNT(*), 0) FROM customer";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				result = rs.getInt(1);
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}

	public int dataCount(String searchKey, String searchValue) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			if (searchKey.equals("created"))
				sql = "SELECT NVL(COUNT(*), 0) FROM customer b JOIN member m ON b.userId=m.userId WHERE TO_CHAR(created, 'YYYY-MM-DD') = ?  ";
			else if (searchKey.equals("userName"))
				sql = "SELECT NVL(COUNT(*), 0) FROM customer b JOIN member m ON b.userId=m.userId WHERE INSTR(userName, ?) = 1 ";
			else
				sql = "SELECT NVL(COUNT(*), 0) FROM customer b JOIN member m ON b.userId=m.userId WHERE INSTR("
						+ searchKey + ", ?) >= 1 ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);

			rs = pstmt.executeQuery();

			if (rs.next())
				result = rs.getInt(1);
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	public List<CustomerDTO> listCustomer(int start, int end) {
		List<CustomerDTO> list = new ArrayList<CustomerDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();

		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("         SELECT boardNum, b.userId, b.userName,");
			sb.append("               subject, groupNum, orderNo, depth, hitCount,");
			sb.append("               created");
			sb.append("               FROM customer b");
			sb.append("               JOIN member m ON b.userId=m.userId");
			sb.append("               ORDER BY groupNum DESC, orderNo ASC ");
			sb.append("    ) tb WHERE ROWNUM <= ? ");
			sb.append(") WHERE rnum >= ? ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				CustomerDTO dto = new CustomerDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setDepth(rs.getInt("depth"));
				dto.setOrderNo(rs.getInt("orderNo"));
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

	public List<CustomerDTO> listCustomer(int start, int end, String searchKey, String searchValue) {
		List<CustomerDTO> list = new ArrayList<CustomerDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();

		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("         SELECT boardNum, b.userId, userName,");
			sb.append("               subject, groupNum, orderNo, depth, hitCount,");
			sb.append("               created");
			sb.append("               FROM customer b");
			sb.append("               JOIN member m ON b.userId=m.userId");
			if (searchKey.equals("created"))
				sb.append("           WHERE TO_CHAR(created, 'YYYY-MM-DD') = ? ");
			else if (searchKey.equals("userName"))
				sb.append("           WHERE INSTR(userName, ?) = 1 ");
			else
				sb.append("           WHERE INSTR(" + searchKey + ", ?) >= 1 ");

			sb.append("               ORDER BY groupNum DESC, orderNo ASC ");
			sb.append("    ) tb WHERE ROWNUM <= ?");
			sb.append(") WHERE rnum >= ?");

			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setString(1, searchValue);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				CustomerDTO dto = new CustomerDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setDepth(rs.getInt("depth"));
				dto.setOrderNo(rs.getInt("orderNo"));
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

	public CustomerDTO readCustomer(int boardNum) {
		CustomerDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();

		try {
			sb.append("SELECT boardNum, b.userId, b.userName, subject, ");
			sb.append("    content, created, hitCount, groupNum, depth, orderNo, parent ");
			sb.append("    FROM customer b");
			sb.append("    JOIN member m ON b.userId=m.userId");
			sb.append("    WHERE boardNum=?");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, boardNum);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new CustomerDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setDepth(rs.getInt("depth"));
				dto.setOrderNo(rs.getInt("orderNo"));
				dto.setParent(rs.getInt("parent"));
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

	public CustomerDTO preReadCustomer(int groupNum, int orderNo, String searchKey, String searchValue) {
		CustomerDTO dto = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();

		try {
			if (searchValue != null && searchValue.length() != 0) {
				sb.append("SELECT ROWNUM, tb.* FROM ( ");
				sb.append("  SELECT boardNum, subject  ");
				sb.append("               FROM customer b");
				sb.append("               JOIN member m ON b.userId=m.userId");
				if (searchKey.equals("created"))
					sb.append("           WHERE (TO_CHAR(created, 'YYYY-MM-DD') = ? ) AND ");
				else if (searchKey.equals("userName"))
					sb.append("           WHERE (INSTR(userName, ?) = 1 ) AND ");
				else
					sb.append("           WHERE (INSTR(" + searchKey + ", ?) >= 1 ) AND ");

				sb.append("     (( groupNum = ? AND orderNo < ?) ");
				sb.append("         OR (groupNum > ? )) ");
				sb.append("         ORDER BY groupNum ASC, orderNo DESC) tb WHERE ROWNUM = 1 ");

				pstmt = conn.prepareStatement(sb.toString());

				pstmt.setString(1, searchValue);
				pstmt.setInt(2, groupNum);
				pstmt.setInt(3, orderNo);
				pstmt.setInt(4, groupNum);
			} else {
				sb.append("SELECT ROWNUM, tb.* FROM ( ");
				sb.append("     SELECT boardNum, subject FROM customer b JOIN member m ON b.userId=m.userId ");
				sb.append("  WHERE (groupNum = ? AND orderNo < ?) ");
				sb.append("         OR (groupNum > ? ) ");
				sb.append("         ORDER BY groupNum ASC, orderNo DESC) tb WHERE ROWNUM = 1 ");

				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, groupNum);
				pstmt.setInt(2, orderNo);
				pstmt.setInt(3, groupNum);
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new CustomerDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setSubject(rs.getString("subject"));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;

	}

	public CustomerDTO nextReadCustomer(int groupNum, int orderNo, String searchKey, String searchValue){
		CustomerDTO dto=null;


        PreparedStatement pstmt=null;
        ResultSet rs=null;
        StringBuffer sb = new StringBuffer();

        try {
            if(searchValue!=null && searchValue.length() != 0) {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("  SELECT boardNum, subject ");
    			sb.append("               FROM customer b");
    			sb.append("               JOIN member m ON b.userId=m.userId");
    			if(searchKey.equals("created"))
    				sb.append("           WHERE (TO_CHAR(created, 'YYYY-MM-DD') = ? ) AND ");
    			else if(searchKey.equals("userName"))
    				sb.append("           WHERE (INSTR(userName, ?) = 1) AND ");
    			else
    				sb.append("           WHERE (INSTR(" + searchKey + ", ?) >= 1) AND ");
    			
                sb.append("     (( groupNum = ? AND orderNo > ?) ");
                sb.append("         OR (groupNum < ? )) ");
                sb.append("         ORDER BY groupNum DESC, orderNo ASC) tb WHERE ROWNUM = 1 ");

                pstmt=conn.prepareStatement(sb.toString());
                pstmt.setString(1, searchValue);
                pstmt.setInt(2, groupNum);
                pstmt.setInt(3, orderNo);
                pstmt.setInt(4, groupNum);

			} else {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("     SELECT boardNum, subject FROM customer b JOIN member m ON b.userId=m.userId ");
                sb.append("  WHERE (groupNum = ? AND orderNo > ?) ");
                sb.append("         OR (groupNum < ? ) ");
                sb.append("         ORDER BY groupNum DESC, orderNo ASC) tb WHERE ROWNUM = 1 ");

                pstmt=conn.prepareStatement(sb.toString());
                pstmt.setInt(1, groupNum);
                pstmt.setInt(2, orderNo);
                pstmt.setInt(3, groupNum);
            }

            rs=pstmt.executeQuery();

            if(rs.next()) {
                dto=new CustomerDTO();
                dto.setBoardNum(rs.getInt("boardNum"));
                dto.setSubject(rs.getString("subject"));
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }

        return dto;

	}
	

    public int updateHitCount(int boardNum){
    	int result=0;
    	PreparedStatement pstmt=null;
    	String sql;
    	
    	sql="UPDATE customer SET hitCount=hitCount+1 WHERE boardNum=?";
    	try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, boardNum);
			result=pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
    
    return result;
    }

    public int updateCustomer(CustomerDTO  dto){
    	int result=0;
    	PreparedStatement pstmt= null;
    	String sql;
    	
    	sql="UPDATE customer SET subject=?, content=?";
    	sql+="WHERE boardNum=?";
    	
    	try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getBoardNum());
			result=pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
    	
    	return result;
    }
	
    public int deleteCustomer(int boardNum){
    	int result=0;
    	PreparedStatement pstmt=null;
    	String sql;
    	
    	sql="DELETE FROM customer WHERE boardNum IN (SELECT boardNum FROM customer  START WITH boardNum=? CONNECT BY PRIOR boardNum=parent)";
    	
    	try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, boardNum);
			result=pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
    	
    	return result;
    }
}
