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
		// 로그인 정보를 세션에서 가져오기
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"notice";
		File f=new File(pathname);
		if(! f.exists())
			f.mkdirs();
		
		if(info==null) { // 로그인되지 않은 경우
				resp.sendRedirect(cp+"/member/login.do");
					return;
		}
				
		BoardDAO dao=new BoardDAO();
		MyUtil util=new MyUtil();
				
		
		if(uri.indexOf("board_free.do")!=-1) {
			// 글 리스트
            String page=req.getParameter("page");
            int current_page=1;
            if(page!=null)
            current_page=Integer.parseInt(page);
                     
            // 검색
            String searchKey=req.getParameter("searchKey");
            String searchValue=req.getParameter("searchValue");
            if(searchKey==null) {
               searchKey="subject";
               searchValue="";
            }
                     
            // GET 방식인 경우 디코딩
            if(req.getMethod().equalsIgnoreCase("GET")) {
               searchValue=URLDecoder.decode(searchValue, "utf-8");
            }
                     
            // 전체 데이터 개수
            int dataCount;
            if(searchValue.length()==0)
               dataCount=dao.dataCount();
            else
               dataCount=dao.dataCount(searchKey, searchValue);
            // 전체 페이지 수
            int numPerPage=10;
            int total_page=util.pageCount(numPerPage, dataCount);
                     
            if(current_page>total_page)
               current_page=total_page;
                     
            // 게시물 가져올 시작과 끝
            int start=(current_page-1)*numPerPage+1;
            int end=current_page*numPerPage;
            // 게시물 가져오기
            List<BoardDTO> list=null;
            if(searchValue.length()==0)
               list=dao.listBoard(start, end);
            else
               list=dao.listBoard(start, end, searchKey, searchValue);
            
            //리스트 글번호 만들기
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
               // 검색인 경우 검색값 인코딩
               searchValue=URLEncoder.encode(searchValue, "utf-8");
               params="searchKey="+searchKey+
                      "&searchValue="+searchValue;
            }
            
            // 페이징 처리
            String listUrl=cp+"/free_board/board_free.do";
            String articleUrl=cp+"/free_board/article.do?page="+current_page;
            if(params.length()!=0) {
               listUrl+="?"+params;
               articleUrl+="&"+params;
            }
            
            String paging=util.paging(current_page, total_page, listUrl);
            
            // 포워딩할 JSP로 넘길 속성
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
			
			// 글 저장
			BoardDTO dto=new BoardDTO();
			dto.setUserId(info.getUserId());
			
			// 파라미터
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
