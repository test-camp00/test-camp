package com.tradeboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

			sb.append("INSERT INTO tradeboard(");
			sb.append("  NUM, USERID, SUBJECT, CONTENT, ");
			sb.append("  HITCOUNT, SAVEFILENAME, ORIGINALFILENAME,FILESIZE) ");
			sb.append("  VALUES (tradeboard_seq.nextval,?,?,?,?,?,?,?)");
			
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
			sql="SELECT NVL(COUNT(*),0) FROM tradeboard";
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
        		sql="SELECT NVL(COUNT(*), 0) FROM tradeboard t JOIN MEMBER m ON t.userId=m.userId WHERE TO_CHAR(created, 'YYYY-MM-DD') = ?  ";
        	else if(searchKey.equals("userName"))
        		sql="SELECT NVL(COUNT(*), 0) FROM tradeboard t JOIN MEMBER m ON t.userId=m.userId WHERE INSTR(userName, ?) = 1 ";
        	else
        		sql="SELECT NVL(COUNT(*), 0) FROM tradeboard t JOIN MEMBER m ON t.userId=m.userId WHERE INSTR(" + searchKey + ", ?) >= 1 ";

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
			sb.append("         SELECT num, t.userId, userName,");
			sb.append("               subject, TO_CHAR(created,'yyyy-mm-dd') created,hitCount,");
			sb.append("               saveFilename");
			sb.append("               FROM tradeboard t");
			sb.append("               JOIN MEMBER m ON t.userId=m.userId");
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
			sb.append("         SELECT num, t.userId, userName,");
			sb.append("               subject, TO_CHAR(created,'yyyy-mm-dd') created,hitCount,");
			sb.append("               saveFilename");
			sb.append("               FROM tradeboard t");
			sb.append("               JOIN MEMBER m ON t.userId=m.userId");
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
	public BoardDTO readBoard(int num) {
		BoardDTO dto=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT num, t.userId, userName, subject, ");
			sb.append("    content, created, hitCount,saveFilename,originalFilename,filesize ");
			sb.append("    FROM tradeboard t");
			sb.append("    JOIN member m ON t.userId=m.userId");
			sb.append("    WHERE num=?");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto=new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				dto.setSaveFilename(rs.getString("saveFilename"));
				dto.setOriginalFilename(rs.getString("originalFilename"));
				dto.setFilesize(rs.getLong("filesize"));
			}
			rs.close();
			pstmt.close();
					
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}
	
    // 이전글
    public BoardDTO preReadBoard(int num,String searchKey, String searchValue) {
        BoardDTO dto=null;

        PreparedStatement pstmt=null;
        ResultSet rs=null;
        StringBuffer sb = new StringBuffer();

        try {
            if(searchValue!=null && searchValue.length() != 0) {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("  SELECT num, subject  ");
    			sb.append("               FROM tradeboard t");
    			sb.append("               JOIN member m ON t.userId=m.userId");
    			if(searchKey.equals("created"))
    				sb.append("           WHERE (TO_CHAR(created, 'YYYY-MM-DD') = ? ) AND ");
    			else if(searchKey.equals("userName"))
    				sb.append("           WHERE (INSTR(userName, ?) = 1 ) AND ");
    			else
    				sb.append("           WHERE (INSTR(" + searchKey + ", ?) >= 1 ) ");
    			 sb.append("         AND (num > ? ) ");
                 sb.append("         ORDER BY num ASC ");
                 sb.append("      ) tb WHERE ROWNUM=1 ");

                pstmt=conn.prepareStatement(sb.toString());
                
                pstmt.setString(1, searchValue);
                pstmt.setInt(2, num);
			} else {
				
				sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("     SELECT num, subject FROM tradeboard t JOIN member m ON t.userId=m.userId ");                
                sb.append("     WHERE num > ? ");
                sb.append("         ORDER BY num ASC ");
                sb.append("      ) tb WHERE ROWNUM=1 ");            

                pstmt=conn.prepareStatement(sb.toString());
                pstmt.setInt(1, num);
			}

            rs=pstmt.executeQuery();

            if(rs.next()) {
                dto=new BoardDTO();
                dto.setNum(rs.getInt("num"));
                dto.setSubject(rs.getString("subject"));
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
    
        return dto;
    }

    // 다음글
    public BoardDTO nextReadBoard(int num,String searchKey, String searchValue) {
        BoardDTO dto=null;

        PreparedStatement pstmt=null;
        ResultSet rs=null;
        StringBuffer sb = new StringBuffer();

        try {
            if(searchValue!=null && searchValue.length() != 0) {
                sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("  SELECT num, subject  ");
    			sb.append("               FROM tradeboard t");
    			sb.append("               JOIN member m ON f.userId=m.userId");
    			if(searchKey.equals("created"))
    				sb.append("           WHERE (TO_CHAR(created, 'YYYY-MM-DD') = ? ) AND ");
    			else if(searchKey.equals("userName"))
    				sb.append("           WHERE (INSTR(userName, ?) = 1 ) AND ");
    			else
    				sb.append("           WHERE (INSTR(" + searchKey + ", ?) >= 1 ) ");
    			 sb.append("         AND (num < ? ) ");
                 sb.append("         ORDER BY num DESC ");
                 sb.append("      ) tb WHERE ROWNUM=1 ");

                pstmt=conn.prepareStatement(sb.toString());
                
                pstmt.setString(1, searchValue);
                pstmt.setInt(2, num);
                
                
			} else {
				
				sb.append("SELECT ROWNUM, tb.* FROM ( ");
                sb.append("     SELECT num, subject FROM tradeboard t JOIN member m ON t.userId=m.userId ");                
                sb.append("     WHERE num < ? ");
                sb.append("         ORDER BY num DESC ");
                sb.append("      ) tb WHERE ROWNUM=1 ");            

                pstmt=conn.prepareStatement(sb.toString());
                
                pstmt.setInt(1, num);
            
			}

            rs=pstmt.executeQuery();

            if(rs.next()) {
                dto=new BoardDTO();
                dto.setNum(rs.getInt("num"));
                dto.setSubject(rs.getString("subject"));
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }

        return dto;
    }
    
	public int updateHitCount(int num) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		sql = "UPDATE tradeboard SET hitCount=hitCount+1 WHERE num=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	public int deleteBoard(int num) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		sql="DELETE FROM tradeboard WHERE num=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
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
	
	public int updateBoard(BoardDTO dto) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql="UPDATE tradeboard SET subject=?, content=?, saveFilename=?, originalFilename=?, filesize=? ";
			sql+= " WHERE num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getSaveFilename());
			pstmt.setString(4, dto.getOriginalFilename());
			pstmt.setLong(5, dto.getFilesize());
			pstmt.setInt(6, dto.getNum());
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
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
	
	public int insertReply(ReplyDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		
		try {

			sb.append("INSERT INTO TRADEREPLY(");
			sb.append("  REPLYNUM, NUM, USERID, CONTENT)");
			sb.append("  VALUES (TRADEREPLY_SEQ.NEXTVAL,?,?,?)");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getUserId());
			pstmt.setString(3, dto.getContent());

			
			
			result=pstmt.executeUpdate();
			pstmt.close();
			pstmt=null;
			
			
		} catch (Exception e) {
			System.out.println("쿼리가 그게 뭐냐");
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
			sb.append("    FROM TRADEREPLY");
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
		
		sql="DELETE FROM TRADEREPLY WHERE replyNum=?";
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
