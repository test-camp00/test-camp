package com.faq;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.util.DBConn;




public class FAQDAO {
	private Connection conn=DBConn.getConnection();
	
	public int insertFAQ(FAQDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("INSERT INTO FAQ(num, subject, content) ");
			sb.append("VALUES(FAQ_seq.NEXTVAL, ?, ?)");
			
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			
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
			sql="SELECT NVL(COUNT(*), 0) FROM FAQ";
			pstmt=conn.prepareStatement(sql);
			
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
	
	// 검색에서의 데이터 개수
	public int dataCount(String searchKey, String searchValue) {
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="SELECT NVL(COUNT(*), 0)  FROM FAQ ";
			if(searchKey.equals("subject"))
				sql+=" WHERE INSTR(subject, ?)= 1 ";
			else if(searchKey.equals("content"))
			   sql+="  WHERE INSTR(content, ?)= 1 ";
			else 
				sql+="  WHERE INSTR("+searchKey+",?) >=1";
			
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			
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
	
	public List<FAQDTO> listFAQ(int start, int end) {
		List<FAQDTO> list=new ArrayList<>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("SELECT* FROM(");
			sb.append("    SELECT ROWNUM rnum, tb.*FROM(");
			sb.append("        SELECT num, subject, content FROM FAQ");
			sb.append("                 ORDER BY num DESC");
			sb.append("    ) tb WHERE ROWNUM <=? ");
			sb.append(") WHERE rnum >=? ");
			

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);

			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				FAQDTO dto=new FAQDTO();
				
				dto.setNum(rs.getInt("num"));				
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				
				
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
	// 검색에서의 리스트
		public List<FAQDTO> listFAQ(int start, int end, String searchKey, String searchValue) {
			List<FAQDTO> list=new ArrayList<>();
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			StringBuffer sb=new StringBuffer();
			
			try {				
				sb.append("SELECT* FROM(");
				sb.append("    SELECT ROWNUM rnum, tb.*FROM(");
				sb.append("        SELECT num, subject, content FROM FAQ");
				if(searchKey.equals("subject"))
				    sb.append(" WHERE INSTR(subject, ?)= 1 ");
				else if(searchKey.equals("content"))
				    sb.append("  WHERE INSTR(content, ?)= 1 ");
				else 
				    sb.append("  WHERE INSTR("+searchKey+",?) >=1");
				sb.append("                 ORDER BY num DESC");
				sb.append("    ) tb WHERE ROWNUM <=? ");
				sb.append(") WHERE rnum >=? ");
				
				
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setString(1, searchValue);
				pstmt.setInt(2, end);
				pstmt.setInt(3, start);

				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					FAQDTO dto=new FAQDTO();
					
					dto.setNum(rs.getInt("num"));					
					dto.setSubject(rs.getString("subject"));				
					dto.setContent(rs.getString("content"));
					
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
	
	// 해당 게시물의 전체 값 가져오기
		public FAQDTO readFAQ(int num) {
			FAQDTO dto=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			StringBuffer sb=new StringBuffer();
			
			try {
				sb.append("SELECT num, subject, content FROM FAQ where num= ?");
				
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, num);

				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					dto=new FAQDTO();
					dto.setNum(rs.getInt("num"));					
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));					
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
		
		// 이전글
	    public FAQDTO preReadFAQ(int num, String searchKey, String searchValue) {
	        FAQDTO dto=null;

	        PreparedStatement pstmt=null;
	        ResultSet rs=null;
	        StringBuffer sb = new StringBuffer();

	        try {
	            if(searchValue!=null && searchValue.length() != 0) {	                
	                sb.append("  SELECT num, subject, content from FAQ");
	                if(searchKey.equals("subject"))
	                	sb.append("     WHERE (INSTR(subject, ?) = 1)  ");	               
	                else
	                	sb.append("     WHERE (INSTR(" + searchKey + ", ?) >= 1) ");
	                sb.append("         AND num > ?  ");
	                sb.append("         ORDER BY num ASC ");
	           

	                pstmt=conn.prepareStatement(sb.toString());
	                pstmt.setString(1, searchValue);
	                pstmt.setInt(2, num);
				} else {
					sb.append("SELECT num, subject, content FROM FAQ");
	                sb.append("     WHERE num > ? ");
	                sb.append("         ORDER BY num ASC ");	             

	                pstmt=conn.prepareStatement(sb.toString());
	                pstmt.setInt(1, num);
				}

	            rs=pstmt.executeQuery();

	            if(rs.next()) {
	                dto=new FAQDTO();
	                dto.setNum(rs.getInt("num"));
	                dto.setSubject(rs.getString("subject"));
	                dto.setContent(rs.getString("content"));
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

	    // 다음글
	    public FAQDTO nextReadFAQ(int num, String searchKey, String searchValue) {
	        FAQDTO dto=null;

	        PreparedStatement pstmt=null;
	        ResultSet rs=null;
	        StringBuffer sb = new StringBuffer();

	        try {
	            if(searchValue!=null && searchValue.length() != 0) {	                
	                sb.append("  SELECT num, subject, content from FAQ");
	                if(searchKey.equals("subject"))
	                	sb.append("     WHERE (INSTR(subject, ?) = 1)  ");	               
	                else
	                	sb.append("     WHERE (INSTR(" + searchKey + ", ?) >= 1) ");
	                sb.append("         AND num < ?  ");
	                sb.append("         ORDER BY num DESC ");
	           

	                pstmt=conn.prepareStatement(sb.toString());
	                pstmt.setString(1, searchValue);
	                pstmt.setInt(2, num);
				} else {
					sb.append("SELECT num, subject, content FROM FAQ");
	                sb.append("     WHERE num < ? ");
	                sb.append("         ORDER BY num DESC ");	             

	                pstmt=conn.prepareStatement(sb.toString());
	                pstmt.setInt(1, num);
				}

	            rs=pstmt.executeQuery();

	            if(rs.next()) {
	                dto=new FAQDTO();
	                dto.setNum(rs.getInt("num"));
	                dto.setSubject(rs.getString("subject"));
	                dto.setContent(rs.getString("content"));
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
	    
	    public int updateFAQ(FAQDTO dto) {
			int result = 0;
			PreparedStatement pstmt = null;
			String sql;
			
			sql="UPDATE FAQ SET subject=?, content=? WHERE num=?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getSubject());
				pstmt.setString(2, dto.getContent());
				pstmt.setInt(3, dto.getNum());
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
		
		public int deleteFAQ(int num) {
			int result = 0;
			PreparedStatement pstmt = null;
			String sql;
			
			sql="DELETE FROM FAQ WHERE num=?";
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

}
