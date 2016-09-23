package com.onetoone;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.member.SessionInfo;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/onetoone/*")
public class OnetooneServlet extends MyServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String uri=req.getRequestURI();
		String cp=req.getContextPath();
		
		HttpSession session=req.getSession();
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		OnetooneDAO dao= new OnetooneDAO();
		MyUtil util= new MyUtil();
		
		if(uri.indexOf("onetoone.do")!=-1){
			String page=req.getParameter("page");
			int current_page=1;
			if(page!=null && page.length()!=0)
				current_page=Integer.parseInt(page);
			int dataCount=dao.dataCount();
			int numPerPage=5;
			int total_page=util.pageCount(numPerPage, dataCount);
			
			// 전체페이지보다 표시할 페이지가 큰경우
			if(total_page<current_page)
				current_page=total_page;
			
			// 가져올데이터의 시작과 끝
			int start=(current_page-1)*numPerPage+1;
			int end=current_page*numPerPage;
			
			//데이터 가져오기
			List<OnetooneDTO> list= dao.listOnetoOne(start, end);
			
			Iterator<OnetooneDTO> it =list.iterator();
			
			while(it.hasNext()){
				OnetooneDTO dto= it.next();
				
				dto.setUserId(dto.getUserId());
				dto.setSubject(dto.getSubject());
				dto.setUserId(dto.getUserId());
				dto.setSecret(dto.getSecret());
				dto.setContent(dto.getContent().replaceAll(">", "&gt;"));
				dto.setContent(dto.getContent().replaceAll("<", "&lt;"));
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}
			
			String strUrl=cp+"/onetoone/onetoone.do";
			String paging=util.paging(	current_page, total_page, strUrl);
			req.setAttribute("list", list);
			req.setAttribute("page", current_page);
			req.setAttribute("paging", paging);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("total_page", total_page);
		
			forward(req, resp, "/WEB-INF/views/onetoone/onetoone.jsp");
		}else if(uri.indexOf("onetoone_ok.do")!=-1) {
			// 방명록 저장
			if(info==null) { // 로그인되지 않은 경우
				resp.sendRedirect(cp+"/member/login.do");
				return;
			}
			
			OnetooneDTO dto=new OnetooneDTO();
			
			dto.setUserId(info.getUserId());
			dto.setContent(req.getParameter("content"));
			dto.setSubject(req.getParameter("subject"));
			if(req.getParameter("secret")!=null)
			dto.setSecret(Integer.parseInt(req.getParameter("secret")));
			else
				dto.setSecret(0);
			
			dao.insertOnetoone(dto);
			
			resp.sendRedirect(cp+"/onetoone/onetoone.do");
		} else if(uri.indexOf("delete.do")!=-1) {
			// 방명록 삭제
			if(info==null) { // 로그인되지 않은 경우
				resp.sendRedirect(cp+"/member/login.do");
				return;
			}
			
			int num=Integer.parseInt(req.getParameter("num"));
			String page=req.getParameter("page");
			

			

			dao.deleteOnetoone(num);
			resp.sendRedirect(cp+"/onetoone/onetoone.do?page="+page);
			
			
		}else if (uri.indexOf("update.do") != -1) {
			// 수정 폼
			if (info == null) { // 로그인되지 않은 경우
				resp.sendRedirect(cp + "/member/login.do");
				return;
			}

			String page = req.getParameter("page");
			int num = Integer.parseInt(req.getParameter("num"));
			OnetooneDTO dto = dao.readOnetoone(num);

			if (dto == null) {
				resp.sendRedirect(cp+"/onetoone/onetoone.do?page="+page);
				return;
			}

			// 게시물을 올린 사용자가 아니면
			if (!dto.getUserId().equals(info.getUserId())) {
				resp.sendRedirect(cp+"/onetoone/onetoone.do?page="+page);
				return;
			}

			req.setAttribute("dto", dto);
			req.setAttribute("page", page);
			req.setAttribute("mode", "update");

			String path = "/WEB-INF/views/onetoone/onetoone.jsp";
			forward(req, resp, path);

		} else if (uri.indexOf("update_ok.do") != -1) {
			// 수정 완료
			if (info == null) { // 로그인되지 않은 경우
				resp.sendRedirect(cp + "/member/login.do");
				return;
			}

			String page = req.getParameter("page");

			if (req.getMethod().equalsIgnoreCase("GET")) {
				resp.sendRedirect(cp+"/onetoone/onetoone.do?page="+page);
				return;
			}

			OnetooneDTO dto = new OnetooneDTO();
			dto.setNum(Integer.parseInt(req.getParameter("num")));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setSecret(Integer.parseInt(req.getParameter("secret")));

			dao.updateOnetoone(dto);
			resp.sendRedirect(cp+"/onetoone/onetoone.do?page="+page);

		} 
	}

}
