package com.tools;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
			sb.append("INSERT INTO ITEM(itemCode, itemName) VALUES (?, ?)");
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, dto.getItemCode());
			pstmt.setString(2, dto.getItemName());
			result = pstmt.executeUpdate();
			pstmt.close();
			pstmt=null;
			sb.delete(0, sb.length());
			
			sb.append("INSERT INTO ITEMDETAIL(num, itemCode, name, content, makesa, fileName) ");
			sb.append(" VALUES(itemDetail_seq.NEXTVAL, ?, ?, ?, ?, ?)");
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, dto.getItemCode());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getMakesa());
			pstmt.setString(5, dto.getFileName());
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
			sql="SELECT NVL(COUNT(*), 0) FROM item WHERE itemName = ?";
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
        		sql="SELECT NVL(COUNT(*), 0) FROM ITEM i1 JOIN ITEMDETAIL i2 ON i1.itemCode=i2.itemCode WHERE itemName = ? AND INSTR(i1.itemCode, ?) >= 1";
        	else if(searchKey.equals("name"))
        		sql="SELECT NVL(COUNT(*), 0) FROM ITEM i1 JOIN ITEMDETAIL i2 ON i1.itemCode=i2.itemCode WHERE itemName = ? AND INSTR(name, ?) >= 1";
        	else
        		sql="SELECT NVL(COUNT(*), 0) FROM ITEM i1 JOIN ITEMDETAIL i2 ON i1.itemCode=i2.itemCode WHERE itemName = ? AND INSTR(makesa, ?) >= 1  ";

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
			sb.append("         SELECT num, i1.itemCode, itemName,");
			sb.append("               name, content, makesa, fileName ");
			sb.append("               FROM item i1");
			sb.append("               JOIN itemdetail i2 ON i1.itemCode=i2.itemCode ");
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
			sb.append("         SELECT num, i1.itemCode, itemName,");
			sb.append("               name, content, makesa, fileName ");
			sb.append("               FROM item i1 ");
			sb.append("               JOIN itemdetail i2 ON i1.itemCode=i2.itemCode ");
			if(searchKey.equals("itemCode"))
				sb.append("           WHERE itemName = ? AND INSTR(i1.itemCode, ?) >= 1 ");
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
			sb.append("SELECT num, i1.itemCode, itemName,");
			sb.append("      name, content, makesa, fileName ");
			sb.append("		 FROM item i1");
			sb.append("      JOIN itemdetail i2 ON i1.itemCode=i2.itemCode ");
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

}
