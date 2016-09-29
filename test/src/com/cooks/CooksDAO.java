package com.cooks;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class CooksDAO {
	private Connection conn = DBConn.getConnection();
	
	public int insertCook(CooksDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		StringBuffer sb = new StringBuffer();
		try {
			
			sb.append("INSERT INTO COOKDETAIL(num, cookCode, cookName, name, ways, memo, fileName, cookplay) ");
			sb.append(" VALUES(COOKDetail_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)");
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, dto.getCookCode());
			pstmt.setString(2, dto.getCookName());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getWays());
			pstmt.setString(5, dto.getMemo());
			pstmt.setString(6, dto.getFileName());
			pstmt.setString(7, dto.getCookplay());
			result = pstmt.executeUpdate();
			pstmt.close();
			pstmt=null;
			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		
		return result;
	}
	
	public int dataCount(String btnKey) {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql ;
		
		try {			
			sql="SELECT NVL(COUNT(*), 0) FROM COOKDETAIL WHERE cookName = ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, btnKey);
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
	
	public int dataCount(String searchKey, String searchValue, String btnKey) {
        int result=0;
        PreparedStatement pstmt=null;
        ResultSet rs=null;
        String sql;

        try {        	
            if(searchKey.equals("cookCode"))
        		sql="SELECT NVL(COUNT(*), 0) FROM COOKDETAIL WHERE cookName = ? AND INSTR(cookCode, ?) >= 1";
        	else if(searchKey.equals("name"))
        		sql="SELECT NVL(COUNT(*), 0) FROM COOKDETAIL WHERE cookName = ? AND INSTR(name, ?) >= 1";
        	else 
        		sql="SELECT NVL(COUNT(*), 0) FROM COOKDETAIL WHERE cookName = ? AND INSTR(ways, ?) >= 1  ";

            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, btnKey);
            pstmt.setString(2, searchValue);

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
	
	public List<CooksDTO> listCooks(int start, int end, String btnKey) {
		List<CooksDTO> list=new ArrayList<CooksDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("         SELECT num, cookCode, cookName,");
			sb.append("               name, ways, memo, fileName, cookplay");
			sb.append("               FROM COOKDETAIL");
			sb.append("               WHERE cookName = ? ");
			sb.append("               ORDER BY num DESC   ");
			sb.append("    ) tb WHERE ROWNUM <= ? ");
			sb.append(") WHERE rnum >= ? ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, btnKey);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);

			rs=pstmt.executeQuery();
			
			while (rs.next()) {
				CooksDTO dto=new CooksDTO();
				dto.setNum(rs.getInt("num"));
				dto.setCookCode(rs.getString("cookCode"));
				dto.setCookName(rs.getString("cookName"));
				dto.setName(rs.getString("name"));
				dto.setWays(rs.getString("ways"));
				dto.setMemo(rs.getString("memo"));
				dto.setFileName(rs.getString("fileName"));
				dto.setCookplay(rs.getString("cookplay"));
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
    public List<CooksDTO> listCooks(int start, int end, String searchKey, String searchValue, String btnKey) {
        List<CooksDTO> list=new ArrayList<CooksDTO>();

        PreparedStatement pstmt=null;
        ResultSet rs=null;
        StringBuffer sb = new StringBuffer();

        try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("         SELECT num,cookCode, cookName,");
			sb.append("               name, ways, memo, fileName, cookplay ");
			sb.append("               FROM COOKDETAIL ");
			if(searchKey.equals("cookCode"))
				sb.append("           WHERE cookName = ? AND INSTR(cookCode, ?) >= 1 ");
			else if(searchKey.equals("name"))
				sb.append("           WHERE cookName = ? AND INSTR(name, ?) >= 1 ");
			else
				sb.append("           WHERE cookName = ? AND INSTR(ways, ?) >= 1 ");
			sb.append("               ORDER BY num DESC   ");
			sb.append("    ) tb WHERE ROWNUM <= ?");
			sb.append(") WHERE rnum >= ?");
			

			pstmt=conn.prepareStatement(sb.toString());
            
			pstmt.setString(1, btnKey);
			pstmt.setString(2, searchValue);
			pstmt.setInt(3, end);
			pstmt.setInt(4, start);
            
            rs=pstmt.executeQuery();
            
            while(rs.next()) {
            	CooksDTO dto=new CooksDTO();
            	dto.setNum(rs.getInt("num"));
				dto.setCookCode(rs.getString("cookCode"));
				dto.setCookName(rs.getString("cookName"));
				dto.setName(rs.getString("name"));
				dto.setWays(rs.getString("ways"));
				dto.setMemo(rs.getString("memo"));
				dto.setFileName(rs.getString("fileName"));
				dto.setCookplay(rs.getString("cookplay"));
				list.add(dto);
            }
            rs.close();
            pstmt.close();
        }catch (Exception e) {
            System.out.println(e.toString());
        }
        return list;
    }
    
    public CooksDTO readCook(int num) {
    	CooksDTO dto=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT num, cookCode, cookName,");
			sb.append("      name, ways, memo, fileName, cookplay ");
			sb.append("		 FROM COOKDETAIL");
			sb.append("      WHERE num = ? ");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new CooksDTO();
				dto.setNum(rs.getInt("num"));
				dto.setCookCode(rs.getString("cookCode"));
				dto.setCookName(rs.getString("cookName"));
				dto.setName(rs.getString("name"));
				dto.setWays(rs.getString("ways"));
				dto.setMemo(rs.getString("memo"));
				dto.setFileName(rs.getString("fileName"));
				dto.setCookplay(rs.getString("cookplay"));
			}
			rs.close();
			pstmt.close();
					
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}
    
    public int updateCook(CooksDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("UPDATE COOKDETAIL SET cookName=?, cookCode=?, name=?, ways=?, memo=?, fileName=?, cookplay=? ");
			sb.append("   WHERE num=?");
			pstmt=conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, dto.getCookName());
			pstmt.setString(2, dto.getCookCode());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getWays());
			pstmt.setString(5, dto.getMemo());
			pstmt.setString(6, dto.getFileName());
			pstmt.setString(7, dto.getCookplay());
			pstmt.setInt(8, dto.getNum());
			
			result=pstmt.executeUpdate();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
    
    public int deleteCook(int num) {
    	int result=0;
    	PreparedStatement pstmt=null;
		String sql;
		
		try {
			sql="DELETE FROM COOKDETAIL WHERE num=?";
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
			sb.append("INSERT INTO COOKREPLY(replyNum, num, userId, content) ");
			sb.append(" VALUES (cookReply_seq.NEXTVAL, ?, ?, ?)");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getUserId());
			pstmt.setString(3, dto.getContent());
			
			result=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			if(pstmt!=null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					
				}
		}
		
		return result;
	}
    
    public int dataCountReply(int num) {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="SELECT NVL(COUNT(*), 0) FROM COOKREPLY WHERE num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			if(rs.next())
				result=rs.getInt(1);
			
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
		
		return result;
	}
    
    public List<ReplyDTO> listReply(int num, int start, int end) {
		List<ReplyDTO> list=new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("        SELECT replyNum, num, c.userId, userName, content");
			sb.append("            ,TO_CHAR(created, 'YYYY-MM-DD') created");
			sb.append("            FROM cookReply c JOIN member m ON c.userId=m.userId  ");
			sb.append("            WHERE num=?");
			sb.append("	       ORDER BY replyNum DESC");
			sb.append("    ) tb WHERE ROWNUM <= ? ");
			sb.append(") WHERE rnum >= ? ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, num);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);

			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ReplyDTO dto=new ReplyDTO();
				
				dto.setReplyNum(rs.getInt("replyNum"));
				dto.setNum(rs.getInt("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				
				list.add(dto);
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
		return list;
	}
    
    public int deleteReply(int replyNum) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		sql="DELETE FROM COOKREPLY WHERE replyNum=?";
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
    
    public int wanted(WantedDTO dto) {
    	int result=0;
    	PreparedStatement pstmt=null;
    	String sql;
    	
    	try {
    		sql="INSERT INTO WANTED(num, userId) VALUES(?, ?)";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, dto.getNum());
    		pstmt.setString(2, dto.getUserId());
    		result=pstmt.executeUpdate();
    		pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
    	
    	
    	return result;
    }
    
    public int wantedCount(int num) {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="SELECT NVL(COUNT(*), 0) FROM WANTED WHERE num = ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
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

}
