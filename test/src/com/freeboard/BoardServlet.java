package com.freeboard;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/free_board/*")
public class BoardServlet  extends MyServlet{
	private static final long serialVersionUID = 1L;

	
	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String uri=req.getRequestURI();
		String cp=req.getContextPath();
		// �α��� ������ ���ǿ��� ��������
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"notice";
		File f=new File(pathname);
		if(! f.exists())
			f.mkdirs();
		
		if(info==null) { // �α��ε��� ���� ���
				resp.sendRedirect(cp+"/member/login.do");
					return;
		}
				
		BoardDAO dao=new BoardDAO();
		MyUtil util=new MyUtil();
				
		
		if(uri.indexOf("board_free.do")!=-1) {
			// �� ����Ʈ
            String page=req.getParameter("page");
            int current_page=1;
            if(page!=null)
            current_page=Integer.parseInt(page);
                     
            // �˻�
            String searchKey=req.getParameter("searchKey");
            String searchValue=req.getParameter("searchValue");
            if(searchKey==null) {
               searchKey="subject";
               searchValue="";
            }
                     
            // GET ����� ��� ���ڵ�
            if(req.getMethod().equalsIgnoreCase("GET")) {
               searchValue=URLDecoder.decode(searchValue, "utf-8");
            }
                     
            // ��ü ������ ����
            int dataCount;
            if(searchValue.length()==0)
               dataCount=dao.dataCount();
            else
               dataCount=dao.dataCount(searchKey, searchValue);
            // ��ü ������ ��
            int numPerPage=10;
            int total_page=util.pageCount(numPerPage, dataCount);
                     
            if(current_page>total_page)
               current_page=total_page;
                     
            // �Խù� ������ ���۰� ��
            int start=(current_page-1)*numPerPage+1;
            int end=current_page*numPerPage;
            // �Խù� ��������
            List<BoardDTO> list=null;
            if(searchValue.length()==0)
               list=dao.listBoard(start, end);
            else
               list=dao.listBoard(start, end, searchKey, searchValue);
            
            //����Ʈ �۹�ȣ �����
            int listNum, n=0;
            Iterator<BoardDTO>it=list.iterator();
            while(it.hasNext()) {
            	BoardDTO dto=it.next();
               listNum=dataCount-(start+n-1);
               dto.setListNum(listNum);
               n++;
            }
            
            String params="";
            if(searchValue.length()!=0) {
               // �˻��� ��� �˻��� ���ڵ�
               searchValue=URLEncoder.encode(searchValue, "utf-8");
               params="searchKey="+searchKey+
                      "&searchValue="+searchValue;
            }
            
            // ����¡ ó��
            String listUrl=cp+"/free_board/board_free.do";
            String articleUrl=cp+"/free_board/article.do?page="+current_page;
            if(params.length()!=0) {
               listUrl+="?"+params;
               articleUrl+="&"+params;
            }
            
            String paging=util.paging(current_page, total_page, listUrl);
            
            // �������� JSP�� �ѱ� �Ӽ�
            req.setAttribute("list", list);
            req.setAttribute("page", current_page);
            req.setAttribute("total_page", total_page);
            req.setAttribute("dataCount", dataCount);
            req.setAttribute("paging", paging);
            req.setAttribute("articleUrl", articleUrl);	
            
        
            
			forward(req, resp, "/WEB-INF/views/free_board/free_list.jsp");
			
		}else if(uri.indexOf("board_free_create.do")!=-1){
			
			req.setAttribute("mode", "created");
			forward(req, resp, "/WEB-INF/views/free_board/free_create.jsp");
			
		}else if(uri.indexOf("board_free_created_ok")!=-1){
			
			String encType="UTF-8";
			int maxFilesize=5*1024*1024;
			
			MultipartRequest mreq=null;
			mreq=new MultipartRequest(req, pathname,maxFilesize,encType,new DefaultFileRenamePolicy());
			
			// �� ����
			BoardDTO dto=new BoardDTO();
			dto.setUserId(info.getUserId());
			
			// �Ķ����
			dto.setSubject(mreq.getParameter("subject"));
			dto.setContent(mreq.getParameter("content"));
			File file=mreq.getFile("upload");
			if(file!=null){
				dto.setSaveFilename(mreq.getFilesystemName("upload"));
				dto.setOriginalFilename(mreq.getOriginalFileName("upload"));
				dto.setFilesize(file.length());
			}
			
			dao.insertBoard(dto);
			
			
			resp.sendRedirect(cp+"/free_board/board_free.do");
			
			
		}
	}
}
