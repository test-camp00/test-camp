package com.gallery;

import java.io.File;
import java.io.IOException;
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

@WebServlet("/gallery/*")
public class GalleryServlet extends MyServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String uri=req.getRequestURI();
		
		String cp=req.getContextPath();
		HttpSession session=req.getSession();
	
		//로그인 세션정보
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) { // 로그인되지 않은 경우
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+File.separator+"uploads"+File.separator+"gallery";
		File f=new File(pathname);
		if(! f.exists()) { // 폴더가 존재하지 않으면
			f.mkdirs();
		}
		
		GalleryDAO dao=new GalleryDAO();
		MyUtil util=new MyUtil();
		
		if(uri.indexOf("gallery_list.do")!=-1) {
			// 게시물 리스트
			String page=req.getParameter("page");
			int current_page=1;
			if(page!=null)
			current_page=Integer.parseInt(page);
						
			// 전체데이터 개수
			int dataCount=dao.dataCount();

			// 전체페이지수
			int numPerPage=6;
			int total_page=util.pageCount(numPerPage, dataCount);
			if(current_page>total_page)
				current_page=total_page;
						
			// 게시물 가져올 시작과 끝위치
			int start=(current_page-1)*numPerPage+1;
			int end=current_page*numPerPage;
						
			// 게시물 가져오기
			List<GalleryDTO> list=dao.listGallery(start, end);
						
			// 페이징 처리
			String listUrl=cp+"/gallery/gallery_list.do";
			String articleUrl = cp + "/gallery/article.do?page="+current_page;
			String paging=util.paging(current_page, total_page, listUrl);
						
						// 포워딩할 list.jsp에 넘길 값
			req.setAttribute("list", list);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("articleUrl", articleUrl);
			req.setAttribute("page", current_page);
			req.setAttribute("total_page", total_page);
			req.setAttribute("paging", paging);
			
			forward(req, resp, "/WEB-INF/views/gallery/gallery_list.jsp");
		}else if(uri.indexOf("created.do") != -1){
			req.setAttribute("mode", "created");
			String path="/WEB-INF/views/gallery/gallery_created.jsp";
			forward(req, resp, path);
		}else if(uri.indexOf("created_ok.do") != -1){
			String encType="utf-8";
			int maxSize=10*1024*1024;
			
			MultipartRequest mreq=new MultipartRequest(
					req, pathname, maxSize, encType,
					new DefaultFileRenamePolicy());
		
			GalleryDTO dto=new GalleryDTO();
			
			// 이미지 파일을 업로드 한경우
			if(mreq.getFile("upload")!=null) {
				dto.setUserId(info.getUserId());
							
				dto.setSubject(mreq.getParameter("subject"));
				dto.setContent(mreq.getParameter("content"));
							
				// 서버에 저장된 파일명
				String saveFilename=mreq.getFilesystemName("upload");
							
				// 파일이름변경
				saveFilename = FileManager.doFilerename(pathname, saveFilename);
							
				dto.setFilename(saveFilename);
							
				// 저장
				dao.insertGallery(dto);
			}
			resp.sendRedirect(cp+"/gallery/gallery_list.do");
		}else if(uri.indexOf("article.do") != -1){
			int num=Integer.parseInt(req.getParameter("num"));
			String page=req.getParameter("page");
			
			GalleryDTO dto=dao.readGallery(num);
			if(dto==null) {
				resp.sendRedirect(cp+"/gallery/gallery_list.do?page="+page);
				return;
			}
			
			
			List<ReplyDTO> listReply=dao.readreply(num);
			
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			req.setAttribute("dto", dto);
			req.setAttribute("listReply", listReply);
			req.setAttribute("page", page);
			
			String path="/WEB-INF/views/gallery/gallery_article.jsp";
			forward(req, resp, path);
		}else if(uri.indexOf("update.do")!=-1) {
			// 수정 폼
			String page=req.getParameter("page");
			int num=Integer.parseInt(req.getParameter("num"));
			GalleryDTO dto=dao.readGallery(num);
			
			if(dto==null) {
				resp.sendRedirect(cp+"/gallery/gallery_list.do?page="+page);
				return;
			}
			
			// 게시물을 올린 사용자가 아니면
			if(! dto.getUserId().equals(info.getUserId())) {
				resp.sendRedirect(cp+"/gallery/gallery_list.do?page="+page);
				return;
			}
			
			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			
			req.setAttribute("mode", "update");
			String path="/WEB-INF/views/gallery/gallery_created.jsp";
			forward(req, resp, path);
			
		}else if(uri.indexOf("update_ok.do")!=-1) {
			// 수정 완료
			String encType="utf-8";
			int maxSize=5*1024*1024;
			
			MultipartRequest mreq=new MultipartRequest(
					req, pathname, maxSize, encType,
					new DefaultFileRenamePolicy());
			
			String page=mreq.getParameter("page");
			String filename=mreq.getParameter("filename");
			
			GalleryDTO dto=new GalleryDTO();
			dto.setNum(Integer.parseInt(mreq.getParameter("num")));
			dto.setSubject(mreq.getParameter("subject"));
			dto.setContent(mreq.getParameter("content"));
			
			// 이미지 파일을 업로드 한경우
			if(mreq.getFile("upload")!=null) {
				// 기존 이미지 파일 지우기
				FileManager.doFiledelete(pathname, filename);
				
				// 서버에 저장된 파일명
				String saveFilename=mreq.getFilesystemName("upload");
				
				// 파일 이름 변경
				saveFilename = FileManager.doFilerename(pathname, saveFilename);
				
				dto.setFilename(saveFilename);
			} else {
				// 새로운 이미지 파일을 올리지 않은 경우 기존 이미지 파일로
				dto.setFilename(filename);
			}
			
			dao.updateGallery(dto);
			
			resp.sendRedirect(cp+"/gallery/gallery_list.do?page="+page);	
			
		}else if(uri.indexOf("delete.do") != -1){
			// 삭제 완료
			int num=Integer.parseInt(req.getParameter("num"));
			String page=req.getParameter("page");
			
			GalleryDTO dto=dao.readGallery(num);
			if(dto==null) {
				resp.sendRedirect(cp+"/gallery/gallery_list.do?page="+page);	
				return;
			}
			
			// 게시물을 올린 사용자나 admin이 아니면
			if(! dto.getUserId().equals(info.getUserId()) && ! info.getUserId().equals("admin")) {
				resp.sendRedirect(cp+"/gallery/gallery_list.do?page="+page);
				return;
			}
			
			// 이미지 파일 지우기
			FileManager.doFiledelete(pathname, dto.getFilename());
			
			// 테이블 데이터 삭제
			dao.deleteGallery(num);
			
			resp.sendRedirect(cp+"/gallery/gallery_list.do?page="+page);
		}else if(uri.indexOf("createReply.do")!=-1){
			int num=Integer.parseInt(req.getParameter("num"));
			String page=req.getParameter("page");
			ReplyDTO dto=new ReplyDTO();

			
			// 파라미터
			
			dto.setUserId(info.getUserId());
			dto.setNum(num);
			dto.setContent(req.getParameter("content"));
			
			dao.insertReply(dto);
			
			//파라미터
			String params="page="+page;
			
			
			// JSP로 전달할 속성
			resp.sendRedirect(cp+"/gallery/article.do?"+params+"&num="+num);
			
		}else if(uri.indexOf("deleteReply.do")!=-1){
			int replyNum=Integer.parseInt(req.getParameter("replyNum"));
			int num=Integer.parseInt(req.getParameter("num"));
			String page=req.getParameter("page");

			
			dao.deleteReply(replyNum);
			
			
			//파라미터
			String params="page="+page;
			
			
			// JSP로 전달할 속성
						
			resp.sendRedirect(cp+"/gallery/article.do?"+params+"&num="+num);	
		}
	
	}
}
