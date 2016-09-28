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
		// 로그인 정보를 세션에서 가져오기
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"free";
		File f=new File(pathname);
		if(! f.exists())
			f.mkdirs();
		
		if(info==null) { // 로그인되지 않은 경우
				resp.sendRedirect(cp+"/member/login.do");
					return;
		}
				
		BoardDAO dao=new BoardDAO();
		MyUtil util=new MyUtil();
				
		
		if(uri.indexOf("board_free.do")!=-1) {//리스트
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
			
			req.setAttribute("mode2", "created");
			
			int result = dao.insertBoard(dto);
			if (result != 1) {
				String message = "게시글 등록이 실패 했습니다.";
				req.setAttribute("message", message);
				forward(req, resp, "/WEB-INF/views/free_board/complete.jsp");
				return;
			}

			StringBuffer sb = new StringBuffer();
			sb.append("<b>" + dto.getUserId() + "</b>님 게시글 등록이 성공 하셨습니다.<br>");

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
			
			// 조회수 증가
			dao.updateHitCount(num);
						
			// 게시물 가져오기
			BoardDTO dto=dao.readBoard(num);
			
			if(dto==null) { // 게시물이 없으면 다시 리스트로
					resp.sendRedirect(cp+"/free_board/board_free.do?page="+page);
					return;
			}
			
			
			int linesu = dto.getContent().split("\n").length;
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			// 이전글 다음글
			BoardDTO preReadDto=dao.preReadBoard(dto.getNum(),searchKey, searchValue);
			BoardDTO nextReadDto=dao.nextReadBoard(dto.getNum(),searchKey, searchValue);
			
			// 리스트나 이전글/다음글에서 사용할 파라미터
			String params="page="+page;
			if(searchValue.length()!=0) {
				params+="&searchKey="+searchKey
						+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
			}
			
			
			List<ReplyDTO> listReply=dao.readreply(num);
			
			// JSP로 전달할 속성
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
		    	pw.print("<script>alert('파일다운로드가 실패했습니다. !!!');history.back();</script>");
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
			
		}else if(uri.indexOf("update.do") != -1){//수정폼
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
			// 수정 완료
			
			
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
				// 기존 파일 삭제
				FileManager.doFiledelete(pathname, mreq.getParameter("saveFilename"));
				
		    	dto.setSaveFilename(mreq.getFilesystemName("upload"));
		    	dto.setOriginalFilename(mreq.getOriginalFileName("upload"));
			    dto.setFilesize(mreq.getFile("upload").length());
			}
			
			req.setAttribute("mode2", "update");
			req.setAttribute("page", page);
			
			int result = dao.updateBoard(dto);
			if (result != 1) {
				String message = "게시글 수정이 실패 했습니다.";
				req.setAttribute("message", message);
				forward(req, resp, "/WEB-INF/views/free_board/complete.jsp");
				return;
			}

			StringBuffer sb = new StringBuffer();
			sb.append("<b>'" + info.getUserId() + "</b>' 님의  게시글 수정이 성공 하셨습니다.<br>");

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

			
			// 파라미터
			
			dto.setUserId(info.getUserId());
			dto.setNum(num);
			dto.setContent(req.getParameter("content"));
			
			dao.insertReply(dto);
			
			//파라미터
			String params="page="+page;
			
			if(searchValue.length()!=0) {
				params+="&searchKey="+searchKey
						+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
			}
			
			// JSP로 전달할 속성
			
		
						
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
			
			
			//파라미터
			String params="page="+page;
			
			if(searchValue.length()!=0) {
				params+="&searchKey="+searchKey
						+"&searchValue="+URLEncoder.encode(searchValue, "utf-8");
			}
			
			// JSP로 전달할 속성
						
			resp.sendRedirect(cp+"/free_board/article.do?"+params+"&num="+num);	
		}
	}
}
