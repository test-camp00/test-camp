package com.freeboard;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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
import com.util.FileManager;
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
		String pathname=root+File.separator+"uploads"+File.separator+"free";
		File f=new File(pathname);
		if(! f.exists())
			f.mkdirs();
		
		if(info==null) { // �α��ε��� ���� ���
				resp.sendRedirect(cp+"/member/login.do");
					return;
		}
				
		BoardDAO dao=new BoardDAO();
		MyUtil util=new MyUtil();
				
		
		if(uri.indexOf("board_free.do")!=-1) {//����Ʈ
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
			
			req.setAttribute("mode2", "created");
			
			int result = dao.insertBoard(dto);
			if (result != 1) {
				String message = "�Խñ� ����� ���� �߽��ϴ�.";
				req.setAttribute("message", message);
				forward(req, resp, "/WEB-INF/views/free_board/complete.jsp");
				return;
			}

			StringBuffer sb = new StringBuffer();
			sb.append("<b>" + dto.getUserId() + "</b>�� �Խñ� ����� ���� �ϼ̽��ϴ�.<br>");

			req.setAttribute("message", sb.toString());
			
			forward(req, resp, "/WEB-INF/views/free_board/complete.jsp");
			
			
		}else if(uri.indexOf("article.do")!=-1){
			int num=Integer.parseInt(req.getParameter("num"));
			String page=req.getParameter("page");
			String searchKey=req.getParameter("searchKey");
			String searchValue=req.getParameter("searchValue");
			if(searchKey==null) {
				searchKey="subject";
				searchValue="";
			}
			
			if(req.getMethod().equalsIgnoreCase("GET"))
				searchValue=URLDecoder.decode(searchValue, "utf-8");
			
			// ��ȸ�� ����
			dao.updateHitCount(num);
						
			// �Խù� ��������
			BoardDTO dto=dao.readBoard(num);
			
			if(dto==null) { // �Խù��� ������ �ٽ� ����Ʈ��
					resp.sendRedirect(cp+"/free_board/board_free.do?page="+page);
					return;
			}
			
			
			int linesu = dto.getContent().split("\n").length;
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			// ������ ������
			BoardDTO preReadDto=dao.preReadBoard(dto.getNum(),searchKey, searchValue);
			BoardDTO nextReadDto=dao.nextReadBoard(dto.getNum(),searchKey, searchValue);
			
			// ����Ʈ�� ������/�����ۿ��� ����� �Ķ����
			String params="page="+page;
			if(searchValue.length()!=0) {
				params+="&searchKey="+searchKey
						+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
			}
			
			
			List<ReplyDTO> listReply=dao.readreply(num);
			
			// JSP�� ������ �Ӽ�
			req.setAttribute("dto", dto);
			req.setAttribute("listReply", listReply);
			req.setAttribute("searchKey", searchKey);
			req.setAttribute("searchValue", searchValue);
			req.setAttribute("linesu", linesu);
			req.setAttribute("page", page);
			req.setAttribute("params", params);
			req.setAttribute("preReadDto", preReadDto);
			req.setAttribute("nextReadDto", nextReadDto);
						
			forward(req, resp, "/WEB-INF/views/free_board/free_article.jsp");

		}else if(uri.indexOf("download.do")!=-1){
			
			int num=Integer.parseInt(req.getParameter("num"));
			String page=req.getParameter("page");
			
			BoardDTO dto=dao.readBoard(num);
			if(dto==null){
				resp.sendRedirect(cp+"/free_board/board_free.do?page="+page);
				return;
			}
			
			boolean b = FileManager.doFiledownload(dto.getSaveFilename(),
					dto.getOriginalFilename(), pathname, resp);
			
			if(! b) {
				resp.setContentType("text/html;charset=utf-8");
		    	PrintWriter pw=resp.getWriter();
		    	pw.print("<script>alert('���ϴٿ�ε尡 �����߽��ϴ�. !!!');history.back();</script>");
		    	return;
			}
			
		}else if(uri.indexOf("delete.do") != -1){
			String page = req.getParameter("page");
			int num = Integer.parseInt(req.getParameter("num"));
			BoardDTO dto=dao.readBoard(num);
			
			if(dto==null){
				resp.sendRedirect(cp+"/free_board/board_free.do?page="+page);
				return;
			}
			
			if (!dto.getUserId().equals(info.getUserId()) && !info.getUserId().equals("admin")) {
				resp.sendRedirect(cp+"/free_board/board_free.do?page="+page);
				return;
			}
			dao.deleteBoard(num);
			resp.sendRedirect(cp+"/free_board/board_free.do?page="+page);
			
		}else if(uri.indexOf("update.do") != -1){//������
			String page=req.getParameter("page");
			int num = Integer.parseInt(req.getParameter("num"));
			BoardDTO dto = dao.readBoard(num);
			
			if(dto==null){
				resp.sendRedirect(cp+"/free_board/board_free.do?page="+page);
				return;
			}
			
			if (!dto.getUserId().equals(info.getUserId())) {
				resp.sendRedirect(cp+"/free_board/board_free.do?page="+page);
				return;
			}
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("mode", "update");

			String path = "/WEB-INF/views/free_board/free_create.jsp";
			forward(req, resp, path);
		}else if (uri.indexOf("update_ok.do") != -1) {
			// ���� �Ϸ�
			
			
			String encType="utf-8";
			int maxFilesize=10*1024*1024;
			
		    MultipartRequest mreq=new MultipartRequest(
		    		req, pathname, maxFilesize, encType,
		    		new DefaultFileRenamePolicy()
		    		);

			BoardDTO dto=new BoardDTO();

			int num=Integer.parseInt(mreq.getParameter("num"));
			String page=mreq.getParameter("page");
			
			dto.setNum(num);
			dto.setSubject(mreq.getParameter("subject"));
			dto.setContent(mreq.getParameter("content"));
			dto.setSaveFilename(mreq.getParameter("saveFilename"));
			dto.setOriginalFilename(mreq.getParameter("originalFilename"));
			dto.setFilesize(Long.parseLong(mreq.getParameter("fileSize")));
			

			if(mreq.getFile("upload")!=null) {
				// ���� ���� ����
				FileManager.doFiledelete(pathname, mreq.getParameter("saveFilename"));
				
		    	dto.setSaveFilename(mreq.getFilesystemName("upload"));
		    	dto.setOriginalFilename(mreq.getOriginalFileName("upload"));
			    dto.setFilesize(mreq.getFile("upload").length());
			}
			
			req.setAttribute("mode2", "update");
			req.setAttribute("page", page);
			
			int result = dao.updateBoard(dto);
			if (result != 1) {
				String message = "�Խñ� ������ ���� �߽��ϴ�.";
				req.setAttribute("message", message);
				forward(req, resp, "/WEB-INF/views/free_board/complete.jsp");
				return;
			}

			StringBuffer sb = new StringBuffer();
			sb.append("<b>'" + info.getUserId() + "</b>' ����  �Խñ� ������ ���� �ϼ̽��ϴ�.<br>");

			req.setAttribute("message", sb.toString());
			
			forward(req, resp, "/WEB-INF/views/free_board/complete.jsp");
			
		}else if(uri.indexOf("deleteFile.do")!=-1) {
			int num=Integer.parseInt(req.getParameter("num"));
			String page=req.getParameter("page");
			
			BoardDTO dto=dao.readBoard(num);
			if(dto==null) {
				resp.sendRedirect(cp+"/free_board/board_free.do?page="+page);
				return;
			}
			
			if(info==null || ! info.getUserId().equals(dto.getUserId())) {
				resp.sendRedirect(cp+"/free_board/board_free.do?page="+page);
				return;
			}
			
			FileManager.doFiledelete(pathname, dto.getSaveFilename());
			dto.setOriginalFilename("");
			dto.setSaveFilename("");
			dto.setFilesize(0);
			
			dao.updateBoard(dto);
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			
			req.setAttribute("mode", "update");
			String path="/WEB-INF/views/free_board/free_create.jsp";
			forward(req, resp, path);			
			
		}else if(uri.indexOf("createReply.do")!=-1){
			int num=Integer.parseInt(req.getParameter("num"));
			String page=req.getParameter("page");
			String searchKey=req.getParameter("searchKey");
			String searchValue=req.getParameter("searchValue");
			
			if(searchKey==null) {
				searchKey="subject";
				searchValue="";
			}
			ReplyDTO dto=new ReplyDTO();

			
			// �Ķ����
			
			dto.setUserId(info.getUserId());
			dto.setNum(num);
			dto.setContent(req.getParameter("content"));
			
			dao.insertReply(dto);
			
			//�Ķ����
			String params="page="+page;
			
			if(searchValue.length()!=0) {
				params+="&searchKey="+searchKey
						+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
			}
			
			// JSP�� ������ �Ӽ�
			
		
						
			resp.sendRedirect(cp+"/free_board/article.do?"+params+"&num="+num);
			
		}else if(uri.indexOf("deleteReply.do")!=-1){
			int replyNum=Integer.parseInt(req.getParameter("replyNum"));
			int num=Integer.parseInt(req.getParameter("num"));
			String page=req.getParameter("page");
			String searchKey=req.getParameter("searchKey");
			String searchValue=req.getParameter("searchValue");
			
			if(searchKey==null) {
				searchKey="subject";
				searchValue="";
			}

			
			dao.deleteReply(replyNum);
			
			
			//�Ķ����
			String params="page="+page;
			
			if(searchValue.length()!=0) {
				params+="&searchKey="+searchKey
						+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
			}
			
			// JSP�� ������ �Ӽ�
						
			resp.sendRedirect(cp+"/free_board/article.do?"+params+"&num="+num);	
		}
	}
}
