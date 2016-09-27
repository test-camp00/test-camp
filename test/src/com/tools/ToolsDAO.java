package com.tools;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class ToolsDAO {
	private Connection conn = DBConn.getConnection();
	
	public int insertTool(ToolsDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		StringBuffer sb = new StringBuffer();
		try {
			
			sb.append("INSERT INTO ITEMDETAIL(num, itemCode, name, content, makesa, fileName, itemName) ");
			sb.append(" VALUES(itemDetail_seq.NEXTVAL, ?, ?, ?, ?, ?, ?)");
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, dto.getItemCode());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getMakesa());
			pstmt.setString(5, dto.getFileName());
			pstmt.setString(6, dto.getItemName());
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
		String sql;
		
		try {
			sql="SELECT NVL(COUNT(*), 0) FROM ITEMDETAIL WHERE itemName = ?";
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
        	if(searchKey.equals("itemCode"))
        		sql="SELECT NVL(COUNT(*), 0) FROM ITEMDETAIL WHERE itemName = ? AND INSTR(itemCode, ?) >= 1";
        	else if(searchKey.equals("name"))
        		sql="SELECT NVL(COUNT(*), 0) FROM ITEMDETAIL WHERE itemName = ? AND INSTR(name, ?) >= 1";
        	else
        		sql="SELECT NVL(COUNT(*), 0) FROM ITEMDETAIL WHERE itemName = ? AND INSTR(makesa, ?) >= 1  ";

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
	
	public List<ToolsDTO> listTools(int start, int end, String btnKey) {
		List<ToolsDTO> list=new ArrayList<ToolsDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		
		try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("         SELECT num, itemCode, itemName,");
			sb.append("               name, content, makesa, fileName ");
			sb.append("               FROM itemdetail");
			sb.append("               WHERE itemName = ? ");
			sb.append("               ORDER BY num DESC   ");
			sb.append("    ) tb WHERE ROWNUM <= ? ");
			sb.append(") WHERE rnum >= ? ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, btnKey);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);

			rs=pstmt.executeQuery();
			
			while (rs.next()) {
				ToolsDTO dto=new ToolsDTO();
				dto.setNum(rs.getInt("num"));
				dto.setItemCode(rs.getString("itemCode"));
				dto.setItemName(rs.getString("itemName"));
				dto.setName(rs.getString("name"));
				dto.setContent(rs.getString("content"));
				dto.setMakesa(rs.getString("makesa"));
				dto.setFileName(rs.getString("fileName"));	
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
    public List<ToolsDTO> listTools(int start, int end, String searchKey, String searchValue, String btnKey) {
        List<ToolsDTO> list=new ArrayList<ToolsDTO>();

        PreparedStatement pstmt=null;
        ResultSet rs=null;
        StringBuffer sb = new StringBuffer();

        try {
			sb.append("SELECT * FROM (");
			sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
			sb.append("         SELECT num, itemCode, itemName,");
			sb.append("               name, content, makesa, fileName ");
			sb.append("               FROM itemdetail ");
			if(searchKey.equals("itemCode"))
				sb.append("           WHERE itemName = ? AND INSTR(itemCode, ?) >= 1 ");
			else if(searchKey.equals("name"))
				sb.append("           WHERE itemName = ? AND INSTR(name, ?) >= 1 ");
			else
				sb.append("           WHERE itemName = ? AND INSTR(makesa, ?) >= 1 ");
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
            	ToolsDTO dto=new ToolsDTO();
            	dto.setNum(rs.getInt("num"));
				dto.setItemCode(rs.getString("itemCode"));
				dto.setItemName(rs.getString("itemName"));
				dto.setName(rs.getString("name"));
				dto.setContent(rs.getString("content"));
				dto.setMakesa(rs.getString("makesa"));
				dto.setFileName(rs.getString("fileName"));	
				list.add(dto);
            }
            rs.close();
            pstmt.close();
        }catch (Exception e) {
            System.out.println(e.toString());
        }
        return list;
    }
    
    public ToolsDTO readTool(int num) {
    	ToolsDTO dto=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT num, itemCode, itemName,");
			sb.append("      name, content, makesa, fileName ");
			sb.append("		 FROM itemdetail");
			sb.append("      WHERE num = ? ");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new ToolsDTO();
				dto.setNum(rs.getInt("num"));
				dto.setItemCode(rs.getString("itemCode"));
				dto.setItemName(rs.getString("itemName"));
				dto.setName(rs.getString("name"));
				dto.setContent(rs.getString("content"));
				dto.setMakesa(rs.getString("makesa"));
				dto.setFileName(rs.getString("fileName"));	
			}
			rs.close();
			pstmt.close();
					
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}
    
    public int updateTool(ToolsDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("UPDATE itemdetail SET itemname=?, itemcode=?, name=?, content=?, makesa=?, fileName=? ");
			sb.append("   WHERE num=?");
			pstmt=conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, dto.getItemName());
			pstmt.setString(2, dto.getItemCode());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getMakesa());
			pstmt.setString(6, dto.getFileName());
			pstmt.setInt(7, dto.getNum());
			
			result=pstmt.executeUpdate();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
    
    public int deleteTool(int num) {
    	int result=0;
    	PreparedStatement pstmt=null;
		String sql;
		
		try {
			sql="DELETE FROM itemdetail WHERE num=?";
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
			sb.append("INSERT INTO itemReply(replyNum, num, userId, content) ");
			sb.append(" VALUES (itemReply_seq.NEXTVAL, ?, ?, ?)");
			
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
			sql="SELECT NVL(COUNT(*), 0) FROM itemReply WHERE num=?";
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
			sb.append("        SELECT replyNum, num, i.userId, userName, content");
			sb.append("            ,TO_CHAR(created, 'YYYY-MM-DD') created");
			sb.append("            FROM itemReply i JOIN member m ON i.userId=m.userId  ");
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
		
		sql="DELETE FROM itemReply WHERE replyNum=?";
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
    		sql="INSERT INTO itemwanted(num, userId) VALUES(?, ?)";
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
			sql="SELECT NVL(COUNT(*), 0) FROM itemwanted WHERE num = ?";
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
